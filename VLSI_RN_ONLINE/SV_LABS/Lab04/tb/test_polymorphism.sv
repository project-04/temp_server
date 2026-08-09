/********************************************************************************************

Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename		:	test_polymorphism.sv  

Description		:	Example for Polymorphism

Author Name		:	Putta Satish

Support e-mail  : 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

*********************************************************************************************/

module test_polymorphism;

	// In class packet_c
	class packet_c;
		// In task send
		virtual task send;
			// Display message "Sending base class packet"
			$display("\nSending  base class packet");
		endtask
	endclass

	// Extend badpacket_c from packet_c
	class badpacket_c extends packet_c;
		// Override task send
		task send;
			// Display message "Sending derived class packet"
			$display("\nSending derived class packet");
		endtask
	endclass

	packet_c p_h;
	badpacket_c c_h1, c_h2;
	// Within initial
	initial begin
		// Create instances for badpacket_c and packet_c 
		c_h1 = new();
		p_h = new();
		// Call send tasks using base and extended class handles
		p_h.send();
		// Assign extended class handle to base class handle
		p_h = c_h1;
		// Call send task using base class object
		p_h.send();




		c_h2 = c_h1; //no error
		//c_h2 = p_h;  //error
		$cast(c_h2, p_h); //no error
		c_h2.send();
		
	end
endmodule
