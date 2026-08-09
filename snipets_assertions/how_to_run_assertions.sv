/*
qverilog -vopt +acc file.sv
vsim work.tb -voptargs=+acc
*/

module test1 (
	input clk, a, b, 
	output reg y);
	 
	always@(posedge clk)
	begin
		y <= a & b;
	end
endmodule

module tb;
	bit clk;
	logic a,b,y;
	
	always #5 clk = ~clk;
	always #40 a = ~a;
	always #20 b = ~b;
	initial $monitor("%b & %b = %b, time = %0d", a, b, y, $time);
	
	test1 duv(clk, a, b, y);
	assertion1 assertion_duv(clk, a, b, y);
	
	initial begin
		clk = 1'b0;
		a = 1'b0;
		b = 1'b0;
		//$fsdbDumpvars(0,tb);
		/*
		repeat(10)
		begin
			a = $urandom_range(0, 1);
			b = $urandom_range(0, 1); //$urandom();
			#10;
			$display("%b & %b = %b", a, b, y);
		end*/
		#300 $finish;
	end
endmodule

module assertion1(input clk, a, b, y);
	test1 duv(clk, a, b, y);

	property p1;
		@(posedge clk) a & b |-> y;
	endproperty
	
	property p2;
		@(posedge clk) a & b |=> y;
	endproperty
	
	
	a1 : assert property(p1)
		$display("--------------------p1 success \t time = %0d", $time);
	else
		$display("--------------------p1 fail \t time = %0d", $time);
	a2 : assert property(p2)
		$display("--------------------p2 success \t time = %0d", $time);
	else
		$display("--------------------p2 fail \t time = %0d", $time);
endmodule



