/*

module top;
	bit clk;
	bit a,b,c;

	

		property p1;
			@(posedge clk) $rose(a) |=> b ##2 c;
		endproperty
	
		p11 : assert property (p1)
			$info("asstertion passed ");
		else 
			$error("assertion failed");
		
		c11 : cover property (p1);
 
endmodule 	
*/
/*
module top;
	bit clk;
	bit a,b,q1,q0,clr;

	always@(posedge clk)
		begin 
			if(clr)
				q1 <= 1'b0;
			else if (a == 0 && b ==0)
				q1<= 1'b1;
			else if(a == 0 && b== 1) 
				q1 <= ~q1;
			else if(a == 1 && b==0)
				q1 <= q1;
			else 
				q1<= 1'b0;
		end
	assign q0 =~q1;
	
        property clr_ppt;
		@(posedge clk) $rose(clr) |=> q1 == 0;
	endproperty

//	property not_equal;
//		@(posedge clk) q1 != q0;
//	endproperty

	property no_change;
		@(posedge clk) disable iff(clr) 
			        (a==1 && b == 0) |=> q1 == $past(q1,1);
	endproperty

	property set;
		@(posedge clk) 	disable iff(clr)
				(a==0 && b==0) |=> q1 == 1; 	
	endproperty

	property toggle;
		@(posedge clk) disable iff(clr)
				(a==0 && b==1) |=> q1 == ~$past(q1,1);
	endproperty

	property reset;
		@(posedge clk) 	disable iff(clr)
				(a==1 && b==1) |=> q1 == 0;
	endproperty

	CLEAR      : assert property(clr_ppt);
	NO_CHGANGE : assert property(no_change);
	SET        : assert property(set);
	RESET      : assert property(toggle);
	TOGGLE     : assert property(reset);

	CLEAR_1      : cover property(clr_ppt);
	NO_CHGANGE_1 : cover property(no_change);
	SET_1 	     : cover property(set);
	RESET_1      : cover property(toggle);
	TOGGLE_1     : cover property(reset);

	
		
endmodule 
*/
/*
module top;

	bit clk,rst;
	
	bit a,b;

	property sig;
	@(posedge clk) disable iff(rst)
	
		a |=> ##2 b;
		
	endproperty
	
	/*property siga;
	@(posedge clk) disable iff(rst)
	
		$rose(a) |=> $rose(b);
		
	endproperty


	assert property(sig);

	cover property(sig);
	
	//assert property(siga);

	//cover property(siga);

endmodule*/
/*
module top;
	bit clk;
	bit a,b,c;

	

		property p1;
			@(posedge clk) $rose(a) |=> b ##2 c;
		endproperty
	
		p11 : assert property (p1)
			$info("asstertion passed ");
		else 
			$error("assertion failed");
		
		c11 : cover property (p1);
 
endmodule 	
*/

/*
//8 queens
class queens;
        rand bit [3:0] a[8][8];
	
	constraint size{foreach (a[i,j])
				a[i][j] inside{0,1};}
				
	constraint diagonals_c {
        foreach(a[i,j]) {
            foreach(a[p,q]) {
                if (i != p || j != q) {
                    (a[i][j] == 1 && a[p][q] == 1) -> ((i - j != p - q) && (i + j != p + q));
                }
            }
        }
    }

	constraint rows{foreach (a[i])
				  (a[i].sum() with(int'(item))) == 1;}
				  
	constraint column{foreach (a[i,j])
				  (a.sum(item) with(int'(a[item.index][j]))) == 1;}
				  
	function void post_randomize();
		foreach(a[i])
			begin 
				foreach(a[j])
					begin 
						$write("%0d ",a[i][j]);
					end
				$display("");
			end
	endfunction
endclass

queens q_h;

module top;
	initial 
		begin
			q_h = new();
			assert(q_h.randomize);
		end
endmodule
*/
/*
//Write a constraint to generate 5 random numbers in an array 5 times such that each time we randomize the elements of the array they should be 
//different from the previous randomized values and the sum of all the elements in the array should be double the sum of previous randomized values.
class packet;
	
	rand bit [7:0] arr [5];
	
	constraint value{foreach(arr[i]){
						soft arr[i] inside{[0:15]};}}
	
	function void post_randomize();
		$display("%p",arr);
	endfunction
	
endclass

packet p_h;

module top;
	initial 
		begin 
			int temp = 1;
			p_h = new();
			//p_h.value.constraint_mode(0);
			//assert(p_h.randomize);
			//p_h.value.constraint_mode(1);
			repeat(5)
				begin 
					assert(p_h.randomize() with {(p_h.arr.sum() with(int'(item))) > temp*2;});
					temp = p_h.arr.sum() with(int'(item));
					$display("%d",temp);
				end
		end
endmodule 
 */
