/********************************************************************************************

Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.


Filename		:	test_mailbox.sv   

Description		:	Example for mailbox

Author Name		:	Putta Satish

Support e-mail  : 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

*********************************************************************************************/

module test_mailbox;

	// In class packet
	class packet;

		// Add the following rand fields 
		// addr (bit type , size 4)
		// data (bit type , size 4)
		rand bit [3:0] addr;
		rand bit [3:0] data;

		// In display function pass a string as an input argument
			// Display the input string message
			// Display the data and address
		function void display(string str);
			$display("%s",str);
			$display("addr=%d, data=%d\n", addr, data);
		endfunction
		
		// In post_randomize method call display method 
		// and pass the string argument as "randomized data"
		function void post_randomize;
			display("Randomized Data");
		endfunction
	endclass

	// In class generator 
	class generator;

		// Declare a handle of packet class	
		// Declare the mailbox parameterized by type class packet 
		packet packet_h;
		mailbox #(packet) gen2drv;
		
		// In constructor
			// Pass the mailbox parameterized by packet as an argument of the constructor
			// Assign the mailbox handle argument to the local mailbox handle of generator
		function new(mailbox #(packet) gen2drv);
			this.gen2drv = gen2drv;
		endfunction

		// In task start, within fork - join_none,
		// create 10 random packets 	
		// Randomize each packet using assert & randomize method
		// Put the generated random packets into the mailbox
		task start;
		fork
			repeat(5)
			begin
				packet_h = new;
				assert(packet_h.randomize());
				gen2drv.put(packet_h);
			end
		join_none
		endtask
	endclass

	// In class driver
		class driver;

		// Declare a handle of packet class
		// Declare a mailbox parameterized by type class packet
		packet packet_h;
		mailbox #(packet) gen2drv;

		// In constructor
			// Pass the mailbox parameterized by packet as an argument
			// Assign the mailbox handle argument to local mailbox handle of driver
		function new (mailbox #(packet) gen2drv);
			this.gen2drv = gen2drv;
		endfunction

		// In task start, within fork - join_none,
		// Get the 10 generated random packets from the mailbox 
		// Use display method in the packet class to display the received data
		task start;
		fork
			repeat(5)
			begin
			//	packet_h = new;
				gen2drv.get(packet_h);
				packet_h.display("Recived Data");
			end
		join_none
		endtask
	endclass

	// In class env
	class env;
		
		// Create the mailbox instance parameterized by packet
		// Declare handles of generator and driver 
		mailbox #(packet) gen2drv = new;
		generator gen_h;
		driver drv_h;

		// In build function
			// Create instance of generator and driver by passing mailbox as an input argument
		function void build;
			gen_h = new(gen2drv);
			drv_h = new(gen2drv);
		endfunction

		// In task start
			// call start task of generator and driver
		task start;
			gen_h.start;
			drv_h.start;
		endtask
	endclass

	env env_h;

	// Within initial block
	initial begin

		// Create an instance of env
		// Call build and start task of env
		env_h = new;
		env_h.build;
		env_h.start;
	end
endmodule
