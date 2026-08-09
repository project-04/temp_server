module tb;
	integer i,j,k;
	parameter [7:0] temp = "$";

/*----------------------------------------------------------
# 1  
# 1 2  
# 1 2 3  
# 1 2 3 4  
# 1 2 3 4 5 
*/
	initial begin
	$display("\n");
		for(i=1; i<=5; i=i+1)
		begin
			$display("%s",{6{"A"}});
		end
	$display("\n");
	end
	
/*----------------------------------------------------------
# 1  
# 1 2  
# 1 2 3  
# 1 2 3 4  
# 1 2 3 4 5 
*/
	initial begin
	$display("\n");
		for(i=1; i<=5; i=i+1)
		begin
			for(j=1; j<=6-i; j=j+1)
			begin
				$write("%0d ",j);
			end
			$display();
		end
	$display("\n");
	end
	
/*----------------------------------------------------------
# 1  
# 1 2  
# 1 2 3  
# 1 2 3 4  
# 1 2 3 4 5
*/ 
	initial begin
	$display("\n");
		for(i=1; i<=5; i=i+1)
		begin
			for(j=1; j<=i; j=j+1)
			begin
				$write("%0d ",j);
			end
			$display();
		end
	$display("\n");
	end
	

/*----------------------------------------------------------
# 1  
# 1 2  
# 1 2 3  
# 1 2 3 4  
# 1 2 3 4 5  
# 1 2 3 4 5  
# 1 2 3 4  
# 1 2 3  
# 1 2  
# 1 
*/
	initial begin
	$display("\n");
		for(i=1; i<=5; i=i+1)
		begin
			for(j=1; j<=i; j=j+1)
			begin
				$write("%0d ",j);
			end
			$display();
		end
	//$display("\n");
	end	
	initial begin
	///$display("\n");
		for(i=1; i<=5; i=i+1)
		begin
			for(j=1; j<=6-i; j=j+1)
			begin
				$write("%0d ",j);
			end
			$display();
		end
	$display("\n");
	end
	
	
/*----------------------------------------------------------
# *      *      * 
# *     * *     * 
# *    *   *    * 
# *   *     *   * 
# *  *       *  * 
# * *         * * 
# **           ** 
# *             * 
*/
	integer r;
	integer c;
	integer mid;
	initial 
	begin
		r=8;
		c=15;
		mid = ((c/2));
		$display("\n");
		
		for(i=0; i<r; i=i+1)
		begin
			if(i==0)
			begin
				for(j=0; j<c; j=j+1)
				begin
					if(j==0 || j==mid || j==c-1)
						$write("*");
					else
						$write(" ");
				end
				$display();
			end
			
			else if(i==r)
			begin
				for(j=0; j<c; j=j+1)
				begin
					if(j==0 || j==c-1)
						$write("*");
					else
						$write(" ");
				end
				$display();
			end
			
			else
			begin
				for(j=0; j<c; j=j+1)
				begin
					if(j==0 || j==mid-i || j==mid+i || j==c-1)
						$write("*");
					else
						$write(" ");
				end
				$display();
			end
		end

	end
	
	
endmodule
