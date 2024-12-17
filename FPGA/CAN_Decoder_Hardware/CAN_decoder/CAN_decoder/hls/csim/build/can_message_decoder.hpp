#ifndef CAN_MESSAGE_DECODER_H
#define CAN_MESSAGE_DECODER_H

#include <stdint.h>
#include <ap_int.h>

// Constants
#define SCALE_FACTOR 1e6
#define OFFSET_FACTOR 1e3
#define MAX_SIGNALS 68
#define MAX_SIGNAL_NAME_LENGTH 512
#define SIGNAL_DEF_WIDTH 80
#define MESSAGE_DEF_WIDTH 56
#define SIGNAL_NAME_INDEX_WIDTH 11
#define HASH_TABLE_SIZE 1024
#define HASH_PRIME 31
#define AVERAGING_WINDOW 1000

// Structs
struct SignalAccumulator {
    ap_int<64> accumulated_values[MAX_SIGNALS];
    ap_uint<32> counter;
};

struct HashEntry {
    ap_uint<29> message_id;
    int lut_index;
    SignalAccumulator accumulator;
};

typedef struct {
    ap_uint<29> id;
    ap_uint<64> data;
} can_message_t;

typedef struct {
    ap_uint<11> signal_name_index;
    ap_int<32> value;
} decoded_signal_t;

// Extern declarations for LUTs
extern ap_uint<MESSAGE_DEF_WIDTH> msg_lut[512];
extern ap_uint<SIGNAL_DEF_WIDTH> signal_def_mem[512];
extern ap_uint<MAX_SIGNAL_NAME_LENGTH> signal_names[512];
extern HashEntry hash_table[HASH_TABLE_SIZE];
extern unsigned int timer;

// Function declarations
int compute_hash(ap_uint<29> can_id);
void initialize_hash_table(int msg_lut_size);
void decode_can_message(can_message_t message, decoded_signal_t decoded_signals[MAX_SIGNALS], int *num_decoded_signals);

#endif
