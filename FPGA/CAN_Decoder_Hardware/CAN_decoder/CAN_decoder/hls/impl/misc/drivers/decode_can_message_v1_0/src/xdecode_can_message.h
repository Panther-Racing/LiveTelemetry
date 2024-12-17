// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.1.2 (64-bit)
// Tool Version Limit: 2024.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XDECODE_CAN_MESSAGE_H
#define XDECODE_CAN_MESSAGE_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xdecode_can_message_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
#ifdef SDT
    char *Name;
#else
    u16 DeviceId;
#endif
    u64 Control_BaseAddress;
} XDecode_can_message_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XDecode_can_message;

typedef u32 word_type;

typedef struct {
    u32 word_0;
    u32 word_1;
    u32 word_2;
    u32 word_3;
} XDecode_can_message_Message;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XDecode_can_message_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XDecode_can_message_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XDecode_can_message_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XDecode_can_message_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
#ifdef SDT
int XDecode_can_message_Initialize(XDecode_can_message *InstancePtr, UINTPTR BaseAddress);
XDecode_can_message_Config* XDecode_can_message_LookupConfig(UINTPTR BaseAddress);
#else
int XDecode_can_message_Initialize(XDecode_can_message *InstancePtr, u16 DeviceId);
XDecode_can_message_Config* XDecode_can_message_LookupConfig(u16 DeviceId);
#endif
int XDecode_can_message_CfgInitialize(XDecode_can_message *InstancePtr, XDecode_can_message_Config *ConfigPtr);
#else
int XDecode_can_message_Initialize(XDecode_can_message *InstancePtr, const char* InstanceName);
int XDecode_can_message_Release(XDecode_can_message *InstancePtr);
#endif


void XDecode_can_message_Set_message(XDecode_can_message *InstancePtr, XDecode_can_message_Message Data);
XDecode_can_message_Message XDecode_can_message_Get_message(XDecode_can_message *InstancePtr);
void XDecode_can_message_Set_num_decoded_signals_i(XDecode_can_message *InstancePtr, u32 Data);
u32 XDecode_can_message_Get_num_decoded_signals_i(XDecode_can_message *InstancePtr);
u32 XDecode_can_message_Get_num_decoded_signals_o(XDecode_can_message *InstancePtr);
u32 XDecode_can_message_Get_num_decoded_signals_o_vld(XDecode_can_message *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
