// '{0, 1, 0, 2, 0, 3, 0, 4, 0, 5}
module test;
	class cls1;
		rand int d[];		
		constraint c1{ 	d.size() == 10;}
		constraint c2{	foreach(d[i]){
					if(i%2==0) d[i] == 0;
					else d[i] == i/2+1;
		}}
		function void post_randomize();
			$display("\n%p\n",d);
		endfunction
	endclass
	
	cls1 h1 = new;
	
	initial assert(h1.randomize());
endmodule

// '{1, 1, 2, 2, 3, 3, 4, 4, 5, 5}

module test2;
	class cls1;
		rand int d[];
		constraint c1{ 	d.size == 10;}
		constraint c2{ foreach(d[i]){
					if(i==0) d[i] == 1;
					else if(i%2==0) d[i] == i/2+1;
					else d[i] == d[i-1];
		}}
		function void post_randomize();
			$display("\n%p\n",d);
		endfunction
	endclass
	
	cls1 h1 = new;
	
	initial void'(h1.randomize());
endmodule

// '{5, -10, 15, -20, 25, -30, 35, -40, 45, -50}

module tese3;
	class cls1;
		rand int d[];
		constraint c1{	d.size == 10;}
		constraint c2{	foreach(d[i]){
					if(i%2==0) d[i] == (i+1)*5;
					else d[i] == (i+1)*-5;
		}}
		function void post_randomize();
			$display("\n%p\n",d);
		endfunction
	endclass
	
	cls1 h1 = new;
	
	initial assert(h1.randomize());
endmodule

// '{9, 19, 29, 39, 49, 59, 69, 79, 89, 99}

module tese4;
	class cls1;
		rand int d[];
		constraint c1{	d.size == 10;}
		constraint c2{	foreach(d[i]){
					d[i] == (i*10)+9;
		}}
		function void post_randomize();
			$display("\n%p\n",d);
		endfunction
	endclass
	
	cls1 h1 = new;
	
	initial assert(h1.randomize());
endmodule

//  1.4  3.06  3.19  1.66  2.93  2.65  2.7  2.94  2.9  2.08 

module tese5;
	class cls1;
		rand int temp;
		real d; 
		//rand int temp		// real can be randomized in questa but not in vcs.
		constraint c1{	temp inside {[125:325]};}
		function void post_randomize();
			d = real'(temp)/100;/*
			d = temp/100.0;
			d = temp;
			d = d/100;
			$write(" %f",d);
			$write(" %0.2f",d);*/
			//$write("temp=%p ",temp);
			$write("d=%p ",d);
		endfunction
	endclass
	
	cls1 h1 = new;
	
	initial begin
		real a;
		
		$display();
		repeat(10) assert(h1.randomize());
		$display();

		a = 525/100; //5.00
		$display(a);
		
		a = 525.0/100; //5.25
		$display(a);
		
		$display();
	end
endmodule

// '{2, 11, 222, 3333, 22222, 555555}

module tese6;
	class cls1;
		rand int d[];
		//int temp;
		
		function int fun(int num, int it);
			int temp = num;
			for(int i=1; i<it; i=i+1)
			begin
				temp = temp+num*(10**i);
			end
			return temp;
		endfunction
		
		constraint c1{	d.size == 6;}
		constraint c2{	foreach(d[i]){
					if(i%2==0) d[i] == fun(2,i+1);
					else d[i] == fun(i,i+1);
				}
		}
		
		function void post_randomize();
			$display("\n%p\n",d);
		endfunction
	endclass
	
	cls1 h1 = new;
	
	initial assert(h1.randomize());
endmodule

// '{3, 2, 5, 8, 3, 6, 7, 2, 1, 2}
//odd numbers in even location and vise versa
module test7;
	class cls1;
		rand int d[];
		
		constraint c1{	d.size() == 10;}
		constraint c2{	foreach(d[i]){
					d[i] inside{[0:10]};
		}}
		constraint c3{ 	foreach(d[i]){
					if(i%2==0) d[i]%2==1;
					else d[i]%2==0;
		}}
		
		function void post_randomize();
			$display("\n%p\n",d);
		endfunction
	endclass
	
	cls1 h1;
	
	initial begin
		h1 = new;
		assert(h1.randomize());
	end
endmodule






//even number b/w 50 to 100?
module test8;
	class cls1;
		rand int d[];
		
		constraint c1{ d.size() == 26;}
		constraint c2{ foreach(d[i]){
					d[i]%2==0;
					d[i] inside {[50:100]};
				}
		}
		
		function void post_randomize();
			$display("\n%p\n",d);
		endfunction
	endclass
	
	cls1 h1;
	
	initial begin
		h1=new;
		void'(h1.randomize());
	end
endmodule

