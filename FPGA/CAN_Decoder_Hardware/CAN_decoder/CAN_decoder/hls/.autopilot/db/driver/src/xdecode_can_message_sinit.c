// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.1.2 (64-bit)
// Tool Version Limit: 2024.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#ifdef SDT
#include "xparameters.h"
#endif
#include "xdecode_can_message.h"

extern XDecode_can_message_Config XDecode_can_message_ConfigTable[];

#ifdef SDT
XDecode_can_message_Config *XDecode_can_message_LookupConfig(UINTPTR BaseAddress) {
	XDecode_can_message_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XDecode_can_message_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XDecode_can_message_ConfigTable[Index].Control_BaseAddress == BaseAddress) {
			ConfigPtr = &XDecode_can_message_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XDecode_can_message_Initialize(XDecode_can_message *InstancePtr, UINTPTR BaseAddress) {
	XDecode_can_message_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XDecode_can_message_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XDecode_can_message_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XDecode_can_message_Config *XDecode_can_message_LookupConfig(u16 DeviceId) {
	XDecode_can_message_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XDECODE_CAN_MESSAGE_NUM_INSTANCES; Index++) {
		if (XDecode_can_message_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XDecode_can_message_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XDecode_can_message_Initialize(XDecode_can_message *InstancePtr, u16 DeviceId) {
	XDecode_can_message_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XDecode_can_message_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XDecode_can_message_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

