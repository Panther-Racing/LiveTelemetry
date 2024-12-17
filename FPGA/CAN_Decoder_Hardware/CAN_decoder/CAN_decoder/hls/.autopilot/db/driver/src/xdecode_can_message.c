// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.1.2 (64-bit)
// Tool Version Limit: 2024.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xdecode_can_message.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XDecode_can_message_CfgInitialize(XDecode_can_message *InstancePtr, XDecode_can_message_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XDecode_can_message_Set_message(XDecode_can_message *InstancePtr, XDecode_can_message_Message Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XDecode_can_message_WriteReg(InstancePtr->Control_BaseAddress, XDECODE_CAN_MESSAGE_CONTROL_ADDR_MESSAGE_DATA + 0, Data.word_0);
    XDecode_can_message_WriteReg(InstancePtr->Control_BaseAddress, XDECODE_CAN_MESSAGE_CONTROL_ADDR_MESSAGE_DATA + 4, Data.word_1);
    XDecode_can_message_WriteReg(InstancePtr->Control_BaseAddress, XDECODE_CAN_MESSAGE_CONTROL_ADDR_MESSAGE_DATA + 8, Data.word_2);
    XDecode_can_message_WriteReg(InstancePtr->Control_BaseAddress, XDECODE_CAN_MESSAGE_CONTROL_ADDR_MESSAGE_DATA + 12, Data.word_3);
}

XDecode_can_message_Message XDecode_can_message_Get_message(XDecode_can_message *InstancePtr) {
    XDecode_can_message_Message Data;

    Data.word_0 = XDecode_can_message_ReadReg(InstancePtr->Control_BaseAddress, XDECODE_CAN_MESSAGE_CONTROL_ADDR_MESSAGE_DATA + 0);
    Data.word_1 = XDecode_can_message_ReadReg(InstancePtr->Control_BaseAddress, XDECODE_CAN_MESSAGE_CONTROL_ADDR_MESSAGE_DATA + 4);
    Data.word_2 = XDecode_can_message_ReadReg(InstancePtr->Control_BaseAddress, XDECODE_CAN_MESSAGE_CONTROL_ADDR_MESSAGE_DATA + 8);
    Data.word_3 = XDecode_can_message_ReadReg(InstancePtr->Control_BaseAddress, XDECODE_CAN_MESSAGE_CONTROL_ADDR_MESSAGE_DATA + 12);
    return Data;
}

void XDecode_can_message_Set_num_decoded_signals_i(XDecode_can_message *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XDecode_can_message_WriteReg(InstancePtr->Control_BaseAddress, XDECODE_CAN_MESSAGE_CONTROL_ADDR_NUM_DECODED_SIGNALS_I_DATA, Data);
}

u32 XDecode_can_message_Get_num_decoded_signals_i(XDecode_can_message *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XDecode_can_message_ReadReg(InstancePtr->Control_BaseAddress, XDECODE_CAN_MESSAGE_CONTROL_ADDR_NUM_DECODED_SIGNALS_I_DATA);
    return Data;
}

u32 XDecode_can_message_Get_num_decoded_signals_o(XDecode_can_message *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XDecode_can_message_ReadReg(InstancePtr->Control_BaseAddress, XDECODE_CAN_MESSAGE_CONTROL_ADDR_NUM_DECODED_SIGNALS_O_DATA);
    return Data;
}

u32 XDecode_can_message_Get_num_decoded_signals_o_vld(XDecode_can_message *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XDecode_can_message_ReadReg(InstancePtr->Control_BaseAddress, XDECODE_CAN_MESSAGE_CONTROL_ADDR_NUM_DECODED_SIGNALS_O_CTRL);
    return Data & 0x1;
}

