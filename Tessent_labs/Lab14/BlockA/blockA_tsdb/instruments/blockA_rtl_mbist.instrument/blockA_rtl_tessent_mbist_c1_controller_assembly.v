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
//       Created on: Wed Aug 14 12:11:35 IST 2019
//--------------------------------------------------------


module blockA_rtl_tessent_mbist_c1_controller_assembly(LV_TM, MEM_BYPASS_EN, SCAN_SHIFT_EN, 
                                                       MCP_BOUNDING_EN, BIST_ON, 
                                                       BIST_DONE, BIST_GO, clk_clka, 
                                                       m1_inst_WEB, m1_inst_BWEB, 
                                                       m1_inst_CEB, m1_inst_D, 
                                                       m1_inst_Q, m1_inst_A, m1_inst_TSEL, 
                                                       m1_inst_RSTB, m1_inst_SCLK, 
                                                       m1_inst_SDIN, m1_inst_SDOUT, 
                                                       reset, ijtag_select, si, 
                                                       capture_en, shift_en, update_en, 
                                                       tck, so);
  input  [31:0] m1_inst_BWEB, m1_inst_D;
  input  [12:0] m1_inst_A;
  input  [1:0] m1_inst_TSEL;
  input  LV_TM, MEM_BYPASS_EN, SCAN_SHIFT_EN, MCP_BOUNDING_EN, clk_clka, 
         m1_inst_WEB, m1_inst_CEB, m1_inst_RSTB, m1_inst_SCLK, m1_inst_SDIN, 
         reset, ijtag_select, si, capture_en, shift_en, update_en, tck;
  output [31:0] m1_inst_Q;
  output BIST_ON, BIST_DONE, BIST_GO, m1_inst_SDOUT, so;

  wire [31:0] BWEB, m1_interface_instance_D, m1_inst_Q_ts1;
  wire [12:0] m1_interface_instance_A;
  wire [8:0] BIST_ROW_ADD;
  wire [3:0] BIST_COL_ADD;
  wire [1:0] BIST_WRITE_DATA, BIST_EXPECT_DATA;
  wire [0:0] toBist;
  wire BIST_CLK_EN, BIRA_EN, PRESERVE_FUSE_REGISTER, CHECK_REPAIR_NEEDED, 
       shift_en_R, BIST_HOLD, BIST_SETUP, BIST_SETUP_ts1, BIST_SETUP_ts2, 
       BIST_SELECT_TEST_DATA, tck_out, TCK_MODE, BIST_ALGO_MODE0, 
       BIST_ALGO_MODE1, ENABLE_MEM_RESET, REDUCED_ADDRESS_COUNT, 
       BIST_ASYNC_RESET, MEM0_BIST_COLLAR_SI, MBISTPG_SO, BIST_SO, bistEn, 
       BIST_GO_ts1, BIST_DIAG_EN, BIST_COLLAR_DIAG_EN, BIST_COLLAR_BIRA_EN, 
       BIST_CLEAR_BIRA, BIST_SHIFT_BIRA_COLLAR, 
       BIST_IO_RA_PRSRV_FUSE_VAL_TO_COLLAR, FL_CNT_MODE0, FL_CNT_MODE1, 
       BIST_WRITEENABLE, BIST_SELECT, BIST_CMP, BIST_COLLAR_EN0, 
       BIST_RUN_TO_COLLAR0, BIST_TESTDATA_SELECT_TO_COLLAR, CHKBCI_PHASE, 
       BIST_SHIFT_COLLAR, BIST_COLLAR_SETUP, BIST_CLEAR_DEFAULT, BIST_CLEAR, 
       BIST_COLLAR_HOLD, ERROR_CNT_ZERO, MBISTPG_RESET_REG_SETUP2, WEB, CEB;

  SYNC_8192X32_BISR m1_inst(
      .SCLK(m1_inst_SCLK), .RSTB(m1_inst_RSTB), .SDIN(m1_inst_SDIN), .SDOUT(m1_inst_SDOUT), 
      .CLK(clk_clka), .WEB(WEB), .BWEB(BWEB), .CEB(CEB), .TSEL(m1_inst_TSEL), .A(m1_interface_instance_A), 
      .D(m1_interface_instance_D), .Q(m1_inst_Q_ts1)
  );
  blockA_rtl_tessent_mbist_bap blockA_rtl_tessent_mbist_bap_inst(
      .reset(reset), .ijtag_select(ijtag_select), .si(si), .capture_en(capture_en), 
      .shift_en(shift_en), .shift_en_R(shift_en_R), .update_en(update_en), .tck(tck), 
      .tck_out(tck_out), .mcp_bounding_en(1'b0), .mcp_bounding_to_en(), .scan_en(), 
      .scan_to_en(), .memory_bypass_en(1'b0), .memory_bypass_to_en(), .ltest_en(LV_TM), 
      .ltest_to_en(), .MBISTPG_GO(BIST_GO), .MBISTPG_DONE(BIST_DONE), .ENABLE_MEM_RESET(ENABLE_MEM_RESET), 
      .REDUCED_ADDRESS_COUNT(REDUCED_ADDRESS_COUNT), .BIST_SELECT_TEST_DATA(BIST_SELECT_TEST_DATA), 
      .BIST_ALGO_MODE0(BIST_ALGO_MODE0), .BIST_ALGO_MODE1(BIST_ALGO_MODE1), .BIRA_EN(BIRA_EN), 
      .BIST_DIAG_EN(BIST_DIAG_EN), .PRESERVE_FUSE_REGISTER(PRESERVE_FUSE_REGISTER), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
      .FL_CNT_MODE0(FL_CNT_MODE0), .FL_CNT_MODE1(FL_CNT_MODE1), .BIST_CLK_EN(BIST_CLK_EN), 
      .CHAIN_BYPASS_EN(), .BIST_HOLD(BIST_HOLD), .INVERT_ASYNC_TCK(), .TCK_MODE(TCK_MODE), 
      .BIST_SETUP({BIST_SETUP_ts2, BIST_SETUP_ts1, BIST_SETUP}), .bistEn(bistEn), 
      .toBist(toBist), .fromBist(MBISTPG_SO), .so(so)
  );
  blockA_rtl_tessent_mbist_c1_controller blockA_rtl_tessent_mbist_c1_controller_inst(
      .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD), .BIST_WRITE_DATA(BIST_WRITE_DATA), 
      .BIST_EXPECT_DATA(BIST_EXPECT_DATA), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP), 
      .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), .MEM_BYPASS_EN(MEM_BYPASS_EN), 
      .MCP_BOUNDING_EN(MCP_BOUNDING_EN), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI), 
      .MEM0_BIST_COLLAR_SO(BIST_SO), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .ERROR_CNT_ZERO(ERROR_CNT_ZERO), .FL_CNT_MODE({FL_CNT_MODE1, 
      FL_CNT_MODE0}), .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR(BIST_CLEAR), .BIST_COLLAR_GO(BIST_GO_ts1), 
      .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .MBISTPG_DIAG_EN(BIST_DIAG_EN), 
      .BIST_CLK(clk_clka), .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0), .BIST_CLK_EN(BIST_CLK_EN), 
      .BIST_SI(toBist), .MBISTPG_SO(MBISTPG_SO), .BIST_SHIFT(shift_en_R), .BIST_HOLD(BIST_HOLD), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP({BIST_SETUP_ts1, BIST_SETUP}), 
      .TCK_MODE(TCK_MODE), .TCK(tck_out), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .BIST_ON_TO_COLLAR(BIST_ON), .LV_TM(LV_TM), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), 
      .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_COLLAR_EN0(BIST_COLLAR_EN0), .CHKBCI_PHASE(CHKBCI_PHASE), .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .BIST_IO_RA_PRSRV_FUSE_VAL_TO_COLLAR(BIST_IO_RA_PRSRV_FUSE_VAL_TO_COLLAR), 
      .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .MBISTPG_EN(bistEn), 
      .MBISTPG_GO(BIST_GO), .MBISTPG_DONE(BIST_DONE)
  );
  blockA_rtl_tessent_mbist_c1_interface_m1 m1_interface_instance(
      .WEB_IN(m1_inst_WEB), .WEB(WEB), .BWEB_IN(m1_inst_BWEB[31:0]), .BWEB(BWEB), 
      .CEB_IN(m1_inst_CEB), .CEB(CEB), .A_IN(m1_inst_A[12:0]), .A(m1_interface_instance_A), 
      .D_IN(m1_inst_D[31:0]), .D(m1_interface_instance_D), .Q_IN(m1_inst_Q_ts1), 
      .Q(m1_inst_Q[31:0]), .SCAN_OBS_FLOPS(), .BIST_CMP(BIST_CMP), .BIST_WRITEENABLE(BIST_WRITEENABLE), 
      .BIST_SELECT(BIST_SELECT), .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD), 
      .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), .MEM_BYPASS_EN(MEM_BYPASS_EN), 
      .SCAN_SHIFT_EN(SCAN_SHIFT_EN), .MCP_BOUNDING_EN(MCP_BOUNDING_EN), .BIST_ON(BIST_ON), 
      .BIST_RUN(BIST_RUN_TO_COLLAR0), .BIST_WRITE_DATA(BIST_WRITE_DATA), .BIST_CLK(clk_clka), 
      .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
      .BIST_EXPECT_DATA(BIST_EXPECT_DATA), .BIST_SO(BIST_SO), .BIST_SI(MEM0_BIST_COLLAR_SI), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_GO(BIST_GO_ts1), .LV_TM(LV_TM), .CHKBCI_PHASE(CHKBCI_PHASE), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN0), .Seg1_SCOL0_FUSE_REG(), .FROM_BISR_Seg1_SCOL0_FUSE_REG({
      1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .Seg1_SCOL0_ALLOC_REG(), .FROM_BISR_Seg1_SCOL0_ALLOC_REG(1'b0), 
      .Seg1_SCOL0_FUSE_ADD_REG(), .FROM_BISR_Seg1_SCOL0_FUSE_ADD_REG({1'b0, 
      1'b0, 1'b0, 1'b0}), .REPAIR_STATUS(), .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
      .ERROR_CNT_ZERO(ERROR_CNT_ZERO), .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .BIST_IO_RA_PRSRV_FUSE_VAL_TO_COLLAR(BIST_IO_RA_PRSRV_FUSE_VAL_TO_COLLAR), 
      .BIST_EN(bistEn)
  );
endmodule

