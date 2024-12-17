set moduleName decode_can_message_Pipeline_VITIS_LOOP_84_1
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
set C_modelName {decode_can_message_Pipeline_VITIS_LOOP_84_1}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict hash_table_message_id { MEM_WIDTH 29 MEM_SIZE 2048 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ zext_ln84 int 9 regular  }
	{ hash_table_message_id int 29 regular {array 512 { 1 3 } 1 1 }  }
	{ empty int 29 regular  }
	{ hash_index_1_out int 9 regular {pointer 1}  }
	{ mul_ln164_out int 16 regular {pointer 1}  }
	{ icmp_ln84_out int 1 regular {pointer 1}  }
}
set hasAXIMCache 0
set hasAXIML2Cache 0
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "zext_ln84", "interface" : "wire", "bitwidth" : 9, "direction" : "READONLY"} , 
 	{ "Name" : "hash_table_message_id", "interface" : "memory", "bitwidth" : 29, "direction" : "READONLY"} , 
 	{ "Name" : "empty", "interface" : "wire", "bitwidth" : 29, "direction" : "READONLY"} , 
 	{ "Name" : "hash_index_1_out", "interface" : "wire", "bitwidth" : 9, "direction" : "WRITEONLY"} , 
 	{ "Name" : "mul_ln164_out", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "icmp_ln84_out", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 17
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ zext_ln84 sc_in sc_lv 9 signal 0 } 
	{ hash_table_message_id_address0 sc_out sc_lv 9 signal 1 } 
	{ hash_table_message_id_ce0 sc_out sc_logic 1 signal 1 } 
	{ hash_table_message_id_q0 sc_in sc_lv 29 signal 1 } 
	{ empty sc_in sc_lv 29 signal 2 } 
	{ hash_index_1_out sc_out sc_lv 9 signal 3 } 
	{ hash_index_1_out_ap_vld sc_out sc_logic 1 outvld 3 } 
	{ mul_ln164_out sc_out sc_lv 16 signal 4 } 
	{ mul_ln164_out_ap_vld sc_out sc_logic 1 outvld 4 } 
	{ icmp_ln84_out sc_out sc_lv 1 signal 5 } 
	{ icmp_ln84_out_ap_vld sc_out sc_logic 1 outvld 5 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "zext_ln84", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "zext_ln84", "role": "default" }} , 
 	{ "name": "hash_table_message_id_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "hash_table_message_id", "role": "address0" }} , 
 	{ "name": "hash_table_message_id_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "hash_table_message_id", "role": "ce0" }} , 
 	{ "name": "hash_table_message_id_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":29, "type": "signal", "bundle":{"name": "hash_table_message_id", "role": "q0" }} , 
 	{ "name": "empty", "direction": "in", "datatype": "sc_lv", "bitwidth":29, "type": "signal", "bundle":{"name": "empty", "role": "default" }} , 
 	{ "name": "hash_index_1_out", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "hash_index_1_out", "role": "default" }} , 
 	{ "name": "hash_index_1_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "hash_index_1_out", "role": "ap_vld" }} , 
 	{ "name": "mul_ln164_out", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "mul_ln164_out", "role": "default" }} , 
 	{ "name": "mul_ln164_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "mul_ln164_out", "role": "ap_vld" }} , 
 	{ "name": "icmp_ln84_out", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "icmp_ln84_out", "role": "default" }} , 
 	{ "name": "icmp_ln84_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "icmp_ln84_out", "role": "ap_vld" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1"],
		"CDFG" : "decode_can_message_Pipeline_VITIS_LOOP_84_1",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "zext_ln84", "Type" : "None", "Direction" : "I"},
			{"Name" : "hash_table_message_id", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "empty", "Type" : "None", "Direction" : "I"},
			{"Name" : "hash_index_1_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "mul_ln164_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "icmp_ln84_out", "Type" : "Vld", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_84_1", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "2", "FirstState" : "ap_ST_fsm_state1", "FirstStateIter" : "", "FirstStateBlock" : "ap_ST_fsm_state1_blk", "LastState" : "ap_ST_fsm_state2", "LastStateIter" : "", "LastStateBlock" : "ap_ST_fsm_state2_blk", "QuitState" : "ap_ST_fsm_state2", "QuitStateIter" : "", "QuitStateBlock" : "ap_ST_fsm_state2_blk", "OneDepthLoop" : "1", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.flow_control_loop_pipe_sequential_init_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	decode_can_message_Pipeline_VITIS_LOOP_84_1 {
		zext_ln84 {Type I LastRead 0 FirstWrite -1}
		hash_table_message_id {Type I LastRead 0 FirstWrite -1}
		empty {Type I LastRead 0 FirstWrite -1}
		hash_index_1_out {Type O LastRead -1 FirstWrite 1}
		mul_ln164_out {Type O LastRead -1 FirstWrite 1}
		icmp_ln84_out {Type O LastRead -1 FirstWrite 1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "-1", "Max" : "-1"}
	, {"Name" : "Interval", "Min" : "-1", "Max" : "-1"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	zext_ln84 { ap_none {  { zext_ln84 in_data 0 9 } } }
	hash_table_message_id { ap_memory {  { hash_table_message_id_address0 mem_address 1 9 }  { hash_table_message_id_ce0 mem_ce 1 1 }  { hash_table_message_id_q0 mem_dout 0 29 } } }
	empty { ap_none {  { empty in_data 0 29 } } }
	hash_index_1_out { ap_vld {  { hash_index_1_out out_data 1 9 }  { hash_index_1_out_ap_vld out_vld 1 1 } } }
	mul_ln164_out { ap_vld {  { mul_ln164_out out_data 1 16 }  { mul_ln164_out_ap_vld out_vld 1 1 } } }
	icmp_ln84_out { ap_vld {  { icmp_ln84_out out_data 1 1 }  { icmp_ln84_out_ap_vld out_vld 1 1 } } }
}
