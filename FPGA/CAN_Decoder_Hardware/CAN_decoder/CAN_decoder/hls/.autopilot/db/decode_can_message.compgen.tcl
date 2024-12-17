# This script segment is generated automatically by AutoPilot

# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

set axilite_register_dict [dict create]
set port_control {
message { 
	dir I
	width 128
	depth 1
	mode ap_none
	offset 16
	offset_end 35
}
num_decoded_signals_i { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 36
	offset_end 43
}
num_decoded_signals_o { 
	dir O
	width 32
	depth 1
	mode ap_vld
	offset 44
	offset_end 51
}
}
dict set axilite_register_dict control $port_control


# Native S_AXILite:
if {${::AESL::PGuard_simmodel_gen}} {
	if {[info proc ::AESL_LIB_XILADAPTER::s_axilite_gen] == "::AESL_LIB_XILADAPTER::s_axilite_gen"} {
		eval "::AESL_LIB_XILADAPTER::s_axilite_gen { \
			id 106 \
			corename decode_can_message_control_axilite \
			name decode_can_message_control_s_axi \
			ports {$port_control} \
			op interface \
			interrupt_clear_mode TOW \
			interrupt_trigger_type default \
			is_flushable 0 \
			is_datawidth64 0 \
			is_addrwidth64 1 \
		} "
	} else {
		puts "@W \[IMPL-110\] Cannot find AXI Lite interface model in the library. Ignored generation of AXI Lite  interface for 'control'"
	}
}

if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler decode_can_message_control_s_axi BINDTYPE interface TYPE interface_s_axilite
}

# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 107 \
    name decoded_signals \
    reset_level 0 \
    sync_rst true \
    dir O \
    corename decoded_signals \
    op interface \
    ports { decoded_signals_address0 { O 7 vector } decoded_signals_ce0 { O 1 bit } decoded_signals_we0 { O 1 bit } decoded_signals_d0 { O 43 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'decoded_signals'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 108 \
    name hash_table_message_id \
    reset_level 0 \
    sync_rst true \
    dir I \
    corename hash_table_message_id \
    op interface \
    ports { hash_table_message_id_address0 { O 9 vector } hash_table_message_id_ce0 { O 1 bit } hash_table_message_id_q0 { I 29 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'hash_table_message_id'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 109 \
    name hash_table_lut_index \
    reset_level 0 \
    sync_rst true \
    dir I \
    corename hash_table_lut_index \
    op interface \
    ports { hash_table_lut_index_address0 { O 9 vector } hash_table_lut_index_ce0 { O 1 bit } hash_table_lut_index_q0 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'hash_table_lut_index'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 110 \
    name hash_table_accumulator_accumulated_values \
    reset_level 0 \
    sync_rst true \
    dir IO \
    corename hash_table_accumulator_accumulated_values \
    op interface \
    ports { hash_table_accumulator_accumulated_values_address0 { O 16 vector } hash_table_accumulator_accumulated_values_ce0 { O 1 bit } hash_table_accumulator_accumulated_values_we0 { O 1 bit } hash_table_accumulator_accumulated_values_d0 { O 64 vector } hash_table_accumulator_accumulated_values_q0 { I 64 vector } hash_table_accumulator_accumulated_values_address1 { O 16 vector } hash_table_accumulator_accumulated_values_ce1 { O 1 bit } hash_table_accumulator_accumulated_values_we1 { O 1 bit } hash_table_accumulator_accumulated_values_d1 { O 64 vector } hash_table_accumulator_accumulated_values_q1 { I 64 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'hash_table_accumulator_accumulated_values'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 111 \
    name hash_table_accumulator_counter \
    reset_level 0 \
    sync_rst true \
    dir IO \
    corename hash_table_accumulator_counter \
    op interface \
    ports { hash_table_accumulator_counter_address0 { O 9 vector } hash_table_accumulator_counter_ce0 { O 1 bit } hash_table_accumulator_counter_we0 { O 1 bit } hash_table_accumulator_counter_d0 { O 32 vector } hash_table_accumulator_counter_q0 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'hash_table_accumulator_counter'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 112 \
    name msg_lut \
    reset_level 0 \
    sync_rst true \
    dir I \
    corename msg_lut \
    op interface \
    ports { msg_lut_address0 { O 9 vector } msg_lut_ce0 { O 1 bit } msg_lut_q0 { I 56 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'msg_lut'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 113 \
    name signal_def_mem \
    reset_level 0 \
    sync_rst true \
    dir I \
    corename signal_def_mem \
    op interface \
    ports { signal_def_mem_address0 { O 9 vector } signal_def_mem_ce0 { O 1 bit } signal_def_mem_q0 { I 80 vector } signal_def_mem_address1 { O 9 vector } signal_def_mem_ce1 { O 1 bit } signal_def_mem_q1 { I 80 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'signal_def_mem'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -1 \
    name ap_ctrl \
    type ap_ctrl \
    reset_level 0 \
    sync_rst true \
    corename ap_ctrl \
    op interface \
    ports { ap_start { I 1 bit } ap_ready { O 1 bit } ap_done { O 1 bit } ap_idle { O 1 bit } } \
} "
}


# Adapter definition:
set PortName ap_clk
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_clock] == "cg_default_interface_gen_clock"} {
eval "cg_default_interface_gen_clock { \
    id -2 \
    name ${PortName} \
    reset_level 0 \
    sync_rst true \
    corename apif_ap_clk \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-113\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}


# Adapter definition:
set PortName ap_rst_n
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_reset] == "cg_default_interface_gen_reset"} {
eval "cg_default_interface_gen_reset { \
    id -3 \
    name ${PortName} \
    reset_level 0 \
    sync_rst true \
    corename apif_ap_rst_n \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-114\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}



# merge
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_end
    cg_default_interface_gen_bundle_end
    AESL_LIB_XILADAPTER::native_axis_end
}


