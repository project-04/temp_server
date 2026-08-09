// '{1, 2, 2, 3, 3, 3, 4, 4, 4, 4}
module test;
	class cls1;
		rand int d[];
		rand int max;
				
		constraint c{	max inside {[3:5]};}
		
		constraint c1{	d.size() == (max*(max+1))/2;}
		constraint c2{	foreach(d[i]){
					if(i==0) d[i] == 1;
					else d[i] == d[i-1] || d[i] == d[i-1]+1 ;
				}
		}
		
		constraint c3{	foreach(d[i]){
					d.sum() with (int'(item==d[i])) == d[i];
				}
		}
		
		function void post_randomize();
			$display("\n%p",d);
			$display("max val(size) %0d\n",max);
		endfunction
	endclass
	
	cls1 h1 = new;
	
	initial assert(h1.randomize());
endmodule



//# '{0, 1, 3, 6, 10, 15, 21, 28, 36, 45}
//# '{1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5}
module test1;
	class cls;
		rand int a[];
		rand int a1[];
		
		constraint c1{	a.size() == 10;
				a1.size() == 15;
				solve a before a1;}
	
		constraint c2{ foreach(a[i]){ 
					if(i==0) a[i] == 0;
					else a[i] == a[i-1] + i;
				}
		}
		
		constraint c3{ foreach(a1[i]){
					if(i==0) a1[i] == 1;
					else if(i inside{a}) a1[i] == a1[i-1] + 1;
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


