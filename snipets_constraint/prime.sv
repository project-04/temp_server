module temp;
	class test;
		rand int d[];
		rand int dp[];
		typedef int array_t [20];
		
		constraint c1{ d.size() == 20;
				unique{d};}
		constraint c2{ dp.size() == 20;}
		constraint c3{ foreach(d[i]){
					d[i] inside {[0:1000]};
					}
				}
		constraint c4{ foreach(dp[i]){
					dp[i] == fun_prime(d[i]);
					}
				}
		
		function int fun_prime(input int a);
			int i;
			
			if(a==1) return a;
			
			for(i=2; i<a; i++) if((a%i)==0) return 0;
			
			return a;
		endfunction
	
		
		/*constraint c4{ dp == fun();}
		
		function array_t fun(); 
			array_t  d;
			int i,j, temp;
			for(i=0; i<=20; i++)
			begin
				for(j=temp; j<=1000; j++)
				begin
					if(fun_prime(j) != 0)
					begin
						d[i] = j;
						j=1001;
					end 
					temp++;
				end
			end
			return d;
		endfunction*/
	endclass
	
	test t1;
	
	initial begin
		int i,j;
		
		t1 = new();
		
		assert(t1.randomize());
		
		$display(t1.dp);
		
		/*
		for(i=0; i<100; i++)
			for(j=2; j<i; j++) if((i%j)==0) return 0;
			
		*/	//return a;
	end
endmodule
