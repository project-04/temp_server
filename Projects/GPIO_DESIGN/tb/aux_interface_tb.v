module aux_interface_tb();
	reg sys_clk, sys_rst;
	reg [31:0] aux_in;
	wire [31:0] aux_i;

	aux_interface AI (.sys_clk(sys_clk),
			.sys_rst(sys_rst),
			.aux_in(aux_in),
			.aux_i(aux_i));

	initial 
	begin
		sys_clk = 1'b0;
		forever #5 sys_clk = ~sys_clk;
	end

	task reset;
	begin
		@(negedge sys_clk);
		sys_rst = 1'b1;
		
		@(negedge sys_clk);
		sys_rst = 1'b0;
	end
	endtask

	initial 
	begin
		reset;
		aux_in = 32'h0123_4567;
		#30 $finish;
	end

	initial 
	begin
		$monitor("sys_clk=%d, sys_rst=%d, aux_in=%h, aux_i=%h",sys_clk, sys_rst, aux_in, aux_i);
	end
endmodule
