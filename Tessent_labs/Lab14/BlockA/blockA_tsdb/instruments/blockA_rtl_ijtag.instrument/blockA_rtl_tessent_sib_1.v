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
//       Created on: Wed Aug 14 12:11:28 IST 2019
//--------------------------------------------------------

module blockA_rtl_tessent_sib_1 (
   ijtag_reset           , // i
   ijtag_sel             , // i
   ijtag_si              , // i
   ijtag_ce              , // i
   ijtag_se              , // i
   ijtag_ue              , // i
   ijtag_tck             , // i
   ijtag_so              , // o
   ijtag_from_so         , // i
   ltest_si              , //i
   ltest_scan_en         , //i
   ltest_en              , //i
   ltest_clk             , //i
   ltest_mem_bypass_en   , //i
   ltest_mcp_bounding_en , //i
   ltest_occ_en          , //i
   ltest_async_set_reset_static_disable , //i
   ltest_static_clock_control_mode , //i
   ltest_clock_sequence  , //i
   ltest_capture_en      , //i
   ltest_so              , //o
   to_ijtag_reset        , // o
   ltest_to_en           , // o
   to_ijtag_si           , // o
   to_ijtag_ce           , // o
   to_ijtag_se           , // o
   to_ijtag_ue           , // o
   to_ijtag_tck          , // o
   ltest_to_mem_bypass_en , // o
   ltest_to_mcp_bounding_en , // o
   ltest_to_scan_en      , // o
   ijtag_to_sel            // o
);
 
   input          ijtag_reset;
   input          ijtag_sel;
   input          ijtag_si;
   input          ijtag_ce;
   input          ijtag_se;
   input          ijtag_ue;
   input          ijtag_tck;
   input          ijtag_from_so;
   output         ijtag_so;
   output         ijtag_to_sel;
   input          ltest_si;
   input          ltest_scan_en;
   input          ltest_en;
   input          ltest_clk;
   input          ltest_mem_bypass_en;
   input          ltest_mcp_bounding_en;
   input          ltest_async_set_reset_static_disable;
   input          ltest_occ_en;
   input          ltest_static_clock_control_mode;
   input    [1:0] ltest_clock_sequence;
   input          ltest_capture_en;
   output         ltest_to_en;
   output         ltest_so;
   output         to_ijtag_reset;
   output         to_ijtag_si;
   output         to_ijtag_ce;
   output         to_ijtag_se;
   output         to_ijtag_ue;
   output         to_ijtag_tck;
   output         ltest_to_mem_bypass_en;
   output         ltest_to_mcp_bounding_en;
   output         ltest_to_scan_en;
 
   reg            sib;
   reg            sib_latch;
   reg            retiming_so;
   reg            to_enable_int;
   reg            ltest_to_si;
   reg            retiming_ltest_to_si;
   reg [1:0]      ltest_ce_se_ue;
   reg            retiming_ltest_to_ce;
   reg            retiming_ltest_to_se;
   reg            ltest_to_sel;
   reg            ltest_so_retiming;
   reg            ltest_to_reset;
   reg            retiming_ltest_to_sel;
   reg [1:0]      occ_ctrl;
   reg            occ_ctrl_so_retimed;
   wire           occ_ctrl_so;
   wire           occ_clock_out;
 
   assign ltest_to_en = ltest_en;
   assign ltest_to_mem_bypass_en = ltest_en & ltest_mem_bypass_en;
   assign ltest_to_mcp_bounding_en = ltest_en & ltest_mcp_bounding_en;
   assign ltest_to_scan_en = ltest_en & ltest_scan_en;
   assign ijtag_to_sel = ltest_en ? ltest_to_sel : to_enable_int & ijtag_sel;
   always @ (negedge ijtag_tck or negedge ijtag_reset) begin
      if (~ijtag_reset) begin
         sib_latch     <= 1'b0;
      end else if (ijtag_ue & ijtag_sel) begin
         sib_latch     <= sib;
      end
   end
   always @ (negedge ijtag_tck or negedge ijtag_reset) begin
      if (~ijtag_reset) begin
         to_enable_int <= 1'b0;
      end else  begin
         to_enable_int <= sib_latch;
      end
   end
 
   assign ijtag_so = retiming_so;
    always @ (ijtag_tck or sib) begin
      if (~ijtag_tck) begin
         retiming_so     <= sib;
      end
   end
 
   always @ (posedge ijtag_tck) begin
      if (ijtag_ce & ijtag_sel) begin
         sib <= 1'b0;
      end else if (ijtag_se & ijtag_sel) begin
         if (sib_latch) begin
            sib <= ijtag_from_so;
         end else begin
            sib <= ijtag_si;
         end
      end
   end
 
   assign to_ijtag_reset = ltest_en ? ltest_to_reset | (ltest_scan_en || ltest_async_set_reset_static_disable) : ijtag_reset;
   assign to_ijtag_si    =  ltest_en ? retiming_ltest_to_si : ijtag_si;
   assign to_ijtag_ce    = ltest_en ? ~ltest_ce_se_ue[1] &  ltest_ce_se_ue[0] : ijtag_ce;
   assign to_ijtag_se    = ltest_en ?  ltest_ce_se_ue[1] & ~ltest_ce_se_ue[0] : ijtag_se;
   assign to_ijtag_ue    = ltest_en ?  ltest_ce_se_ue[1] &  ltest_ce_se_ue[0] : ijtag_ue;
   assign ltest_so       = ltest_so_retiming;
   always @ (posedge to_ijtag_tck) begin
     if (ltest_scan_en) begin
       ltest_to_sel <= ltest_ce_se_ue[1];
       ltest_ce_se_ue[1] <= ltest_ce_se_ue[0];
       ltest_ce_se_ue[0] <= retiming_ltest_to_si;
       ltest_to_si <= ltest_to_reset;
       ltest_to_reset <= occ_ctrl_so;
     end else begin
       ltest_to_si <= ijtag_from_so;
       ltest_ce_se_ue <= ltest_ce_se_ue;
       ltest_to_sel <= ltest_to_sel;
       ltest_to_reset <= ltest_to_reset;
     end
   end
   wire ltest_clk_buf;

   wire         ltest_scan_en_buf_out;
   wire         ltest_capture_en_buf_out;
   wire         static_clock_control_mode_buf_out;
   wire   [1:0] clock_sequence_buf_out;
   wire         ltest_scan_in_buf_out;
   wire         occ_ctrl_so_buf_in;

   buf02 tessent_persistent_cell_ltest_scan_en_buf (
      .A                 ( ltest_scan_en ),
      .Y                 ( ltest_scan_en_buf_out )
   );
   buf02 tessent_persistent_cell_ltest_capture_en_buf (
      .A                 ( ltest_capture_en ),
      .Y                 ( ltest_capture_en_buf_out )
   );
   buf02 tessent_persistent_cell_static_clock_control_mode_buf (
      .A                 ( ltest_static_clock_control_mode ),
      .Y                 ( static_clock_control_mode_buf_out )
   );
   buf02 tessent_persistent_cell_clock_sequence_buf_0 (
      .A                 ( ltest_clock_sequence[0] ),
      .Y                 ( clock_sequence_buf_out[0] )
   );
   buf02 tessent_persistent_cell_clock_sequence_buf_1 (
      .A                 ( ltest_clock_sequence[1] ),
      .Y                 ( clock_sequence_buf_out[1] )
   );
   buf02 tessent_persistent_cell_ltest_scan_in_buf (
      .A                 ( ltest_si ),
      .Y                 ( ltest_scan_in_buf_out )
   );
   buf02 tessent_persistent_cell_occ_ctrl_so_buf (
      .A                 ( occ_ctrl_so_buf_in ),
      .Y                 ( occ_ctrl_so )
   );
   buf02 tessent_persistent_cell_cts_stop_buf (
     .A                  ( ltest_clk ),
     .Y                  ( ltest_clk_buf )
   );
   always @ (posedge ltest_clk_buf) begin
     if (ltest_scan_en_buf_out) begin
       if (static_clock_control_mode_buf_out) begin
          occ_ctrl[1:0] <= clock_sequence_buf_out;
       end else begin
         occ_ctrl[1:0] <= {ltest_scan_in_buf_out,occ_ctrl[1]};
       end
     end else begin
       if (ltest_capture_en_buf_out) begin
         occ_ctrl[1:0] <= {1'b0,occ_ctrl[1]};
       end
     end
   end
   always @ (negedge ltest_clk_buf) begin
     occ_ctrl_so_retimed <= occ_ctrl[0];
   end
   assign occ_ctrl_so_buf_in = (static_clock_control_mode_buf_out) ? ltest_scan_in_buf_out : occ_ctrl_so_retimed;
 
   cgand tessent_persistent_cell_occ_clock_gate (
     .GCK                ( occ_clock_out),
     .CK                 ( ltest_clk_buf ),
     .FE                 ( occ_ctrl[0] & ltest_capture_en_buf_out & ltest_occ_en),
     .TE                 ( ltest_scan_en_buf_out)
   );
    
   clock_mux21 tessent_persistent_cell_ltest_clock_mux (
     .A0                 ( ijtag_tck ),
     .A1                 ( occ_clock_out ),
     .S0                 ( ltest_en ),
     .Y                  ( to_ijtag_tck )
   );
   
    always @ (to_ijtag_tck or ltest_to_si) begin
     if (~to_ijtag_tck) begin
       retiming_ltest_to_si <= ltest_to_si;
     end
   end 
   always @ (to_ijtag_tck or ltest_to_sel) begin
     if (~to_ijtag_tck) begin
       ltest_so_retiming <= ltest_to_sel;
     end
   end
endmodule
