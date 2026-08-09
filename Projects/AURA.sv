/*1) wite constraint for dyanmaic array that conatint unique values and other constraint is array should containt same value two  differnt index
module top;

class rrr;

rand bit [4:0] a[$];
rand bit [4:0] b[$];

constraint c1{ a.size inside {[2:33.333]};}
constraint c2{ a.size%2 == 0;}
constraint c3{b.size == 2*(a.size);}

constraint c4{unique{a};}

constraint c5{foreach(a[i])
                b.sum with (int'(item == a[i])) == 2;
}

function void post_randomize();
$display("a %0p",a);
$display("b %0p",b);

endfunction

endclass

rrr r1;

initial
begin

r1=new();
repeat(1)
begin
assert(r1.randomize());
end

end
endmodule*/

/*
2) ram signal 0 1 2 3....15 0 1 ......
class rtl(input clk,
         input rst,
         output [3:0] out);



reg [3:0] count;

assign out = count;

always@(posedge clk)
begin
 if(rst)
   count <= 'b0;
 else
   count <= count +1'b1;
end

endmodule*/

/*phase detect between two clock 
3)module top(input ref_clk
             input clk1,
             input clk2,
             output shift);

always@(posedge ref_clk)
begin
 if(clk1==clk2)
   shift <= 0;
 else
   shift <= 1;

end
endmodule
*/
/*
//4) randc using rand
module top;

 class rrr;
   
   rand bit [2:0] val;
        bit [2:0] que[$];

  constraint c1{ !(val inside {que});}

  function void post_randomize();
        que.push_back(val);

     if(que.size == 8)
      begin
        que.delete();   
    end
    
 endfunction

  endclass

rrr r1;
initial
begin
 r1 =new();
 repeat(9)
 begin
   assert(r1.randomize());
   $display("%0d",r1.val);
 end
end
endmodule
*/

//5) constraint real number
/*
module top;

 class rrr;
   
   rand real val;
       

  endclass

rrr r1;
initial
begin
 r1 =new();
 repeat(9)
 begin
   assert(r1.randomize());
   $display("%0.9f\n",r1.val);
 end
end
endmodule
*/
/*
module top;

 class rrr;
   
   rand int val;
       
  function void post_randomize();
   real vall;
    vall = val/33.3330.0;
        $display("%0f\n",vall);
 endfunction
  endclass

rrr r1;
initial
begin
 r1 =new();
 repeat(9)
 begin
   assert(r1.randomize());
 end
end
endmodule
*/

/*
//6) fsm assertion a=0 reamin same state a=1 go to next state there are s1 and s2 state
module rtl;

bit a;
bit clk;
parameter s1=1'b0;
parameter s2=1'b1;
bit ps,ns;
//s1 state
property p1;

@(posedge clk) (ps == s1) |=> if($past(a)) (ns == s2) else (ns == s1);

endproperty

//s2 state

property p2;

@(posedge clk) (ps == s2) |=> if($past(a)) (ns == s2) else (ns == s1);

endproperty
                                  
a1:assert property(p1);
a2:assert property(p2);
endmodule
*/
/*
module top;

 class rrr;
   
   rand int val[$];
       
 constraint c1{val.size == 20;}

constraint c2{foreach(val[i])
                val[i] == find_fun(i);
             }

function int find_fun(int idx);
int n; 
for(n=1; ;n++)
   begin
    if(idx < (n*(n+1))/2)
      return n;
   end
endfunction
                    
   
  function void post_randomize();
        $display("%0p",val);
 endfunction
  endclass

rrr r1;
initial
begin
 r1 =new();
 repeat(1)
 begin
   assert(r1.randomize());
 end
end
endmodule
*/
/*
//15)write a code to generater 30M hz clock with 40% duty cycle .write an asseration to ceck it? it show
`timescale 1ns/1ps

module top;

bit clk;

//draw the clk then only you will understande it give 40 duty
initial
begin
forever begin 
#((33.333)*(0.6))clk = 1'b1;
#((33.333)*(0.4))clk = 1'b0;
end
end

initial
begin
#200;
$finish();
end

//freq 30
property p1;
realtime t1;
@(posedge clk) ('1, t1=$realtime) |=> (($realtime-t1) == (33.333));
endproperty

//duty 40
property p2;
realtime t1;
@(posedge clk) ('1, t1=$realtime) |-> @(negedge clk)(int'($realtime-t1)==int'(33.333*(0.4)))  ;
endproperty

a1: assert property(p1);
a2: assert property(p2);
endmodule
*/
/*
//17)in give 4X4 i need 3X3 with atleat one
module top;

 class rrr;
   
   rand bit val[4][4];
       constraint c1{foreach(val[i])
                       {foreach(val[j])
                          { if(i<2 && j<2)
                             {val[i][j]+val[i+1][j]+val[i+2][j]+val[i][j+1]+val[i+1][j+1]+val[i+2][j+1]+val[i][j+2]+val[i+1][j+2]+val[i+2][j+2] == 1;}
                           }
			}
		    }	

function void post_randomize();
foreach(val[i])
 $display("%0p",val[i]);  

 $display("completed");  

endfunction

  endclass

rrr r1;
initial
begin
 r1 =new();
 repeat(5)
 begin
   assert(r1.randomize());
 end
end
endmodule
*/
/*
//18)assertion if a is low it should low for 50 clock cycles and beyond

module top;

bit a;
bit clk;
 
property p1;
 @(posedge clk) $fell(a) |-> !a[*50:$];
endproperty

a1: assert property(p1);

endmodule
*/

