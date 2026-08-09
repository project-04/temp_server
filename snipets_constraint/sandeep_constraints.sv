


//2.---------------Even loaction in odd locations odd locations in even ---------//

/*

class packet;

rand bit[3:0] data[10];
constraint even_odd{foreach(data[i])
			if(i%2==0)
			data[i]%2==1;
			else
			data[i]%2==0;}
endclass
packet pkt;
module test;
        initial
                begin
                        pkt=new();
                        pkt.randomize();
                        $display("%p",pkt);
		end
                


endmodule

*/
//3-------------------------fibonacci series-------------------------------//



/*
class packet;
rand int a[10];
constraint fibonacci{foreach(a[i])
			if(i==0)
			a[i]==0;
			else if (i==1)
			a[i]==1;
			else
			a[i]==a[i-1]+a[i-2];}

endclass

packet pkt;
module test;
        initial
                begin
                        pkt=new();
                        pkt.randomize();
                        $display("%p",pkt);

                end


endmodule
*/


//4 -----------------------------Ascending number --& Descending-- number------------------------------//

/*

class packet;
//rand bit[3:0] data[10];
rand bit [3:0] data1[10];
//constraint assen_desen{foreach(data[i])
//			if(i>0)
//			data[i]>data[i-1];}
constraint cx1{foreach(data1[j])
			if(j>0)
			data1[j]<data1[j-1];}
	

//constraint desen_ascen{foreach(data[i])
//			if(i>0)
			
//		data[i]<data[i-1];}


endclass

packet pkt;
module test;
       initial
                begin
                        pkt=new();
                        pkt.randomize();
                //        $display("data=%p",pkt.data);
			$display("data1=%p",pkt.data1);
                end


endmodule
*/


//----prime numberes ---//


/*
class packet;

rand int a[$];
	constraint c1{a.size==1000;
                    
			foreach(a[i])
			if(i>1 &&(!((i%2==0 && i!=2)||(i%3==0 && i!=3) ||(i%5==0 && i!=5)||(i%7==0 && i!=7))))
			a[i]==i;
			else
			a[i]==2;
			}
function void post_randomize();

a=a.unique();
endfunction


endclass
packet pkt;
module test;
        initial
                begin
                        pkt=new();
                        pkt.randomize();
                //        $display("data=%p",pkt.data);
                        $display("data1=%p",pkt.a);
                end


endmodule
*/

class prime_array;

  rand int a[];              // dynamic array
  bit is_prime[50];          // lookup table

  // Constructor
  function new();
    compute_primes();        // fill prime table before randomization
  endfunction

  // Function to compute primes up to 49
  function void compute_primes();
    for (int i = 0; i < 50; i++) begin
      is_prime[i] = 1;

      if (i < 2)
        is_prime[i] = 0;
      else begin
        for (int j = 2; j*j <= i; j++) begin
          if (i % j == 0) begin
            is_prime[i] = 0;
            break;
          end
        end
      end
    end
  endfunction

  // Constraint
  constraint c1 {
    a.size() == 50;

    foreach (a[i]) {
      if (is_prime[i])
        a[i] == i;
      else
        a[i] == 2;
    }
  }

  // Display function
  function void display();
    foreach (a[i]) begin
      $display("a[%0d] = %0d", i, a[i]);
    end
  endfunction

endclass


module test;

  initial begin
    prime_array obj = new();

    if (obj.randomize()) begin
      $display("Randomization successful\n");
      obj.display();
    end
    else begin
      $display("Randomization failed");
    end
  end

endmodule


//---------Armstrong numebr -----------------//
/*
class packet;
 rand int arm;
 constraint cons {arm inside {370,345,456,407,455,544};}
 function void post_randomize();
 int sum,r,temp;
 temp = arm;
 for(int i=0;i<3;i++)begin
 r = arm % 10;
 sum = (r ** 3)+sum;
 arm = arm / 10;
end

 if(temp == sum)
 $display("armstrong number = %d",temp);
 else
 $display("not a armstrong number = %d",temp);
 endfunction
endclass
module ram();
 packet pkt;
 initial begin
 pkt=new();
 repeat(5)begin
 pkt.randomize();
 end
end
endmodule
*/
//-----------------Palindrome --------------------------------------------//

