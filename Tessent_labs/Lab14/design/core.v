module core (clka,clkb,in,out);
input clka,clkb,in;
output out;

wire out1,out2,out3;
reg f1, f2, f3;
reg [2:0] f_ratio;
wire clk_out;

always @ (posedge clka) begin
  f1 <= ~f1;
  f2 <= ~f2;
  f3 <= ~f3;
  f_ratio <= ~f_ratio;
end

clk_div clk_div (.clk_in(clka), .clk_out(clk_out), .rst(f3), .ratio(f_ratio));
clock_mux21 clock_mux1 (.A0(clk_out), .A1(clkb), .S0(f1), .Y(clkm));
cgand cgand1 ( .GCK(clk1) , .FE(f2) , .TE(1'b0) , .CK(clkm) );
cgand cgand2 ( .GCK(clk2) , .FE(f2) , .TE(1'b0) , .CK(clkb) );

assign out = out1^out2^out3;

blockA blockA_clka_i1 (.CLK(clk1),.in(in),.out(out1));
blockA blockA_clka_i2 (.CLK(clk1),.in(in),.out(out2));

blockB blockB_clka_i1 (.CLK(clk2),.in(in),.out(out3));

endmodule