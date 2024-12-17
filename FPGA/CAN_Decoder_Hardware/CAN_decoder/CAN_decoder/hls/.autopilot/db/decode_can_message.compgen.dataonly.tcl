# This script segment is generated automatically by AutoPilot

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


