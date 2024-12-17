#include "can_message_decoder.hpp"
#include <stdio.h>

// Define LUTs and global variables
ap_uint<MESSAGE_DEF_WIDTH> msg_lut[512];
ap_uint<SIGNAL_DEF_WIDTH> signal_def_mem[512];
ap_uint<MAX_SIGNAL_NAME_LENGTH> signal_names[512];
HashEntry hash_table[HASH_TABLE_SIZE];
unsigned int timer = 0;

// Hash function to compute the index
int compute_hash(ap_uint<29> can_id) {
    return (can_id * HASH_PRIME) % HASH_TABLE_SIZE;
}

// Function to initialize the hash table
void initialize_hash_table(int msg_lut_size, HashEntry hash_table[HASH_TABLE_SIZE]) {
    #pragma HLS PIPELINE II=1

    // Clear the hash table
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        hash_table[i].message_id = 0;
        hash_table[i].lut_index = 0;
        hash_table[i].accumulator.counter = 0;
        //Clear the accumulator in each hash entry
        for(int j = 0; j < MAX_SIGNALS; j++){
            hash_table[i].accumulator.accumulated_values[j] = 0;
        }
    }

    // Populate the hash table
    for (int i = 1; i <= msg_lut_size; i++) {
        ap_uint<MESSAGE_DEF_WIDTH> message_def = msg_lut[i];
        ap_uint<29> message_id = message_def(51, 23);
        ap_uint<7> num_signals = message_def(22, 16);
        int hash_index = compute_hash(message_id);

        // if(i < 50){
        //     printf("Message Definition: %014x\n", message_def);
        //     //printf("Message ID: %08x \t hash: %d\n", message_id, hash_index);
        // }

        //If message_id is 0, this hash table index is empty (there is no collision)
        //While the message_id is not 0, linearly probe the hash table to find the next open index
        while(hash_table[hash_index].message_id != 0){
            ++hash_index;
            //printf(".");
        }
        //printf("\n");
        
        //Once we find an available spot in the hash_table, add this message index
        hash_table[hash_index].message_id = message_id;
        hash_table[hash_index].lut_index = i;
        // if(i < 50){
        //     printf("%d: Stored in hash table: message id: %08x\t lut index: %d\n", hash_index, hash_table[hash_index].message_id, hash_table[hash_index].lut_index);
        // }
    }
}

