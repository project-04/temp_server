//# '{1, 2, 4, 6, 9, 12, 16, 20, 25, 30}
//# '{0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1}
module test2;
	class cls;
		rand int a[];
		rand bit a1[];
		
		constraint c1{	a.size() == 10;
				a1.size() == 20;
				solve a before a1;}
	
		constraint c2{ foreach(a[i]){
					if(i==0) a[i] == 1;
					else if(i==1) a[i] == 2;
					else if(i%2==0) a[i] == (a[i-1] - a[i-2]) + a[i-1] + 1;
					else if(i%2==1) a[i] == (a[i-1] - a[i-2]) + a[i-1];
				}
		}
		
		constraint c3{ foreach(a1[i]){
					if(i==0) a1[i] == 0;
					else if(i inside{a}) a1[i] == ~a1[i-1];
					else a1[i] == a1[i-1];
				}
		}		
	endclass
	
	cls h;
	
	initial begin
		h=new();
		assert(h.randomize());
		$display("%p", h.a);
		$display("%p\n", h.a1);
	end	
endmodule


//# '{0, 4, 1, 0, 3, 2, 0, 2, 3, 0, 1, 4}
module test3;
	class cls;
		rand bit[7:0] a[];
		
		constraint c1{	a.size() == 12;}
	
		constraint c2{ foreach(a[i]){
					if(i==0 || i%3 == 0) a[i] == 0;
					else if(i == 1) a[i] == 4;
					else if((i+1)%3 == 0) a[i] + a[i-1] == 5;
					else if(i%3 == 1) a[i-3] - a[i] == 1;
				}
		}
		
	endclass
	
	cls h;
	
	initial begin
		h=new();
		assert(h.randomize());
		$display("%p\n", h.a);
	end	
endmodule
