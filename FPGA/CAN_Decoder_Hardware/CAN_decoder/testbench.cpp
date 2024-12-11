#include <stdio.h>
#include <stdlib.h>
#include "can_message_decoder.cpp"

// Declare LUTs
ap_uint<MESSAGE_DEF_WIDTH> msg_lut_test[1024];     // ap_uint<56>
ap_uint<SIGNAL_DEF_WIDTH> signal_def_mem_test[1024]; // ap_uint<80>
ap_uint<MAX_SIGNAL_NAME_LENGTH> signal_names_test[1024]; // ap_uint<512>

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "ap_int.h"

// Template function to load COE files into arrays of varying bit-widths
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
        // Skip lines with comments or empty lines
        if (line[0] == ';' || line[0] == '\n' || strlen(line) == 0) continue;

        // Detect radix if specified
        if (strstr(line, "memory_initialization_radix=") != NULL) {
            sscanf(line, "memory_initialization_radix=%d;", &radix);
            continue;
        }

        // Skip the initialization vector line
        if (strstr(line, "memory_initialization_vector=") != NULL) {
            continue;
        }

        // Read data values
        char *token = strtok(line, ", \n");
        while (token && index < size) {
            array[index++] = ap_uint<N>(strtoull(token, NULL, radix)); // Convert value using the detected radix
            token = strtok(NULL, ", \n");
        }
    }

    fclose(file);

    if (index < size) {
        printf("Warning: COE file %s contains fewer values than expected (%d < %d).\n", filename, index, size);
    }
}


int main() {
    // Load COE files
    load_coe<MESSAGE_DEF_WIDTH>("msg_lut_test.coe", msg_lut_test, 1024);
    load_coe<SIGNAL_DEF_WIDTH>("signal_def_mem_test.coe", signal_def_mem_test, 1024);
    load_coe<MAX_SIGNAL_NAME_LENGTH>("signal_names_test.coe", signal_names_test, 1024);

    // Test print first few values
    for (int i = 0; i < 5; i++) {
        printf("msg_lut_test[%d] = 0x%llx\n", i, (unsigned long long)msg_lut_test[i].to_uint64());
    }

    // Initialize the hash table
    initialize_hash_table(1024);

    // Input CAN message
    can_message_t message = { .id = 0x123, .data = 0x1122334455667788 };

    // Output array for decoded signals
    decoded_signal_t decoded_signals[MAX_SIGNALS];
    int num_decoded_signals = 0;

    // Call the decoder
    decode_can_message(message, decoded_signals, &num_decoded_signals);

    // Print results
    printf("Number of decoded signals: %d\n", num_decoded_signals);
    for (int i = 0; i < num_decoded_signals; i++) {
        printf("Signal Name Index: %u, Value: %d\n",
               (unsigned)decoded_signals[i].signal_name_index,
               (int)decoded_signals[i].value);
    }

    return 0;
}
