Module SYNC_8192X32_BISR {
  DataInPort                             A[12:0] { 
    Attribute connection_rule_option = "allowed_no_source"; 
    Attribute tessent_memory_bist_function = "address";
  }
  ClockPort                              CLK;
  Attribute tessent_use_in_dft_specification = "false"; 
  Attribute keep_active_during_scan_test     = "false"; 
  Attribute tessent_memory_module            = "without_internal_scan_logic";
}
