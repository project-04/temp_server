//--------------------------------------------------------
//
//  Copyright Mentor Graphics Corporation
//  All Rights Reserved
//
//  THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY
//  INFORMATION WHICH IS THE PROPERTY OF MENTOR GRAPHICS
//  CORPORATION OR ITS LICENSORS AND IS SUBJECT
//  TO LICENSE TERMS.
//
//--------------------------------------------------------
//  File created by: Tessent Shell
//          Version: 2019.1
//       Created on: Wed Aug 14 12:11:31 IST 2019
//--------------------------------------------------------

Module blockA_rtl_tessent_mbist_bap {
 
  ResetPort     reset                   { ActivePolarity 0;      }
  SelectPort    ijtag_select;
  ScanInPort    si;
  CaptureEnPort capture_en;
  ShiftEnPort   shift_en;
  ToShiftEnPort shift_en_R;
  UpdateEnPort  update_en;
  TCKPort       tck;
  DataInPort    memory_bypass_en { Attribute connection_rule_option = "allowed_tied_low"; }
  DataOutPort   memory_bypass_to_en     { Source memory_bypass_en; Attribute connection_rule_option = "allowed_no_destination"; }
  DataInPort    mcp_bounding_en { Attribute connection_rule_option = "allowed_tied_low"; }
  DataOutPort   mcp_bounding_to_en      { Source mcp_bounding_en; Attribute connection_rule_option = "allowed_no_destination"; }
  DataInPort    ltest_en { Attribute connection_rule_option = "allowed_tied_low"; }
  DataOutPort   ltest_to_en             { Source ltest_en; Attribute connection_rule_option = "allowed_no_destination"; }
  ScanOutPort   so                      { Source sib_0;          }
  ScanOutPort   toBist[0:0]             {
    Source toBist_int; 
    Attribute connection_rule_option = "allowed_no_destination";
  }
  ScanInPort    fromBist[0:0]            {
    Attribute connection_rule_option = "allowed_tied_low";
  }
  DataOutPort   bistEn[0:0]             { 
    Source bistEn_int[0:0];
    Attribute connection_rule_option = "allowed_no_destination";
  }
  DataInPort   MBISTPG_GO[0:0]          {
    Attribute connection_rule_option = "allowed_no_source"; 
  }
  DataInPort   MBISTPG_DONE[0:0]        {
    Attribute connection_rule_option = "allowed_no_source"; 
  }
  DataOutPort   ENABLE_MEM_RESET        {
    Source ENABLE_MEM_RESET_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   REDUCED_ADDRESS_COUNT   {
    Source REDUCED_ADDRESS_COUNT_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   BIST_SELECT_TEST_DATA   {
    Source BIST_SELECT_TEST_DATA_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   BIST_ALGO_MODE0         {
    Source BIST_ALGO_MODE0_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   BIST_ALGO_MODE1         {
    Source BIST_ALGO_MODE1_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   BIRA_EN                 {
    Source BIRA_EN_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   BIST_DIAG_EN            {
    Source BIST_DIAG_EN_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   PRESERVE_FUSE_REGISTER  {
    Source PRESERVE_FUSE_REGISTER_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   CHECK_REPAIR_NEEDED     {
    Source CHECK_REPAIR_NEEDED_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   BIST_ASYNC_RESET        {
    Source BIST_ASYNC_RESET_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   FL_CNT_MODE0            {
    Source FL_CNT_MODE0_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   FL_CNT_MODE1            {
    Source FL_CNT_MODE1_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   BIST_CLK_EN             {
    Source BIST_CLK_EN_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   CHAIN_BYPASS_EN         {
    Source CHAIN_BYPASS_EN_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
  }
  DataOutPort   BIST_HOLD               {
    Source BIST_HOLD_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
  }
  DataOutPort   INVERT_ASYNC_TCK        {
    Source INVERT_ASYNC_TCK_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   TCK_MODE                {
    Source TCK_MODE_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   BIST_SETUP[2:0]         {
    Source BIST_SETUP_tdr[2:0];
    Attribute connection_rule_option = "allowed_no_destination";
  }
  Attribute                             ijtag_logical_connection = "{tck tck_out}";
  Enum                                  OnOff                    { 
    ON                                  = 1'b1; 
    OFF                                 = 1'b0; 
  }
 
  ScanInterface client { 
    Port si; 
    Port so; 
    Port ijtag_select;
  }
  ScanInterface host_0 {
    Port toBist[0];
    Port fromBist[0];
    Port shift_en_R;
  }
   Attribute keep_active_during_scan_test = "false";
 
  ScanRegister BIST_SETUP_tdr[2:0] {
    ScanInSource     si;
    CaptureSource    BIST_SETUP_tdr[2],
                     BIST_SETUP_tdr[1],
                     BIST_SETUP_tdr[0];
    ResetValue       3'b000;
    DefaultLoadValue 3'b000;
  }
  ScanRegister TCK_MODE_tdr {
    ScanInSource     BIST_SETUP_tdr[0];
    CaptureSource    TCK_MODE_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister INVERT_ASYNC_TCK_tdr {
    ScanInSource     TCK_MODE_tdr;
    CaptureSource    INVERT_ASYNC_TCK_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister BIST_HOLD_tdr {
    ScanInSource     INVERT_ASYNC_TCK_tdr;
    CaptureSource    BIST_HOLD_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister CHAIN_BYPASS_EN_tdr {
    ScanInSource     BIST_HOLD_tdr;
    CaptureSource    CHAIN_BYPASS_EN_tdr;
    ResetValue       1'b1;
    DefaultLoadValue 1'b1;
  }
  ScanRegister BIST_CLK_EN_tdr {
    ScanInSource     CHAIN_BYPASS_EN_tdr;
    CaptureSource    BIST_CLK_EN_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister FL_CNT_MODE1_tdr {
    ScanInSource     BIST_CLK_EN_tdr;
    CaptureSource    FL_CNT_MODE1_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister FL_CNT_MODE0_tdr {
    ScanInSource     FL_CNT_MODE1_tdr;
    CaptureSource    FL_CNT_MODE0_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister BIST_ASYNC_RESET_tdr {
    ScanInSource     FL_CNT_MODE0_tdr;
    CaptureSource    BIST_ASYNC_RESET_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister CHECK_REPAIR_NEEDED_tdr {
    ScanInSource     BIST_ASYNC_RESET_tdr;
    CaptureSource    CHECK_REPAIR_NEEDED_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister PRESERVE_FUSE_REGISTER_tdr {
    ScanInSource     CHECK_REPAIR_NEEDED_tdr;
    CaptureSource    PRESERVE_FUSE_REGISTER_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister BIST_DIAG_EN_tdr {
    ScanInSource     PRESERVE_FUSE_REGISTER_tdr;
    CaptureSource    BIST_DIAG_EN_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister BIRA_EN_tdr {
    ScanInSource     BIST_DIAG_EN_tdr;
    CaptureSource    BIRA_EN_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister BIST_ALGO_MODE1_tdr {
    ScanInSource     BIRA_EN_tdr;
    CaptureSource    BIST_ALGO_MODE1_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister BIST_ALGO_MODE0_tdr {
    ScanInSource     BIST_ALGO_MODE1_tdr;
    CaptureSource    BIST_ALGO_MODE0_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister BIST_SELECT_TEST_DATA_tdr {
    ScanInSource     BIST_ALGO_MODE0_tdr;
    CaptureSource    BIST_SELECT_TEST_DATA_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister REDUCED_ADDRESS_COUNT_tdr {
    ScanInSource     BIST_SELECT_TEST_DATA_tdr;
    CaptureSource    MBISTPG_DONE[0];
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister ENABLE_MEM_RESET_tdr {
    ScanInSource     REDUCED_ADDRESS_COUNT_tdr;
    CaptureSource    MBISTPG_GO[0];
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  Alias tdr[19:0] = BIST_SETUP_tdr[2:0],
                     TCK_MODE_tdr,
                     INVERT_ASYNC_TCK_tdr,
                     BIST_HOLD_tdr,
                     CHAIN_BYPASS_EN_tdr,
                     BIST_CLK_EN_tdr,
                     FL_CNT_MODE1_tdr,
                     FL_CNT_MODE0_tdr,
                     BIST_ASYNC_RESET_tdr,
                     CHECK_REPAIR_NEEDED_tdr,
                     PRESERVE_FUSE_REGISTER_tdr,
                     BIST_DIAG_EN_tdr,
                     BIRA_EN_tdr,
                     BIST_ALGO_MODE1_tdr,
                     BIST_ALGO_MODE0_tdr,
                     BIST_SELECT_TEST_DATA_tdr,
                     REDUCED_ADDRESS_COUNT_tdr,
                     ENABLE_MEM_RESET_tdr {
    RefEnum          tdr_symbols;
  }
  Enum tdr_symbols {
    idle              = 20'b00000010001000000100;
    ignore            = 20'bxxxxxxxxxxxxxxxxxxxx;
    mbist_async_reset = 20'b00000010000000000000;
  }
  Alias ChainBypassMode = CHAIN_BYPASS_EN_tdr;
  ScanMux    fromBistMux_0 SelectedBy sib_0,BIST_SETUP_tdr[1],ChainBypassMode {
    3'b100 : fromBist[0];
    3'bxxx : ENABLE_MEM_RESET_tdr;
  }
  ScanRegister sib_0 {
    ScanInSource     fromBistMux_0;
    CaptureSource    sib_0;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  Alias bistEn_int[0:0] = sib_0;
  Alias toBist_int[0:0] = ENABLE_MEM_RESET_tdr;
 
  Attribute tessent_use_in_dft_specification = "false";
  Attribute tessent_instrument_type          = "mentor::memory_bist";
  Attribute tessent_instrument_subtype       = "bist_access_port";
  Attribute tessent_signature                = "1cfc7d818eea83ca9de8929bcbd2a100";
}