/*

class packet;
 rand int poli;
 constraint cons {poli inside {454,343,678,756,777};}
 function void post_randomize();
 int r,sum,temp;
 temp = poli;
 for (int i=0; i<3; i++)begin
 r = poli % 10;
 sum = (sum *10) + r;
 poli = poli / 10;
 end
 if(temp == sum)
 $display("its a polidrome = %d",temp);
 else
 $display("its not a polidrome = %d",temp);
 endfunction
endclass
module ram();
 packet pkt;
 initial begin
 pkt=new();
 repeat(5)begin
 pkt.randomize();
 end
end
endmodule 
*/




 //Write a constraint for two random variables such that one variable does not match the other, and five bits are toggled.
/*
class packet ;
 rand bit [9:0] var_1;
 rand bit [9:0] var_2;
 constraint cons {
 var_1 != var_2;
 $countones(var_1) == 5;
 $countones(var_2) == 5;
 }
constraint toggle {foreach (var_1[i])
 if(i>0 && var_1[i]==1)
 var_1[i] != var_1[i-1];
 foreach (var_2[j])
 if(j>0 && var_2[j]==1)
 var_2[j] != var_2[j-1];}

endclass

module ram();
 packet pkt;
 initial begin
 pkt=new;
 repeat(4)begin
 pkt.randomize();
 $display("(var1)%b != (var2)%b",pkt.var_1,pkt.var_2);
 end
end
endmodule

*/

//Write a constraint such that the sum of any three consecutive elements in an array even

/*
class packet;
rand bit[7:0] even[10];
 constraint cons {foreach (even[i])
 if(i<7)
 ((even[i]+even[i+1]+even[i+2]) % 2)==0;}
endclass
module ram();
 packet pkt;
 initial begin
 pkt=new;
 repeat(4)begin
 pkt.randomize();
 $display("even = %p",pkt.even);
 end
end
endmodule 
*/

//Write a constraint for a variable such that the number of ones depends on the value of another variable

/*
class packet ;
 rand bit [7:0]a;
 rand int num_ones;
 constraint cons_1 {$countones(a)==num_ones;}
endclass 
module ram();
 packet pkt;
 initial begin
 pkt=new();
 repeat(5)begin
 pkt.randomize();
 $display("a=%b,number_of ones=%0d",pkt.a,pkt.num_ones);
 end
end
endmodule

*/

// Write a constraint to generate a 32-bit number with exactly one bit high using $onehot(). //

/*
class packet;
parent_trans trans_h;

rand int data;

constraint cons {$onehot(data);}

endclass


packet pkt;

module test;
initial
	begin
		pkt=new();
		assert (pkt.randomize());
parent_trans trans_h;
		$display("%b",pkt.data);
		

	end

endmodule
*/

//--------Write a constraint so that the elements in two queues are different----------------------------//

/*
class packet;

rand int q1[$];
rand int q2[$];

//constraint c1{ q1.size inside{[1:10]};
//	      q2.size inside{[1:10]};}
constraint c1{ q1.size==5;
            q2.size ==5;}
constraint cons {foreach(q1[i]) q1[i] inside {[1:100]};
		foreach(q2[i]) q2[i] inside {[1:100]};
		foreach(q1[i])!(q2[i] inside {q1});}

endclass
packet pkt;
module test;
initial
        begin
                pkt=new();
                assert (pkt.randomize());
                $display("q1=%p,q2=%p",pkt.q1,pkt.q2);
        end

endmodule

*/


