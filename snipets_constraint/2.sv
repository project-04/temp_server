module top;
	class test;
		rand int unsigned a, b, c, d;
		
		constraint c1 {a<b; b<c; c<d;}
		constraint c2 {(a+b+c+d)==40;}
		constraint c3 {a inside{[1:20]};
		b inside{[1:20]};
		c inside{[1:20]};
		d inside{[1:20]};}
		
		function void post_randomize();
			$write("\n\n");
			$display("%0d + %0d + %0d + %0d = %0d", a, b, c, d,(a+b+c+d));
			$write("\n\n");
		endfunction
	endclass
	
	test t1;
	
	initial 
	begin
		t1=new();
		repeat(10)
			assert(t1.randomize());
	end
endmodule					
