//-------------------------------------------------
//  File created by: Tessent Shell
//          Version: 2019.1
//       Created on: Wed Aug 14 12:11:36 IST 2019
//-------------------------------------------------


Module blockA_rtl_tessent_mbist_c1_controller_assembly {
   // Created by ICL extraction
   DataOutPort BIST_DONE {
      Source blockA_rtl_tessent_mbist_c1_controller_inst.MBISTPG_DONE;
      Attribute tessent_use_in_dft_specification = "false";
   }
   DataOutPort BIST_GO {
      Source blockA_rtl_tessent_mbist_c1_controller_inst.MBISTPG_GO;
      Attribute tessent_use_in_dft_specification = "false";
   }
   DataInPort LV_TM {
      Attribute connection_rule_option = "allowed_tied_low";
      Attribute tessent_use_in_dft_specification = "false";
   }
   CaptureEnPort capture_en;
   ClockPort clk_clka {
      Attribute tessent_clock_domain_labels = "clk_clka clk_clka";
      Attribute tessent_clock_periods = "all 12.00ns";
   }
   SelectPort ijtag_select;
   ResetPort reset {
      ActivePolarity 0;
   }
   ShiftEnPort shift_en;
   ScanInPort si;
   ScanOutPort so {
      Source blockA_rtl_tessent_mbist_bap_inst.so;
   }
   TCKPort tck;
   UpdateEnPort update_en;
   ScanInterface C0 {
      Port si;
      Port so;
      Port ijtag_select;
      Port shift_en;
      Port capture_en;
      Port update_en;
      Port reset;
      Port tck;
   }
   Attribute tessent_design_format = "verilog_2001";
   Attribute test_setup_procfile = "";
   Attribute forced_low_input_port_list = "{MEM_BYPASS_EN} {MCP_BOUNDING_EN}";
   Attribute icl_extraction_date = "Wed Aug 14 12:11:36 IST 2019";
   Attribute created_by_tessent_icl_extract = "true";
   Attribute tessent_design_id = "rtl";
   Instance blockA_rtl_tessent_mbist_bap_inst Of blockA_rtl_tessent_mbist_bap {
      InputPort reset = reset;
      InputPort ijtag_select = ijtag_select;
      InputPort si = si;
      InputPort capture_en = capture_en;
      InputPort shift_en = shift_en;
      InputPort update_en = update_en;
      InputPort tck = tck;
      InputPort memory_bypass_en = 'b0;
      InputPort mcp_bounding_en = 'b0;
      InputPort ltest_en = LV_TM;
      InputPort fromBist[0] = 
          blockA_rtl_tessent_mbist_c1_controller_inst.MBISTPG_SO;
      InputPort MBISTPG_GO[0] = 
          blockA_rtl_tessent_mbist_c1_controller_inst.MBISTPG_GO;
      InputPort MBISTPG_DONE[0] = 
          blockA_rtl_tessent_mbist_c1_controller_inst.MBISTPG_DONE;
      Attribute tessent_design_instance = "blockA_rtl_tessent_mbist_bap_inst";
   }
   Instance blockA_rtl_tessent_mbist_c1_controller_inst Of 
       blockA_rtl_tessent_mbist_c1_controller {
      InputPort BIST_CLK = clk_clka;
      InputPort BIST_CLK_EN = blockA_rtl_tessent_mbist_bap_inst.BIST_CLK_EN;
      InputPort MBISTPG_EN = blockA_rtl_tessent_mbist_bap_inst.bistEn[0];
      InputPort BIST_HOLD = blockA_rtl_tessent_mbist_bap_inst.BIST_HOLD;
      InputPort LV_TM = LV_TM;
      InputPort MEM_BYPASS_EN = 'b0;
      InputPort MCP_BOUNDING_EN = 'b0;
      InputPort MBIST_RA_PRSRV_FUSE_VAL = 
          blockA_rtl_tessent_mbist_bap_inst.PRESERVE_FUSE_REGISTER;
      InputPort MBISTPG_BIRA_EN = blockA_rtl_tessent_mbist_bap_inst.BIRA_EN;
      InputPort CHECK_REPAIR_NEEDED = 
          blockA_rtl_tessent_mbist_bap_inst.CHECK_REPAIR_NEEDED;
      InputPort MBISTPG_ASYNC_RESETN = 
          blockA_rtl_tessent_mbist_bap_inst.BIST_ASYNC_RESET;
      InputPort MBISTPG_DIAG_EN = blockA_rtl_tessent_mbist_bap_inst.BIST_DIAG_EN;

      InputPort BIST_SETUP2 = blockA_rtl_tessent_mbist_bap_inst.BIST_SETUP[2];
      InputPort BIST_SETUP[1] = blockA_rtl_tessent_mbist_bap_inst.BIST_SETUP[1];
      InputPort BIST_SETUP[0] = blockA_rtl_tessent_mbist_bap_inst.BIST_SETUP[0];
      InputPort TCK_MODE = blockA_rtl_tessent_mbist_bap_inst.TCK_MODE;
      InputPort MBISTPG_REDUCED_ADDR_CNT_EN = 
          blockA_rtl_tessent_mbist_bap_inst.REDUCED_ADDRESS_COUNT;
      InputPort MBISTPG_MEM_RST = 
          blockA_rtl_tessent_mbist_bap_inst.ENABLE_MEM_RESET;
      InputPort MBISTPG_TESTDATA_SELECT = 
          blockA_rtl_tessent_mbist_bap_inst.BIST_SELECT_TEST_DATA;
      InputPort FL_CNT_MODE[1] = blockA_rtl_tessent_mbist_bap_inst.FL_CNT_MODE1;
      InputPort FL_CNT_MODE[0] = blockA_rtl_tessent_mbist_bap_inst.FL_CNT_MODE0;
      InputPort MBISTPG_ALGO_MODE[1] = 
          blockA_rtl_tessent_mbist_bap_inst.BIST_ALGO_MODE1;
      InputPort MBISTPG_ALGO_MODE[0] = 
          blockA_rtl_tessent_mbist_bap_inst.BIST_ALGO_MODE0;
      InputPort TCK = tck;
      InputPort BIST_SI = blockA_rtl_tessent_mbist_bap_inst.toBist[0];
      InputPort BIST_SHIFT = blockA_rtl_tessent_mbist_bap_inst.shift_en_R;
      InputPort MEM0_BIST_COLLAR_SO = m1_interface_instance.BIST_SO;
      Attribute tessent_design_instance = 
          "blockA_rtl_tessent_mbist_c1_controller_inst";
   }
   Instance m1_inst Of SYNC_8192X32_BISR {
      InputPort A[12] = m1_interface_instance.A[12];
      InputPort A[11] = m1_interface_instance.A[11];
      InputPort A[10] = m1_interface_instance.A[10];
      InputPort A[9] = m1_interface_instance.A[9];
      InputPort A[8] = m1_interface_instance.A[8];
      InputPort A[7] = m1_interface_instance.A[7];
      InputPort A[6] = m1_interface_instance.A[6];
      InputPort A[5] = m1_interface_instance.A[5];
      InputPort A[4] = m1_interface_instance.A[4];
      InputPort A[3] = m1_interface_instance.A[3];
      InputPort A[2] = m1_interface_instance.A[2];
      InputPort A[1] = m1_interface_instance.A[1];
      InputPort A[0] = m1_interface_instance.A[0];
      InputPort CLK = clk_clka;
      Attribute tessent_design_instance = "m1_inst";
   }
   Instance m1_interface_instance Of blockA_rtl_tessent_mbist_c1_interface_m1 {
      InputPort BIST_CLK = clk_clka;
      InputPort BIST_COLLAR_EN = 
          blockA_rtl_tessent_mbist_c1_controller_inst.BIST_COLLAR_EN0;
      InputPort BIST_EN = blockA_rtl_tessent_mbist_bap_inst.bistEn[0];
      InputPort BIST_ASYNC_RESETN = 
          blockA_rtl_tessent_mbist_bap_inst.BIST_ASYNC_RESET;
      InputPort BIST_SI = 
          blockA_rtl_tessent_mbist_c1_controller_inst.MEM0_BIST_COLLAR_SI;
      InputPort BIST_SHIFT_COLLAR = 
          blockA_rtl_tessent_mbist_c1_controller_inst.BIST_SHIFT_COLLAR;
      InputPort BIST_SETUP2 = blockA_rtl_tessent_mbist_bap_inst.BIST_SETUP[2];
      InputPort BIST_SETUP1 = blockA_rtl_tessent_mbist_bap_inst.BIST_SETUP[1];
      InputPort BIST_SETUP0 = blockA_rtl_tessent_mbist_bap_inst.BIST_SETUP[0];
      InputPort MEM_BYPASS_EN = 'b0;
      InputPort MCP_BOUNDING_EN = 'b0;
      InputPort CHECK_REPAIR_NEEDED = 
          blockA_rtl_tessent_mbist_bap_inst.CHECK_REPAIR_NEEDED;
      InputPort FROM_BISR_Seg1_SCOL0_FUSE_REG[4] = 'b0;
      InputPort FROM_BISR_Seg1_SCOL0_FUSE_REG[3] = 'b0;
      InputPort FROM_BISR_Seg1_SCOL0_FUSE_REG[2] = 'b0;
      InputPort FROM_BISR_Seg1_SCOL0_FUSE_REG[1] = 'b0;
      InputPort FROM_BISR_Seg1_SCOL0_FUSE_REG[0] = 'b0;
      InputPort FROM_BISR_Seg1_SCOL0_ALLOC_REG = 'b0;
      InputPort FROM_BISR_Seg1_SCOL0_FUSE_ADD_REG[3] = 'b0;
      InputPort FROM_BISR_Seg1_SCOL0_FUSE_ADD_REG[2] = 'b0;
      InputPort FROM_BISR_Seg1_SCOL0_FUSE_ADD_REG[1] = 'b0;
      InputPort FROM_BISR_Seg1_SCOL0_FUSE_ADD_REG[0] = 'b0;
      Attribute tessent_design_instance = "m1_interface_instance";
   }
}

