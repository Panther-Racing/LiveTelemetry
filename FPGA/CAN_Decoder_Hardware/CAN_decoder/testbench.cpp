#include "can_message_decoder.hpp"
#include <stdio.h>
#include <stdlib.h>
#include <direct.h>  // For _getcwd on Windows
#include <iostream>
#include <string.h>
#include <fstream>

// Define LUTs and global variables
extern ap_uint<MESSAGE_DEF_WIDTH> msg_lut[512];
extern ap_uint<SIGNAL_DEF_WIDTH> signal_def_mem[512];
extern ap_uint<MAX_SIGNAL_NAME_LENGTH> signal_names[512];
extern HashEntry hash_table[HASH_TABLE_SIZE];

#include <string>
#include <cstring>

template <int N>
void load_coe(const char *filename, ap_uint<N> *array, int size) {
    FILE *file = fopen(filename, "r");
    if (!file) {
        printf("Error: Cannot open file %s\n", filename);
        exit(EXIT_FAILURE);
    }

    char line[256];
    int index = 0;
    int radix = 16; // Default radix is hexadecimal

    while (fgets(line, sizeof(line), file)) {
        // Skip comments or empty lines
        if (line[0] == ';' || line[0] == '\n' || strlen(line) == 0) continue;

        // Detect radix
        if (strstr(line, "memory_initialization_radix=") != NULL) {
            sscanf(line, "memory_initialization_radix=%d;", &radix);
            continue;
        }

        // Skip the initialization vector
        if (strstr(line, "memory_initialization_vector=") != NULL) {
            continue;
        }

        // Parse large values
        char *token = strtok(line, ", \n");
        while (token && index < size) {
            std::string str_value(token);

            ap_uint<N> value = 0;
            for (size_t i = 0; i < str_value.size(); i++) {
                // Shift and add based on radix
                char digit = str_value[i];
                value = value * radix;

                if (digit >= '0' && digit <= '9') {
                    value += (digit - '0');
                } else if (digit >= 'A' && digit <= 'F') {
                    value += (digit - 'A' + 10);
                } else if (digit >= 'a' && digit <= 'f') {
                    value += (digit - 'a' + 10);
                }
            }

            array[index++] = value; // Store the parsed value
            token = strtok(NULL, ", \n");
        }
    }

    fclose(file);

    if (index < size) {
        printf("Warning: COE file %s contains fewer values than expected (%d < %d).\n", filename, index, size);
    }
}

int main() {
    printf("Starting Test\n");

    char cwd[256];
    if (_getcwd(cwd, sizeof(cwd)) != NULL) {
        std::cout << "Current working directory: " << cwd << std::endl;
    }

    //Open Output File
    std::ofstream output_file("C:/Users/flaud/Documents/GitHub/LiveTelemetry/FPGA/decoded_output.txt");
    if(!output_file){
        printf("Error opening output file.\n");
        return -1;
    }

    // Load COE files
    load_coe<MESSAGE_DEF_WIDTH>("C:/Users/flaud/Documents/GitHub/LiveTelemetry/FPGA/msg_lut.coe", msg_lut, 512);
    load_coe<SIGNAL_DEF_WIDTH>("C:/Users/flaud/Documents/GitHub/LiveTelemetry/FPGA/signal_def_mem.coe", signal_def_mem, 512);
    load_coe<MAX_SIGNAL_NAME_LENGTH>("C:/Users/flaud/Documents/GitHub/LiveTelemetry/FPGA/signal_names.coe", signal_names, 512);

    // for(int j = 0; j < 20; j++){
    //     printf("Signal Mem: %020llx\n", (unsigned long long)signal_def_mem[j]);
    // }

    // Initialize the hash table
    initialize_hash_table(512, hash_table);

    // Input CAN message
    can_message_t message[] = { { .id = 0xa1, .data = 0x280280280280 }, 
                                { .id = 0xa2, .data = 0x280280280280 }, 
                                { .id = 0xa3, .data = 0x90416199041619 }, 
                                { .id = 0xa4, .data = 0x11111111 }, 
                                { .id = 0xa5, .data = 0x28040280280 }, 
                                { .id = 0xa6, .data = 0x280280280280 }, 
                                { .id = 0xa7, .data = 0x280280280280 }, 
                                { .id = 0xa8, .data = 0x280280280280 }, 
                                { .id = 0xa9, .data = 0x901901901901 }, 
                                { .id = 0xaa, .data = 0x4443f8341c3ff }, 
                                { .id = 0xab, .data = 0x40404040 }, 
                                { .id = 0xac, .data = 0x28028035500 }, 
                                { .id = 0xad, .data = 0x409c280280280 }, 
                                { .id = 0xae, .data = 0x40404040 }, 
                                { .id = 0xaf, .data = 0x44280280280 }, 
                                { .id = 0xb0, .data = 0x28028040280 }, 
                                { .id = 0xc0, .data = 0x2804017280 }, 
                                { .id = 0xc1, .data = 0x40104000 }, 
                                { .id = 0xc2, .data = 0x40104000 }, 
                                { .id = 0x118, .data = 0x4028190000 }, 
                                { .id = 0x119, .data = 0x4028028000 }, 
                                { .id = 0x202, .data = 0x40400000 }, 
                                { .id = 0x500, .data = 0x40000000 }, 
                                { .id = 0x542, .data = 0x480208020cd00 }, 
                                { .id = 0x544, .data = 0x402802818180 }, 
                                { .id = 0x644, .data = 0x4190280100 }, 
                                { .id = 0x646, .data = 0x45004000 }, 
                                { .id = 0x648, .data = 0x4d5555555555555 }, 
                                { .id = 0x6b0, .data = 0x028028804ff }, 
                                { .id = 0x6b1, .data = 0x04404440 }, 
                                { .id = 0x6b2, .data = 0x4028028044 }, 
                                { .id = 0x6b3, .data = 0xfa0400004 }, 
                                { .id = 0x6b5, .data = 0x04040000 }, 
                                { .id = 0x6b6, .data = 0x1900280000 }, 
                                { .id = 0x6b8, .data = 0x0280289c409c40 }, 
                                { .id = 0x6b9, .data = 0x44444444 }, 
                                { .id = 0x6ba, .data = 0x9c401901909c40 }, 
                                { .id = 0x6bb, .data = 0x9c400280404 }, 
                                { .id = 0x6bc, .data = 0x04000000 }, 
                                { .id = 0x750, .data = 0x4028028000 }, 
                                { .id = 0x9806e5f4, .data = 0x02802880000 }, 
                                { .id = 0x9806e7f4, .data = 0x02802880000 }, 
                                { .id = 0x9806e9f4, .data = 0x02802880000 }, 
                                { .id = 0x98ff50e5, .data = 0x00000000 } };

    for(int j = 0; j < 44; j++){

        // Output array for decoded signals
        decoded_signal_t decoded_signals[MAX_SIGNALS];
        int num_decoded_signals = 0;
        // Call the decoder
        decode_can_message(message[j], decoded_signals, &num_decoded_signals, hash_table, msg_lut, signal_def_mem);

        // Print results
        printf("Number of decoded signals: %d\n", num_decoded_signals);
        for (int i = 0; i < num_decoded_signals; i++) {
            char decoded_signal_name[64 + 1] = {0};
            printf("Signal Name: %u, Value: %d\n", decoded_signals[i].signal_name_index, (int)decoded_signals[i].value);
        }

        //Write resolts to a file
        for (int i = 0; i < num_decoded_signals; i++) {
            output_file << decoded_signals[i].signal_name_index << " "
                        << decoded_signals[i].value << std::endl;
        }

    }

    return 0;
}
