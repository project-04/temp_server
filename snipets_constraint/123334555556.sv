// '{1, 2, 3, 3, 3, 4, 5, 5, 5, 5, 5, 6, 7, 7, 7, 7, 7, 7, 7}
module test;
	class cls1;
		rand int d[];
		rand int max;
		
		constraint c{max inside {[3:6]};}
		constraint c1{	d.size == (((max)/2)+((max+1)/2)**2);}
		constraint c2{	foreach(d[i]){
					if(i==0) d[i] == 1;
					else {
							d[i] == d[i-1] ||  d[i] == d[i-1]+1;
					}
				}
		}
		
		constraint c3{	foreach(d[i]){
				if(d[i]%2==0)
					d.sum() with (int'(item==d[i])) == 1;
				else
					d.sum() with (int'(item==d[i])) == d[i];
				}
		}
		
		function void post_randomize();
			$display("\n%p\n",d);
		endfunction
	endclass
	
	cls1 h1 = new;
	
	initial assert(h1.randomize());
endmodule



//# '{0, 1, 2, 5, 6, 11, 12, 19, 20, 29}
//# '{1, 2, 3, 3, 3, 4, 5, 5, 5, 5, 5, 6, 7, 7, 7}
module test1;
        class cls;
                rand int a[];
                rand int a1[];

                constraint c1{  a.size() == 10;
                                a1.size() == 15;
                                solve a before a1;}

                constraint c2{ foreach(a[i]){
                                        if(i==0) a[i] == 0;
                                        else if (i%2==1) a[i] == a[i-1] + i;
					else a[i] == a[i-1]+1;
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