// instanced as blockA_rtl_tessent_mbist_c1_controller_assembly.blockA_rtl_tessent_mbist_bap_inst
Module blockA_rtl_tessent_mbist_bap {
   // ICL module read from source on or near line 17 of file '/home/susmita/MBIST_exercise1/MBIST/BlockA/blockA_tsdb/instruments/blockA_rtl_mbist.instrument/blockA_rtl_tessent_mbist_bap.icl'
   ResetPort reset {
      ActivePolarity 0;
   }
   SelectPort ijtag_select;
   ScanInPort si;
   CaptureEnPort capture_en;
   ShiftEnPort shift_en;
   ToShiftEnPort shift_en_R;
   UpdateEnPort update_en;
   TCKPort tck;
   DataInPort memory_bypass_en {
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataOutPort memory_bypass_to_en {
      Source memory_bypass_en;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataInPort mcp_bounding_en {
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataOutPort mcp_bounding_to_en {
      Source mcp_bounding_en;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataInPort ltest_en {
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataOutPort ltest_to_en {
      Source ltest_en;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   ScanOutPort so {
      Source sib_0;
   }
   ScanOutPort toBist[0:0] {
      Source toBist_int;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   ScanInPort fromBist[0:0] {
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataOutPort bistEn[0:0] {
      Source bistEn_int[0:0];
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataInPort MBISTPG_GO[0:0] {
      Attribute connection_rule_option = "allowed_no_source";
   }
   DataInPort MBISTPG_DONE[0:0] {
      Attribute connection_rule_option = "allowed_no_source";
   }
   DataOutPort ENABLE_MEM_RESET {
      Source ENABLE_MEM_RESET_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort REDUCED_ADDRESS_COUNT {
      Source REDUCED_ADDRESS_COUNT_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort BIST_SELECT_TEST_DATA {
      Source BIST_SELECT_TEST_DATA_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort BIST_ALGO_MODE0 {
      Source BIST_ALGO_MODE0_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort BIST_ALGO_MODE1 {
      Source BIST_ALGO_MODE1_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort BIRA_EN {
      Source BIRA_EN_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort BIST_DIAG_EN {
      Source BIST_DIAG_EN_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort PRESERVE_FUSE_REGISTER {
      Source PRESERVE_FUSE_REGISTER_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort CHECK_REPAIR_NEEDED {
      Source CHECK_REPAIR_NEEDED_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort BIST_ASYNC_RESET {
      Source BIST_ASYNC_RESET_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort FL_CNT_MODE0 {
      Source FL_CNT_MODE0_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort FL_CNT_MODE1 {
      Source FL_CNT_MODE1_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort BIST_CLK_EN {
      Source BIST_CLK_EN_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort CHAIN_BYPASS_EN {
      Source CHAIN_BYPASS_EN_tdr;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort BIST_HOLD {
      Source BIST_HOLD_tdr;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort INVERT_ASYNC_TCK {
      Source INVERT_ASYNC_TCK_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort TCK_MODE {
      Source TCK_MODE_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort BIST_SETUP[2:0] {
      Source BIST_SETUP_tdr[2:0];
      Attribute connection_rule_option = "allowed_no_destination";
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
   Attribute ijtag_logical_connection = "{tck tck_out}";
   Attribute keep_active_during_scan_test = "false";
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_instrument_type = "mentor::memory_bist";
   Attribute tessent_instrument_subtype = "bist_access_port";
   Attribute tessent_signature = "1cfc7d818eea83ca9de8929bcbd2a100";
   Alias tdr[19:0] = BIST_SETUP_tdr[2:0], TCK_MODE_tdr, INVERT_ASYNC_TCK_tdr, 
       BIST_HOLD_tdr, CHAIN_BYPASS_EN_tdr, BIST_CLK_EN_tdr, FL_CNT_MODE1_tdr, 
       FL_CNT_MODE0_tdr, BIST_ASYNC_RESET_tdr, CHECK_REPAIR_NEEDED_tdr, 
       PRESERVE_FUSE_REGISTER_tdr, BIST_DIAG_EN_tdr, BIRA_EN_tdr, 
       BIST_ALGO_MODE1_tdr, BIST_ALGO_MODE0_tdr, BIST_SELECT_TEST_DATA_tdr, 
       REDUCED_ADDRESS_COUNT_tdr, ENABLE_MEM_RESET_tdr {
      RefEnum tdr_symbols;
   }
   Alias ChainBypassMode = CHAIN_BYPASS_EN_tdr {
   }
   Alias bistEn_int[0:0] = sib_0 {
   }
   Alias toBist_int[0:0] = ENABLE_MEM_RESET_tdr {
   }
   Enum OnOff {
      ON = 1'b1;
      OFF = 1'b0;
   }
   Enum tdr_symbols {
      idle = 20'b00000010001000000100;
      ignore = 20'bxxxxxxxxxxxxxxxxxxxx;
      mbist_async_reset = 20'b00000010000000000000;
   }
   ScanRegister BIST_SETUP_tdr[2:0] {
      ScanInSource si;
      CaptureSource BIST_SETUP_tdr[2], BIST_SETUP_tdr[1], BIST_SETUP_tdr[0];
      DefaultLoadValue 3'b000;
      ResetValue 3'b000;
   }
   ScanRegister TCK_MODE_tdr {
      ScanInSource BIST_SETUP_tdr[0];
      CaptureSource TCK_MODE_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister INVERT_ASYNC_TCK_tdr {
      ScanInSource TCK_MODE_tdr;
      CaptureSource INVERT_ASYNC_TCK_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister BIST_HOLD_tdr {
      ScanInSource INVERT_ASYNC_TCK_tdr;
      CaptureSource BIST_HOLD_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister CHAIN_BYPASS_EN_tdr {
      ScanInSource BIST_HOLD_tdr;
      CaptureSource CHAIN_BYPASS_EN_tdr;
      DefaultLoadValue 1'b1;
      ResetValue 1'b1;
   }
   ScanRegister BIST_CLK_EN_tdr {
      ScanInSource CHAIN_BYPASS_EN_tdr;
      CaptureSource BIST_CLK_EN_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister FL_CNT_MODE1_tdr {
      ScanInSource BIST_CLK_EN_tdr;
      CaptureSource FL_CNT_MODE1_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister FL_CNT_MODE0_tdr {
      ScanInSource FL_CNT_MODE1_tdr;
      CaptureSource FL_CNT_MODE0_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister BIST_ASYNC_RESET_tdr {
      ScanInSource FL_CNT_MODE0_tdr;
      CaptureSource BIST_ASYNC_RESET_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister CHECK_REPAIR_NEEDED_tdr {
      ScanInSource BIST_ASYNC_RESET_tdr;
      CaptureSource CHECK_REPAIR_NEEDED_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister PRESERVE_FUSE_REGISTER_tdr {
      ScanInSource CHECK_REPAIR_NEEDED_tdr;
      CaptureSource PRESERVE_FUSE_REGISTER_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister BIST_DIAG_EN_tdr {
      ScanInSource PRESERVE_FUSE_REGISTER_tdr;
      CaptureSource BIST_DIAG_EN_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister BIRA_EN_tdr {
      ScanInSource BIST_DIAG_EN_tdr;
      CaptureSource BIRA_EN_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister BIST_ALGO_MODE1_tdr {
      ScanInSource BIRA_EN_tdr;
      CaptureSource BIST_ALGO_MODE1_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister BIST_ALGO_MODE0_tdr {
      ScanInSource BIST_ALGO_MODE1_tdr;
      CaptureSource BIST_ALGO_MODE0_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister BIST_SELECT_TEST_DATA_tdr {
      ScanInSource BIST_ALGO_MODE0_tdr;
      CaptureSource BIST_SELECT_TEST_DATA_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister REDUCED_ADDRESS_COUNT_tdr {
      ScanInSource BIST_SELECT_TEST_DATA_tdr;
      CaptureSource MBISTPG_DONE[0];
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister ENABLE_MEM_RESET_tdr {
      ScanInSource REDUCED_ADDRESS_COUNT_tdr;
      CaptureSource MBISTPG_GO[0];
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister sib_0 {
      ScanInSource fromBistMux_0;
      CaptureSource sib_0;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanMux fromBistMux_0 SelectedBy sib_0, BIST_SETUP_tdr[1], ChainBypassMode {
      3'b100 : fromBist[0];
      3'bxxx : ENABLE_MEM_RESET_tdr;
   }
}

// instanced as blockA_rtl_tessent_mbist_c1_controller_assembly.blockA_rtl_tessent_mbist_c1_controller_inst
Module blockA_rtl_tessent_mbist_c1_controller {
   // ICL module read from source on or near line 25 of file '/home/susmita/MBIST_exercise1/MBIST/BlockA/blockA_tsdb/instruments/blockA_rtl_mbist.instrument/blockA_rtl_tessent_mbist_c1_controller.icl'
   ClockPort BIST_CLK {
      Attribute forced_low_input_port_list = "TCK_MODE";
   }
   DataInPort BIST_CLK_EN;
   DataInPort MBISTPG_EN;
   DataInPort BIST_HOLD;
   DataInPort LV_TM {
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataInPort MEM_BYPASS_EN {
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataInPort MCP_BOUNDING_EN {
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataInPort MBIST_RA_PRSRV_FUSE_VAL {
      RefEnum OnOff;
   }
   DataInPort MBISTPG_BIRA_EN {
      RefEnum OnOff;
   }
   DataInPort CHECK_REPAIR_NEEDED {
      RefEnum OnOff;
   }
   DataInPort MBISTPG_ASYNC_RESETN {
      RefEnum AsyncResetN;
   }
   DataInPort MBISTPG_DIAG_EN;
   DataInPort BIST_SETUP2;
   DataInPort BIST_SETUP[1:0];
   DataInPort TCK_MODE;
   DataInPort MBISTPG_REDUCED_ADDR_CNT_EN {
      RefEnum OnOff;
   }
   DataInPort MBISTPG_MEM_RST {
      RefEnum OnOff;
   }
   DataInPort MBISTPG_TESTDATA_SELECT {
      RefEnum OnOff;
   }
   DataInPort FL_CNT_MODE[1:0];
   DataInPort MBISTPG_ALGO_MODE[1:0];
   DataOutPort MBISTPG_GO {
      RefEnum PassFail;
   }
   DataOutPort MBISTPG_DONE {
      RefEnum PassFail;
   }
   TCKPort TCK;
   ScanInPort BIST_SI;
   ScanOutPort MBISTPG_SO {
      Source BIST_SO_INT;
   }
   ShiftEnPort BIST_SHIFT {
      Attribute connection_rule_option = "allowed_no_source";
   }
   ToShiftEnPort BIST_SHIFT_COLLAR {
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort BIST_COLLAR_EN0 {
      Attribute tessent_memory_alias = "m1";
   }
   ScanOutPort MEM0_BIST_COLLAR_SI {
      Source MEM0_BIST_COLLAR_SI_INT;
   }
   ScanInPort MEM0_BIST_COLLAR_SO;
   ScanInterface Client {
      Port BIST_SI;
      Port MBISTPG_SO;
      Port BIST_SHIFT;
   }
   ScanInterface MEM0_INTERFACE {
      Port BIST_SHIFT_COLLAR;
      Port MEM0_BIST_COLLAR_SI;
      Port MEM0_BIST_COLLAR_SO;
   }
   Attribute tessent_instrument_container = "blockA_rtl_mbist";
   Attribute tessent_instrument_type = "mentor::memory_bist";
   Attribute tessent_instrument_subtype = "controller";
   Attribute tessent_signature = "4fc27619b98688e4ac73671684dfe455";
   Attribute tessent_ignore_during_icl_verification = "on";
   Attribute keep_active_during_scan_test = "false";
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_bist_clk_persistent_cell_output_list = 
       "tessent_persistent_cell_GATING_BIST_CLK/GCK";
   Alias SETUP_MODE[2:0] = BIST_SETUP2, BIST_SETUP[1:0] {
      RefEnum SetupModes;
   }
   Alias RUN_MODE[3:0] = MBISTPG_EN, BIST_SETUP2, BIST_SETUP[1:0] {
      RefEnum RunModes;
   }
   Alias INST_POINTER_REG[4:0] = INST_POINTER_REG_HW[4:0] {
   }
   Alias A_ADD_REG_Y[3:0] = A_ADD_REG_Y_HW[3:0] {
   }
   Alias A_ADD_REG_X[8:0] = A_ADD_REG_X_HW[8:0] {
   }
   Alias B_ADD_REG_Y[3:0] = B_ADD_REG_Y_HW[3:0] {
   }
   Alias B_ADD_REG_X[8:0] = B_ADD_REG_X_HW[8:0] {
   }
   Alias WDATA_REG[1:0] = WDATA_REG_HW[1:0] {
   }
   Alias EDATA_REG[1:0] = EDATA_REG_HW[1:0] {
   }
   Alias REPEATLOOP_A_CNTR_REG[1:0] = REPEATLOOP_A_CNTR_REG_HW[1:0] {
   }
   Alias REPEATLOOP_B_CNTR_REG[1:0] = REPEATLOOP_B_CNTR_REG_HW[1:0] {
   }
   Alias MEM0_BIST_COLLAR_SI_INT = MEM0_TO_COLLAR_SI_MUX {
   }
   Alias STOP_ERROR_CNT_REG[11:0] = STOP_ERROR_CNT_REG_HW[11:0] {
   }
   Alias BIST_SO_INT = BIRA_SETUP_MUX {
   }
   Enum PassFail {
      Pass = 1'b1;
      Fail = 1'b0;
      Ignore = 1'bx;
   }
   Enum AsyncResetN {
      On = 1'b0;
      Off = 1'b1;
   }
   Enum SetupModes {
      Short = 3'b000;
      Long = 3'b001;
      Bira = 3'b100;
   }
   Enum OnOff {
      On = 1'b1;
      Off = 1'b0;
   }
   Enum RunModes {
      HWDefault = 4'b1010;
      RunTimeProg = 4'b1011;
      Idle = 4'bxx0x;
      Off = 4'b0xxx;
   }
   ScanRegister DIAG_EN_REG[0:0] {
      ScanInSource BIST_SI;
   }
   ScanRegister BIRA_EN_REG[0:0] {
      ScanInSource DIAG_EN_REG[0];
   }
   ScanRegister CMP_EN_MASK_EN[0:0] {
      ScanInSource BIRA_EN_REG[0];
   }
   ScanRegister CMP_EN_PARITY[0:0] {
      ScanInSource CMP_EN_MASK_EN[0];
   }
   ScanRegister MEM_SELECT_REG0[0:0] {
      ScanInSource CMP_EN_PARITY[0];
      ResetValue 1'd1;
   }
   ScanRegister REDUCED_ADDR_CNT_EN_REG[0:0] {
      ScanInSource MEM_SELECT_REG0[0];
      RefEnum OnOff;
   }
   ScanRegister ALGO_SEL_CNT_REG[0:0] {
      ScanInSource REDUCED_ADDR_CNT_EN_REG[0];
      RefEnum OnOff;
   }
   ScanRegister SELECT_COMMON_OPSET_REG[0:0] {
      ScanInSource ALGO_SEL_CNT_REG[0];
      RefEnum OnOff;
   }
   ScanRegister SELECT_COMMON_DATA_PAT_REG[0:0] {
      ScanInSource SELECT_COMMON_OPSET_REG[0];
      RefEnum OnOff;
   }
   ScanRegister MICROCODE_EN_REG[0:0] {
      ScanInSource SELECT_COMMON_DATA_PAT_REG[0];
   }
   ScanRegister INST_POINTER_REG_HW[0:4] {
      ScanInSource MICROCODE_EN_REG[0];
   }
   ScanRegister A_ADD_REG_Y_HW[0:3] {
      ScanInSource INST_POINTER_REG_HW[4];
   }
   ScanRegister A_ADD_REG_X_HW[0:8] {
      ScanInSource A_ADD_REG_Y_HW[3];
   }
   ScanRegister B_ADD_REG_Y_HW[0:3] {
      ScanInSource A_ADD_REG_X_HW[8];
   }
   ScanRegister B_ADD_REG_X_HW[0:8] {
      ScanInSource B_ADD_REG_Y_HW[3];
   }
   ScanRegister OPSET_SELECT_REG[0:0] {
      ScanInSource B_ADD_REG_X_HW[8];
   }
   ScanRegister WDATA_REG_HW[0:1] {
      ScanInSource OPSET_SELECT_REG[0];
   }
   ScanRegister EDATA_REG_HW[0:1] {
      ScanInSource WDATA_REG_HW[1];
   }
   ScanRegister X_ADDR_BIT_SEL_REG[0:0] {
      ScanInSource EDATA_REG_HW[1];
   }
   ScanRegister Y_ADDR_BIT_SEL_REG[0:0] {
      ScanInSource X_ADDR_BIT_SEL_REG[0];
   }
   ScanRegister REPEATLOOP_A_CNTR_REG_HW[0:1] {
      ScanInSource Y_ADDR_BIT_SEL_REG[0];
   }
   ScanRegister REPEATLOOP_B_CNTR_REG_HW[0:1] {
      ScanInSource REPEATLOOP_A_CNTR_REG_HW[1];
   }
   ScanRegister PRESERVE_BIRA_FUSE_REG[0:0] {
      ScanInSource MEM0_BIST_COLLAR_SO;
   }
   ScanRegister LOAD_BISR_FUSE_REG[0:0] {
      ScanInSource PRESERVE_BIRA_FUSE_REG[0];
   }
   ScanRegister STOP_ON_ERROR_REG[0:0] {
      ScanInSource LOAD_BISR_FUSE_REG[0];
   }
   ScanRegister FREEZE_STOP_ERROR_REG[0:0] {
      ScanInSource STOP_ON_ERROR_REG[0];
   }
   ScanRegister STOP_ERROR_CNT_REG_HW[0:11] {
      ScanInSource FREEZE_STOP_ERROR_REG[0];
   }
   ScanMux BIST_TO_COLLAR_SO_MUX SelectedBy LONG_SETUP, SHORT_SETUP {
      2'b01 : Y_ADDR_BIT_SEL_REG[0];
      2'b10 : REPEATLOOP_B_CNTR_REG_HW[1];
   }
   ScanMux MEM0_TO_COLLAR_SI_MUX SelectedBy BIRA_SETUP {
      1'b0 : BIST_TO_COLLAR_SO_MUX;
      1'b1 : BIST_SI;
   }
   ScanMux CONTROLLER_SETUP_CHAIN SelectedBy MBISTPG_EN, SETUP_MODE[2:0] {
      1'b1, 3'b00x : STOP_ERROR_CNT_REG_HW[11];
   }
   ScanMux BIRA_SETUP_MUX SelectedBy BIRA_SETUP {
      1'b0 : CONTROLLER_SETUP_CHAIN;
      1'b1 : MEM0_BIST_COLLAR_SO;
   }
   LogicSignal BIRA_SETUP {
      MBISTPG_EN, SETUP_MODE[2:0] == 1'b1, 3'b100;
   }
   LogicSignal LONG_SETUP {
      MBISTPG_EN, SETUP_MODE[2:0] == 1'b1, 3'b001;
   }
   LogicSignal SHORT_SETUP {
      MBISTPG_EN, SETUP_MODE[2:0] == 1'b1, 3'b000;
   }
}

// instanced as blockA_rtl_tessent_mbist_c1_controller_assembly.m1_inst
Module SYNC_8192X32_BISR {
   // ICL module read from source on or near line 1 of file '/home/susmita/MBIST_exercise1/MBIST/BlockA/blockA_tsdb/instruments/blockA_rtl_mbist.instrument/SYNC_8192X32_BISR.icl'
   DataInPort A[12:0] {
      Attribute connection_rule_option = "allowed_no_source";
      Attribute tessent_memory_bist_function = "address";
   }
   ClockPort CLK;
   Attribute tessent_use_in_dft_specification = "false";
   Attribute keep_active_during_scan_test = "false";
   Attribute tessent_memory_module = "without_internal_scan_logic";
}

// instanced as blockA_rtl_tessent_mbist_c1_controller_assembly.m1_interface_instance
Module blockA_rtl_tessent_mbist_c1_interface_m1 {
   // ICL module read from source on or near line 25 of file '/home/susmita/MBIST_exercise1/MBIST/BlockA/blockA_tsdb/instruments/blockA_rtl_mbist.instrument/blockA_rtl_tessent_mbist_c1_interface_m1.icl'
   ClockPort BIST_CLK;
   DataInPort BIST_COLLAR_EN;
   DataInPort BIST_EN {
      Attribute connection_rule_option = "allowed_no_source";
   }
   DataInPort BIST_ASYNC_RESETN;
   ScanInPort BIST_SI;
   ScanOutPort BIST_SO {
      Source BIST_SO_INT;
   }
   ShiftEnPort BIST_SHIFT_COLLAR;
   DataInPort BIST_SETUP2;
   DataInPort BIST_SETUP1;
   DataInPort BIST_SETUP0;
   DataInPort MEM_BYPASS_EN {
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataInPort MCP_BOUNDING_EN {
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataOutPort A[12:0] {
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_memory_bist_function = "address";
   }
   DataInPort CHECK_REPAIR_NEEDED;
   DataOutPort Seg1_SCOL0_FUSE_REG[4:0] {
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataInPort FROM_BISR_Seg1_SCOL0_FUSE_REG[4:0] {
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataOutPort Seg1_SCOL0_ALLOC_REG {
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataInPort FROM_BISR_Seg1_SCOL0_ALLOC_REG {
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataOutPort Seg1_SCOL0_FUSE_ADD_REG[3:0] {
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataInPort FROM_BISR_Seg1_SCOL0_FUSE_ADD_REG[3:0] {
      Attribute connection_rule_option = "allowed_tied_low";
   }
   Attribute tessent_instrument_type = "mentor::memory_bist";
   Attribute tessent_instrument_subtype = "memory_interface";
   Attribute tessent_signature = "df748fdb196c460adc2b8a6f088fa7c4";
   Attribute tessent_ignore_during_icl_verification = "on";
   Attribute keep_active_during_scan_test = "false";
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_bist_input_select_persistent_cell_output_list = 
       "tessent_persistent_cell_BIST_INPUT_SELECT_INT/Y";
   Attribute tessent_async_bypass_persistent_cell_input_list = "";
   Attribute tessent_bist_clk_persistent_cell_output_list = 
       "tessent_persistent_cell_GATING_BIST_CLK/GCK";
   Attribute tessent_memory_output_is_tristate = "false";
   Attribute tessent_memory_control_inputs_list = "CEB SELECT ACTIVELOW";
   Attribute tessent_memory_test_inputs_list = "";
   Attribute tessent_memory_test_outputs_list = "";
   Attribute tessent_memory_control_inputs_di_coverage_list = "partial";
   Alias RA_STATUS_SHADOW_REG[1:0] = RA_STATUS_SHADOW_REG_HW[1:0] {
   }
   Alias BIST_SO_INT = BIRA_SETUP_MUX {
   }
   ScanRegister RA_STATUS_SHADOW_REG_HW[0:1] {
      ScanInSource BIST_SI;
   }
   ScanRegister FREEZE_STOP_ERROR_REG[0:0] {
      ScanInSource RA_STATUS_SHADOW_REG[1];
   }
   ScanRegister GO_ID_REG[31:0] {
      ScanInSource FREEZE_STOP_ERROR_REG[0];
   }
   ScanRegister RA_INTERFACE_Seg1_SPARE0_FUSE_REG[0:4] {
      ScanInSource BIST_SI;
   }
   ScanRegister RA_INTERFACE_Seg1_SPARE0_ALLOC_REG[0:0] {
      ScanInSource RA_INTERFACE_Seg1_SPARE0_FUSE_REG[4];
   }
   ScanRegister RA_INTERFACE_Seg1_SPARE0_FUSE_ADD_REG[0:3] {
      ScanInSource RA_INTERFACE_Seg1_SPARE0_ALLOC_REG[0];
   }
   ScanRegister RA_INTERFACE_STATUS_REG[0:1] {
      ScanInSource RA_INTERFACE_Seg1_SPARE0_FUSE_ADD_REG[3];
   }
   ScanMux BIRA_SETUP_MUX SelectedBy BIRA_SETUP {
      1'b0 : GO_ID_REG[0];
      1'b1 : RA_INTERFACE_STATUS_REG[1];
   }
   LogicSignal BIRA_SETUP {
      (BIST_SETUP2, BIST_SETUP1), BIST_SETUP0 == 3'b100;
   }
}