/*

//Write constraints to generate a n-bit random value (n is even) such that the number of bits set is equal to number of bits that are zero.
//Should not use pre/post randomize methods, only constraints allowed.
class packet;
	parameter N = 15;
	randc reg [N:0] a;
	
	constraint count{$countones(a) == (N+1)/2;} 

endclass

packet p_h;

module top;
	initial 
		begin 
			int one,zero;
			p_h = new();
			p_h.randomize();
			
			foreach(p_h.a[i])
				begin 
					if(p_h.a[i] == 1'b1)
						one = one+1;
					else if(p_h.a[i] == 1'b0)
						zero = zero +1;
				end
			$display("%d, %b,one = %d,zero = %d",p_h.a,p_h.a,one,zero);
		end
endmodule 
*/
/*
class packet;
	rand bit [3:0] a[10];
	
	constraint count{foreach(a[i])
							foreach(a[j])
									if(i < j)
										a[i] != a[j];}

	function void post_randomize();
		$display("%p",a);
	endfunction
	constraint count1{unique{a};}
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			p_h.randomize();
			$display(p_h.a);
		end
endmodule 
*/
//write a constraint for a sq matrix and the rotate counter clock wise 90 digree;
/*
class packet;
		parameter n = 5;
        rand bit [3:0] a[n][n];
		     bit [3:0] b[n][n];
			 
	constraint size{foreach (a[i,j])
				a[i][j] inside{[0:9]};}
	
				
				  
	function void post_randomize();
	$display("---------------------------original array---------------------------");
		foreach(a[i])
			begin 
				foreach(a[j])
					begin 
						$write("%0d ",a[i][j]);
					end
				$display("");
			end
		$display("");
		
		for(int i = 0 ; i <n+1 ; i++)
			begin 
				for(int j = 0 ;j <n+1 ; j++)
					begin 
						b[i][j] = a[j][(n-1)-i];
					end
			end
		
	$display("---------------------------90 degree rotated array---------------------------");
		foreach(b[i])
			begin 
				foreach(b[j])
					begin 


						$write("%0d ",b[i][j]);
					end
				$display("");
			end
		$display("");
			
	endfunction
endclass

packet q_h;

module top;
	initial 
		begin
			q_h = new();  
			assert(q_h.randomize);
		end
endmodule
*/
//signal a is high in next clock cycle signal b should be high until c is high
/*
module top;
	bit clk,a,b,c,rst;
	
	property p1;
		@(posedge clk) disable iff(rst) $rose(a) |=> b until_with c;  
	endproperty
	
	P1 : assert property(p1);
	
	C1 : cover property(p1);
endmodule 
*/

//write an assertion to check that whenever req goesw high ack must be aserted within 3 cycles 
//and once ack is asserted req must go low in the next cycle;
/*
module top;
	bit clk,req,ack,rst;
	
	property p1;
		@(posedge clk) disable iff(rst) $rose(req) |-> ##[0:2]ack ##1 $fell(req); 
	endproperty
	
	P1 : assert property(p1);
	
	C1 : cover property(p1);
endmodule 
*/
/*
module assertion;
	bit clk,req,grant;
	
	property p1;
		@(posedge clk) $rose(req) |-> ##3 (grant) !(req) !##[0:$] grant; 
	endproperty
	
	P1 : assert property(p1);
	C1 : cover property(p1);
endmodule 
 */
/*
There is an 8 bit vector (bit[7:0] data_in) which takes some random value. Write a constraint in 
such a way that every time it is randomized, total no. of bits toggled (data_in) should be 5 with 
respect to the previous value of data_in.
*/
/*
class packet;
	
	rand bit [7:0] data;
	rand int count;
	
	constraint ones{ $countones(data) == 5;}
	
	function void post_randomize();
		$display("%b",data);
	endfunction
	
endclass

packet p_h;

module top;
	int c=0;
	bit [7:0] num[$];
	initial 
		begin 
			p_h = new();
			repeat(5)
				begin 
					assert(p_h.randomize());
					num.push_back(p_h.data);
					if(c != 0)
						begin 
							p_h.count = num[c-1]^p_h.data;
							$display("no of ones %0d",$countones(p_h.count));
							$display ("xor value %0b data = %b, num = %b",p_h.count,p_h.data,num[c-1]);
						end
					c++;
				end
			$displayb("%p",num);
			$display ("%0d",p_h.count);
		end
endmodule 
*/

/*
class packet;
	rand bit val;
	bit toggle = 0;
	int flag  = 0;
	int count  = 1;
	
	constraint c_val {val == toggle;}

				
	
	function void post_randomize;
		flag ++;
	//	$display("flag - %0d ",flag);
		if(flag == count)
			begin 
				toggle = ~toggle;
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
			repeat(30)
				begin
					assert(p_h.randomize);
					$write("%0b ",p_h.val);
				end
					$display("\n%0d ",p_h.count);
					$display("%0d ",p_h.flag);

		end
endmodule 
*/
	
/*
module top;
		logic [3:0] grant;
		logic valid_req;
		logic clk;
		
		property p0;
			@(posedge clk) $onehot(grant);
		endproperty
		
		property p1;
			@(posedge clk) $rose(valid_req) |-> ##[1:5] $onehot(grant);
		endproperty 
		
		P1 : assert property (p1);
		C1 : cover property (p1);
		P0 : assert property (p0);
		C0 : cover property (p0);

endmodule 
*/
/*
class packet;

	rand int a[12];

	constraint c1 {
			foreach(a[i])
				if ((i%2!=0 && i<2) || (i%6>=4 && i<6) || (i%12>=9 && i<12))
					a[i] == 1;
				else
					a[i] == 0;
			}

	function void post_randomize();
		$display("array %p ",a);
	endfunction

endclass

module top;

	packet p;

initial
begin

	p = new;

	assert(p.randomize);
	
end

endmodule
*/
/*module top;

	bit clk;
	
	bit b;

	property sig;
	@(posedge clk) $rose(b);
		
	endproperty
	
	assert property(sig);

	cover property(sig);
	
endmodule*/
/*module top;

	bit clk;
	
	bit [3:0] g;

	property sig;
	@(posedge clk) $onehot0(g);
		
	endproperty
	
	assert property(sig);

	cover property(sig);
	
endmodule*/

module top;

	bit clk;
	
	bit a,b;

	property sig;
	@(posedge clk) a |-> ##1 b;
		
	endproperty
	
	assert property(sig);

	cover property(sig);
	
endmodule




