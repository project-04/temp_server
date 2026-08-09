module test;
	integer a,b;
	reg [31:0] c;
	real d;
	
	initial begin
		/*a=32'hffff_ffff;
		//b=5;
		//b <= b+a;
		//a <= a+b;
		
		a=a-32'h1;
		$display("%d %d",a,b);
		
		#1;
		a=0;
		a=a-1'b1;
		$display("%d %d",a,b);	*/
		
		c=32'hffff_ffff;
		c=c-32'h1;
		$display("%d",c);
		$display("%h",c);
		
		#1;
		c=0;
		c=c-1'b1;
		$display("%d",c);
		$display("%h",c);
		//d=1.3;
		$display("%f",d);	
	end
	//initial $monitor("%b",a);
endmodule