//------------ Write a constraint to generate a 10-bit variable with alternating values (e.g.1010101010).
/*
class packet;

rand int a[10];
constraint cns_1{foreach(a[i])
		if(i%2==0)
		a[i]==1;
		else
		a[i]==0;}


endclass

module test;
packet pkt;
 initial begin
 pkt=new();
 pkt.randomize();
 $display("data=%0p",pkt.a);
 
end
endmodule
*/
//parent_trans trans_h;




//Write a constraint to generate even numbers between 10 to 30 using a fixed-size array,dynamic array, and queue. 

/*

class packet;
	rand int fixed[10];// fixed array
	rand int dyn[];
	rand int q[$];

	constraint cons { q.size==10;
			   dyn.size==10;
			   foreach (fixed[i]) fixed[i] inside{[10:30]} && fixed[i]%2==0;
			   foreach(dyn[i]) dyn[i] inside {[10:30]} && dyn[i]%2==0;
			   foreach(q[i]) q[i] inside {[10:30]} && q[i]%2==0;
				}

endclass

module ram();
 packet pkt;
 initial begin
 pkt=new();
 repeat(2)begin                                                                                                                                                                                    
 pkt.randomize();
 $display("fixed=%p,dyn=%p,q=%p",pkt.fixed,pkt.dyn,pkt.q);
 end
end
endmodule
*/


//----- Write a constraint to randomly generate 10 unique numbers between 99 and 100------------------------//

/*class packet;

rand int a;
real b;
constraint cons{a inside{[990:1000]};}
		//unique{a};}
function void post_randomize();

b=a/10.0;
$display("real=%f",b);

endfunction
endclass
packet pkt;
module test;
initial
	begin
	pkt=new();
	repeat(5)
	begin
	assert(pkt.randomize());
	end
	end

endmodule*/

//- Write a constraint on a two-dimensional array to generate even numbers in the first 4 locations and odd numbers in the next 4 locations. 

/*class packet;

rand bit[3:0]a[2][4];
constraint cons{foreach(a[i])
		foreach(a[i][j]) 
///Row 0--> a[0][0] ,a[0][1],a[0][2],a[0][3];
//Row 1--> a[1][0],a[1][1],a[1][2], a[1][3]; 
		if(i==0)// it will check Row 0
		a[i][j]%2==0; // a[0][0]%2==0; [j] is just checking which column you are checking --> 8%2==0  
													//5%2==1
				//a[0][1]%2==0;
				//a[0][2]%2==0;
				//a[0][3]%2==0;
		else
		a[i][j]%2==1;}
endclass
packet pkt;

parent_trans trans_h;
module test;
initial
	begin
	pkt=new();
	assert (pkt.randomize());
	$display("%p",pkt.a);
	end


endmodule
*/


//------------  Write a code to generate a random number between 1.35 and 2.57//
/*class packet;
rand int a;
real b;

constraint c1{ a inside{[1350:2570]};}
function void post_randomize();
	b=a/1000.0;
	$display("%f",b);

endfunction
endclass 
packet pkt;
module test;
	initial
		begin
		pkt=new();
		repeat(5)
		begin
		pkt.randomize();
		end
		
		end
endmodule

*/


//----------------Write a constraint to generate the pattern 1122334455.--------//

/*
class packet;
	rand int a[10];
	constraint c1{ foreach(a[i])
		//	if(i%2==0)
			  a[i]==(i+2)/2;}


endclass

packet pkt;
module test;
initial
	begin
		pkt=new();
		pkt.randomize();
		$display("%0p",pkt.a);
	end

endmodule


*/
//-------------Write a constraint to generate the pattern 5 -10 15 -20 25 -30.---------//

/*
class packet;

rand int a[10];
constraint cons{foreach(a[i])
		if(i%2==0)
		a[i]==5+(i*5);
		else
		a[i]==-5*(i+1);}

endclass


packet pkt;
module test;
initial
	begin
		pkt=new();
		pkt.randomize();
		$display("%p",pkt.a);
	end

endmodule
parent_trans trans_h;
 */


