module gpio_interface_tb();
	reg ext_clk_pad_i;
	reg [31:0] out_pad_o;
	reg [31:0] oen_padoe_o;
	wire [31:0] in_pad_i;
	wire [31:0] IO_pad;
	wire gpio_eclk;

gpio_interface GI (ext_clk_pad_i, out_pad_o, oen_padoe_o, in_pad_i, IO_pad, gpio_eclk);

always begin
	#5 ext_clk_pad_i = 1'b0;
	ext_clk_pad_i = ~ext_clk_pad_i;
end

task initialize();
	begin
		out_pad_o = 32'h00000000;
		oen_padoe_o = 32'h00000000;
	end
endtask

task inputs(input [31:0] a,b);
	begin
		out_pad_o = a;
		oen_padoe_o = b;
	end
endtask

initial
begin
	initialize();
	#10;
	inputs(32'h0f0f0f0f, 32'h0f0f0f0f);
	#10 $finish;
end

initial
	$monitor("ext_clk_pad_i=%d, out_pad_o=%h, oen_padoe_o=%h, in_pad_i=%h, IO_pad=%h, gpio_eclk=%d", ext_clk_pad_i, out_pad_o, oen_padoe_o, in_pad_i, IO_pad, gpio_eclk);
endmodule
