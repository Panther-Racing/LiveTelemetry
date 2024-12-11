#include <stdint.h>
#include <ap_int.h>

// Define constants for fixed-point representation
#define SCALE_FACTOR 1e6
#define OFFSET_FACTOR 1e3

// Maximum number of signals per message allowed
#define MAX_SIGNALS 68

// Maximum length that a signal name can be in bits
#define MAX_SIGNAL_NAME_LENGTH 512

// Bit width of each signal definition
#define SIGNAL_DEF_WIDTH 80
// Bit width of each message definition
#define MESSAGE_DEF_WIDTH 56
#define SIGNAL_NAME_INDEX_WIDTH 11

// Variables for the hash function
#define HASH_TABLE_SIZE 1024
#define HASH_PRIME 31

// Number of cycles to run before averaging values
#define AVERAGING_WINDOW 1000

// BRAMs for the LUTs
ap_uint<MESSAGE_DEF_WIDTH> msg_lut[1024];               // Message Lookup Table (msg_lut.coe)
ap_uint<SIGNAL_DEF_WIDTH> signal_def_mem[1024];         // Signal Definitions (signal_def_mem.coe)
ap_uint<MAX_SIGNAL_NAME_LENGTH> signal_names[1024];     // Signal Names (signal_names.coe)

// Signal accumulator structure
struct SignalAccumulator {
    ap_int<64> accumulated_values[MAX_SIGNALS];  // Accumulated values for averaging per signal
    ap_uint<32> counter;                         // Counters for averaging
};

// Hash table entry for chaining
struct HashEntry {
    ap_uint<29> message_id;                     //Corresponding CAN ID for this message
    int lut_index;                              //Index of the message decode structure in the LUT
    SignalAccumulator* accumulator;             // Pointer to the accumulator for this message ID
    HashEntry* next;                            //Pointer to next hashEntry for chaining during collision
};

HashEntry hash_table[HASH_TABLE_SIZE];

// Global timer
unsigned int timer = 0;

// Input CAN message structure
typedef struct {
    ap_uint<29> id;     // CAN ID
    ap_uint<64> data;   // 8-byte data payload
} can_message_t;

// Output decoded signal structure
typedef struct {
    ap_uint<11> signal_name_index;  // Signal Name Index
    ap_int<32> value;               // Decoded signal value
} decoded_signal_t;

// Hash function to compute the index
int compute_hash(ap_uint<29> can_id) {
    return (can_id * HASH_PRIME) % HASH_TABLE_SIZE;
}

// Function to initialize the hash table
void initialize_hash_table(int msg_lut_size) {
    #pragma HLS PIPELINE II=1

    // Clear the hash table
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        hash_table[i].message_id = 0;
        hash_table[i].lut_index = 0;
        hash_table[i].accumulator = nullptr;
        hash_table[i].next = nullptr;
    }

    // Populate the hash table
    for (int i = 1; i <= msg_lut_size; i++) {
        ap_uint<MESSAGE_DEF_WIDTH> entry = msg_lut[i];
        ap_uint<29> message_id = entry(MESSAGE_DEF_WIDTH-1, MESSAGE_DEF_WIDTH-29);
        int hash_index = compute_hash(message_id);

        // Insert into hash table using chaining
        HashEntry* new_entry = new HashEntry();
        new_entry->message_id = message_id;
        new_entry->lut_index = i;
        new_entry->accumulator = new SignalAccumulator();
        //Initialize all accumulator values to 0
        new_entry->accumulator->counter = 0;
        for (int j = 0; j < MAX_SIGNALS; j++) {
            new_entry->accumulator->accumulated_values[j] = 0;
        }
        new_entry->next = nullptr;

        //If the message_id is 0, this hash table index is empty (there is no collision)
        if (hash_table[hash_index].message_id == 0) {
            hash_table[hash_index] = *new_entry;
        } else {
            // Otherwise, there is collision so add to the chain
            HashEntry* current = &hash_table[hash_index];
            while (current->next != nullptr) {
                current = current->next;
            }
            current->next = new_entry;
        }
    }
}

