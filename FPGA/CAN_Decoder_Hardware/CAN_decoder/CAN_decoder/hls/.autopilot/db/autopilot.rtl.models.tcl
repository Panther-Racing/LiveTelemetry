set SynModuleInfo {
  {SRCNAME decode_can_message_Pipeline_VITIS_LOOP_84_1 MODELNAME decode_can_message_Pipeline_VITIS_LOOP_84_1 RTLNAME decode_can_message_decode_can_message_Pipeline_VITIS_LOOP_84_1
    SUBMODULES {
      {MODELNAME decode_can_message_flow_control_loop_pipe_sequential_init RTLNAME decode_can_message_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME decode_can_message_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME decode_can_message_Pipeline_VITIS_LOOP_117_2 MODELNAME decode_can_message_Pipeline_VITIS_LOOP_117_2 RTLNAME decode_can_message_decode_can_message_Pipeline_VITIS_LOOP_117_2
    SUBMODULES {
      {MODELNAME decode_can_message_dadd_64ns_64ns_64_5_full_dsp_1 RTLNAME decode_can_message_dadd_64ns_64ns_64_5_full_dsp_1 BINDTYPE op TYPE dadd IMPL fulldsp LATENCY 4 ALLOW_PRAGMA 1}
      {MODELNAME decode_can_message_ddiv_64ns_64ns_64_31_no_dsp_1 RTLNAME decode_can_message_ddiv_64ns_64ns_64_31_no_dsp_1 BINDTYPE op TYPE ddiv IMPL fabric LATENCY 30 ALLOW_PRAGMA 1}
      {MODELNAME decode_can_message_uitodp_32ns_64_5_no_dsp_1 RTLNAME decode_can_message_uitodp_32ns_64_5_no_dsp_1 BINDTYPE op TYPE uitodp IMPL auto LATENCY 4 ALLOW_PRAGMA 1}
      {MODELNAME decode_can_message_sitodp_64s_64_5_no_dsp_1 RTLNAME decode_can_message_sitodp_64s_64_5_no_dsp_1 BINDTYPE op TYPE sitodp IMPL auto LATENCY 4 ALLOW_PRAGMA 1}
      {MODELNAME decode_can_message_mul_32s_24ns_56_1_1 RTLNAME decode_can_message_mul_32s_24ns_56_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME decode_can_message_sparsemux_9_3_32_1_1 RTLNAME decode_can_message_sparsemux_9_3_32_1_1 BINDTYPE op TYPE sparsemux IMPL auto}
    }
  }
  {SRCNAME decode_can_message_Pipeline_VITIS_LOOP_182_4 MODELNAME decode_can_message_Pipeline_VITIS_LOOP_182_4 RTLNAME decode_can_message_decode_can_message_Pipeline_VITIS_LOOP_182_4
    SUBMODULES {
      {MODELNAME decode_can_message_sdiv_64ns_33ns_32_68_1 RTLNAME decode_can_message_sdiv_64ns_33ns_32_68_1 BINDTYPE op TYPE sdiv IMPL auto LATENCY 67 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME decode_can_message MODELNAME decode_can_message RTLNAME decode_can_message IS_TOP 1
    SUBMODULES {
      {MODELNAME decode_can_message_control_s_axi RTLNAME decode_can_message_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
    }
  }
}
