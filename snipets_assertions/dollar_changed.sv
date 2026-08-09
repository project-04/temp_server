module tb;
	bit clk;
	logic a,b,start;
	
	always #5 clk = ~clk;
	initial $monitor("clk = %0b, a = %0b, b = %0b, start = %0b, time = %0d", clk, a, b, start, $time);
	
	//test1 duv(clk, a, b, y);
	assertion1 assertion_duv(clk, a, b, start);
	
	initial begin
		clk = 1'b1;
		start = 1;
		a=0; b=0;
		
		@(posedge clk);
		@(posedge clk);
		a = 1;
		b = 0;
		@(posedge clk);
		a = 1;
		b = 1;
		@(posedge clk);
		a = 0;
		b = 0;
		
		@(posedge clk);
		@(posedge clk);
		a = 1;
		b = 0;
		@(posedge clk);
		a = 0;
		b = 1;
		@(posedge clk);
		a = 0;
		b = 0;
		
		@(posedge clk);
		@(posedge clk);
		a = 1;
		b = 0;
		@(posedge clk);
		a = 0;
		b = 0;
		@(posedge clk);
		a = 0;
		b = 1;
		@(posedge clk);
		a = 0;
		b = 0;
		
		@(posedge clk);
		@(posedge clk);
		a = 1;
		b = 0;
		@(posedge clk);
		a = 1;
		b = 1;
		@(posedge clk);
		a = 1;
		b = 0;
		@(posedge clk);
		a = 0;
		b = 0;
		
		#30;
		@(posedge clk);
		@(posedge clk);
		a = 0;
		b = 0;
		@(posedge clk);
		a = 0;
		b = 1;
		@(posedge clk);
		a = 0;
		b = 1;
		@(posedge clk);
		a = 0;
		b = 0;
		
		
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		
		#20 $finish;
	end
endmodule

module assertion1(input clk, a, b, start);
	property p1;
		@(posedge clk)
			a |-> $changed(b);
	endproperty
	
	until_a1 : assert property(p1)
		$display("--------------------until success \t time = %0d", $time);
	else
		$display("--------------------until fail \t time = %0d", $time);
		
	/*property p2;
		@(posedge clk)
			start |-> a throughout b;
	endproperty
	
	throughout_a2 : assert property(p2)
		$display("--------------------throughout success \t time = %0d", $time);
	else
		$display("--------------------throughout fail \t time = %0d", $time);*/
		
endmodule