//------------- Write a constraint to generate the pattern 9 19 29 39 49 59 69 79---//
/*
class packet;

rand int a[10];
constraint cons{foreach(a[i])
		a[i]==9+(i*10);}

endclass

packet pkt;

module test;
initial
	begin
	pkt=new();
	pkt.randomize();
	$display("%p",pkt.a);
	end

endmodule

*/


//------------------------ . Write a constraint to generate the pattern 1234554321------------------------//
/*
class packet;
rand int a[10];
constraint cons{foreach(a[i])
		if(i<5)
		a[i]==i+1;
		else
		a[i]==a[9-i];}
endclass
packet pkt;

module test;
initial
	begin
		pkt=new();
		pkt.randomize();
		$display("%p",pkt.a);
	end
endmodule
*/


//------------------------Write a constraint to generate the pattern 0101010101.---------------------// 
/*class packet;
rand int a[10];
constraint cons{foreach(a[i])	
	
		a[i]==(i+2)/2;}

endclass
packet pkt;

module test;
initial
	begin
	pkt=new();
	pkt.randomize();
	$display("%p",pkt.a);

	end
endmodule
*/

//------------------------. Write a constraint for generating a Gray code sequence of 5 bits---//
/*

class packet;
 rand bit [4:0] gray [];
 constraint cons {gray.size == 32;}
 constraint conss {foreach (gray[i])
 if (i> 0)
 $countones(gray[i] ^ gray[i-1]) ==1;
 }
endclass
module ram();
 packet pkt;
 initial begin
 pkt = new();
 if (pkt.randomize()) begin
 $display("Gray Code Sequence:");
 foreach(pkt.gray[i])
 $display("gray[%0d] = %05b", i, pkt.gray[i]);
 end else
 $display("Randomization failed!");
 end
endmodule 

*/
//-------------------Generate Factorial of 5 even numbers and 5 odd numbers---//
/*
class packet;

rand int a[];
rand int b[];
constraint even{a.size==5;
		foreach(a[i])
		a[i]==fact((i+1)*2);}
constraint odd{b.size==5;
		foreach(b[i])
		b[i]==fact(((i+1)*2)-1);}

function int fact(int c);
	if(c==0)
	fact=1;
	else
	fact=c*fact(c-1);
endfunction
endclass

packet pkt;

module test;
initial
	begin
		pkt=new();
		pkt.randomize();
		foreach(pkt.a[i])
			$display("a[%0d]=%0d",i,pkt.a[i]);
	
		foreach(pkt.b[i])
			$display("b[%0d]=%0d",i,pkt.b[i]);
	end


endmodule
*/




//- Explain how an automatic keyword works in recursive fuynction with an example ------------//
/*


module top;
function automatic logic [8191:1]factorial(int unsigned a);
 if(a==0)
        factorial=1;
else
factorial=a*factorial(a-1);
$display("factorial =%od",a,factorial);
endfunction
initial
	begin
	factorial(10);

	end
endmodule
  */

//----Write an SV  constraint to randomize a varible of 32 bit "var1".Every 4th time when the variable is randomized, the value should be randoimized 100.
/*

module top;

class test;

  rand bit [31:0] var1;

endclass

test t1;

initial begin
  t1 = new();

  for(int i=1; i<=10; i++) begin
    if(i%4==0)
      assert(t1.randomize() with {var1==100;});
   else
      assert(t1.randomize());

    $display("var1 = %0d", t1.var1);
  end

end
endmodule 


*/


 // constraint to generate the following pattern 0,2,1,3,4,6,5,7,8 //




