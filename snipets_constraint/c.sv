//1) write constraint such that even locations in an array should contain odd numbers and odd locations in the array should contain even numbers,array size should
//be randomized to 10.
/*
class packet ;
	rand bit[3:0] arr[];
	
	constraint size{arr.size == 10;}
	constraint c1{foreach(arr[i])
						{
							if(i%2 == 0)
								arr[i] % 2 == 1;
							else 
								arr[i] % 2 != 1;}}
	
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize)
			$display("%0p",p_h.arr);
		end
endmodule 	
*/

//2 write a constraint such that arr of any size should contain number of "1" equal to the half size of the array
/*
class packet;
	rand bit[3:0] arr[];
	rand bit[3:0] n;
	
	constraint size{arr.size == n;}2
	constraint c2{foreach(arr[i])
					arr[i] inside {0,1};
				(arr.sum with (int'(item == 1))) == n/2 ;}
	
	
	function void post_randomize();
		foreach(arr[i])
			$write("%0d ",arr[i]);
		$display("");
		$display("no of ones = %0d",arr.sum with (int'(item == 1)));
		$display("%0d",arr.size);
		endfunction
	
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize);
		end
endmodule 	
*/

//3)write a constraint to create a 5X5 matrix in that every element should be unique, do not use unique keyword
/*
class packet;
	rand bit[5:0] a[5][5];
	
	constraint c1{foreach (a[i,j])
					{
						foreach(a[m,n])
							{
								if(i != m && j != n)
									a[i][j] != a[m][n];
								}
								}}
	
	
	function void post_randomize();
			foreach(a[i])
			begin 
				foreach(a[j])
					begin 
						$write("%0d  ",a[i][j]);
					end
				$display("");
			end
			
	endfunction
	
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize);
		end
endmodule 
*/
//4)write a constraint for 5X5 matrix in that diagonal elements should be in divisible of 5 other elements should be equal to 0
/*
class packet;
	rand bit[5:0] a[5][5];
	
    constraint c1 {
        foreach (a[i,j]) {

            if (i == j)
                a[i][j] % 5 == 0;

            else if (i + j == 4)
                a[i][j] % 5 == 0;
				
            else
                a[i][j] == 0;
        }
    }
	
	
	function void post_randomize();
			foreach(a[i])
			begin 
				foreach(a[j])
					begin 
						$write("%0d  ",a[i][j]);
					end
				$display("");
			end
			
	endfunction
	
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize);
		end
endmodule 
*/
/*
//5)write a constaint to print 9 99 999 9999 99999
class packet;
	rand int a;
	int count = 0;
	
	constraint c2{a == nine(count);}
	
	function int nine(int x);
		int num = 0;
		for(int i = 0 ; i <=x ; i++)
			num = num*10+9;
		return num;
	endfunction
	
	function void post_randomize();
			count++;
			$write("%0d ",a);
	endfunction
	
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			repeat(5)
			assert(p_h.randomize);
		end
endmodule 
*/
/*
//6write a constraint to generate unique numbers in an array without using unique keyword,array size should be randomized to 10
class packet;
	rand bit[3:0] a[];
	
	constraint size{a.size == 10;}
	
	constraint c1{foreach (a[i])
					{
						foreach(a[j])
							{
								if(i != j)
									a[i] != a[j];
								}
								}}
	
	
	function void post_randomize();
			foreach(a[i])
				$write("%0d  ",a[i]);
			
	endfunction
	
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize);
		end
endmodule 
*/
//7 write a constraint to print 1 0 1 0 1 0 1 0 1 0
/*
class packet;
	rand bit[3:0] a[];
	
	constraint size{a.size == 10;}
	
	constraint c1{foreach (a[i])
					{
						if(i%2 == 0)
							a[i] == 1;
						else 
							a[i] == 0;}}
	
	
	function void post_randomize();
			foreach(a[i])
				$write("%0d  ",a[i]);
			
	endfunction
	
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize);
		end
endmodule 
*/
/*
//8 write a constraiant for creating an arr in that first half of the elements should  
//be in desending order and other half should be in asending order

class packet;
	rand bit[3:0] arr[];
	
	constraint size{arr.size == 10;}
	

    constraint c_order {

        foreach (arr[i]) {
            if (i >= arr.size/2)
                if (i > 0)
                    arr[i] > arr[i-1];
        }

        foreach (arr[i]) {
            if (i < arr.size/2)
                if (i > arr.size/2)
                    arr[i] > arr[i-1];
        }
    }
									
	function void post_randomize();
			foreach(arr[i])
				$write("%0d  ",arr[i]);
			
	endfunction
	
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize);
		end
endmodule
*/

