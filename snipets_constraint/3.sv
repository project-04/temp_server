module temp;
	class test1;
		rand int d[];
		
		constraint c1{d.size() == 20;}
		constraint c2{
			foreach(d[i]){
				if(i == 0)
					d[i] == 1;
				else if(i%2==1)
					d[i] == d[i-1];
				else if(i%2==0){
					d[i] == d[i-1]+1;
				}
			}
		};
		function void post_randomize();
			$display(d);
		endfunction
	endclass
	
	class test2;
		rand int d[];
		
		constraint c1{d.size() == 10;}
		constraint c2{
			foreach(d[i]){
				if(i == 0)
					d[i] == 1;
				else if(i%2==1)
					d[i] == d[i-1];
				else if(i%3==0)
					d[i] == d[i-1];
				else if(i%2==0){
					d[i] == d[i-1]+1;
				}
			}
		};
		function void post_randomize();
			$display(d);
		endfunction
	endclass
		
	test1 t1;
	test2 t2;

	initial 
	begin
		t1=new();
			assert(t1.randomize()); //1122334455
		
		t2=new();
			void'(t2.randomize()); //111 222 333 444 //not geting
			
	end
endmodule