/*
module test;
class transaction;
        rand int a[9];
        constraint c1{foreach(a[i]){
                                if(i==0||i==3||i==4||i==7||i==8)
                                        a[i]==i;
                                else if (i==1 || i==5)
                                        a[i]==i+1;
                                else    
                                        a[i]==i-1;}}
endclass

transaction t1;
        initial
                begin
                        t1=new();
                        t1.randomize();
                        $display("%p",t1);
parent_trans trans_h;
                end
endmodule
*/
/////////////////////31         ascending/decending order
/*
module test12;
class gen;
rand int a[];
rand int b[];
constraint c1{a.size inside{[5:10]};  foreach(a[i]) a[i] inside {[1:100]};}
constraint c2{foreach(a[i])
                if(i!=a.size-1)
                         a[i]<a[i+1];}
constraint c4{b.size inside{[5:10]};  foreach(b[j]) b[j] inside {[1:100]};}

constraint c3{foreach(b[j])
                                if(j!=b.size-1)
                                b[j]>b[j+1];}


endclass
initial begin
        gen h=new;
        //repeat(5) begin
        h.randomize();
        //foreach(h.a[i])
                $display("Ascend value: %p",h.a);
        //foreach(h.b[i])
        $display("Decend value: %p",h.b);

        //end
end
endmodule


*/




//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//122122122122
/*class packet;

rand int a[15];
constraint c1{ foreach(a[i])  
		  if( i%3==0)
                a[i]==0;
        else
                a[i]==i;
                }
endclass
module test;
packet pkt;

initial
        begin
        pkt=new();
        pkt.randomize();
        $display("%p",pkt.a);


        end

endmodule
*/


// First row should be even numbers 
// second row should be divisible by 5
// third row should be divisible by 3

/*
class array_2d;

  rand bit[7:0] a[3][4];

  constraint c1 {


    // Row 0 → Even numbers
    foreach (arr[0][j])
      arr[0][j] % 2 == 0;

    // Row 1 → Divisible by 5
    foreach (arr[1][j])
      arr[1][j] % 5 == 0;

    // Row 2 → Perfect squares
    foreach (arr[2][j])
      arr[2][j] inside {1,4,9,16,25,36,49,64,81,100};

    // All elements unique
    unique {arr};
  }
*/


/*
constraint cons{ foreach(a[i])
		foreach(a[i,j])
		if(i==0)
		a[i][j]%2==0;

		else if(i==1)
		a[i][j]%5==0;

		else if(i==2)
		a[i][j] inside {1,4,9,16,25,36,49,64,81};

		unique {a};
		} 
endclass

module test;

  array_2d h1;

parent_trans trans_h;
  initial begin

    h1 = new();

    if (h1.randomize()) begin
      $display("Randomization Successful");

      // Correct printing
      $display("%p", h1.arr);

    end else begin
      $display("Randomization Failed");
    end

  end

endmodule

*/

//--------------------------------------------------------------------------------------------------------//

// First row should be odd only
// Second row should be multiple of 7
// Thirf row should be multiples of 3

/*

class packet;
rand bit[7:0] a[3][3];
constraint cons{ foreach(a[i])
		foreach(a[i,j])
		if(i==0)
		a[i][j]%2==1; // odd numbers 
		
		else if(i==1) 
		a[i][j]%7==0;
		
		else if(i==2)
parent_trans trans_h;
		a[i][j]%3==0;
		}
			
endclass

module test;
  packet pkt;
  initial 
	begin
    pkt = new();

/*    if (pkt.randomize())
	begin

	foreach (pkt.a[i]) 
	begin
  	$write("Row %0d: ", i);

  	foreach (pkt.a[i][j])
parent_trans trans_h;
	 begin
    	$write("%0d ", pkt.a[i][j]); // no newline
  	end

  $display(); // newline after each row
end
end
end
*/

/*
if (pkt.randomize()) begin
      $display("Randomization Successful");

      // Correct printing
      $display("%p", pkt.a);

    end else begin
      $display("Randomization Failed");
    end

  end

endmodule		
*/



// ---------------------------------------------------------------------------------------------------------------------------------------------//





//Write a constrtaint to generate 10 elements in an arry based on the following conditions
// I. Elements should be in odd only
//II. First indexed should be 125
//III.Every even indexed should be mutiples of 7.


