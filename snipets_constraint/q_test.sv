module test;
class c1 #(int t);
	rand int d[][];
	rand int a[][];
	rand int m[][];

	constraint c1{d.size() inside{[3:5]};
			foreach(d[i]){
				d[i].size() inside {[6:9]};
			}
			foreach(d[i,j]){
				if(i==j) d[i][j] == 0;
				else if((i+j) == d.size()-1) d[i][j] == 0;
				else     d[i][j] inside{[1:9]};
			}
		}
	
	constraint c2{a.size() inside{[3:5]};
			foreach(a[i]){
				if(i==0)
					a[i].size() inside {[6:9]};
				else 
					a[i].size() == a[i-1].size();
			}
			foreach(a[i,j]){
				if(i==j) a[i][j] == 0;
				else if((i+j) == a.size()-1) a[i][j] == 0;
				else     a[i][j] inside{[1:9]};
			}
		}
		
	constraint c3{m.size() == t;
			foreach(m[i]){
				m[i].size() == t;
			}
			foreach(m[i,j]){
				if(i==0 & j==0) m[i][j] == 1;
				else if(j==0) m[i][j] == m[i-1][m.size()-1]+1;
				else if(j!=0)    m[i][j] == m[i][j-1]+1;
			}
		}
	
	function void post_randomize();
		foreach(d[i])
			$display("%0p",d[i]);
		
		$display();
		
		foreach(a[i])
			$display("%0p",a[i]);
		
		$display();
		
		foreach(m[i])
			$display("%2p",m[i]);
	endfunction
endclass
c1 #(5) h;
initial begin
 h=new;
 h.randomize();
end
endmodule











module test2;

	class cls1;
		rand bit [7:0] mem [0:1023] [0:3];
		rand int mode;
		rand bit [1:0] temp;
		
		constraint c1{ mode inside {[0:5]};}
		constraint c2{ if(mode inside {[0:3]}){
					foreach(mem[i,j]){
						if(j!=mode)
							mem[i][j] == 0;
						}
					}
				else{
					foreach(mem[i,j]){
						if(j!=temp)
							mem[i][j] == 0;
						}
					}
				}
		function void post_randomize();
			$display("\nmode = %0d",mode);
			foreach(mem[i,j])
				if(i==0 && j==0)
					$display("%3p",mem[i]);
		endfunction
	endclass
	
	cls1 h;
	initial begin		
	 h=new;
	 repeat(7)
	 h.randomize();
	end
endmodule





