set moduleName decode_can_message_Pipeline_VITIS_LOOP_182_4
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
set C_modelName {decode_can_message_Pipeline_VITIS_LOOP_182_4}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict hash_table_accumulator_accumulated_values { MEM_WIDTH 64 MEM_SIZE 278528 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict signal_def_mem { MEM_WIDTH 80 MEM_SIZE 5120 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict decoded_signals { MEM_WIDTH 43 MEM_SIZE 408 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ empty_27 int 7 regular  }
	{ num_signals_150 int 7 regular  }
	{ mul_ln184 int 16 regular  }
	{ hash_table_accumulator_accumulated_values int 64 regular {array 34816 { 0 1 } 1 1 }  }
	{ empty int 9 regular  }
	{ signal_def_mem int 80 regular {array 512 { 1 3 } 1 1 }  }
	{ conv_i32 int 32 regular  }
	{ decoded_signals int 43 regular {array 68 { 0 3 } 0 1 }  }
}
set hasAXIMCache 0
set hasAXIML2Cache 0
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "empty_27", "interface" : "wire", "bitwidth" : 7, "direction" : "READONLY"} , 
 	{ "Name" : "num_signals_150", "interface" : "wire", "bitwidth" : 7, "direction" : "READONLY"} , 
 	{ "Name" : "mul_ln184", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "hash_table_accumulator_accumulated_values", "interface" : "memory", "bitwidth" : 64, "direction" : "READWRITE"} , 
 	{ "Name" : "empty", "interface" : "wire", "bitwidth" : 9, "direction" : "READONLY"} , 
 	{ "Name" : "signal_def_mem", "interface" : "memory", "bitwidth" : 80, "direction" : "READONLY"} , 
 	{ "Name" : "conv_i32", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "decoded_signals", "interface" : "memory", "bitwidth" : 43, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 25
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ empty_27 sc_in sc_lv 7 signal 0 } 
	{ num_signals_150 sc_in sc_lv 7 signal 1 } 
	{ mul_ln184 sc_in sc_lv 16 signal 2 } 
	{ hash_table_accumulator_accumulated_values_address0 sc_out sc_lv 16 signal 3 } 
	{ hash_table_accumulator_accumulated_values_ce0 sc_out sc_logic 1 signal 3 } 
	{ hash_table_accumulator_accumulated_values_we0 sc_out sc_logic 1 signal 3 } 
	{ hash_table_accumulator_accumulated_values_d0 sc_out sc_lv 64 signal 3 } 
	{ hash_table_accumulator_accumulated_values_address1 sc_out sc_lv 16 signal 3 } 
	{ hash_table_accumulator_accumulated_values_ce1 sc_out sc_logic 1 signal 3 } 
	{ hash_table_accumulator_accumulated_values_q1 sc_in sc_lv 64 signal 3 } 
	{ empty sc_in sc_lv 9 signal 4 } 
	{ signal_def_mem_address0 sc_out sc_lv 9 signal 5 } 
	{ signal_def_mem_ce0 sc_out sc_logic 1 signal 5 } 
	{ signal_def_mem_q0 sc_in sc_lv 80 signal 5 } 
	{ conv_i32 sc_in sc_lv 32 signal 6 } 
	{ decoded_signals_address0 sc_out sc_lv 7 signal 7 } 
	{ decoded_signals_ce0 sc_out sc_logic 1 signal 7 } 
	{ decoded_signals_we0 sc_out sc_logic 1 signal 7 } 
	{ decoded_signals_d0 sc_out sc_lv 43 signal 7 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "empty_27", "direction": "in", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "empty_27", "role": "default" }} , 
 	{ "name": "num_signals_150", "direction": "in", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "num_signals_150", "role": "default" }} , 
 	{ "name": "mul_ln184", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "mul_ln184", "role": "default" }} , 
 	{ "name": "hash_table_accumulator_accumulated_values_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "hash_table_accumulator_accumulated_values", "role": "address0" }} , 
 	{ "name": "hash_table_accumulator_accumulated_values_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "hash_table_accumulator_accumulated_values", "role": "ce0" }} , 
 	{ "name": "hash_table_accumulator_accumulated_values_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "hash_table_accumulator_accumulated_values", "role": "we0" }} , 
 	{ "name": "hash_table_accumulator_accumulated_values_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "hash_table_accumulator_accumulated_values", "role": "d0" }} , 
 	{ "name": "hash_table_accumulator_accumulated_values_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "hash_table_accumulator_accumulated_values", "role": "address1" }} , 
 	{ "name": "hash_table_accumulator_accumulated_values_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "hash_table_accumulator_accumulated_values", "role": "ce1" }} , 
 	{ "name": "hash_table_accumulator_accumulated_values_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "hash_table_accumulator_accumulated_values", "role": "q1" }} , 
 	{ "name": "empty", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "empty", "role": "default" }} , 
 	{ "name": "signal_def_mem_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "signal_def_mem", "role": "address0" }} , 
 	{ "name": "signal_def_mem_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "signal_def_mem", "role": "ce0" }} , 
 	{ "name": "signal_def_mem_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":80, "type": "signal", "bundle":{"name": "signal_def_mem", "role": "q0" }} , 
 	{ "name": "conv_i32", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "conv_i32", "role": "default" }} , 
 	{ "name": "decoded_signals_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "decoded_signals", "role": "address0" }} , 
 	{ "name": "decoded_signals_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "decoded_signals", "role": "ce0" }} , 
 	{ "name": "decoded_signals_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "decoded_signals", "role": "we0" }} , 
 	{ "name": "decoded_signals_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":43, "type": "signal", "bundle":{"name": "decoded_signals", "role": "d0" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2"],
		"CDFG" : "decode_can_message_Pipeline_VITIS_LOOP_182_4",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "2", "EstimateLatencyMax" : "196",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "empty_27", "Type" : "None", "Direction" : "I"},
			{"Name" : "num_signals_150", "Type" : "None", "Direction" : "I"},
			{"Name" : "mul_ln184", "Type" : "None", "Direction" : "I"},
			{"Name" : "hash_table_accumulator_accumulated_values", "Type" : "Memory", "Direction" : "IO"},
			{"Name" : "empty", "Type" : "None", "Direction" : "I"},
			{"Name" : "signal_def_mem", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "conv_i32", "Type" : "None", "Direction" : "I"},
			{"Name" : "decoded_signals", "Type" : "Memory", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_182_4", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage0", "LastStateIter" : "ap_enable_reg_pp0_iter68", "LastStateBlock" : "ap_block_pp0_stage0_subdone", "QuitState" : "ap_ST_fsm_pp0_stage0", "QuitStateIter" : "ap_enable_reg_pp0_iter68", "QuitStateBlock" : "ap_block_pp0_stage0_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sdiv_64ns_33ns_32_68_1_U96", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.flow_control_loop_pipe_sequential_init_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	decode_can_message_Pipeline_VITIS_LOOP_182_4 {
		empty_27 {Type I LastRead 0 FirstWrite -1}
		num_signals_150 {Type I LastRead 0 FirstWrite -1}
		mul_ln184 {Type I LastRead 0 FirstWrite -1}
		hash_table_accumulator_accumulated_values {Type IO LastRead 0 FirstWrite 1}
		empty {Type I LastRead 0 FirstWrite -1}
		signal_def_mem {Type I LastRead 67 FirstWrite -1}
		conv_i32 {Type I LastRead 0 FirstWrite -1}
		decoded_signals {Type O LastRead -1 FirstWrite 68}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "2", "Max" : "196"}
	, {"Name" : "Interval", "Min" : "2", "Max" : "196"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	empty_27 { ap_none {  { empty_27 in_data 0 7 } } }
	num_signals_150 { ap_none {  { num_signals_150 in_data 0 7 } } }
	mul_ln184 { ap_none {  { mul_ln184 in_data 0 16 } } }
	hash_table_accumulator_accumulated_values { ap_memory {  { hash_table_accumulator_accumulated_values_address0 mem_address 1 16 }  { hash_table_accumulator_accumulated_values_ce0 mem_ce 1 1 }  { hash_table_accumulator_accumulated_values_we0 mem_we 1 1 }  { hash_table_accumulator_accumulated_values_d0 mem_din 1 64 }  { hash_table_accumulator_accumulated_values_address1 MemPortADDR2 1 16 }  { hash_table_accumulator_accumulated_values_ce1 MemPortCE2 1 1 }  { hash_table_accumulator_accumulated_values_q1 MemPortDOUT2 0 64 } } }
	empty { ap_none {  { empty in_data 0 9 } } }
	signal_def_mem { ap_memory {  { signal_def_mem_address0 mem_address 1 9 }  { signal_def_mem_ce0 mem_ce 1 1 }  { signal_def_mem_q0 mem_dout 0 80 } } }
	conv_i32 { ap_none {  { conv_i32 in_data 0 32 } } }
	decoded_signals { ap_memory {  { decoded_signals_address0 mem_address 1 7 }  { decoded_signals_ce0 mem_ce 1 1 }  { decoded_signals_we0 mem_we 1 1 }  { decoded_signals_d0 mem_din 1 43 } } }
}
