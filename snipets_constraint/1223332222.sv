//# '{0, 1, 3, 6, 10, 15, 21, 28, 36, 45}
//# '{1, 2, 2, 3, 3, 3, 2, 2, 2, 2, 5, 5, 5, 5, 5}
module test;
        class cls;
                rand int a[];
                rand int a1[];

                constraint c1{  a.size() == 10;
                                a1.size() == 30;
                                solve a before a1;}

                constraint c2{ foreach(a[i]){
                                        if(i==0) a[i] == 0;
                                        else a[i] == a[i-1] + i;
                                }
                }

                constraint c3{ foreach(a1[i]){
                                        if(i==0) a1[i] == 1;
                                        else if(i inside{a}){
						if((a1[i-1]+1)%2==0)
							a1[i] == 2;	
						else	
							a1[i] == a1[(i/2)-1] + 2;
                                        }
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

