set moduleName decode_can_message_Pipeline_VITIS_LOOP_117_2
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set C_modelName {decode_can_message_Pipeline_VITIS_LOOP_117_2}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict signal_def_mem { MEM_WIDTH 80 MEM_SIZE 5120 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict hash_table_accumulator_accumulated_values { MEM_WIDTH 64 MEM_SIZE 278528 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
set C_modelArgList {
	{ num_signals3 int 7 regular  }
	{ empty int 9 regular  }
	{ signal_def_mem int 80 regular {array 512 { 1 1 } 1 1 }  }
	{ message_data2 int 64 regular  }
	{ mul_ln164_reload int 16 regular  }
	{ hash_table_accumulator_accumulated_values int 64 regular {array 34816 { 2 2 } 1 1 }  }
	{ zext_ln117 int 7 regular  }
}
set hasAXIMCache 0
set hasAXIML2Cache 0
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "num_signals3", "interface" : "wire", "bitwidth" : 7, "direction" : "READONLY"} , 
 	{ "Name" : "empty", "interface" : "wire", "bitwidth" : 9, "direction" : "READONLY"} , 
 	{ "Name" : "signal_def_mem", "interface" : "memory", "bitwidth" : 80, "direction" : "READONLY"} , 
 	{ "Name" : "message_data2", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "mul_ln164_reload", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "hash_table_accumulator_accumulated_values", "interface" : "memory", "bitwidth" : 64, "direction" : "READWRITE"} , 
 	{ "Name" : "zext_ln117", "interface" : "wire", "bitwidth" : 7, "direction" : "READONLY"} ]}
