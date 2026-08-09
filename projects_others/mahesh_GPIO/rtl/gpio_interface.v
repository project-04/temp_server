module gpio_interface (
	input ext_clk_pad_i,
	input [31:0] out_pad_o,
	input [31:0] oen_padoe_o,
	output [31:0] in_pad_i, 
	inout [31:0]IO_pad,
	output gpio_eclk);
genvar i;

generate for(i=0; i<32; i=i+1)
	begin: gen_gpio_buf
		bufif1 a1 (IO_pad[i],out_pad_o[i],oen_padoe_o[i]);
	end
endgenerate

assign in_pad_i = IO_pad;
assign gpio_eclk = ext_clk_pad_i;
endmodule
