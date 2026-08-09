/********************************************************************************************

Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename		:	test_semaphore.sv   

Description		:	Example for semaphore

Author Name		:	Putta Satish

Support e-mail  : 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

*********************************************************************************************/

module test_semaphore;

	// In class driver
	class driver;

		// write task send with input argument of string type
		task send(input string a);
			// Get the key using sem handle 
			sem.get(1);
			// Display the string which indicates the respective driver information
			$display($time,a);
			#10;
			// Put the key using sem handle 
			sem.put(1);
			// Display the string which indicates the respective driver information
			//$display(a);
		endtask
	endclass
	
	// Declare an array of two drivers  
	driver d[2];
	// Declare a handle for semaphore
	semaphore sem;
	// Within initial block
	initial begin
		// Create instances of drivers
		d[0] = new();
		d[1] = new();
		
		// Create the instance of semaphore handle and initialize it with 1 key
		sem = new(1); //change it to 1 & 2. And then check the output
		
		// Call send task of both drivers 5 times within fork join
		// pass any meaning full string message to indicate the driver information
		for(int i=0; i<5; i++)
		fork
			d[0].send("driver1");
			d[1].send("driver2");
		join
	end
endmodule 