//even number 50, 52, 54,.. 100?
module test9;
	class cls1;
		rand int d[];
		//randc int temp;
		
		constraint c1{ d.size() == 26;}
		//constraint c2{ unique(d);}
		constraint c2{ foreach(d[i]){
					if(i==0) d[i]==50;
					d[i]%2==0;
					d[i] inside {[50:100]};
				}
		}
		constraint c3{ foreach(d[i]){
					foreach(d[j]){
						if(i<j) //d[i] != d[j];  //for unique elements
							d[j] > d[i]; //for assigning order
					}
				}
		}
		
		function void post_randomize();
			$display("\n%p\n",d);
		endfunction
	endclass
	
	cls1 h1;
	
	initial begin
		h1=new;
		void'(h1.randomize());
	end
endmodule




/*
// 32bit variable with only 12 no.of 1's?
module test10;
	class cls1;
		rand  bit unsigned [31:0] d[];
		
		constraint c1{ d.size() == 10;}
		constraint c2{ foreach(d[i]){
					$countones(d[i])==12;
					//d[i] inside {[0:(2**32)]};
				}
		}
		
		function void post_randomize();
			$display("\n%p\n",d);
			foreach(d[i]) $display("%b countones=%0d",d[i], $countones(d[i]));
		endfunction
	endclass
	
	cls1 h1;
	
	initial begin
		h1=new;
		void'(h1.randomize());
	end
endmodule
*/
/*
module test10;
	class cls1;
		rand bit [3:0] d;
		
		function void post_randomize();
			$display("\n%b\n",d);
		endfunction
		
		function void ran(cls1 temp);
			if(temp.randomize())
				while(this.d!=4'b1111)
					void'(temp.randomize());
		endfunction
	endclass
	
	cls1 h1;
	
	initial begin
		h1=new;
		h1.ran(h1);
		$display("final d=%b", h1.d);
	end
endmodule
*/

// '{1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880}
//factoral
module tset11;
	class cls1;
		rand integer d[];
		constraint c1{ d.size() == 10;}
		constraint c2{ foreach(d[i]){
					d[i] == fact_fun(i);
				}
		}

		function int fact_fun(int i);
			int temp;
			if(i==0 || i==1)
				return 1;
			else
				temp = i*(fact_fun(i-1));
			return temp;
		endfunction
		
		function void post_randomize();
			$display("\n%p\n",d);
		endfunction
	endclass
	
	cls1 h1;
	
	initial begin
		h1=new;
		void'(h1.randomize());
	end
endmodule

// '{0, 1, 1, 2, 3, 5, 8, 13, 21, 34}
//fib series
module tset12;
	class cls1;
		rand integer d[];
		constraint c1{ d.size() == 10;}
		constraint c2{ foreach(d[i]){
					if(i==0) d[i] == 0;
					else if(i==1) d[i] ==1;
					else d[i] == d[i-1]+ d[i-2];
				}
		}
		
		function void post_randomize();
			$display("\n%p\n",d);
		endfunction
	endclass
	
	cls1 h1;
	
	initial begin
		h1=new;
		void'(h1.randomize());
	end
endmodule

//sum of the elements in the row == coloum == diagonal

module tset13;
	class cls1;
		rand int d[3][3];
		rand int s;
		
		constraint c1{ s inside {[10:100]};
				
				foreach(d[i,j]){
					d[i][j] inside {[1:100]};
					d[i].sum == 10; //row equal to 10
				}
				/*foreach(d[i]){ 
					(d[i][0] + d[i][1] +  d[i][2]) == 10; //row equal to 10
				}*/
				foreach(d[i]){ 
					(d[0][i] + d[1][i] +  d[2][i]) == 10; //coloum equal to 10
				}
				
				(d[0][0] + d[1][1] +  d[2][2]) == 10; //digonal equal to 10
		}
		
		function void post_randomize();
			foreach(d[i,j])
				if(j==0) $write("\n",d[i][j]);
				else 	$write(d[i][j]);
			$write("\n\n");
		endfunction
	endclass
	
	cls1 h1;
	
	initial begin
		h1=new;
		void'(h1.randomize());
	end
endmodule


//# '{0, 2, 1, 3, 4, 6, 5, 7, 8}
//    0  1  2  3  4  5  6  7  8
module test14;
	class cls1;
		rand  bit unsigned [31:0] d[];
		
		constraint c1{ d.size() == 9;}
		constraint c2{ foreach(d[i]){
					if(i==1 || i==5)
						d[i] == i+1;
					else if(i==2 || i==6)
						d[i] == i-1;
					else
						d[i] == i;
				}
		}
		
		function void post_randomize();
			$display("\n%p\n",d);
		endfunction
	endclass
	
	cls1 h1;
	
	initial begin
		h1=new;
		void'(h1.randomize());
	end
endmodule
