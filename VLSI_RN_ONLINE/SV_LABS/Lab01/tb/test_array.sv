/********************************************************************************************

Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename		:	test_array.sv   

Description		:	Example for different type of Arrays

Author Name		:	Putta Satish

Support e-mail  : 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

*********************************************************************************************/

module test_array();

	// Declare a dynamic array data_da of int data type
	int data_da[];

	// Declare queues data_q & addr_q of int data type
	int data_q[$], addr_q[$];

	// Declare associative array data_mem of int data type and indexed with bit[7:0]
	int data_mem [bit[7:0]];
	
	// Declare int variable result,and and an 8 bit variable idx
	int result;
	bit [7:0] idx;

	initial
		begin

			$display("########################################################################");

	
			// Allocate 10 memory locations for dynamic array & initialize
			// all the locations with some random values less than 20 & display the array
			data_da = new[10];
			foreach(data_da[i])
				data_da[i] = {$random} % 20;
			foreach(data_da[i])	
				$display("Values in the data_da %d", data_da[i]);
			$display("Values in the data_da %p", data_da);

			// Call the array reduction method sum which returns the sum
			// of all elements of array and collect the return value to the variable result

			$display("########################################################################");

			result = data_da.sum();
			
			// Display the sum of elements, result
			$display("sum of the data_da %d", result);
	
			// Similarly explore other array reduction methods 
			// product,or,and & xor
			result = data_da.product();
			$display("product of the data_da %d", result);

			result = data_da.or();
			$display("or of the data_da %d", result);
			
			result = data_da.and();
			$display("and of the data_da %d", result);

			result = data_da.xor();
			$display("xor of the data_da %d", result);

			// Call the array reduction method sum with "with" clause which returns 
			// total number of elements satisfying the condition within the "with" clause 

			//result = data_da.sum with (bit'(item>7)); //return 0
			//result = data_da.sum with ((item>7)); //return 0
			//both are same, by default it return bit.
			result = data_da.sum with (int'(item>7));
			
			// Display the value of the result
			
			$display("no. of items greater than 7 = %0d", result);
			
			// Similarly explore other array reduction methods with "with"clause 
		
			result = data_da.sum with ((item>7)*item);
			//result = data_da.sum with (int'(item>7)*item); //both are same
			
			$display("sum of items greater than 7 = %0d", result);
			
			result = data_da.product with ((item>7)?item:1);
			
			$display("product of items greater than 7 = %0d", result);





			
	
			$display("########################################################################");

			// Sorting Methods
	
			// call all the sorting methods like reverse, sort, rsort & 
			// shuffle & display the array after execution of each method to 
			// understand the behaviour of the array methods

			data_da.reverse();
			$display("reverse of the data_da %p", data_da);

			data_da.sort();
			$display("sort of the data_da %p", data_da);

			data_da.rsort();
			$display("rsort (reverse sort) of the data_da %p", data_da);

			data_da.shuffle();
			$display("shuffle of the data_da %p", data_da);
	





			$display("########################################################################");

			// Call Array locator methods like min, max, unique,find_* with,
			// find_*_index with using dynamic array & display 
			// the contents of data_q after execution of each method to 
			// understand the behaviour of the array methods
	
			data_q = data_da.find with (item == 8);
			$display("find element 8 in the data_da = %p", data_q);

			data_q  = data_da.find_index with (item == 8);
			$display("find element 8 index in the data_da = %p", data_q);
			
			data_q = data_da.find with (item > 7);
			$display("find elements greater then 7 in the data_da = %p", data_q);

			data_q  = data_da.find_index with (item > 7);
			$display("find elements greater then 7 index in the data_da = %p", data_q);

			data_q = data_da.find_first with (item < 10);
			$display("find first elements which are less then 10 in the data_da = %p", data_q);

			data_q = data_da.find_first_index with (item < 10);
			$display("find first elements index which are less then 10 in the data_da = %p", data_q);

			data_q = data_da.find_last with (item < 10);
			$display("find last elements which are less then 10 in the data_da = %p", data_q);

			data_q  = data_da.find_last_index with (item < 10);
			$display("find last elements index which are less then 10 in the data_da = %p", data_q);

			data_q  = data_da.max();
			$display("max in the data_da = %p", data_q);

			data_q  = data_da.min();
			$display("min in the data_da = %p", data_q );
			
			data_q  = data_da.unique();
			$display("unique elements in the data_da = %p", data_q );

			data_q  = data_da.unique_index();
			$display("unique elements index in the data_da = %p", data_q );


			$display("########################################################################");

			//Generate some 10 random address less than 100 within a repeat loop 
			//push the address in to the addr_q
			repeat(10)
				addr_q.push_front({$random} % 100);


			//Display the addr_q
			$display("Values in the data_da %p", addr_q);

					
			
			// With in for loop update the associate array with random data less than 200
			// based on the address stored in addr_q
			// Hint: To get the address use pop method
			for(int i=0; i<10; i=i+1)
				data_mem[addr_q.pop_back()]= {$random} % 200;
			
			// Display the contents of associate array using foreach loop
			foreach(data_mem[i])
				$display("data_mem[%0d] = %0d", i, data_mem[i]);
			


			$display("########################################################################");
			// Display the first index of the array by using associative array method first
			if(data_mem.first(idx))
                          $display("first index in data_mem %0d",idx);

			// Display the first element of the array
    			$display("first element in data_mem %0d",data_mem[idx]);
				
			// Display the last index of the array by using associative array method last
			if(data_mem.last(idx))
                          $display("last index in data_mem %0d",idx);

			// Display the last element of the array
    			$display("last element in data_mem %0d",data_mem[idx]);

    			$display("first element in data_mem %0p",data_mem);
			$display("########################################################################");
			
			/*
			//adding elements
			int d[];
			d=new[d.size()+5] (d);

			for(int i=d.size()-5; i<=d.size(); i++)
			if(i==10) d[i]=100;
			else d[i]=(i-10+1)*100;

			$display("d = ", d);
			$display("size : %d", d.size());
			*/
		end
endmodule
	
	
	
