set moduleName decode_can_message
set isTopModule 1
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set C_modelName {decode_can_message}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict decoded_signals { MEM_WIDTH 43 MEM_SIZE 408 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict hash_table_message_id { MEM_WIDTH 29 MEM_SIZE 2048 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict hash_table_lut_index { MEM_WIDTH 32 MEM_SIZE 2048 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict hash_table_accumulator_accumulated_values { MEM_WIDTH 64 MEM_SIZE 278528 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict hash_table_accumulator_counter { MEM_WIDTH 32 MEM_SIZE 2048 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict msg_lut { MEM_WIDTH 56 MEM_SIZE 3584 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict signal_def_mem { MEM_WIDTH 80 MEM_SIZE 5120 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ message int 128 regular {axi_slave 0}  }
	{ decoded_signals int 43 regular {array 68 { 0 3 } 0 1 }  }
	{ num_decoded_signals int 32 regular {axi_slave 2}  }
	{ hash_table_message_id int 29 regular {array 512 { 1 3 } 1 1 }  }
	{ hash_table_lut_index int 32 regular {array 512 { 1 3 } 1 1 }  }
	{ hash_table_accumulator_accumulated_values int 64 regular {array 34816 { 2 2 } 1 1 }  }
	{ hash_table_accumulator_counter int 32 regular {array 512 { 2 3 } 1 1 }  }
	{ msg_lut int 56 regular {array 512 { 1 3 } 1 1 }  }
	{ signal_def_mem int 80 regular {array 512 { 1 1 } 1 1 }  }
}
set hasAXIMCache 0
set hasAXIML2Cache 0
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "message", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 128, "direction" : "READONLY", "offset" : {"in":16}, "offset_end" : {"in":35}} , 
 	{ "Name" : "decoded_signals", "interface" : "memory", "bitwidth" : 43, "direction" : "WRITEONLY"} , 
 	{ "Name" : "num_decoded_signals", "interface" : "axi_slave", "bundle":"control","type":"ap_ovld","bitwidth" : 32, "direction" : "READWRITE", "offset" : {"in":36, "out":44}, "offset_end" : {"in":43, "out":51}} , 
 	{ "Name" : "hash_table_message_id", "interface" : "memory", "bitwidth" : 29, "direction" : "READONLY"} , 
 	{ "Name" : "hash_table_lut_index", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "hash_table_accumulator_accumulated_values", "interface" : "memory", "bitwidth" : 64, "direction" : "READWRITE"} , 
 	{ "Name" : "hash_table_accumulator_counter", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "msg_lut", "interface" : "memory", "bitwidth" : 56, "direction" : "READONLY"} , 
 	{ "Name" : "signal_def_mem", "interface" : "memory", "bitwidth" : 80, "direction" : "READONLY"} ]}
# RTL Port declarations: 
set portNum 57
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst_n sc_in sc_logic 1 reset -1 active_low_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ decoded_signals_address0 sc_out sc_lv 7 signal 1 } 
	{ decoded_signals_ce0 sc_out sc_logic 1 signal 1 } 
	{ decoded_signals_we0 sc_out sc_logic 1 signal 1 } 
	{ decoded_signals_d0 sc_out sc_lv 43 signal 1 } 
	{ hash_table_message_id_address0 sc_out sc_lv 9 signal 3 } 
	{ hash_table_message_id_ce0 sc_out sc_logic 1 signal 3 } 
	{ hash_table_message_id_q0 sc_in sc_lv 29 signal 3 } 
	{ hash_table_lut_index_address0 sc_out sc_lv 9 signal 4 } 
	{ hash_table_lut_index_ce0 sc_out sc_logic 1 signal 4 } 
	{ hash_table_lut_index_q0 sc_in sc_lv 32 signal 4 } 
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
	{ hash_table_accumulator_counter_address0 sc_out sc_lv 9 signal 6 } 
	{ hash_table_accumulator_counter_ce0 sc_out sc_logic 1 signal 6 } 
	{ hash_table_accumulator_counter_we0 sc_out sc_logic 1 signal 6 } 
	{ hash_table_accumulator_counter_d0 sc_out sc_lv 32 signal 6 } 
	{ hash_table_accumulator_counter_q0 sc_in sc_lv 32 signal 6 } 
	{ msg_lut_address0 sc_out sc_lv 9 signal 7 } 
	{ msg_lut_ce0 sc_out sc_logic 1 signal 7 } 
	{ msg_lut_q0 sc_in sc_lv 56 signal 7 } 
	{ signal_def_mem_address0 sc_out sc_lv 9 signal 8 } 
	{ signal_def_mem_ce0 sc_out sc_logic 1 signal 8 } 
	{ signal_def_mem_q0 sc_in sc_lv 80 signal 8 } 
	{ signal_def_mem_address1 sc_out sc_lv 9 signal 8 } 
	{ signal_def_mem_ce1 sc_out sc_logic 1 signal 8 } 
	{ signal_def_mem_q1 sc_in sc_lv 80 signal 8 } 
	{ s_axi_control_AWVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_AWREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_AWADDR sc_in sc_lv 6 signal -1 } 
	{ s_axi_control_WVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_WREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_WDATA sc_in sc_lv 32 signal -1 } 
	{ s_axi_control_WSTRB sc_in sc_lv 4 signal -1 } 
	{ s_axi_control_ARVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_ARREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_ARADDR sc_in sc_lv 6 signal -1 } 
	{ s_axi_control_RVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_RREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_RDATA sc_out sc_lv 32 signal -1 } 
	{ s_axi_control_RRESP sc_out sc_lv 2 signal -1 } 
	{ s_axi_control_BVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_BREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_BRESP sc_out sc_lv 2 signal -1 } 
}
set NewPortList {[ 
	{ "name": "s_axi_control_AWADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "control", "role": "AWADDR" },"address":[{"name":"message","role":"data","value":"16"},{"name":"num_decoded_signals","role":"data","value":"36"}] },
	{ "name": "s_axi_control_AWVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWVALID" } },
	{ "name": "s_axi_control_AWREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWREADY" } },
	{ "name": "s_axi_control_WVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WVALID" } },
	{ "name": "s_axi_control_WREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WREADY" } },
	{ "name": "s_axi_control_WDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control", "role": "WDATA" } },
	{ "name": "s_axi_control_WSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "control", "role": "WSTRB" } },
	{ "name": "s_axi_control_ARADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "control", "role": "ARADDR" },"address":[{"name":"num_decoded_signals","role":"data","value":"44"}, {"name":"num_decoded_signals","role":"valid","value":"48","valid_bit":"0"}] },
	{ "name": "s_axi_control_ARVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "ARVALID" } },
	{ "name": "s_axi_control_ARREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "ARREADY" } },
	{ "name": "s_axi_control_RVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "RVALID" } },
	{ "name": "s_axi_control_RREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "RREADY" } },
	{ "name": "s_axi_control_RDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control", "role": "RDATA" } },
	{ "name": "s_axi_control_RRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "control", "role": "RRESP" } },
	{ "name": "s_axi_control_BVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "BVALID" } },
	{ "name": "s_axi_control_BREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "BREADY" } },
	{ "name": "s_axi_control_BRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "control", "role": "BRESP" } }, 
 	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst_n", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "decoded_signals_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "decoded_signals", "role": "address0" }} , 
 	{ "name": "decoded_signals_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "decoded_signals", "role": "ce0" }} , 
 	{ "name": "decoded_signals_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "decoded_signals", "role": "we0" }} , 
 	{ "name": "decoded_signals_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":43, "type": "signal", "bundle":{"name": "decoded_signals", "role": "d0" }} , 
 	{ "name": "hash_table_message_id_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "hash_table_message_id", "role": "address0" }} , 
 	{ "name": "hash_table_message_id_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "hash_table_message_id", "role": "ce0" }} , 
 	{ "name": "hash_table_message_id_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":29, "type": "signal", "bundle":{"name": "hash_table_message_id", "role": "q0" }} , 
 	{ "name": "hash_table_lut_index_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "hash_table_lut_index", "role": "address0" }} , 
 	{ "name": "hash_table_lut_index_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "hash_table_lut_index", "role": "ce0" }} , 
 	{ "name": "hash_table_lut_index_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "hash_table_lut_index", "role": "q0" }} , 
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
 	{ "name": "hash_table_accumulator_counter_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "hash_table_accumulator_counter", "role": "address0" }} , 
 	{ "name": "hash_table_accumulator_counter_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "hash_table_accumulator_counter", "role": "ce0" }} , 
 	{ "name": "hash_table_accumulator_counter_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "hash_table_accumulator_counter", "role": "we0" }} , 
 	{ "name": "hash_table_accumulator_counter_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "hash_table_accumulator_counter", "role": "d0" }} , 
 	{ "name": "hash_table_accumulator_counter_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "hash_table_accumulator_counter", "role": "q0" }} , 
 	{ "name": "msg_lut_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "msg_lut", "role": "address0" }} , 
 	{ "name": "msg_lut_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "msg_lut", "role": "ce0" }} , 
 	{ "name": "msg_lut_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":56, "type": "signal", "bundle":{"name": "msg_lut", "role": "q0" }} , 
 	{ "name": "signal_def_mem_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "signal_def_mem", "role": "address0" }} , 
 	{ "name": "signal_def_mem_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "signal_def_mem", "role": "ce0" }} , 
 	{ "name": "signal_def_mem_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":80, "type": "signal", "bundle":{"name": "signal_def_mem", "role": "q0" }} , 
 	{ "name": "signal_def_mem_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "signal_def_mem", "role": "address1" }} , 
 	{ "name": "signal_def_mem_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "signal_def_mem", "role": "ce1" }} , 
 	{ "name": "signal_def_mem_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":80, "type": "signal", "bundle":{"name": "signal_def_mem", "role": "q1" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "3", "81", "84"],
		"CDFG" : "decode_can_message",
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
			{"Name" : "message", "Type" : "None", "Direction" : "I"},
			{"Name" : "decoded_signals", "Type" : "Memory", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "81", "SubInstance" : "grp_decode_can_message_Pipeline_VITIS_LOOP_182_4_fu_229", "Port" : "decoded_signals", "Inst_start_state" : "11", "Inst_end_state" : "12"}]},
			{"Name" : "num_decoded_signals", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "hash_table_message_id", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_decode_can_message_Pipeline_VITIS_LOOP_84_1_fu_205", "Port" : "hash_table_message_id", "Inst_start_state" : "1", "Inst_end_state" : "2"}]},
			{"Name" : "hash_table_lut_index", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "hash_table_accumulator_accumulated_values", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "3", "SubInstance" : "grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216", "Port" : "hash_table_accumulator_accumulated_values", "Inst_start_state" : "6", "Inst_end_state" : "7"},
					{"ID" : "81", "SubInstance" : "grp_decode_can_message_Pipeline_VITIS_LOOP_182_4_fu_229", "Port" : "hash_table_accumulator_accumulated_values", "Inst_start_state" : "11", "Inst_end_state" : "12"}]},
			{"Name" : "hash_table_accumulator_counter", "Type" : "Memory", "Direction" : "IO"},
			{"Name" : "msg_lut", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "signal_def_mem", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "3", "SubInstance" : "grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216", "Port" : "signal_def_mem", "Inst_start_state" : "6", "Inst_end_state" : "7"},
					{"ID" : "81", "SubInstance" : "grp_decode_can_message_Pipeline_VITIS_LOOP_182_4_fu_229", "Port" : "signal_def_mem", "Inst_start_state" : "11", "Inst_end_state" : "12"}]},
			{"Name" : "timer", "Type" : "Vld", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_172_3", "PipelineType" : "no",
				"LoopDec" : {"FSMBitwidth" : "12", "FirstState" : "ap_ST_fsm_state8", "LastState" : ["ap_ST_fsm_state12"], "QuitState" : ["ap_ST_fsm_state8"], "PreState" : ["ap_ST_fsm_state3", "ap_ST_fsm_state7"], "PostState" : ["ap_ST_fsm_state1"], "OneDepthLoop" : "0", "OneStateBlock": ""}}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_84_1_fu_205", "Parent" : "0", "Child" : ["2"],
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
	{"ID" : "2", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_84_1_fu_205.flow_control_loop_pipe_sequential_init_U", "Parent" : "1"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216", "Parent" : "0", "Child" : ["4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80"],
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
	{"ID" : "4", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.dadd_64ns_64ns_64_5_full_dsp_1_U7", "Parent" : "3"},
	{"ID" : "5", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.ddiv_64ns_64ns_64_31_no_dsp_1_U8", "Parent" : "3"},
	{"ID" : "6", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.ddiv_64ns_64ns_64_31_no_dsp_1_U9", "Parent" : "3"},
	{"ID" : "7", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.uitodp_32ns_64_5_no_dsp_1_U10", "Parent" : "3"},
	{"ID" : "8", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.uitodp_32ns_64_5_no_dsp_1_U11", "Parent" : "3"},
	{"ID" : "9", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sitodp_64s_64_5_no_dsp_1_U12", "Parent" : "3"},
	{"ID" : "10", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sitodp_64s_64_5_no_dsp_1_U13", "Parent" : "3"},
	{"ID" : "11", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.mul_32s_24ns_56_1_1_U14", "Parent" : "3"},
	{"ID" : "12", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U15", "Parent" : "3"},
	{"ID" : "13", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U16", "Parent" : "3"},
	{"ID" : "14", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U17", "Parent" : "3"},
	{"ID" : "15", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U18", "Parent" : "3"},
	{"ID" : "16", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U19", "Parent" : "3"},
	{"ID" : "17", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U20", "Parent" : "3"},
	{"ID" : "18", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U21", "Parent" : "3"},
	{"ID" : "19", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U22", "Parent" : "3"},
	{"ID" : "20", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U23", "Parent" : "3"},
	{"ID" : "21", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U24", "Parent" : "3"},
	{"ID" : "22", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U25", "Parent" : "3"},
	{"ID" : "23", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U26", "Parent" : "3"},
	{"ID" : "24", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U27", "Parent" : "3"},
	{"ID" : "25", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U28", "Parent" : "3"},
	{"ID" : "26", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U29", "Parent" : "3"},
	{"ID" : "27", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U30", "Parent" : "3"},
	{"ID" : "28", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U31", "Parent" : "3"},
	{"ID" : "29", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U32", "Parent" : "3"},
	{"ID" : "30", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U33", "Parent" : "3"},
	{"ID" : "31", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U34", "Parent" : "3"},
	{"ID" : "32", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U35", "Parent" : "3"},
	{"ID" : "33", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U36", "Parent" : "3"},
	{"ID" : "34", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U37", "Parent" : "3"},
	{"ID" : "35", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U38", "Parent" : "3"},
	{"ID" : "36", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U39", "Parent" : "3"},
	{"ID" : "37", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U40", "Parent" : "3"},
	{"ID" : "38", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U41", "Parent" : "3"},
	{"ID" : "39", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U42", "Parent" : "3"},
	{"ID" : "40", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U43", "Parent" : "3"},
	{"ID" : "41", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U44", "Parent" : "3"},
	{"ID" : "42", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U45", "Parent" : "3"},
	{"ID" : "43", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U46", "Parent" : "3"},
	{"ID" : "44", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U47", "Parent" : "3"},
	{"ID" : "45", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U48", "Parent" : "3"},
	{"ID" : "46", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U49", "Parent" : "3"},
	{"ID" : "47", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U50", "Parent" : "3"},
	{"ID" : "48", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U51", "Parent" : "3"},
	{"ID" : "49", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U52", "Parent" : "3"},
	{"ID" : "50", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U53", "Parent" : "3"},
	{"ID" : "51", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U54", "Parent" : "3"},
	{"ID" : "52", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U55", "Parent" : "3"},
	{"ID" : "53", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U56", "Parent" : "3"},
	{"ID" : "54", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U57", "Parent" : "3"},
	{"ID" : "55", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U58", "Parent" : "3"},
	{"ID" : "56", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U59", "Parent" : "3"},
	{"ID" : "57", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U60", "Parent" : "3"},
	{"ID" : "58", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U61", "Parent" : "3"},
	{"ID" : "59", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U62", "Parent" : "3"},
	{"ID" : "60", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U63", "Parent" : "3"},
	{"ID" : "61", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U64", "Parent" : "3"},
	{"ID" : "62", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U65", "Parent" : "3"},
	{"ID" : "63", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U66", "Parent" : "3"},
	{"ID" : "64", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U67", "Parent" : "3"},
	{"ID" : "65", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U68", "Parent" : "3"},
	{"ID" : "66", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U69", "Parent" : "3"},
	{"ID" : "67", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U70", "Parent" : "3"},
	{"ID" : "68", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U71", "Parent" : "3"},
	{"ID" : "69", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U72", "Parent" : "3"},
	{"ID" : "70", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U73", "Parent" : "3"},
	{"ID" : "71", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U74", "Parent" : "3"},
	{"ID" : "72", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U75", "Parent" : "3"},
	{"ID" : "73", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U76", "Parent" : "3"},
	{"ID" : "74", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U77", "Parent" : "3"},
	{"ID" : "75", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U78", "Parent" : "3"},
	{"ID" : "76", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U79", "Parent" : "3"},
	{"ID" : "77", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U80", "Parent" : "3"},
	{"ID" : "78", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U81", "Parent" : "3"},
	{"ID" : "79", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.sparsemux_9_3_32_1_1_U82", "Parent" : "3"},
	{"ID" : "80", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216.flow_control_loop_pipe_sequential_init_U", "Parent" : "3"},
	{"ID" : "81", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_182_4_fu_229", "Parent" : "0", "Child" : ["82", "83"],
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
	{"ID" : "82", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_182_4_fu_229.sdiv_64ns_33ns_32_68_1_U96", "Parent" : "81"},
	{"ID" : "83", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_decode_can_message_Pipeline_VITIS_LOOP_182_4_fu_229.flow_control_loop_pipe_sequential_init_U", "Parent" : "81"},
	{"ID" : "84", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.control_s_axi_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	decode_can_message {
		message {Type I LastRead 0 FirstWrite -1}
		decoded_signals {Type O LastRead -1 FirstWrite 68}
		num_decoded_signals {Type IO LastRead 10 FirstWrite 11}
		hash_table_message_id {Type I LastRead 0 FirstWrite -1}
		hash_table_lut_index {Type I LastRead 8 FirstWrite -1}
		hash_table_accumulator_accumulated_values {Type IO LastRead 34 FirstWrite 1}
		hash_table_accumulator_counter {Type IO LastRead 7 FirstWrite 3}
		msg_lut {Type I LastRead 9 FirstWrite -1}
		signal_def_mem {Type I LastRead 67 FirstWrite -1}
		timer {Type O LastRead -1 FirstWrite -1}}
	decode_can_message_Pipeline_VITIS_LOOP_84_1 {
		zext_ln84 {Type I LastRead 0 FirstWrite -1}
		hash_table_message_id {Type I LastRead 0 FirstWrite -1}
		empty {Type I LastRead 0 FirstWrite -1}
		hash_index_1_out {Type O LastRead -1 FirstWrite 1}
		mul_ln164_out {Type O LastRead -1 FirstWrite 1}
		icmp_ln84_out {Type O LastRead -1 FirstWrite 1}}
	decode_can_message_Pipeline_VITIS_LOOP_117_2 {
		num_signals3 {Type I LastRead 0 FirstWrite -1}
		empty {Type I LastRead 0 FirstWrite -1}
		signal_def_mem {Type I LastRead 34 FirstWrite -1}
		message_data2 {Type I LastRead 0 FirstWrite -1}
		mul_ln164_reload {Type I LastRead 0 FirstWrite -1}
		hash_table_accumulator_accumulated_values {Type IO LastRead 34 FirstWrite 111}
		zext_ln117 {Type I LastRead 0 FirstWrite -1}}
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
	{"Name" : "Latency", "Min" : "-1", "Max" : "-1"}
	, {"Name" : "Interval", "Min" : "0", "Max" : "0"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	decoded_signals { ap_memory {  { decoded_signals_address0 mem_address 1 7 }  { decoded_signals_ce0 mem_ce 1 1 }  { decoded_signals_we0 mem_we 1 1 }  { decoded_signals_d0 mem_din 1 43 } } }
	hash_table_message_id { ap_memory {  { hash_table_message_id_address0 mem_address 1 9 }  { hash_table_message_id_ce0 mem_ce 1 1 }  { hash_table_message_id_q0 mem_dout 0 29 } } }
	hash_table_lut_index { ap_memory {  { hash_table_lut_index_address0 mem_address 1 9 }  { hash_table_lut_index_ce0 mem_ce 1 1 }  { hash_table_lut_index_q0 mem_dout 0 32 } } }
	hash_table_accumulator_accumulated_values { ap_memory {  { hash_table_accumulator_accumulated_values_address0 mem_address 1 16 }  { hash_table_accumulator_accumulated_values_ce0 mem_ce 1 1 }  { hash_table_accumulator_accumulated_values_we0 mem_we 1 1 }  { hash_table_accumulator_accumulated_values_d0 mem_din 1 64 }  { hash_table_accumulator_accumulated_values_q0 mem_dout 0 64 }  { hash_table_accumulator_accumulated_values_address1 MemPortADDR2 1 16 }  { hash_table_accumulator_accumulated_values_ce1 MemPortCE2 1 1 }  { hash_table_accumulator_accumulated_values_we1 MemPortWE2 1 1 }  { hash_table_accumulator_accumulated_values_d1 MemPortDIN2 1 64 }  { hash_table_accumulator_accumulated_values_q1 MemPortDOUT2 0 64 } } }
	hash_table_accumulator_counter { ap_memory {  { hash_table_accumulator_counter_address0 mem_address 1 9 }  { hash_table_accumulator_counter_ce0 mem_ce 1 1 }  { hash_table_accumulator_counter_we0 mem_we 1 1 }  { hash_table_accumulator_counter_d0 mem_din 1 32 }  { hash_table_accumulator_counter_q0 mem_dout 0 32 } } }
	msg_lut { ap_memory {  { msg_lut_address0 mem_address 1 9 }  { msg_lut_ce0 mem_ce 1 1 }  { msg_lut_q0 mem_dout 0 56 } } }
	signal_def_mem { ap_memory {  { signal_def_mem_address0 mem_address 1 9 }  { signal_def_mem_ce0 mem_ce 1 1 }  { signal_def_mem_q0 mem_dout 0 80 }  { signal_def_mem_address1 MemPortADDR2 1 9 }  { signal_def_mem_ce1 MemPortCE2 1 1 }  { signal_def_mem_q1 MemPortDOUT2 0 80 } } }
}

set maxi_interface_dict [dict create]

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
