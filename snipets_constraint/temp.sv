/*
	module pattern;
	class pattern;
	rand bit[3:0] d[14];
	rand bit[4:0]s;

/*
				constraint c1{foreach(da[i])
										da[i]==i;
							}
*/
				/*				function void post_randomize;
	
								foreach(da[i])
									repeat(i+1)
										begin
										$write("%d",da[i]);
										end
										
					endfunction
*/

/*				function void post_randomize();
					int idx,reach;
					int n=1;
					while(reach==0)
					begin	
						for(int i=1; i<=n; i++)
						begin
							d[idx] = n;
							idx++;
						end
						n++;
						if(idx==5) reach=1;
					end
				endfunction
			
			
			endclass
		
		pattern t;

				initial begin
								t=new;
							assert(t.randomize);
							$display("d=%0p",t.d);
									end
			endmodule
 
*/


module m1;
	class cls1;
		rand int x[6];
		rand int y;
		static int q[$];
		
		constraint c1{unique{x};
				foreach(x[i]){
					x[i] inside{[1:15]};
				}
			}
				
		constraint c2{if(x.sum()%2 == 1)
					y inside{[2:8]};
				else
					y == 0;
					
				foreach(q[i]){
					y != q[i];
				}
			}
			
		function void post_randomize();
			if( q.size()==7)
				q.delete();
				
			if(x.sum()%2 == 1)
			begin
				q.push_front(y);
			end
			$display("x = %0p, x.sum=%0d)",x, x.sum());
			$display("y = %0d",y);
			$display("q = %0p\n
			",q);
		endfunction
	endclass
	
	cls1 h1;
	
	initial begin
		
		h1 = new();
	
		repeat(10) assert(h1.randomize());
	end
endmodule
			

