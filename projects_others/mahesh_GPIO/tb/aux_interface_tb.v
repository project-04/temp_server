module aux_interface_tb();
	reg sys_clk, sys_rst;
	reg [31:0] aux_in;
	wire [31:0] aux_i;

aux_interface AI (sys_clk, sys_rst, aux_in, aux_i);

always begin
	#5 sys_clk = 1'b0;
	#5 sys_clk = ~sys_clk;
end

task reset;
	begin
		@(negedge sys_clk);
		sys_rst = 1'b1;
		@(negedge sys_clk);
		sys_rst = 1'b0;
	end
endtask

initial begin
	reset;
	aux_in = 32'h34569876;
	#200 $finish;
end

initial 
	$monitor("sys_clk=%d, sys_rst=%d, aux_in=%h, aux_i=%h",sys_clk, sys_rst, aux_in, aux_i);
endmodule
