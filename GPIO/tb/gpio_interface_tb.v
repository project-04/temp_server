module gpio_interface_tb();
	reg ext_clk_pad_i;
	reg [31:0] out_pad_o, oen_padoe_o;
	wire [31:0] IO_pad, in_pad_i;
	wire gpio_eclk;

	gpio_interface GI (.ext_clk_pad_i(ext_clk_pad_i),
			.out_pad_o(out_pad_o),
			.oen_padoe_o(oen_padoe_o),
			.in_pad_i(in_pad_i),
			.IO_pad(IO_pad),
			.gpio_eclk(gpio_eclk));
		
	initial 
	begin
		ext_clk_pad_i = 1'b0;
		forever #5 ext_clk_pad_i = ~ext_clk_pad_i;
	end

	task initialize();
	begin
		out_pad_o     = 32'h0000_0000;
		oen_padoe_o   = 32'h0000_0000;
	end
	endtask

	task inputs(input [31:0] a, b);
	begin
		out_pad_o   = a;
		oen_padoe_o = b;
	end
	endtask

	initial
	begin
		initialize();
		
		#10;
		inputs(32'hffff_0000, 32'hffff_ffff);
		
		#20;
		$finish;
	end

	initial 
	begin
		$monitor("ext_clk_pad_i=%0h, out_pad_o=%0h, oen_padoe_o=%0h, IO_pad=%0h, in_pad_i=%0h, gpio_eclk=%0h \n", ext_clk_pad_i, out_pad_o, oen_padoe_o, IO_pad, in_pad_i, gpio_eclk);
	end
endmodule
