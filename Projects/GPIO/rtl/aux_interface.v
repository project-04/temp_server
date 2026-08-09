module aux_interface(
	//from APB Slave
	input sys_clk, sys_rst,
	//from AUX
	input [31:0] aux_in,
	//to Register
	output reg [31:0] aux_i);

	always @(posedge sys_clk or posedge sys_rst)
	begin
		if(sys_rst)
			aux_i <= 32'h0;
		else
			aux_i <= aux_in;
	end
endmodule

