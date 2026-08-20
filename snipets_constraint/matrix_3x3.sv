/*
00 01 02
10 11 12
20 21 22
*/

module tset1;
	class cls1;
		rand int d[3][3];
		rand int temp[3];
		
		constraint c1{ foreach(d[i,j]){
					d[i][j] inside {[0:100]};
					//d[i].sum == 10; //row equal to 10
					/*temp.sum ==10;
					if(i==j)
						d[i][j] == temp[i];*/
				}
				foreach(d[i]){ 
					(d[i][0] + d[i][1] +  d[i][2]) == 10; //row equal to 10 //sum or product
				}
				foreach(d[i]){ 
					(d[0][i] + d[1][i] +  d[2][i]) == 10; //coloum equal to 10 //sum or product
				}
				
				(d[0][0] * d[1][1] *  d[2][2]) == 10; //digonal equal to 10 //sum or product
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


/*
#           8         54         10
#          27         10         60
#          10         24          4
reverse digonal same values
*/
module tset2;
	class cls1;
		rand int d[][];
		
		constraint c1{  d.size() == 3;
				foreach(d[i]) d[i].size() == 3;
				foreach(d[i,j]) d[i][j] inside {[0:100]};
		}
		constraint c2{	foreach(d[i,j]){
					if((i+j) == (d.size()-1)) //0,2 1,1 2,0 so i+j==2
						d[i][j] == 1; 
					else d[i][j] == 0;
				}	
		}
		
		function void post_randomize();
			foreach(d[i,j])
				if(j==0) $write("\n",d[i][j]);
				else 	$write(d[i][j]);
			$write("\nreverse digonal same values\n");
		endfunction
	endclass
	
	cls1 h1;
	
	initial begin
		h1=new;
		void'(h1.randomize());
	end
endmodule




/*
#           1         20         20
#          10          1         20
#          10         10          1
digonal same, lower digonal same, upper digonal same
*/
module tset3;
	class cls1;
		rand logic [4:0] d[][];
		
		constraint c1{  d.size() == 3;
				foreach(d[i]) d[i].size() == 3;
				foreach(d[i,j]) d[i][j] inside {[0:100]};
		}
		
		constraint c2{
				foreach(d[i,j]){
					if(i==j) d[i][j] == 5'd1;
					else if(i>j) d[i][j] == 5'd10; //lower digonal same
					else if(i<j) d[i][j] == 5'd20; //upper digonal same
				}
		}
		
		function void post_randomize();
			foreach(d[i,j])
				if(j==0) $write("\n",d[i][j]);
				else 	$write(" ",d[i][j]);
			$write("\ndigonal same, lower digonal same, upper digonal same\n");
		endfunction
	endclass
	
	cls1 h1;
	
	initial begin
		h1=new;
		void'(h1.randomize());
	end
endmodule




/*
#           9          1          3
#           1          8          2
#           3          2          9
Symmetric Matrix (A = A tranpose)
*/ 
module tset4;
	class cls1;
		rand int d[][];
		
		constraint c1{  d.size() == 3;
				foreach(d[i]) d[i].size() == 3;
				foreach(d[i,j]) d[i][j] inside {[0:9]};
		}
		constraint c2{	foreach(d[i,j]){
					d[i][j] == d[j][i];
				}	
		}
		
		function void post_randomize();
			foreach(d[i,j])
				if(j==0) $write("\n",d[i][j]);
				else 	$write(d[i][j]);
			$write("\nSymmetric Matrix\n");
		endfunction
	endclass
	
	cls1 h1;
	
	initial begin
		h1=new;
		void'(h1.randomize());
	end
endmodule




/*
#           5          6          0
#           0          8          5
#           7          3          3
Asymmetric Matrix (A != A tranpose)
*/ 
module tset5;
	class cls1;
		rand int d[][];
		
		constraint c1{  d.size() == 3;
				foreach(d[i]) d[i].size() == 3;
				foreach(d[i,j]) d[i][j] inside {[0:9]};
		}
		constraint c2{	foreach(d[i,j]){
					if(i != j)
						d[i][j] != d[j][i];
				}	
		}
		
		function void post_randomize();
			foreach(d[i,j])
				if(j==0) $write("\n",d[i][j]);
				else 	$write(d[i][j]);
			$write("\nAsymmetric Matrix\n");
		endfunction
	endclass
	
	cls1 h1;
	
	initial begin
		h1=new;
		void'(h1.randomize());
	end
endmodule



/*
#           1          3          5
#           4          6          8
#           2          7          8
Row Increment
*/
module tset6;
	class cls1;
		rand int d[][];
		
		constraint c1{  d.size() == 3;
				foreach(d[i]) d[i].size() == 3;
				foreach(d[i,j]) d[i][j] inside {[0:9]};
		}
		constraint c2{	foreach(d[i,j]){
					if(j >= 1)
						d[i][j] > d[i][j-1];
				}	
		}
		
		function void post_randomize();
			foreach(d[i,j])
				if(j==0) $write("\n",d[i][j]);
				else 	$write(d[i][j]);
			$write("\nRow Increment\n");
		endfunction
	endclass
	
	cls1 h1;
	
	initial begin
		h1=new;
		void'(h1.randomize());
	end
endmodule




/*
#           0          0          6
#           3          1          7
#           9          3          9
Coloum Increment
*/
module tset7;
	class cls1;
		rand int d[][];
		
		constraint c1{  d.size() == 3;
				foreach(d[i]) d[i].size() == 3;
				foreach(d[i,j]) d[i][j] inside {[0:9]};
		}
		constraint c2{	foreach(d[i,j]){
					if(i >= 1)
						d[i][j] > d[i-1][j];
				}	
		}
		
		function void post_randomize();
			foreach(d[i,j])
				if(j==0) $write("\n",d[i][j]);
				else 	$write(d[i][j]);
			$write("\nColoum Increment\n");
		endfunction
	endclass
	
	cls1 h1;
	
	initial begin
		h1=new;
		void'(h1.randomize());
	end
endmodule




/*
#           4          5          7
#           5          6          8
#           6          7          9
Row and Coloum Increment
*/
module tset8;
	class cls1;
		rand int d[][];
		
		constraint c1{  d.size() == 3;
				foreach(d[i]) d[i].size() == 3;
				foreach(d[i,j]) d[i][j] inside {[0:9]};
		}
		constraint c2{	foreach(d[i,j]){
					if(j >= 1)
						d[i][j] > d[i][j-1]; //row
					if(i >= 1)
						d[i][j] > d[i-1][j]; //coloum
				}	
		}
		
		function void post_randomize();
			foreach(d[i,j])
				if(j==0) $write("\n",d[i][j]);
				else 	$write(d[i][j]);
			$write("\nRow and Coloum Increment\n");
		endfunction
	endclass
	
	cls1 h1;
	
	initial begin
		h1=new;
		void'(h1.randomize());
	end
endmodule




/*
#           0          5          5
#           1          3          6
#           7          9          3
Unique Coloum Elements
*/
module tset9;
	class cls1;
		rand int d[][];
		real arr = 0.000012;
		
		constraint c1{  d.size() == 3;
				foreach(d[i]) d[i].size() == 3;
				foreach(d[i,j]) d[i][j] inside {[0:9]};
		}
		constraint c2{	foreach(d[i,j]){
					foreach(d[k,l]){
						if(i!=k && j==l)
							d[i][j] != d[k][l];
					}
				}	
		}
		
		function void post_randomize();
			foreach(d[i,j])
				if(j==0) $write("\n",d[i][j]);
				else 	$write(d[i][j]);
			$write("\nUnique Coloum Elements\n");
			$display("%f",arr);
			$display("%g",arr);
		endfunction
	endclass
	
	cls1 h1;
	
	initial begin
		h1=new;
		void'(h1.randomize());
	end
endmodule
