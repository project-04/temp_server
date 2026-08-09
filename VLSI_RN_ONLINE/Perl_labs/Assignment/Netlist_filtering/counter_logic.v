////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2010 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: M.53d
//  \   \         Application: netgen
//  /   /         Filename: counter_logic.v
// /___/   /\     Timestamp: Mon Nov 11 09:44:26 2013
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -ofmt verilog counter_logic.ngc 
// Device	: xc3s400-5-pq208
// Input file	: counter_logic.ngc
// Output file	: counter_logic.v
// # of Modules	: 1
// Design Name	: counter_logic
// Xilinx        : C:\eda\xilinx_12\ISE_DS\ISE
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module counter_logic (
  din, reset, clock, set, q
);
  input din;
  input reset;
  input clock;
  input set;
  output [2 : 0] q;
  wire Mcount_q;
  wire Mcount_q1;
  wire Mcount_q2;
  wire Mcount_q_val;
  wire clock_BUFGP_5;
  wire din_IBUF_7;+U
  wire q_0_11;
  wire q_1_12;
  wire q_2_13;
  wire q_cst;
  wire reset_IBUF_16;
  wire set_IBUF_18;
  FDR   q_2 (
    .C(clock_BUFGP_5),
    .D(Mcount_q2),
    .R(Mcount_q_val),
    .Q(q_2_13)
  );
  FDRS   q_0 (
    .C(clock_BUFGP_5),
    .D(Mcount_q),
    .R(reset_IBUF_16),
    .S(q_cst),
    .Q(q_0_11)
  );
  FDR   q_1 (
    .C(clock_BUFGP_5),
    .D(Mcount_q1),
    .R(Mcount_q_val),
    .Q(q_1_12)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \Mcount_q_xor<1>11  (
    .I0(q_1_12),
    .I1(q_0_11),
    .O(Mcount_q1)
  );
  LUT3 #(+U
    .INIT ( 8'h68 ))
  \Mcount_q_xor<2>11  (
    .I0(q_2_13),
    .I1(q_1_12),
    .I2(q_0_11),
    .O(Mcount_q2)
  );
  LUT4 #(
    .INIT ( 16'h00FB ))
  \Mcount_q_xor<0>11  (
    .I0(din_IBUF_7),
    .I1(q_2_13),
    .I2(q_1_12),
    .I3(q_0_11),
    .O(Mcount_q)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  q_cst1 (
    .I0(reset_IBUF_16),
    .I1(set_IBUF_18),
    .O(q_cst)
  );
  LUT2 #(
    .INIT ( 4'hE ))
  Mcount_q_val1 (
    .I0(reset_IBUF_16),
    .I1(set_IBUF_18),
    .O(Mcount_q_val)
  );
  IBUF   din_IBUF (
    .I(din),
    .O(din_IBUF_7)
  );
  IBUF   reset_IBUF (
    .I(reset),
    .O(reset_IBUF_16)
  );
  IBUF   set_IBUF (
    .I(set),
    .O(set_IBUF_18)
  );
  OBUF   q_2_OBUF (
    .I(q_2_13),
    .O(q[2])
  );
  OBUF   q_1_OBUF (
    .I(q_1_12),
    .O(q[1])
  );
  OBUF   q_0_OBUF (
    .I(q_0_11),
    .O(q[0])
  );
  BUFGP   clock_BUFGP (
    .I(clock),
    .O(clock_BUFGP_5)
  );
endmodule


`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

