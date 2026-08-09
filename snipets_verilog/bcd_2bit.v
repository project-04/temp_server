//que: write the RTL for a BCD counter which countes the values form 00-99?

module bcd(
	input clk, rst,
	output reg [3:0] bcd);
	  
	always@(posedge clk, posedge rst) // (or and ,) work same, or else we can use (*) as well
	begin
		if(rst) bcd = 4'b0000;
		else if(bcd == 4'b1001) bcd = 4'b0000;
	  	else bcd = bcd+1'b1;
	end
endmodule

module bcd_00_99(
	input clk, rst,
	output wire [3:0] msb_bcd, lsb_bcd);
	
	bcd bcd1(~(|lsb_bcd), rst, msb_bcd);
	bcd bcd2(clk,      rst, lsb_bcd);
endmodule

module tb;
	reg clk, rst;
	wire [3:0] msb_bcd, lsb_bcd;
	
	bcd_00_99 bcd_00_99_inst(clk, rst, msb_bcd, lsb_bcd);
	
	initial $monitor("msb_bcd lsb_bcd = %0d%0d", msb_bcd, lsb_bcd);
	
	always #2 clk = ~clk;
	
	initial begin
		clk = 0;
		rst = 1;
		
		#20;
		rst = 0;
		#500 $finish;
	end
endmodule