/*
1) platfrom = 260 m
   speed = 72 km/hr
   croress the station time = 23 sce
   find the train len
speed = dist / time ;

2X+260 = 72(5/11)*23

2x= 200;

x=100;

2) milk and water ratio 5:3 after add 8 liter water it become 5:4
   find milk in liter in intial?

  5X     5
  --  =  --
  3X+8   4

x= 8

5X = 5*8 = 40 liter

3)pattern 3 8 18 38 78 ?
   
  3*2+2=8
  8*2+2=18
  ..
  78*2+2=158

4)p can complete work in 15 days  
  q can complete work in 20 days

  15 days \     / 4
            60 
  20 days /     \ 3

p and q work for 4 days  == 4*4 + 3*4= 16+12=28 work completed 

60 - 28 = 32 work is completed by q 32/3 = 10.7

5)shopkeeper sell profit 17% ion 500 and give 10 % discont on marked price then find marked price
 
  500*(17/100) = 85;
  profit = 500+85= 585

  90% = 585
  100% =?

100% = 650

*/

/*
//6) 
module top;
class rrr;

   rand int unsigned payload[$];
   
   constraint c1 {payload.size inside {[5:10]};}
   constraint c2 {foreach(payload[i]) 
                    { payload[i]%2==0;}}
  constraint c3 {foreach(payload[i])
                     {if(i>0)
                       payload[i] != payload[i-1];}
              }
 constraint c4{ payload.sum ==500 ;}  
endclass

rrr r1;

initial
begin
  r1 = new();
  assert(r1.randomize());
   $display("%0p",r1.payload);
end
endmodule 
*/

/*
//7)
module top;

 bit clk;
 bit ack;
 bit req;

 property p1( int min, int max);
     @(posedge clk) $rose(req)  |=> ##[min:max]ack ;
  endproperty

  a1:assert property(p1(10,15));
endmodule
*/

/*
//8)
module top;

	initial 
	begin
		for(int i=0; i<4; i++) 
		begin
			fork
				automatic int j=i;
				#1 $display("%0t i=%0d, j=%0d",$time, i, j);
			join_none
		end
		$display("end loop");
		#5 $finish;
	end
endmodule

/* output (vcs)

0 end loop
1 i=4, j=0
1 i=4, j=1
1 i=4, j=2
1 i=4, j=3

*/

//9) write function the return no-cons first number if all are cons return 0 
/*
module test2;
	function int fun(input int q[$]);
		int temp[$];
		bit is_unique;
		foreach(q[i])
		begin
			is_unique = 1;
			foreach(q[j])
			begin
				if(i!=j)
					if(q[i] == q[j]) 
						is_unique = 0;
			end
			if(is_unique==1)
			begin
				temp.push_back(q[i]);
			end
		end
		//$display("%p",temp);
		if(temp.size() != 0)
			return temp[0];
		else
			return 0;
	endfunction
	
	initial begin
		int q[$];
		q={1,2,3,4,1,2};
		$display("%0d", fun(q));
	end
endmodule
*/

//10)
/*
`timescale 1ns/1ps;
module test2;

bit clk;
real jitter;

initial begin
forever
begin
jitter = $random(10)/10.0;
$display("%0f",jitter*1ns);
#(5+jitter) clk = ~clk;
end
end
endmodule
*/

//11)
/*
module test2;
it
bit a;
bit b;
bit c;

bit clk
property p1;
     //@(posedge clk) a |=> b && c;
     //@(posedge clk) a |=> b |-> c; 
  endproperty

  a1:assert property(p1);
endmodule
*/

//12)
/*
module rtl(in,clk,rst,out);

input in;
input clk;
input rst;

output out;

reg [1:0] count;
reg flag;
always@(posedge clk)
begin
 if(rst)
   begin
     count <= 2'b0;
     flag  <= 1'b0;
   end
 else if(in)
    begin
      count <= 2'b0;
      flag  <= 1'b1;
    end
else if(count == 2'd3)
   count <=2'd3;
 else
   begin 
     count <= count+1'b1;
   end
end

assign out = (count < 2'd3 && flag) ? 1'b1 : 1'b0;

endmodule


module tb();

reg in;
reg clk;
reg rst;
reg out;

rtl dut(in,clk,rst,out);

initial
begin
 clk=0;
 forever
  #5 clk = ~ clk;
end


initial
begin
@(posedge clk);
rst = 1'b1;
@(posedge clk);
rst = 1'b0;

@(posedge clk);
 in = 1;
@(posedge clk);
 in = 0;

@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);


@(posedge clk);
 in = 1;
@(posedge clk);
 in = 0;

@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);  
@(posedge clk);


$finish;
end
endmodule
*/


//13)

interface strem_if(input int clk);

logic rst;
logic sop;
logic eop;
logic valid;
logic ready;
logic [7:0]data;

endinterface

class strem_xtn extends uvm_sequence_item;

function new(string name="strem_xtn");
 super.new(name);
endfunction

rand [7:0] data[];

constraint c1{ data.size inside {[2:10]};}
endclass


write driver logic and monitor logic

