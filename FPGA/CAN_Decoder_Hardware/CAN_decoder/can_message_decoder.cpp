#include <stdint.h>
#include <ap_int.h>

//Define constants for fixed-point representation
#define SCALE_FACTOR 1e6
#define OFFSET_FACTOR 1e3

//Maximum number of signals per message allowed
#define MAX_SIGNALS 68

//Maximum length that a signal name can be in bits
#define MAX_SIGNAL_NAME_LENGTH 512

//Bit width of each signal definition
#define SIGNAL_DEF_WIDTH 80
//Bit width of each message definition
#define MESSAGE_DEF_WIDTH 56
#define SIGNAL_NAME_INDEX_WIDTH 11

//Variables for the hash function
#define HASH_TABLE_SIZE 1024
#define HASH_PRIME 31

//Use a hash table for the LUT indicies so that we don't have to search the LUT for each CAN index
//but we also don't need a huge array since each CAN message has a bit size of 29
ap_uint<8> hash_table[HASH_TABLE_SIZE];

// BRAMs for the LUTs
ap_uint<MESSAGE_DEF_WIDTH> msg_lut[1024];               // Message Lookup Table (msg_lut.coe)
ap_uint<SIGNAL_DEF_WIDTH> signal_def_mem[1024];         // Signal Definitions (signal_def_mem.coe)
ap_uint<MAX_SIGNAL_NAME_LENGTH> signal_names[1024];     // Signal Names (signal_names.coe)

// Input CAN message structure
typedef struct {
    ap_uint<29> id;     //CAN ID
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
        hash_table[i] = 0;
    }

    // Populate the hash table
    for (int i = 1; i <= msg_lut_size; i++) {
        ap_uint<MESSAGE_DEF_WIDTH> entry = msg_lut[i];
        ap_uint<29> message_id = entry(MESSAGE_DEF_WIDTH-1, MESSAGE_DEF_WIDTH-29);
        int hash_index = compute_hash(message_id);

        // Handle collisions using linear probing
        while (hash_table[hash_index] != 0) {
            hash_index = (hash_index + 1) % HASH_TABLE_SIZE;
        }

        hash_table[hash_index] = i; // Store the index of the msg_lut entry
    }
}

// Function to decode a CAN message
void decode_can_message(can_message_t message, decoded_signal_t decoded_signals[MAX_SIGNALS], int *num_decoded_signals) {
    #pragma HLS INTERFACE ap_memory depth=1024 port=msg_lut
    #pragma HLS INTERFACE ap_memory depth=1024 port=signal_def_mem
    #pragma HLS INTERFACE ap_memory depth=1024 port=signal_names
    #pragma HLS INTERFACE ap_memory depth=1024 port=hash_table
    #pragma HLS INTERFACE ap_fifo port=decoded_signals
    #pragma HLS INTERFACE s_axilite port=message
    #pragma HLS INTERFACE s_axilite port=num_decoded_signals
    #pragma HLS INTERFACE ap_ctrl_none port=return

    // Initialize number of decoded signals
    *num_decoded_signals = 0;

    // Compute the hash index for the CAN ID
    int hash_index = compute_hash(message.id);

    // Resolve collisions using linear probing
    int found_index = -1;
    while (hash_table[hash_index] != 0) {
        int lut_index = hash_table[hash_index];
        ap_uint<MESSAGE_DEF_WIDTH> entry = msg_lut[lut_index];
        ap_uint<29> message_id = entry(MESSAGE_DEF_WIDTH-1, MESSAGE_DEF_WIDTH-29);

        if (message_id == message.id) {
            found_index = lut_index;
            break;
        }

        hash_index = (hash_index + 1) % HASH_TABLE_SIZE;
    }

    if (found_index == -1) {
        // Message ID not found
        return;
    }

    // Extract fields from the found entry
    ap_uint<MESSAGE_DEF_WIDTH> entry = msg_lut[found_index];
    ap_uint<7> num_signals = entry(22, 16);
    ap_uint<16> signal_def_pointer = entry(15, 0);

    // Decode each signal
    for (int j = 0; j < num_signals; j++) {
        #pragma HLS UNROLL factor=MAX_SIGNALS
        //Offset by +1 to skip the first entry which is the size of the LUT
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

        //Sign extend the value if it is a signed value
        if (is_signed && value[length - 1]) {
            value = value - (1 << length);
        }

        //Scale the value and apply the offset
        value = (value * scale) / SCALE_FACTOR + offset / OFFSET_FACTOR;

        // Store the decoded signal
        decoded_signals[*num_decoded_signals].signal_name_index = signal_name_index;
        decoded_signals[*num_decoded_signals].value = value;
        (*num_decoded_signals)++;
    }
}