//# '{1, 3, 5, 8, 11, 15, 19, 24, 29, 35}
//# '{0, 1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7}

module test1;
	class cls;
		rand int a[];
		rand int a1[];
		
		constraint c1{	a.size() == 10;
				a1.size() == 20;
				solve a before a1;}
	
		constraint c2{ foreach(a[i]){
					if(i==0) a[i] == 1;
					else if(i==1) a[i] == 3;
					else if(i%2==0) a[i] == (a[i-1] - a[i-2]) + a[i-1];
					else if(i%2==1) a[i] == (a[i-1] - a[i-2]) + a[i-1] + 1;
				}
		}
		
		constraint c3{ foreach(a1[i]){
					if(i==0) a1[i] == 0;
					else if(i inside{a}) a1[i] == a1[i-1]+1;
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


