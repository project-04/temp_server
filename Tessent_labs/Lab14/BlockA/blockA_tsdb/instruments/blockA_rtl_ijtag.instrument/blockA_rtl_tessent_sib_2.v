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

module blockA_rtl_tessent_sib_2 (
   ijtag_reset           , // i
   ijtag_sel             , // i
   ijtag_si              , // i
   ijtag_ce              , // i
   ijtag_se              , // i
   ijtag_ue              , // i
   ijtag_tck             , // i
   ijtag_so              , // o
   ijtag_from_so         , // i
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
 
   reg            sib;
   reg            sib_latch;
   reg            retiming_so;
   reg            to_enable_int;
 
   assign ijtag_to_sel = to_enable_int & ijtag_sel;
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
 
endmodule
