/*
# ___1___ 
# __212__ 
# _32123_ 
# 4321234 
*/

module test;
	integer r,c;
	integer i,j,k;
	
	initial begin
		r=7;
		c=2*r-1;
		
		for(i=0; i<r; i=i+1)
		begin
			//for(j=0; j<c; j=j+1)
			begin
				for(k=(c/2)-i; k>0 ; k=k-1)
				begin
					$write("_");
				end
				
				for(k=i+1; k>1; k=k-1)
				begin
					$write("%0d",k);
				end
				
				for(k=1; k<=i+1; k=k+1)
				begin
					$write("%0d",k);
				end
				
				for(k=(c/2); k>i ; k=k-1)
				begin
					$write("_");
				end
				//$write("\t");
			end
		$display();
		end
	end
endmodule




/*
# **** 
# *  * 
# *  * 
# *  * 
# **** 
*/
module test2;
	integer i,j;
	integer r,c;
	
	initial begin
		$display;
		r=5;
		c=4;
		
		for(i=1; i<=r; i=i+1)
		begin
			if(i==1 || i==r)
			begin
				for(j=1; j<=c; j=j+1)
				begin
					$write("*");
				end
			end
					
			else
			begin
				for(j=1; j<=c; j=j+1)
				begin
					if(j==1 || j==c)
					begin
						$write("*");
					end
					else
					begin	
						$write(" ");
					end
				end
			end
			$display;
		end
	end
endmodule



/*
#     *
#    **
#   ***
#  ****
# *****
*/

module test3;
	integer r,c,i,j;
	
	initial begin
		$display;
		r=5;
		c=5;
		
		for(i=1; i<=r; i=i+1) //i=1;
		begin
			for(j=(r-i); j>=1; j=j-1) //j=5-1=4, 4 spaces
			begin
				$write(" ");
			end
			for(j=i; j>=1; j=j-1)
			begin
				$write("*");
			end
			$display;
		end
	end
endmodule


/*
# *****
# **** 
# ***  
# **   
# *  
*/

module test4;
	integer r,c,i,j;
	
	initial begin
		$display;
		
		r=5;c=5;
		
		for(i=0; i<=r; i=i+1) //i=0
		begin
			for(j=r-i; j>=1; j=j-1) $write("*"); //j=5-0=5, 5 stars;
			for(j=i  ; j>=1; j=j-1) $write(" ");
			$display;
		end
	end
endmodule
	

/*
# ____1____ 
# ___1_1___
# __1_2_1__ 
# _1_2_2_1_
# 1_2_3_2_1 
*/
/*
# ____1____ 
# ___1_1___.
# __1_2_1__ 
# _1_3_3_1_
# 1_4_6_4_1 
*/
module test5;
	integer r,i,j;
	integer arr[4:0][4:0];
	
	task pasical_fun(input integer r);
	begin: fun
		for(i=0; i<r; i=i+1)
		begin
			for(j=0; j<=r; j=j+1)
			begin
				if(j==0 || j==i)
					arr[i][j] = 1;
				else
					arr[i][j] = arr[i-1][j-1]+arr[i-1][j];
			end
		end
		/*for(i=0; i<r; i=i+1)
		begin
			for(j=0; j<r; j=j+1)
			begin
				$write("%0d ", arr[i][j]);
			end
			$display();
		end*/
	end
	endtask
	
	initial begin
		$display;
		
		r=5;
		pasical_fun(r);
		
		for(i=0; i<r; i=i+1)
		begin
			for(j=i; j<r; j=j+1)
			begin
				$write(" ");
			end
			for(j=0; j<i+1; j=j+1)
			begin
				$write("%0d ", arr[i][j]);
			end
			$display();
		end
	end
endmodule
