// Function to decode a CAN message
void decode_can_message(can_message_t message, decoded_signal_t decoded_signals[MAX_SIGNALS], 
                        int *num_decoded_signals, HashEntry hash_table[HASH_TABLE_SIZE],
                        ap_uint<MESSAGE_DEF_WIDTH> msg_lut[512], ap_uint<SIGNAL_DEF_WIDTH> signal_def_mem[512]) {
    #pragma HLS INTERFACE ap_memory depth=512 port=msg_lut
    #pragma HLS INTERFACE ap_memory depth=512 port=signal_def_mem
    #pragma HLS INTERFACE ap_memory depth=512 port=signal_names
    #pragma HLS INTERFACE ap_memory port=decoded_signals
    #pragma HLS INTERFACE s_axilite port=message
    #pragma HLS INTERFACE s_axilite port=num_decoded_signals

    if(DEBUG){
        printf("Input to can message decoder: id: %08x \t data: %016x\n", message.id, message.data);
    }

    // Compute the hash index for the CAN ID
    int hash_index = compute_hash(message.id);
    if(DEBUG){
        printf("Computed hash index %d\n", hash_index);
        printf("Message at that hash: %08x\n", hash_table[hash_index].message_id);
    }

    // If the current item in the hash table is not the right message, probe the table linearly
    //until the right value is found
    while(hash_table[hash_index].message_id != message.id && hash_index < HASH_TABLE_SIZE){
        if(DEBUG){
            printf("Searching for non-conflicting hash index: %08x\t %08x\n", message.id, hash_table[hash_index].message_id);
        }
        ++hash_index;
    }

    //If the message ID is not found after probing the whole table, the message ID is not present in our DBC
    //so return from the function
    if(hash_table[hash_index].message_id != message.id){
        printf("Message not found, returning");
        return;
    }

    // Extract fields from the found entry
    ap_uint<MESSAGE_DEF_WIDTH> entry = msg_lut[hash_table[hash_index].lut_index];
    ap_uint<7> num_signals = entry(22, 16);
    ap_uint<16> signal_def_pointer = entry(15, 0);

    if(DEBUG){
        printf("LUT Index: %d\n", hash_table[hash_index].lut_index);
        printf("Message Decode Raw: %014x\n", msg_lut[hash_table[hash_index].lut_index]);
        printf("Message Decode Information: Num Signals: %02x \t Signal Def Pointer: %04llx\n", num_signals, (unsigned long long)signal_def_pointer);
    }
    
    //Increment the count for this message in the accumulator
    ++hash_table[hash_index].accumulator.counter;

    // for(int j = 0; j < 100; j++){
    //     printf("Signal Mem: %020llx\n", (unsigned long long)signal_def_mem[j]);
    // }

    // Decode each signal
    for (int j = 0; j < num_signals; j++) {
        #pragma HLS UNROLL factor=MAX_SIGNALS
        ap_uint<SIGNAL_DEF_WIDTH> signal_def = signal_def_mem[signal_def_pointer + j + 1];
        
        if(DEBUG){
            printf("Signal Def: %020llx\n", (unsigned long long)signal_def);
        }

        // Extract signal definition fields
        ap_uint<11> signal_name_index = signal_def(74, 64);
        ap_uint<7> start_bit = signal_def(63, 57);
        ap_uint<7> length = signal_def(56, 50);
        ap_uint<1> is_signed = signal_def[49];
        ap_uint<1> endianness = signal_def[48];
        ap_uint<24> scale = signal_def(47, 24);
        ap_uint<24> offset = signal_def(23, 0);

        if(DEBUG){
            printf("Signal Definition Details: Start Bit: %02llx, Length: %02llx, Signed: %01llx, Endianness: %01llx, Scale: %06llx, Offset: %06llx, Signal Name Index: %03llx\n", 
                (unsigned long long)start_bit, (unsigned long long)length, (unsigned long long)is_signed, (unsigned long long)endianness, (unsigned long long)scale, 
                (unsigned long long)offset, (unsigned long long)signal_name_index);
        }
        
        // Extract the raw signal value using the start bit and length
        ap_uint<64> data = message.data;
        ap_uint<32> raw_value = (data >> (CAN_DATA_LENGTH - (start_bit+length))) & ((1 << length) - 1);

        ap_int<32> value = raw_value;

        // Sign extend the value if it is a signed value
        if (is_signed && value[length - 1]) {
            value = value - (1 << length);
        }

        if(DEBUG){
            printf("Data: %016llx \t Raw Value: %08llx \t Sign Extended: %08llx\n", 
                (unsigned long long)data, (unsigned long long)raw_value, (unsigned long long)value);
        }

        // Scale the value and apply the offset
        value = (value * scale) / SCALE_FACTOR + offset / OFFSET_FACTOR;

        if(DEBUG){
            printf("Decoded value %06llx\n", value);
        }

        // Add this to the value in the buffer (to be accumulated)
        hash_table[hash_index].accumulator.accumulated_values[j] += value;
    }

    // Check if the averaging window is complete
    if (++timer >= AVERAGING_WINDOW) {
        timer = 0;  // Reset the global timer

        // Output averaged values and reset buffers
        for (int i = 0; i < HASH_TABLE_SIZE; i++) {
            //Only run the averaging if there are actual values stored in this accumulator (the count is not 0)
            if(hash_table[i].accumulator.counter > 0){

                // Extract fields from the message definition
                ap_uint<MESSAGE_DEF_WIDTH> entry = msg_lut[hash_table[i].lut_index];
                ap_uint<7> num_signals = entry(22, 16);
                ap_uint<16> signal_def_pointer = entry(15, 0);

                //Traverse through all of the signals in this message
                for (int j = 0; j < num_signals; j++) {                
                    decoded_signals[*num_decoded_signals].signal_name_index = signal_def_mem[signal_def_pointer + j + 1](74, 64);
                    decoded_signals[*num_decoded_signals].value = hash_table[i].accumulator.accumulated_values[j] / hash_table[i].accumulator.counter;

                    // Reset the accumulator buffer for this signal
                    hash_table[i].accumulator.accumulated_values[j] = 0;

                    (*num_decoded_signals)++;
                }
                //Reset the accumulator counter
                hash_table[i].accumulator.counter = 0;
            }
        }
    }
}