//9) write a constraint to find 20 unique numbers between 99 and 100; 
/*
class packet;
	rand real arr[20];
	
	constraint size{foreach(arr[i])
				arr[i] inside {[99.0:100.0]};}
	

									
	function void post_randomize();
			foreach(arr[i])	
				$display("%0f ",arr[i]);
			
	endfunction
	
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize);
		end
endmodule
*/
//11)write a constraint for a 32bit variable in which the every 5th bit should only be 0 and rest of the bits should be 1 
/*
class packet;
	rand bit [0:31] arr;
		
		constraint c1{foreach(arr[i])
						{
								if((i+1)%5 == 0)
									arr[i] == 0;
								else 
									arr[i] == 1;
								}
							}
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize());
			$display("%0b",p_h.arr);
		end
endmodule 	
*/
//12 write a constraint for sorting the elements in an array without using sorting method, array size should be randomized to 20
/*
class packet;
	rand bit [7:0] arr[];
		
		constraint size{arr.size == 20;}
		constraint c1  {foreach(arr[i])
							{
								if(i<19)
								arr[i]<arr[i+1];
							}
						}
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize());
			$display("%0p",p_h.arr);
		end
endmodule 
*/
//13)a sv code contains 4 variables namely a,b,c,d each 4bits , write a constraint 
//such that the in one randomization any 1 variable only should get randomized
/*
class packet;
	rand bit [3:0] a;
	rand bit [3:0] b;
	rand bit [3:0] c;
	rand bit [3:0] d;
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			p_h.a.rand_mode(0);
			p_h.b.rand_mode(0);
			p_h.c.rand_mode(0);
			p_h.d.rand_mode(0);
			
			randcase
				100 : p_h.a.rand_mode(1);
				200 : p_h.b.rand_mode(1);
				300 : p_h.c.rand_mode(1);
				400 : p_h.d.rand_mode(1);
			endcase
			
			assert(p_h.randomize());
			$display("a = %0d , b = %0d , c = %0d , d = %0d",p_h.a,p_h.b,p_h.c,p_h.d);
		end
endmodule 
*/

//14)write a constraint to print 5 -10 15 -20 25 -30 
/*
class packet;
	rand int a[];
	constraint size{a.size == 20;}
	constraint c1{foreach(a[i])
						{
							if(i<a.size)
								{
									if(i%2 == 0)
										a[i] == (i+1) * 5;
									else 
										a[i] == (i+1) * -5;
								}
						}
					}
							
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize());
			$display("a = %0p",p_h.a);
		end
endmodule 
*/

/*
//15)
//write a constraint to print 0 1 0 0 1 1 0 0 0 1 1 1 0 0 0 0 1 1 1 1
class packet;
	rand bit val;
	bit toggle = 0;
	int flag  = 0;
	int count  = 1;
	
	constraint c_val {val == toggle;}

				
	
	function void post_randomize;
		flag ++;
		if(flag == count)
			begin
				$display("before toggle - %0b",toggle);
				toggle = ~toggle;
				$display("after toggle - %0b",toggle);
				if(toggle == 0)
					count++;
				flag = 0;
			end
	endfunction
	
endclass

packet p_h;

module top;
	initial 
		begin
			p_h = new();
			for(int i = 0; i <3; i++)
				begin
					assert(p_h.randomize);
					$display("Iteration %0d - %0b ",i,p_h.val);
					$display("count -   %0d ",p_h.count);
					$display("flag  -   %0d ",p_h.flag);
				end


		end
endmodule 
*/

//16)
//write a constraint to create a 5X5 matrix in that diaginal elements should containt 1 and rest of the elements should contain 0
/*
class packet;
	rand bit[3:0] arr[5][5];
	
	constraint c1{foreach(arr[i,j])
					{
						if((i==j) || (i+j == 4))
							arr[i][j] == 1;
						else 
							arr[i][j] == 0;
							}
						}
							
	function void post_randomize;
		foreach(arr[i])
			begin 
				foreach(arr[j])
					$write("%0d ",arr[i][j]);
				$display("");
			end
	endfunction
	
endclass

packet p_h;

module top;
	initial
		begin
			p_h = new();
			assert(p_h.randomize());
		end
endmodule
*/


//17) write a constraint for a 128 bit if 1 comes it should contain an adjecent 1 to it and one should not be consecutive more than 2 time 
//	neither i shouldnt be stay single 
/*
class packet;
	rand bit[0:127] arr;
	
    constraint c1 
	{
        foreach(arr[i]) 
			{
			if(i == 0)
				if(arr[i] == 1)
					arr[i+1] == 1;
			
			if(i == 127)
				if(arr[i] == 1)
					arr[i-1] == 1;
			
			
					
            if (i > 0 && i < 127)
				{
					arr[i-1] && arr[i] -> !arr[i+1];
               
					if (arr[i] == 1) 
						{
							(arr[i-1] == 1 || arr[i+1] == 1);
						}
				}
			}
    }
	     
							
	function void post_randomize;
		$display("%0b ",arr);
	endfunction
	
endclass

packet p_h;

module top;
	initial
		begin
			p_h = new();
			assert(p_h.randomize());
		end
endmodule
*/

