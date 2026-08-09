module blockA (CLK,in,out);
input CLK,in;
output out;

wire [7:0] fromMem1,fromMem2,fromMem3,fromMem4A,fromMem4,fromMem5a,fromMem5, out_l1;
wire [15:0] fromMem6;
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
		.CR0(7'd0));
assign out = ^(fromMem1 ^ fromMem2 ^ fromMem3 ^ fromMem4 ^ fromMem5 ^ fromMem6[15:8] ^ fromMem6[7:0]);

endmodule