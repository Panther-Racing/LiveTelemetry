#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <ap_int.h>
#include <algorithm>

// Include the header file for your top function
#include "can_message_decoder.h"

// Define constants
#define MAX_LUT_SIZE 65536  // Adjust based on your LUT size
#define LUT_ENTRY_WORDS ((LUT_ENTRY_BITS + 31) / 32)

// Function to load the LUT from the .coe file
void load_lut(const char* coe_file, ap_uint<32>* lut_memory, int& lut_size) {
    std::ifstream infile(coe_file);
    if (!infile.is_open()) {
        std::cerr << "Failed to open LUT file: " << coe_file << std::endl;
        exit(1);
    }

    std::string line;
    bool data_started = false;
    int lut_index = 0;

    while (std::getline(infile, line)) {
        // Skip comments and headers
        if (line.find("memory_initialization_vector=") != std::string::npos) {
            data_started = true;
            continue;
        }
        if (!data_started) {
            continue;
        }

        // Remove commas and semicolons
        line.erase(std::remove(line.begin(), line.end(), ','), line.end());
        line.erase(std::remove(line.begin(), line.end(), ';'), line.end());

        // Remove whitespace
        line.erase(std::remove_if(line.begin(), line.end(), ::isspace), line.end());

        if (line.empty()) {
            continue;
        }

        // Convert hex string to 32-bit words
        int num_chars = line.length();
        int num_words = (num_chars + 7) / 8;  // Each word is 8 hex digits

        for (int i = 0; i < num_words; i++) {
            int start_idx = num_chars - (i + 1) * 8;
            int length = 8;
            if (start_idx < 0) {
                length += start_idx;
                start_idx = 0;
            }
            std::string word_str = line.substr(start_idx, length);
            ap_uint<32> word = static_cast<ap_uint<32>>(std::stoul(word_str, nullptr, 16));
            lut_memory[lut_index++] = word;
        }
    }

    // The LUT size is stored in the first word
    lut_size = static_cast<int>(lut_memory[0]);

    infile.close();
}

int main() {
    // Initialize LUT memory
    ap_uint<32>* lut_memory = new ap_uint<32>[MAX_LUT_SIZE];
    int lut_size = 0;

    // Load the LUT from the .coe file
    load_lut("output.coe", lut_memory, lut_size);

    // Define test inputs
    ap_uint<32> can_id = 0x1ABCDE;  // Replace with a valid CAN ID from your DBC
    ap_uint<64> can_data = 0x123456789ABCDEF0;  // Replace with test data

    // Output array to store decoded signals
    ap_int<32> decoded_signals[MAX_SIGNALS];

    // Call the top function
    can_message_decoder(can_id, can_data, lut_memory, decoded_signals);

    // Display the results
    std::cout << "Decoded Signals:" << std::endl;
    for (int i = 0; i < MAX_SIGNALS; i++) {
        std::cout << "Signal " << i << ": " << decoded_signals[i] << std::endl;
    }

    // Clean up
    delete[] lut_memory;

    return 0;
}
