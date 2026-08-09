/*module test1 (input clk, a, b, c);	 
endmodule
*/
module tb;
	bit clk;
	logic a,b,c,d;
	
	always #5 clk = ~clk;
	initial $monitor("a = %b, b = %b, c = %b, d = %b, time = %0d", a, b, c, d, $time);
	
	//test1 duv(clk, a, b, y);
	assertion1 assertion_duv(clk, a, b, c, d);
	
	initial begin
		clk = 1'b1;
		#10 a = 1'b1;	b = 1'b0; 	c = 1'b0; 	d = 1'b0;//1
		#10 		b = 1; 		c = 1; //2
		#10 a = 0; 	b = 0; //3
		#10 a = 1; 					d = 1; //4
		#10; //5
		#10 		b = 1; 		c = 0; 		d = 0; //6
		#10 a = 0; //7
		#10 a = 1; 	b = 0; 	//8
		#10 a = 0; 			c = 1; 		d = 1; //9
		#10 a = 1; 			c = 0; 		d = 0; //10 
		#10 a = 0; 	b = 1; //11
		#10 		b = 0; //12
		#10 a = 1; 	       		c = 1; 		d = 1; //13
		#10 a = 0; 			c = 0; 		d = 0; //14
		#10 		b = 1; //15
		#10 //16
		
		#20 $finish;
	end
endmodule

module assertion1(input clk, a, b, c, d);
	//test1 duv(clk, a, b, c);
	
	sequence s1;
		@(posedge clk)
			a ##1 b;
	endsequence
	
	sequence s2;
		@(posedge clk)
			##2 c;
	endsequence
	
	property p1;
		@(posedge clk)
			s1.ended |-> s2;
	endproperty
	
	a1 : assert property(p1)
		$display("--------------------ended success \t time = %0d", $time);
	else
		$display("--------------------ended fail \t time = %0d", $time);
		
	sequence s3;
		@(posedge clk)
			a ##1 b;
	endsequence
	
	sequence s4;
		@(posedge clk)
			##2 d;
	endsequence
	
	property p2;
		@(posedge clk)
			s3.triggered |-> s4;
	endproperty
	
	a2 : assert property(p2)
		$display("--------------------triggered success \t time = %0d", $time);
	else
		$display("--------------------triggered fail \t time = %0d", $time);
		
endmodule