# RTL Port declarations: 
set portNum 27
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ num_signals3 sc_in sc_lv 7 signal 0 } 
	{ empty sc_in sc_lv 9 signal 1 } 
	{ signal_def_mem_address0 sc_out sc_lv 9 signal 2 } 
	{ signal_def_mem_ce0 sc_out sc_logic 1 signal 2 } 
	{ signal_def_mem_q0 sc_in sc_lv 80 signal 2 } 
	{ signal_def_mem_address1 sc_out sc_lv 9 signal 2 } 
	{ signal_def_mem_ce1 sc_out sc_logic 1 signal 2 } 
	{ signal_def_mem_q1 sc_in sc_lv 80 signal 2 } 
	{ message_data2 sc_in sc_lv 64 signal 3 } 
	{ mul_ln164_reload sc_in sc_lv 16 signal 4 } 
	{ hash_table_accumulator_accumulated_values_address0 sc_out sc_lv 16 signal 5 } 
	{ hash_table_accumulator_accumulated_values_ce0 sc_out sc_logic 1 signal 5 } 
	{ hash_table_accumulator_accumulated_values_we0 sc_out sc_logic 1 signal 5 } 
	{ hash_table_accumulator_accumulated_values_d0 sc_out sc_lv 64 signal 5 } 
	{ hash_table_accumulator_accumulated_values_q0 sc_in sc_lv 64 signal 5 } 
	{ hash_table_accumulator_accumulated_values_address1 sc_out sc_lv 16 signal 5 } 
	{ hash_table_accumulator_accumulated_values_ce1 sc_out sc_logic 1 signal 5 } 
	{ hash_table_accumulator_accumulated_values_we1 sc_out sc_logic 1 signal 5 } 
	{ hash_table_accumulator_accumulated_values_d1 sc_out sc_lv 64 signal 5 } 
	{ hash_table_accumulator_accumulated_values_q1 sc_in sc_lv 64 signal 5 } 
	{ zext_ln117 sc_in sc_lv 7 signal 6 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "num_signals3", "direction": "in", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "num_signals3", "role": "default" }} , 
 	{ "name": "empty", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "empty", "role": "default" }} , 
 	{ "name": "signal_def_mem_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "signal_def_mem", "role": "address0" }} , 
 	{ "name": "signal_def_mem_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "signal_def_mem", "role": "ce0" }} , 
 	{ "name": "signal_def_mem_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":80, "type": "signal", "bundle":{"name": "signal_def_mem", "role": "q0" }} , 
 	{ "name": "signal_def_mem_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "signal_def_mem", "role": "address1" }} , 
 	{ "name": "signal_def_mem_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "signal_def_mem", "role": "ce1" }} , 
 	{ "name": "signal_def_mem_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":80, "type": "signal", "bundle":{"name": "signal_def_mem", "role": "q1" }} , 
 	{ "name": "message_data2", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "message_data2", "role": "default" }} , 
 	{ "name": "mul_ln164_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "mul_ln164_reload", "role": "default" }} , 
 	{ "name": "hash_table_accumulator_accumulated_values_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "hash_table_accumulator_accumulated_values", "role": "address0" }} , 
 	{ "name": "hash_table_accumulator_accumulated_values_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "hash_table_accumulator_accumulated_values", "role": "ce0" }} , 
 	{ "name": "hash_table_accumulator_accumulated_values_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "hash_table_accumulator_accumulated_values", "role": "we0" }} , 
 	{ "name": "hash_table_accumulator_accumulated_values_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "hash_table_accumulator_accumulated_values", "role": "d0" }} , 
 	{ "name": "hash_table_accumulator_accumulated_values_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "hash_table_accumulator_accumulated_values", "role": "q0" }} , 
 	{ "name": "hash_table_accumulator_accumulated_values_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "hash_table_accumulator_accumulated_values", "role": "address1" }} , 
 	{ "name": "hash_table_accumulator_accumulated_values_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "hash_table_accumulator_accumulated_values", "role": "ce1" }} , 
 	{ "name": "hash_table_accumulator_accumulated_values_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "hash_table_accumulator_accumulated_values", "role": "we1" }} , 
 	{ "name": "hash_table_accumulator_accumulated_values_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "hash_table_accumulator_accumulated_values", "role": "d1" }} , 
 	{ "name": "hash_table_accumulator_accumulated_values_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "hash_table_accumulator_accumulated_values", "role": "q1" }} , 
 	{ "name": "zext_ln117", "direction": "in", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "zext_ln117", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77"],
		"CDFG" : "decode_can_message_Pipeline_VITIS_LOOP_117_2",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "316", "EstimateLatencyMax" : "452",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "num_signals3", "Type" : "None", "Direction" : "I"},
			{"Name" : "empty", "Type" : "None", "Direction" : "I"},
			{"Name" : "signal_def_mem", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "message_data2", "Type" : "None", "Direction" : "I"},
			{"Name" : "mul_ln164_reload", "Type" : "None", "Direction" : "I"},
			{"Name" : "hash_table_accumulator_accumulated_values", "Type" : "Memory", "Direction" : "IO"},
			{"Name" : "zext_ln117", "Type" : "None", "Direction" : "I"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_117_2", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "68", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage43", "LastStateIter" : "ap_enable_reg_pp0_iter4", "LastStateBlock" : "ap_block_pp0_stage43_subdone", "QuitState" : "ap_ST_fsm_pp0_stage42", "QuitStateIter" : "ap_enable_reg_pp0_iter4", "QuitStateBlock" : "ap_block_pp0_stage42_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.dadd_64ns_64ns_64_5_full_dsp_1_U7", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.ddiv_64ns_64ns_64_31_no_dsp_1_U8", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.ddiv_64ns_64ns_64_31_no_dsp_1_U9", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.uitodp_32ns_64_5_no_dsp_1_U10", "Parent" : "0"},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.uitodp_32ns_64_5_no_dsp_1_U11", "Parent" : "0"},
	{"ID" : "6", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sitodp_64s_64_5_no_dsp_1_U12", "Parent" : "0"},
	{"ID" : "7", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sitodp_64s_64_5_no_dsp_1_U13", "Parent" : "0"},
	{"ID" : "8", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_32s_24ns_56_1_1_U14", "Parent" : "0"},
	{"ID" : "9", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U15", "Parent" : "0"},
	{"ID" : "10", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U16", "Parent" : "0"},
	{"ID" : "11", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U17", "Parent" : "0"},
	{"ID" : "12", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U18", "Parent" : "0"},
	{"ID" : "13", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U19", "Parent" : "0"},
	{"ID" : "14", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U20", "Parent" : "0"},
	{"ID" : "15", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U21", "Parent" : "0"},
	{"ID" : "16", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U22", "Parent" : "0"},
	{"ID" : "17", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U23", "Parent" : "0"},
	{"ID" : "18", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U24", "Parent" : "0"},
	{"ID" : "19", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U25", "Parent" : "0"},
	{"ID" : "20", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U26", "Parent" : "0"},
	{"ID" : "21", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U27", "Parent" : "0"},
	{"ID" : "22", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U28", "Parent" : "0"},
	{"ID" : "23", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U29", "Parent" : "0"},
	{"ID" : "24", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U30", "Parent" : "0"},
	{"ID" : "25", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U31", "Parent" : "0"},
	{"ID" : "26", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U32", "Parent" : "0"},
	{"ID" : "27", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U33", "Parent" : "0"},
	{"ID" : "28", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U34", "Parent" : "0"},
	{"ID" : "29", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U35", "Parent" : "0"},
	{"ID" : "30", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U36", "Parent" : "0"},
	{"ID" : "31", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U37", "Parent" : "0"},
	{"ID" : "32", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U38", "Parent" : "0"},
	{"ID" : "33", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U39", "Parent" : "0"},
	{"ID" : "34", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U40", "Parent" : "0"},
	{"ID" : "35", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U41", "Parent" : "0"},
	{"ID" : "36", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U42", "Parent" : "0"},
	{"ID" : "37", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U43", "Parent" : "0"},
	{"ID" : "38", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U44", "Parent" : "0"},
	{"ID" : "39", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U45", "Parent" : "0"},
	{"ID" : "40", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U46", "Parent" : "0"},
	{"ID" : "41", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U47", "Parent" : "0"},
	{"ID" : "42", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U48", "Parent" : "0"},
	{"ID" : "43", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U49", "Parent" : "0"},
	{"ID" : "44", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U50", "Parent" : "0"},
	{"ID" : "45", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U51", "Parent" : "0"},
	{"ID" : "46", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U52", "Parent" : "0"},
	{"ID" : "47", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U53", "Parent" : "0"},
	{"ID" : "48", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U54", "Parent" : "0"},
	{"ID" : "49", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U55", "Parent" : "0"},
	{"ID" : "50", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U56", "Parent" : "0"},
	{"ID" : "51", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U57", "Parent" : "0"},
	{"ID" : "52", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U58", "Parent" : "0"},
	{"ID" : "53", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U59", "Parent" : "0"},
	{"ID" : "54", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U60", "Parent" : "0"},
	{"ID" : "55", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U61", "Parent" : "0"},
	{"ID" : "56", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U62", "Parent" : "0"},
	{"ID" : "57", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U63", "Parent" : "0"},
	{"ID" : "58", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U64", "Parent" : "0"},
	{"ID" : "59", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U65", "Parent" : "0"},
	{"ID" : "60", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U66", "Parent" : "0"},
	{"ID" : "61", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U67", "Parent" : "0"},
	{"ID" : "62", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U68", "Parent" : "0"},
	{"ID" : "63", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U69", "Parent" : "0"},
	{"ID" : "64", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U70", "Parent" : "0"},
	{"ID" : "65", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U71", "Parent" : "0"},
	{"ID" : "66", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U72", "Parent" : "0"},
	{"ID" : "67", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U73", "Parent" : "0"},
	{"ID" : "68", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U74", "Parent" : "0"},
	{"ID" : "69", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U75", "Parent" : "0"},
	{"ID" : "70", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U76", "Parent" : "0"},
	{"ID" : "71", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U77", "Parent" : "0"},
	{"ID" : "72", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U78", "Parent" : "0"},
	{"ID" : "73", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U79", "Parent" : "0"},
	{"ID" : "74", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U80", "Parent" : "0"},
	{"ID" : "75", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U81", "Parent" : "0"},
	{"ID" : "76", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_9_3_32_1_1_U82", "Parent" : "0"},
	{"ID" : "77", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.flow_control_loop_pipe_sequential_init_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	decode_can_message_Pipeline_VITIS_LOOP_117_2 {
		num_signals3 {Type I LastRead 0 FirstWrite -1}
		empty {Type I LastRead 0 FirstWrite -1}
		signal_def_mem {Type I LastRead 34 FirstWrite -1}
		message_data2 {Type I LastRead 0 FirstWrite -1}
		mul_ln164_reload {Type I LastRead 0 FirstWrite -1}
		hash_table_accumulator_accumulated_values {Type IO LastRead 34 FirstWrite 111}
		zext_ln117 {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "316", "Max" : "452"}
	, {"Name" : "Interval", "Min" : "316", "Max" : "452"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	num_signals3 { ap_none {  { num_signals3 in_data 0 7 } } }
	empty { ap_none {  { empty in_data 0 9 } } }
	signal_def_mem { ap_memory {  { signal_def_mem_address0 mem_address 1 9 }  { signal_def_mem_ce0 mem_ce 1 1 }  { signal_def_mem_q0 mem_dout 0 80 }  { signal_def_mem_address1 MemPortADDR2 1 9 }  { signal_def_mem_ce1 MemPortCE2 1 1 }  { signal_def_mem_q1 MemPortDOUT2 0 80 } } }
	message_data2 { ap_none {  { message_data2 in_data 0 64 } } }
	mul_ln164_reload { ap_none {  { mul_ln164_reload in_data 0 16 } } }
	hash_table_accumulator_accumulated_values { ap_memory {  { hash_table_accumulator_accumulated_values_address0 mem_address 1 16 }  { hash_table_accumulator_accumulated_values_ce0 mem_ce 1 1 }  { hash_table_accumulator_accumulated_values_we0 mem_we 1 1 }  { hash_table_accumulator_accumulated_values_d0 mem_din 1 64 }  { hash_table_accumulator_accumulated_values_q0 mem_dout 0 64 }  { hash_table_accumulator_accumulated_values_address1 MemPortADDR2 1 16 }  { hash_table_accumulator_accumulated_values_ce1 MemPortCE2 1 1 }  { hash_table_accumulator_accumulated_values_we1 MemPortWE2 1 1 }  { hash_table_accumulator_accumulated_values_d1 MemPortDIN2 1 64 }  { hash_table_accumulator_accumulated_values_q1 MemPortDOUT2 0 64 } } }
	zext_ln117 { ap_none {  { zext_ln117 in_data 0 7 } } }
}