// Function to decode a CAN message
void decode_can_message(can_message_t message, decoded_signal_t decoded_signals[MAX_SIGNALS], int *num_decoded_signals) {
    #pragma HLS INTERFACE ap_memory depth=1024 port=msg_lut
    #pragma HLS INTERFACE ap_memory depth=1024 port=signal_def_mem
    #pragma HLS INTERFACE ap_memory depth=1024 port=signal_names
    #pragma HLS INTERFACE ap_fifo port=decoded_signals
    #pragma HLS INTERFACE s_axilite port=message
    #pragma HLS INTERFACE s_axilite port=num_decoded_signals
    #pragma HLS INTERFACE ap_ctrl_none port=return

    // Compute the hash index for the CAN ID
    int hash_index = compute_hash(message.id);

    // Search the hash table for the matching CAN ID
    HashEntry* current = &hash_table[hash_index];
    SignalAccumulator* accumulator = nullptr;
    while (current != nullptr) {
        if (current->message_id == message.id) {
            accumulator = current->accumulator;
            break;
        }
        current = current->next;
    }

    if (accumulator == nullptr) {
        // Message ID not found
        return;
    }

    // Extract fields from the found entry
    ap_uint<MESSAGE_DEF_WIDTH> entry = msg_lut[current->lut_index];
    ap_uint<7> num_signals = entry(22, 16);
    ap_uint<16> signal_def_pointer = entry(15, 0);

    //Increment the count for this message in the accumulator
    ++accumulator->counter;

    // Decode each signal
    for (int j = 0; j < num_signals; j++) {
        #pragma HLS UNROLL factor=MAX_SIGNALS
        ap_uint<SIGNAL_DEF_WIDTH> signal_def = signal_def_mem[signal_def_pointer + j + 1];

        // Extract signal definition fields
        ap_uint<11> signal_name_index = signal_def(74, 64);
        ap_uint<7> start_bit = signal_def(63, 57);
        ap_uint<7> length = signal_def(56, 50);
        ap_uint<1> is_signed = signal_def[49];
        ap_uint<1> endianness = signal_def[48];
        ap_uint<24> scale = signal_def(47, 24);
        ap_uint<24> offset = signal_def(23, 0);

        // Extract the raw signal value using the start bit and length
        ap_uint<64> data = message.data;
        ap_uint<32> raw_value = (data >> start_bit) & ((1 << length) - 1);

        ap_int<32> value = raw_value;

        // Sign extend the value if it is a signed value
        if (is_signed && value[length - 1]) {
            value = value - (1 << length);
        }

        // Scale the value and apply the offset
        value = (value * scale) / SCALE_FACTOR + offset / OFFSET_FACTOR;

        // Add this to the value in the buffer (to be accumulated)
        accumulator->accumulated_values[j] += value;
    }

    // Check if the averaging window is complete
    if (++timer >= AVERAGING_WINDOW) {
        timer = 0;  // Reset the global timer

        // Output averaged values and reset buffers
        for (int i = 0; i < HASH_TABLE_SIZE; i++) {
            HashEntry* current = &hash_table[i];
            while (current != nullptr) {
                SignalAccumulator* acc = current->accumulator;
                //Only run the averaging if there are actual values stored in this accumulator (the count is not 0)
                if(acc->counter > 0){
                    for (int j = 0; j < MAX_SIGNALS; j++) {
                    
                        decoded_signals[*num_decoded_signals].signal_name_index = signal_def_mem[j + 1](74, 64);
                        decoded_signals[*num_decoded_signals].value = acc->accumulated_values[j] / acc->counter;

                        // Reset the accumulator buffer for this signal
                        acc->accumulated_values[j] = 0;

                        (*num_decoded_signals)++;
                    }
                    //Reset the accumulator counter
                    acc->counter = 0;
                }
                //Advance through the hash table chain        
                current = current->next;
            }
        }
    }
}