/*
class packet;

  rand bit[7:0] a[10];

  constraint cons {

    foreach (a[i]) {

      // I. All elements should be odd
      a[i] % 2 == 1;

      // II. First index should be 125
      if (i == 0)
        a[i] == 125;

      // III. Even index → multiples of 7 (and already odd)
      else if (i % 2 == 0)
        a[i] % 7 == 0;
    }
  }

endclass
module test;
packet pkt;
initial
	begin
	pkt=new();
	if(pkt.randomize())
	begin
	$display("%p",pkt.a);
	end
	else
	begin
		$display("Randomization failure");
	end
	end


endmodule
*/

//---------------------------------------------------------------------------------------------------------------------------------------------//


//1.Write a constraint that generates odd numbers within 0 to 30.
/*
class packet ;
rand bit[3:0] a;
constraint c1{ a%2==1; a inside {[0:30]};}

endclass
packet pkt;
module test;
 initial
parent_trans trans_h;
	begin
	repeat(30)
		begin
	pkt=new();
	pkt.randomize();
	$display("%p",pkt.a);
	end
end

endmodule

*/

//---------------------------------------------------------------------------------------------------------------//
//Write a constraint to generate a pattern 9753186420.

/*
class packet;

rand int a[10];
constraint c1{ foreach(a[i])
		if(i<5)
		a[i]==10-(i+(i+1));
		else
		a[i]==18-(i*2);
		}
endclass

module test;
packet pkt;
initial
        begin
 //       repeat(30)
    //            begin
        pkt=new();
        pkt.randomize();
        $display("%p",pkt.a);
   //     end
end



endmodule


*/

/////////////---------------------------------------------------------------------------------------////


// Pattern for 0,1,0,1,0,1,0

/*
class constraint_5;
rand int da[];
constraint c1{da.size == 10;}
constraint c2{foreach(da[i])
da[i] == i%2;}

endclass
constraint_5 c1;
module test();
initial
begin
c1 = new;
assert(c1.randomize());
$display("da: %p",c1.da);
parent_trans trans_h;
end
endmodule



*/



//-------------------------------------------------------------------------------------------------//

//Write a constraint to generate a pattern 1010101010
/*class constraint_5;
rand int a[10];

constraint c1{foreach(a[i])
	if(i%2==0)
		a[i]==1;
	else
parent_trans trans_h;
		a[i]==0;}
endclass
constraint_5 c1;

module test();
initial
begin
c1 = new;
assert(c1.randomize());
$display("da: %p",c1.a);
end
endmodule

*/




//---------------------------------------------------------------------------------------------------------------//
//parent_trans trans_h;
// Write a constraint to generate a pattern 2, 3, 5,6, 8, 9, 11, 12, 14, 15
/*class constraint_5;
rand int a[10];

constraint c1{foreach(a[i])
        if(i==0)
		a[i]==2;
        else if(i==1)
                a[i]==3;
	else if(i%2==0)
		a[i]==a[i-2]+3;
	else if(i%2==1)
		a[i]==a[i-2]+3;
}
endclass
constraint_5 c1;

module test();
initial
parent_trans trans_h;
begin
c1 = new;
assert(c1.randomize());
$display("da: %p",c1.a);
end
endmodule
*/



//----------------------------------------------------------//




//Write a constraint to generate a pattern 0, 0, 1,1, 2, 4, 7, 13, 24, 44, 81, 149, 274, 504, 927
/*
class packet;

rand int a[15];
constraint c1{ foreach(a[i])
		if(i<2)
		a[i]==0;
		else if (i==2)
		a[i]==1;
		else
		a[i]==a[i-3]+a[i-2]+a[i-1];}


endclass
module test;
packet pkt;

initial
	begin
	pkt=new();
	pkt.randomize();
	$display("%p",pkt.a);


	end


endmodule

*/

//----------------------------------------------------------------------//

