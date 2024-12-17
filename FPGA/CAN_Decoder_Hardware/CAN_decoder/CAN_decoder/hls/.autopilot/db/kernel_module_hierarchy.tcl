set ModuleHierarchy {[{
"Name" : "decode_can_message","ID" : "0","Type" : "sequential",
"SubInsts" : [
	{"Name" : "grp_decode_can_message_Pipeline_VITIS_LOOP_84_1_fu_205","ID" : "1","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "VITIS_LOOP_84_1","ID" : "2","Type" : "pipeline"},]},
	{"Name" : "grp_decode_can_message_Pipeline_VITIS_LOOP_117_2_fu_216","ID" : "3","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "VITIS_LOOP_117_2","ID" : "4","Type" : "pipeline"},]},],
"SubLoops" : [
	{"Name" : "VITIS_LOOP_172_3","ID" : "5","Type" : "no",
	"SubInsts" : [
	{"Name" : "grp_decode_can_message_Pipeline_VITIS_LOOP_182_4_fu_229","ID" : "6","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_182_4","ID" : "7","Type" : "pipeline"},]},]},]
}]}