//18.2 33 222 5555 22222 777777
/*
class packet;
	rand longint arr[];
	constraint c1{
					arr.size == 10;
					arr[0]   == 1;
					foreach(arr[i])
						{
							if(i>0)
								{
									if(i%2 == 0)
										arr[i] == (((10**(i+1) - 1)/9)*2); 
									else	
										arr[i] == (((10**(i+1) - 1)/9)*(2+i));
								}
										
						}
					}

						
	function void post_randomize();

		foreach(arr[i])
			$write("%0d ",arr[i]);			
	endfunction
					
endclass

packet p_h;

module top;
	initial
		begin
			p_h = new();
			assert(p_h.randomize());
		end
endmodule
*/
/*
class packet;
	rand int arr;
	int count;
	constraint c1 { if(count%2 == 1)
						arr == 2;
					else if(count%2 == 0)
						arr == count + 1;
						} 
					
endclass

packet p_h;

module top;
	initial
		begin
			p_h = new();
			repeat(8)
				begin 
					p_h.count++;
					repeat(p_h.count)
						begin 
							assert(p_h.randomize());
							$write("%0d",p_h.arr);
						end
					$write(" ");
				end
		end
endmodule
*/

//19) 1 2 333 4 55555 6 7777777
/*
class packet;
	rand int arr[],b[];
	constraint c1{
					arr.size == 10;
					arr[0]   == 1;
					foreach(arr[i])
						{
							if(i>0)
								{
									arr[i] ==  (arr[i-1]*10+1);
								}
						}
					}
	constraint c2{
					b.size == 10;
					foreach(b[i])
						{
							if(i%2 == 1)
								b[i] == i+1;
							else 
								b[i] == arr[i] * (i+1);
						}
					}
						
	function void post_randomize();

		foreach(b[i])
			$write("%0d ",b[i]);			
	endfunction
					
endclass

packet p_h;

module top;
	initial
		begin
			p_h = new();
			assert(p_h.randomize());
		end
endmodule
*/

/*21) write a prameterized class which should contain an array of 10 values in which the differnce between the values should be equal 
but all the values in the array should be unique. array size should be randomized

class packet #(int N = 10);
	randc bit[7:0] arr[];
	
	constraint size{arr.size == N;}
		
	constraint add{foreach(arr[i])
				{
					foreach(arr[j])
						{
							if((j>0) && (j<N-1) )
							arr[j]-arr[j+1] == arr[j-1] - arr[j];
						}
						}
					}
	function void post_randomize();
		$display(" %p",arr);
		$write("difference btw nums - ");
		foreach(arr[i])
			begin 
				if(i < N-1)
					$write(" %0d",arr[i]-arr[i+1]);
			end 
	endfunction
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize);
		end
endmodule 						
*/




/*
//Generate random values without using rand keyword...but if u give randomize it should work
class packet ;
	bit[7:0] arr[];
	
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize(arr) with {p_h.arr.size == 10;
											foreach(p_h.arr[i])
												arr[i] inside {[0:50]};})
			$display("%0d",p_h.arr);
		end
endmodule 	
*/
/*

// print odd values in even index and even value in odd index without using any modulous or divide operator
class packet;
	rand bit[3:0] arr[];

	constraint c0{arr.size == 10;}
	
	constraint c1{foreach(arr[i])
					{
						if(i[0] == 1'b1)//odd
							{
								arr[i][0] == 1'b0;//even
							}
						else if(i[0] == 1'b0) //even
							{
								arr[i][0] == 1'b1; //odd
							}
						}
					}

						
	function void post_randomize();	
		$write("%0p ",arr);
	endfunction
					
endclass

packet p_h;

module top;
	initial
		begin
			p_h = new();
			assert(p_h.randomize());
		end
endmodule




*/

// 4*4 matrix with 0000
//		   0111
	//	   0122


module top;		// 0123
class test;

	rand bit [2:0] a[4][4];

	constraint c1{ foreach(a[i,j]) 
				if(i==0 || j==0)
					a[i][j] == 0;
				else if(i==1 || j==1)
					a[i][j] == 1;

				else if( i==2 || j==2)
                                        a[i][j] == 2;
				
				else				
					a[i][j] == 3;
				}

 function void post_randomize();
	foreach(a[i])
		begin
		   foreach(a[j])
			$write(" %0d ",a[i][j]);
			$display("");
		end
 endfunction	
endclass
test t1;

initial
 begin
 t1 = new();

assert(t1.randomize());

 end
endmodule
				
/*
module top;

class test;

	randc int a [];

 	constraint a1 { a.size() == 10; }
	

	constraint a2 { foreach(a[i]) 
			if(i%2 == 1)
			  a[i]%2 == 1;
			else
			  a[i]%2 == 0;}
		
	constraint a3 {foreach(a[i])
			a[i] inside{[0:100]};}
endclass

test t;

initial
begin
 t = new();

assert( t.randomize())
	$display("%p",t.a);
end
endmodule

*/
