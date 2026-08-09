module top;
	class test;
		rand int m[][];
		
		constraint size{
				m.size() == 3;
				foreach(m[i])
					m[i].size() == 3;
				}
				
		constraint c1{
			foreach(m[i,j]){
				if(i == j){
					m[i][j] == m.size()-1;
				}
				else{
					m[i][j] inside{[10:99]};
				}
			}
		}
		
		function void post_randomize();
			//$write("\n");
			foreach(m[i,j])
			begin
				if(j == 0)
				begin
					$write("\n");
				end
				$write("%d ",m[i][j]);
			end
			$write("\n\n");
		endfunction
	endclass
	
	class test_2; rand int d[10]; constraint c1{ foreach(d[i]){ if(i<5){ d[i]==9-(i*2);} else{ d[i]==(i*2)-10;}  }} endclass //9, 7, 5, 3, 1, 0, 2, 4, 6, 8
	class test_3; rand int d[10]; constraint c1{ foreach(d[i]){ if(i<5){ d[i]==9-(i*2);} else{ d[i]==8-2*(i-5);} }} endclass //9, 7, 5, 3, 1, 8, 6, 4, 2, 0
	
	class test_4; rand int d[10]; constraint c1{ foreach(d[i]){ if(i<5){ d[i]==(i*2)+1;} else{ d[i]==(i*2)-10;}  }} endclass //1, 3, 5, 7, 9, 0, 2, 4, 6, 8
	class test_5; rand int d[10]; constraint c1{ foreach(d[i]){ if(i<5){ d[i]==(i*2)+1;} else{ d[i]==8-2*(i-5);} }} endclass //1, 3, 5, 7, 9, 8, 6, 4, 2, 0
	
	class test_6; rand int d[4]; constraint c1{ foreach(d[i]){ d[i]==(i*10)+9; }} endclass //9,19,29,39
	
	test t1;
	test_2 t2;
	test_3 t3;
	test_4 t4;
	test_5 t5;
	test_6 t6;
	
	initial 
	begin
		t1=new();
		assert(t1.randomize());
		
		t2=new();
		assert(t2.randomize());
		$display("%p",t2.d);
		
		t3=new();
		assert(t3.randomize());
		$display("%p",t3.d);
		
		t4=new();
		assert(t4.randomize());
		$display("%p",t4.d);
		
		t5=new();
		assert(t5.randomize());
		$display("%p",t5.d);
		
		t6=new();
		assert(t6.randomize());
		$display("%p",t6.d);
	end
endmodule					
