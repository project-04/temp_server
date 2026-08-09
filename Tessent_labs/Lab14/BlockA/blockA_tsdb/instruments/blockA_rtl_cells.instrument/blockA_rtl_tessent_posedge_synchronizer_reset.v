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

  
module blockA_rtl_tessent_posedge_synchronizer_reset (rn, d, clk, q);
input rn, d, clk;
output reg q;
reg ntc_retiming_q_reg;
always @ (posedge clk or negedge rn) begin
  if (~rn) begin
    ntc_retiming_q_reg <= 1'b0;
    q <= 1'b0;
  end else begin
    ntc_retiming_q_reg <= d;
    q <= ntc_retiming_q_reg;
  end
end
endmodule