//0,1,2,0,4,5,0,7,8,0
/*
class packet;

rand int a[15];
constraint c1{ foreach(a[i])	if( i%3==0)
		a[i]==0;
	else
		a[i]==i;
		}
endclass
module test;
packet pkt;

initial
        begin
        pkt=new();
        pkt.randomize();
        $display("%p",pkt.a);


        end


endmodule
*/
//parent_trans trans_h;
// 1,2,2,1,2,2,1,2,2
/*class packet;
rand int a[15];
constraint c1{ foreach(a[i])
	    if(i%3==0)
                a[i]==1;
        else
                a[i]==2;
                }
endclass
module test;
packet pkt;

initial
        begin
        pkt=new();
        pkt.randomize();
        $display("%p",pkt.a);

parent_trans trans_h;

        end

endmodule
*/



//--------------------------------------------------------------------------------------------------------------------------//

//packet size is 64 to 1500  and mutiples of 4

/*

class trans;
 rand int a;
int q[$];
        constraint cons { a inside {[64:1500]};
                                a%4==0;
                        }
function void  post_randomize();

q.push_back(a);
$display("%d",a);
endfunction

endclass
module test;

trans t1;

initial
	begin

	t1=new();
	repeat(5)
	begin
	t1.randomize();
	end
parent_trans trans_h;
	end

endmodule 

*/
//---------------------------------------------------------------------------------------------------------------//

//2,33,222,5555,22222,777777,2222222,999999999.......
/*
class packet_trans;

rand int a[];

constraint cons{a.size==30;}
constraint c2{foreach(a[i])
	if(i%2==0)
	a[i]==2;
	else
	a[i]==i+2;}
parent_trans trans_h;

 function void display();
foreach(a[i])
	begin
	repeat(i+1) begin
	$write("%0p",a[i]);
	end
	$write(",");
	end

endfunction

endclass

module test;

packet_trans h1;
initial
	begin
parent_trans trans_h;
		h1=new();
		h1.randomize();
		h1.display();

	end


endmodule

*/
//-------------------------------------------------------------------------------------------------------------------------//

// 1,22,333,4444,55555,666666,7777777,88888888.....
/*

class packet_trans;

rand int a[];
constraint cons{a.size==10;
		foreach(a[i])
		a[i]==i+1;}

function void display();
	foreach(a[i])
		begin
		repeat(i+1)
		begin
		$write("%0p",a[i]);
		end
		$write(",");
		end

endfunction
endclass

module test;
	packet_trans trans_h;
	initial
		begin
			trans_h=new();
			trans_h.randomize();
			trans_h.display();

parent_trans trans_h;
		end



endmodule

*/

//-----------------------------------------------------------------------------------------------------------------------------------//


//amstrong number;
/*
module test;
class abc;
parent_trans trans_h;
rand int num;
int a,b,c,d;

constraint c2{num inside{[100:500]};}
function void display();

a=(num%10);// unit place
b=(num/10)%10;// Tens place
c=(num/100);// 100's place
d=(a*a*a)+(b*b*b)+(c*c*c);// d=a**3+b**3+c**3;

if(num==d)
$display("armstrong number=%0p",d);

else
$display("it is not armstrong number=%0p",d);
endfunction
endclass

abc a_b;
initial begin
a_b=new;
repeat(500)begin
parent_trans trans_h;
a_b.randomize();
a_b.display();
end
end
endmodule

*/

//-----------------------------------------------------------------------------------------------------------------------//
// palindrome
/*class parent_trans;

rand int num;
int a,b,c,d;
constraint cons{num inside {[100:500]};}
constraint cons_1{
			num%10==num/100;}// Last digit ==First digit // --->  ex: 141 --> last digit is 1 and first digit is 1

	function void display();
parent_trans trans_h;
		$display("Polindrome number =%d",num);

	endfunction
endclass

module test;
parent_trans trans_h;
	
initial
	begin
	trans_h=new();
	repeat(5)
	begin
	trans_h.randomize();
	trans_h.display();
	end

	end

endmodule
*/

//--------------------------------------------------------------------------------------------------------------------------//

