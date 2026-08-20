module test;
	reg clk, rst;
	wire y;
	assign y = (rst == 0)?clk : ~clk;
	initial begin
		clk=0; rst=0;
		#5;
		$display($time, "-> %0b", y);
		
		rst = 1;
		#5;
		$display($time, "-> %0b", y);
		$finish;
	end
	always #5 clk = ~clk;
endmodule
