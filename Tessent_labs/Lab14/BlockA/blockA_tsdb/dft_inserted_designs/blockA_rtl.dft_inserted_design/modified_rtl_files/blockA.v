module blockA (CLK,in,out, ijtag_tck, ijtag_reset, ijtag_ce, ijtag_se, ijtag_ue, 
               ijtag_sel, ijtag_si, ijtag_so);
input CLK,in;
output out;
  input ijtag_tck, ijtag_reset, ijtag_ce, ijtag_se, ijtag_ue, ijtag_sel, 
        ijtag_si;
  wire ijtag_tck, ijtag_reset, ijtag_ce, ijtag_se, ijtag_ue, ijtag_sel, 
       ijtag_si;
  output ijtag_so;
  wire ijtag_so;


//wire [7:0] fromMem1,fromMem2,fromMem3,fromMem4A,fromMem4,fromMem5a,fromMem5, out_l1;
//wire [15:0] fromMem6;

wire [15:0] data_from_mem;
       wire [0:0] toBist;
       wire [3:0] BIST_COL_ADD;
       wire [8:0] BIST_ROW_ADD;
       wire [1:0] BIST_WRITE_DATA, BIST_EXPECT_DATA;
       wire [31:0] BWEB;
       wire [12:0] memA_interface_inst_A;
       wire [31:0] memA_interface_inst_D, memA_Q;
       wire blockA_rtl_tessent_sib_mbist_inst_so, 
            blockA_rtl_tessent_sib_sti_inst_so, 
            blockA_rtl_tessent_sib_sti_inst_to_select, to_ijtag_tck, 
            to_ijtag_ue, to_ijtag_reset, to_ijtag_se, to_ijtag_ce, ijtag_to_sel, 
            ltest_to_en, ltest_to_mem_bypass_en, ltest_to_scan_en, 
            ltest_to_mcp_bounding_en, BIST_CLK_EN, BIRA_EN, 
            PRESERVE_FUSE_REGISTER, CHECK_REPAIR_NEEDED, shift_en_R, BIST_HOLD, 
            BIST_SETUP, BIST_SETUP_ts1, BIST_SETUP_ts2, BIST_SELECT_TEST_DATA, 
            tck_out, TCK_MODE, mcp_bounding_to_en, scan_to_en, 
            memory_bypass_to_en, ltest_to_en_ts1, BIST_ALGO_MODE0, 
            BIST_ALGO_MODE1, ENABLE_MEM_RESET, REDUCED_ADDRESS_COUNT, 
            BIST_ASYNC_RESET, MEM0_BIST_COLLAR_SI, MBISTPG_SO, BIST_SO, bistEn, 
            MBISTPG_DONE, MBISTPG_GO, BIST_GO, BIST_DIAG_EN, 
            BIST_COLLAR_DIAG_EN, BIST_COLLAR_BIRA_EN, BIST_CLEAR_BIRA, 
            BIST_SHIFT_BIRA_COLLAR, BIST_IO_RA_PRSRV_FUSE_VAL_TO_COLLAR, 
            FL_CNT_MODE0, FL_CNT_MODE1, BIST_WRITEENABLE, BIST_SELECT, BIST_CMP, 
            BIST_COLLAR_EN0, BIST_RUN_TO_COLLAR0, 
            BIST_TESTDATA_SELECT_TO_COLLAR, BIST_ON_TO_COLLAR, CHKBCI_PHASE, 
            BIST_SHIFT_COLLAR, BIST_COLLAR_SETUP, BIST_CLEAR_DEFAULT, 
            BIST_CLEAR, BIST_COLLAR_HOLD, ERROR_CNT_ZERO, 
            MBISTPG_RESET_REG_SETUP2, WEB, CEB, 
            blockA_rtl_tessent_mbist_bap_inst_so;
       wire [15:0] tessent_filler_net;
       
      
       assign out = ^data_from_mem;

    /*SYNC_1RW_32x16_RC_BISR mem3 (
		                 .CLK(CLK), 
		                 .D(16'b0), 
	    	                 .Q(), 
	 	                 .BWE(16'd0), 
	                         .WE(1'b0), 
		                 .OE(1'b0), 
	                         .A(5'd0), 
		                 .RR0(4'd0), 
		                 .RR1(4'd0), 
		                 .CR0(7'd0)
                                );*/

      
      SYNC_8192X32_BISR memA (
                                .CLK(CLK),
                                .CEB(CEB),
                                .WEB(WEB),
                                .RSTB(1'b0),
                                .SCLK(1'b0),
                               .SDIN(1'b0),
                               .SDOUT(),
                               .A(memA_interface_inst_A),
                               .D(memA_interface_inst_D),
                               .BWEB(BWEB),
                               .TSEL(2'b01),
                               .Q(memA_Q)
                             );




  blockA_rtl_tessent_sib_1 blockA_rtl_tessent_sib_sti_inst(
      .ijtag_reset(ijtag_reset), .ijtag_sel(ijtag_sel), .ijtag_si(ijtag_si), .ijtag_ce(ijtag_ce), 
      .ijtag_se(ijtag_se), .ijtag_ue(ijtag_ue), .ijtag_tck(ijtag_tck), .ijtag_so(ijtag_so), 
      .ijtag_from_so(blockA_rtl_tessent_sib_mbist_inst_so), .ltest_si(1'b0), .ltest_scan_en(1'b0), 
      .ltest_en(1'b0), .ltest_clk(1'b0), .ltest_mem_bypass_en(1'b1), .ltest_mcp_bounding_en(1'b0), 
      .ltest_occ_en(1'b0), .ltest_async_set_reset_static_disable(1'b0), .ltest_static_clock_control_mode(1'b0), 
      .ltest_clock_sequence({1'b0, 1'b0}), .ltest_capture_en(1'b1), .ltest_so(), 
      .to_ijtag_reset(to_ijtag_reset), .ltest_to_en(ltest_to_en), .to_ijtag_si(blockA_rtl_tessent_sib_sti_inst_so), 
      .to_ijtag_ce(to_ijtag_ce), .to_ijtag_se(to_ijtag_se), .to_ijtag_ue(to_ijtag_ue), 
      .to_ijtag_tck(to_ijtag_tck), .ltest_to_mem_bypass_en(ltest_to_mem_bypass_en), 
      .ltest_to_mcp_bounding_en(ltest_to_mcp_bounding_en), .ltest_to_scan_en(ltest_to_scan_en), 
      .ijtag_to_sel(blockA_rtl_tessent_sib_sti_inst_to_select)
  );

  blockA_rtl_tessent_sib_2 blockA_rtl_tessent_sib_mbist_inst(
      .ijtag_reset(to_ijtag_reset), .ijtag_sel(blockA_rtl_tessent_sib_sti_inst_to_select), 
      .ijtag_si(blockA_rtl_tessent_sib_sti_inst_so), .ijtag_ce(to_ijtag_ce), .ijtag_se(to_ijtag_se), 
      .ijtag_ue(to_ijtag_ue), .ijtag_tck(to_ijtag_tck), .ijtag_so(blockA_rtl_tessent_sib_mbist_inst_so), 
      .ijtag_from_so(blockA_rtl_tessent_mbist_bap_inst_so), .ijtag_to_sel(ijtag_to_sel)
  );

  blockA_rtl_tessent_mbist_bap blockA_rtl_tessent_mbist_bap_inst(
      .reset(to_ijtag_reset), .ijtag_select(ijtag_to_sel), .si(blockA_rtl_tessent_sib_sti_inst_so), 
      .capture_en(to_ijtag_ce), .shift_en(to_ijtag_se), .shift_en_R(shift_en_R), 
      .update_en(to_ijtag_ue), .tck(to_ijtag_tck), .tck_out(tck_out), .mcp_bounding_en(ltest_to_mcp_bounding_en), 
      .mcp_bounding_to_en(mcp_bounding_to_en), .scan_en(ltest_to_scan_en), .scan_to_en(scan_to_en), 
      .memory_bypass_en(ltest_to_mem_bypass_en), .memory_bypass_to_en(memory_bypass_to_en), 
      .ltest_en(ltest_to_en), .ltest_to_en(ltest_to_en_ts1), .MBISTPG_GO(MBISTPG_GO), 
      .MBISTPG_DONE(MBISTPG_DONE), .ENABLE_MEM_RESET(ENABLE_MEM_RESET), .REDUCED_ADDRESS_COUNT(REDUCED_ADDRESS_COUNT), 
      .BIST_SELECT_TEST_DATA(BIST_SELECT_TEST_DATA), .BIST_ALGO_MODE0(BIST_ALGO_MODE0), 
      .BIST_ALGO_MODE1(BIST_ALGO_MODE1), .BIRA_EN(BIRA_EN), .BIST_DIAG_EN(BIST_DIAG_EN), 
      .PRESERVE_FUSE_REGISTER(PRESERVE_FUSE_REGISTER), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_ASYNC_RESET(BIST_ASYNC_RESET), .FL_CNT_MODE0(FL_CNT_MODE0), .FL_CNT_MODE1(FL_CNT_MODE1), 
      .BIST_CLK_EN(BIST_CLK_EN), .CHAIN_BYPASS_EN(), .BIST_HOLD(BIST_HOLD), .INVERT_ASYNC_TCK(), 
      .TCK_MODE(TCK_MODE), .BIST_SETUP({BIST_SETUP_ts2, BIST_SETUP_ts1, 
      BIST_SETUP}), .bistEn(bistEn), .toBist(toBist), .fromBist(MBISTPG_SO), .so(blockA_rtl_tessent_mbist_bap_inst_so)
  );

  blockA_rtl_tessent_mbist_c1_controller blockA_rtl_tessent_mbist_c1_controller_inst(
      .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD), .BIST_WRITE_DATA(BIST_WRITE_DATA), 
      .BIST_EXPECT_DATA(BIST_EXPECT_DATA), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP), 
      .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), .MEM_BYPASS_EN(memory_bypass_to_en), 
      .MCP_BOUNDING_EN(mcp_bounding_to_en), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI), 
      .MEM0_BIST_COLLAR_SO(BIST_SO), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .ERROR_CNT_ZERO(ERROR_CNT_ZERO), .FL_CNT_MODE({FL_CNT_MODE1, 
      FL_CNT_MODE0}), .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR(BIST_CLEAR), .BIST_COLLAR_GO(BIST_GO), 
      .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .MBISTPG_DIAG_EN(BIST_DIAG_EN), 
      .BIST_CLK(CLK), .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0), .BIST_CLK_EN(BIST_CLK_EN), 
      .BIST_SI(toBist), .MBISTPG_SO(MBISTPG_SO), .BIST_SHIFT(shift_en_R), .BIST_HOLD(BIST_HOLD), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP({BIST_SETUP_ts1, BIST_SETUP}), 
      .TCK_MODE(TCK_MODE), .TCK(tck_out), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), 
      .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_COLLAR_EN0(BIST_COLLAR_EN0), .CHKBCI_PHASE(CHKBCI_PHASE), .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .BIST_IO_RA_PRSRV_FUSE_VAL_TO_COLLAR(BIST_IO_RA_PRSRV_FUSE_VAL_TO_COLLAR), 
      .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .MBISTPG_EN(bistEn), 
      .MBISTPG_GO(MBISTPG_GO), .MBISTPG_DONE(MBISTPG_DONE)
  );

  blockA_rtl_tessent_mbist_c1_interface_m1 memA_interface_inst(
      .WEB_IN(1'b0), .WEB(WEB), .BWEB_IN({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
      1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
      1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
      1'b0, 1'b0, 1'b0}), .BWEB(BWEB), .CEB_IN(1'b0), .CEB(CEB), .A_IN({1'b0, 
      1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .A(memA_interface_inst_A), 
      .D_IN({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
      1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
      1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .D(memA_interface_inst_D), 
      .Q_IN(memA_Q), .Q({tessent_filler_net, data_from_mem[15:0]}), .SCAN_OBS_FLOPS(), 
      .BIST_CMP(BIST_CMP), .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_SELECT(BIST_SELECT), 
      .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR0), .BIST_WRITE_DATA(BIST_WRITE_DATA), 
      .BIST_CLK(CLK), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
      .BIST_EXPECT_DATA(BIST_EXPECT_DATA), .BIST_SO(BIST_SO), .BIST_SI(MEM0_BIST_COLLAR_SI), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_GO(BIST_GO), .LV_TM(ltest_to_en_ts1), .CHKBCI_PHASE(CHKBCI_PHASE), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN0), .Seg1_SCOL0_FUSE_REG(), .FROM_BISR_Seg1_SCOL0_FUSE_REG({
      1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .Seg1_SCOL0_ALLOC_REG(), .FROM_BISR_Seg1_SCOL0_ALLOC_REG(1'b0), 
      .Seg1_SCOL0_FUSE_ADD_REG(), .FROM_BISR_Seg1_SCOL0_FUSE_ADD_REG({1'b0, 
      1'b0, 1'b0, 1'b0}), .REPAIR_STATUS(), .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
      .ERROR_CNT_ZERO(ERROR_CNT_ZERO), .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .BIST_IO_RA_PRSRV_FUSE_VAL_TO_COLLAR(BIST_IO_RA_PRSRV_FUSE_VAL_TO_COLLAR), 
      .BIST_EN(bistEn)
  );
endmodule 

/*
// [start] : mem1 {{{
SYNC_1R1W_16x8 mem1 ( 
		.CLKR(CLK), 
		.CLKW(CLK), 
		.AR(4'd0), 
		.AW(4'd0), 
		.D(8'd0), 
		.Q(fromMem1), 
		.RE(1'b0), 
		.WE(1'b0), 
		.GWE(8'd0), 
		.OE(1'b0));
// [end]   : mem1 }}}
// [start] : mem2 {{{
SYNC_1R1W_16x8 mem2 ( 
		.CLKR(CLK), 
		.CLKW(CLK), 
		.AR(4'd0), 
		.AW(4'd0), 
		.D(fromMem1), 
		.Q(fromMem2), 
		.RE(1'b0), 
		.WE(1'b0), 
		.GWE(8'd0), 
		.OE(1'b0));
// [end]   : mem2 }}}
// [start] : mem3 {{{
SYNC_1RW_32x16_RC_BISR mem3 (
		.CLK(CLK), 
		.D(16'b0), 
		.Q(), 
		.BWE(16'd0), 
		.WE(1'b0), 
		.OE(1'b0), 
		.A(5'd0), 
		.RR0(4'd0), 
		.RR1(4'd0), 
		.CR0(7'd0));
// [end]   : mem3 }}}

// [start] : mem4 {{{
SYNC_1RW_32x16_RC_BISR mem4 (
		.CLK(CLK), 
		.D(16'b0), 
		.Q(), 
		.BWE(16'd0), 
		.WE(1'b0), 
		.OE(1'b0), 
		.A(5'd0), 
		.RR0(4'd0), 
		.RR1(4'd0), 
		.CR0(7'd0));
// [end]   : mem4 }}}
// [start] : mem5 {{{
SYNC_1RW_32x16_RC_BISR mem5 (
		.CLK(CLK), 
		.D(16'b0), 
		.Q(), 
		.BWE(16'd0), 
		.WE(1'b0), 
		.OE(1'b0), 
		.A(5'd0), 
		.RR0(4'd0), 
		.RR1(4'd0), 
		.CR0(7'd0));
// [end]   : mem5 }}}

// [start] : mem6 {{{
SYNC_1RW_32x16_RC_BISR mem6 (
		.CLK(CLK), 
		.D(16'b0), 
		.Q(), 
		.BWE(16'd0), 
		.WE(1'b0), 
		.OE(1'b0), 
		.A(5'd0), 
		.RR0(4'd0), 
		.RR1(4'd0), 
		.CR0(7'd0));
// [end]   : mem6 }}}

blockA_l1 blockA_l1_i1 (.CLK(CLK),.in(in),.out(out));

endmodule
module blockA_l1 (CLK,in,out);
input CLK,in;
output out;

wire [7:0] fromMem1,fromMem2,fromMem3,fromMem4A,fromMem4,fromMem5a,fromMem5, out_l2;
wire [15:0] fromMem6;
SYNC_1R1W_16x8 mem1 ( 
		.CLKR(CLK), 
		.CLKW(CLK), 
		.AR(4'd0), 
		.AW(4'd0), 
		.D(8'd0), 
		.Q(fromMem1), 
		.RE(1'b0), 
		.WE(1'b0), 
		.GWE(8'd0), 
		.OE(1'b0));
SYNC_1R1W_16x8 mem2 ( 
		.CLKR(CLK), 
		.CLKW(CLK), 
		.AR(4'd0), 
		.AW(4'd0), 
		.D(fromMem1), 
		.Q(fromMem2), 
		.RE(1'b0), 
		.WE(1'b0), 
		.GWE(8'd0), 
		.OE(1'b0));
SYNC_1R1W_16x8 mem3 ( 
		.CLKR(CLK), 
		.CLKW(CLK), 
		.AR(4'd0), 
		.AW(4'd0), 
		.D(fromMem2), 
		.Q(fromMem3), 
		.RE(1'b0), 
		.WE(1'b0), 
		.GWE(8'd0), 
		.OE(1'b0));
SYNC_2R2W_12x8 mem4 ( 
		.CLK(CLK), 
		.CE(1'b0), 
		.AR1(4'd0), 
		.AR2(4'd0), 
		.AW1(4'd0), 
		.AW2(4'd0), 
		.D1(fromMem1),  
		.D2(fromMem4a), 
		.Q1(fromMem4a),  
		.Q2(fromMem4), 
		.RE1(1'b0), 
		.RE2(1'b0), 
		.WE1(1'b0), 
		.WE2(1'b0), 
		.OE1(1'b0), 
		.OE2(1'b0));
SYNC_2R2W_12x8 mem5 ( 
		.CLK(CLK), 
		.CE(1'b0), 
		.AR1(4'd0), 
		.AR2(4'd0), 
		.AW1(4'd0), 
		.AW2(4'd0), 
		.D1(fromMem4),  
		.D2(fromMem5a), 
		.Q1(fromMem5a),  
		.Q2(fromMem5), 
		.RE1(1'b0), 
		.RE2(1'b0), 
		.WE1(1'b0), 
		.WE2(1'b0), 
		.OE1(1'b0), 
		.OE2(1'b0)); 

SYNC_1RW_32x16_RC_BISR mem6 (
		.CLK(CLK), 
		.D({fromMem1,fromMem2}), 
		.Q(fromMem6), 
		.BWE(16'd0), 
		.WE(1'b0), 
		.OE(1'b0), 
		.A(5'd0), 
		.RR0(4'd0), 
		.RR1(4'd0), 
		.CR0(7'd0));

blockA_l2 blockA_l2_i1 (.CLK(CLK),.in(in),.out(out_l2));

assign out = ^(fromMem1 ^ fromMem2 ^ fromMem3 ^ fromMem4 ^ fromMem5 ^ fromMem6[15:8] ^ fromMem6[7:0] ^ out_l2);

endmodule
module blockA_l2 (CLK,in,out);
input CLK,in;
output out;

wire [7:0] fromMem1,fromMem2,fromMem3,fromMem4A,fromMem4,fromMem5a,fromMem5;
wire [15:0] fromMem6;
SYNC_1R1W_16x8 mem1 ( 
		.CLKR(CLK), 
		.CLKW(CLK), 
		.AR(4'd0), 
		.AW(4'd0), 
		.D(8'd0), 
		.Q(fromMem1), 
		.RE(1'b0), 
		.WE(1'b0), 
		.GWE(8'd0), 
		.OE(1'b0));
SYNC_1R1W_16x8 mem2 ( 
		.CLKR(CLK), 
		.CLKW(CLK), 
		.AR(4'd0), 
		.AW(4'd0), 
		.D(fromMem1), 
		.Q(fromMem2), 
		.RE(1'b0), 
		.WE(1'b0), 
		.GWE(8'd0), 
		.OE(1'b0));
SYNC_1R1W_16x8 mem3 ( 
		.CLKR(CLK), 
		.CLKW(CLK), 
		.AR(4'd0), 
		.AW(4'd0), 
		.D(fromMem2), 
		.Q(fromMem3), 
		.RE(1'b0), 
		.WE(1'b0), 
		.GWE(8'd0), 
		.OE(1'b0));
SYNC_2R2W_12x8 mem4 ( 
		.CLK(CLK), 
		.CE(1'b0), 
		.AR1(4'd0), 
		.AR2(4'd0), 
		.AW1(4'd0), 
		.AW2(4'd0), 
		.D1(fromMem1),  
		.D2(fromMem4a), 
		.Q1(fromMem4a),  
		.Q2(fromMem4), 
		.RE1(1'b0), 
		.RE2(1'b0), 
		.WE1(1'b0), 
		.WE2(1'b0), 
		.OE1(1'b0), 
		.OE2(1'b0));
SYNC_2R2W_12x8 mem5 ( 
		.CLK(CLK), 
		.CE(1'b0), 
		.AR1(4'd0), 
		.AR2(4'd0), 
		.AW1(4'd0), 
		.AW2(4'd0), 
		.D1(fromMem4),  
		.D2(fromMem5a), 
		.Q1(fromMem5a),  
		.Q2(fromMem5), 
		.RE1(1'b0), 
		.RE2(1'b0), 
		.WE1(1'b0), 
		.WE2(1'b0), 
		.OE1(1'b0), 
		.OE2(1'b0));

SYNC_1RW_32x16_RC_BISR mem6 (
		.CLK(CLK), 
		.D({fromMem1,fromMem2}), 
		.Q(fromMem6), 
		.BWE(16'd0), 
		.WE(1'b0), 
		.OE(1'b0), 
		.A(5'd0), 
		.RR0(4'd0), 
		.RR1(4'd0), 
		.CR0(7'd0));*/

