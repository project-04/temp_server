module tb;
	bit clk;
	logic fe, r, rp;
	
	always #5 clk = ~clk;
	
	assertion1 assertion_duv(clk, fe, r, rp);
	
	initial begin
		clk = 1'b0;
		rp = 1'b0;
		r=0;
		#10 fe = 1'b0;
		#20 fe = 1'b1;
		//rp = 1'b1;
		#40 r  = 1'b1;
		#40 $finish;
	end
endmodule

module assertion1(input clk, fe, r, rp);

	property p1;
		@(posedge clk) fe & r |-> $stable(rp);
	endproperty
	
	a1 : assert property(p1)
		$display("--------------------p1 success \t time = %0d", $time);
	else
		$display("--------------------p1 fail \t time = %0d", $time);
endmodule
