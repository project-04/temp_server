/*
----------------------------------------------------------------------------------
-                                                                                -
-  Copyright Mentor Graphics Corporation                                         -
-  All Rights Reserved                                                           -
-                                                                                -
-  THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY                               -
-  INFORMATION WHICH IS THE PROPERTY OF MENTOR GRAPHICS                          -
-  CORPORATION OR ITS LICENSORS AND IS SUBJECT                                   -
-  TO LICENSE TERMS.                                                             -
-                                                                                -
----------------------------------------------------------------------------------
-  File created by: Tessent Shell                                                -
-          Version: 2019.1                                                       -
-       Created on: Wed Aug 14 12:11:29 IST 2019                                 -
----------------------------------------------------------------------------------


*/
 // ============================================================================
// == Description     : ICL description for blockA_rtl_tessent_mbist_c1_interface_m1
// == Tool Name       : membistipCommonGenerate
// == Tool Version    : 2019.1      Fri Feb 15 21:15:11 GMT 2019
// ============================================================================
Module blockA_rtl_tessent_mbist_c1_interface_m1 {
    ClockPort                       BIST_CLK;
    DataInPort                      BIST_COLLAR_EN; 
    DataInPort                      BIST_EN {
        Attribute connection_rule_option = "allowed_no_source";}
    DataInPort                      BIST_ASYNC_RESETN;
    ScanInPort                      BIST_SI;
    ScanOutPort                     BIST_SO {Source BIST_SO_INT;}
    ShiftEnPort                     BIST_SHIFT_COLLAR;
    DataInPort                      BIST_SETUP2;
    DataInPort                      BIST_SETUP1;
    DataInPort                      BIST_SETUP0;
    DataInPort                      MEM_BYPASS_EN {
        Attribute connection_rule_option = "allowed_tied_low";}
    DataInPort                      MCP_BOUNDING_EN {
        Attribute connection_rule_option = "allowed_tied_low";}
    DataOutPort                     A[12:0] { 
        Attribute connection_rule_option = "allowed_no_destination"; 
        Attribute tessent_memory_bist_function = "address"; }
    DataInPort                      CHECK_REPAIR_NEEDED;
    DataOutPort      Seg1_SCOL0_FUSE_REG[4:0] { Attribute connection_rule_option = "allowed_no_destination"; }
    DataInPort       FROM_BISR_Seg1_SCOL0_FUSE_REG[4:0] { Attribute connection_rule_option = "allowed_tied_low"; }
    DataOutPort      Seg1_SCOL0_ALLOC_REG { Attribute connection_rule_option = "allowed_no_destination"; }
    DataInPort       FROM_BISR_Seg1_SCOL0_ALLOC_REG { Attribute connection_rule_option = "allowed_tied_low"; }
    DataOutPort      Seg1_SCOL0_FUSE_ADD_REG[3:0] { Attribute connection_rule_option = "allowed_no_destination"; }
    DataInPort       FROM_BISR_Seg1_SCOL0_FUSE_ADD_REG[3:0] { Attribute connection_rule_option = "allowed_tied_low"; }
    LogicSignal      BIRA_SETUP { BIST_SETUP2,BIST_SETUP1,BIST_SETUP0 == 3'b100;}
// [start] : LONG_SETUP / SHORT_SETUP chain registers {{{
  ScanRegister RA_STATUS_SHADOW_REG_HW[0:1] {
    ScanInSource     BIST_SI;
  }
  Alias RA_STATUS_SHADOW_REG[1:0] = RA_STATUS_SHADOW_REG_HW[1:0];
  ScanRegister FREEZE_STOP_ERROR_REG[0:0] {
    ScanInSource     RA_STATUS_SHADOW_REG[1];
  }
  ScanRegister GO_ID_REG[31:0] {
    ScanInSource     FREEZE_STOP_ERROR_REG[0];
  }
// [end]   : LONG_SETUP / SHORT_SETUP chain registers }}}
    
  ScanRegister RA_INTERFACE_Seg1_SPARE0_FUSE_REG[0:4] {
      ScanInSource                  BIST_SI;
  }
  ScanRegister RA_INTERFACE_Seg1_SPARE0_ALLOC_REG[0:0] {
      ScanInSource                  RA_INTERFACE_Seg1_SPARE0_FUSE_REG[4];
  }
  ScanRegister RA_INTERFACE_Seg1_SPARE0_FUSE_ADD_REG[0:3] {
      ScanInSource                  RA_INTERFACE_Seg1_SPARE0_ALLOC_REG[0];
  }
  ScanRegister RA_INTERFACE_STATUS_REG[0:1] {
      ScanInSource                  RA_INTERFACE_Seg1_SPARE0_FUSE_ADD_REG[3];
  }
  ScanMux BIRA_SETUP_MUX SelectedBy BIRA_SETUP {
      1'b0 : GO_ID_REG[0];
      1'b1 : RA_INTERFACE_STATUS_REG[1];
  }
  Alias BIST_SO_INT = BIRA_SETUP_MUX;
  Attribute          tessent_instrument_type = "mentor::memory_bist";
  Attribute          tessent_instrument_subtype = "memory_interface";
  Attribute          tessent_signature = "df748fdb196c460adc2b8a6f088fa7c4";
  Attribute          tessent_ignore_during_icl_verification = "on";
  Attribute          keep_active_during_scan_test           = "false";
  Attribute          tessent_use_in_dft_specification = "false";
  Attribute          tessent_bist_input_select_persistent_cell_output_list = "tessent_persistent_cell_BIST_INPUT_SELECT_INT/Y";
  Attribute          tessent_async_bypass_persistent_cell_input_list = "";
  Attribute          tessent_bist_clk_persistent_cell_output_list = "tessent_persistent_cell_GATING_BIST_CLK/GCK";
  Attribute          tessent_memory_output_is_tristate = "false";
  Attribute          tessent_memory_control_inputs_list = "CEB SELECT ACTIVELOW";
  Attribute          tessent_memory_test_inputs_list = "";
  Attribute          tessent_memory_test_outputs_list = "";
  Attribute          tessent_memory_control_inputs_di_coverage_list = "partial";
}
