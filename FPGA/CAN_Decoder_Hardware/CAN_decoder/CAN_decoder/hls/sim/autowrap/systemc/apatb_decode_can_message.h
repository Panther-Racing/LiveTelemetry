// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.1.2 (64-bit)
// Tool Version Limit: 2024.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================

extern "C" void AESL_WRAP_decode_can_message (
__cosim_s16__ message,
volatile void* decoded_signals,
volatile void* num_decoded_signals,
volatile void* hash_table_message_id,
volatile void* hash_table_lut_index,
volatile void* hash_table_accumulator_accumulated_values,
volatile void* hash_table_accumulator_counter,
volatile void* msg_lut,
volatile void* signal_def_mem);
