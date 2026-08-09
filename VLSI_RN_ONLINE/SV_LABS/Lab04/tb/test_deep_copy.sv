/********************************************************************************************

Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename		:	test_deep_copy.sv   

Description		:	Example for Shallow and Deep Copy

Author Name		:	Putta Satish

Support e-mail  : 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

*********************************************************************************************/

module test_deep_copy;

	// In class parity_calc_c
	class parity_calc_c;
		// Declare parity (bit type, size 8), initialize it with some random value
		//bit [7:0] parity = {$random}%500;
		bit [7:0] parity = 8'd200;
		// Write copy method that returns parity_calc_c class type
		function parity_calc_c copy();
			// Create copy instance
			copy = new();
			// Copy all the current properties into copy object
			copy.parity = this.parity;
		endfunction
	endclass: parity_calc_c

	// In class packet_c
	class packet_c;
		
		// Declare header (bit type , size 8), initialize it with some random value
		bit [7:0] header = 8'd100;
		// Declare data (bit type , size 8), initialize it with some random value
		bit [7:0] data = 8'd50;
		// Declare and create an instance of parity_calc_c
		parity_calc_c par = new();
		// Define copy method that returns packet_c class type
		function packet_c copy();
			// Create copy instance
			copy = new();
			// Copy all the current class properties into copy object
			copy.header = this.header;
			copy.data   = this.data;
			copy.par    = this.par.copy();
		endfunction

	endclass: packet_c

	// Declare 2 handles pkt_h1 & pkt_h2 for packet_c class 
	packet_c pkt_h1, pkt_h2;

	// Within initial
	initial begin
		// Create pkt_h1 object
		pkt_h1 = new();
		// Use shallow copy method to copy pkt_h1 to pkt_h2 
		pkt_h2 = new pkt_h1;
		$display("created a pkt_h1, pkt_h2 handles for packet_c. and new addres for pkt_h1 and shallow copy to pkt_h2 = pkt_h1"); 
		// Display the properties of parent class and sub class properties of pkt_h1 and pkt_h2
		$display("pkt_h1 = %p | pkt_h1.par = %p", pkt_h1, pkt_h1.par);
		$display("pkt_h2 = %p | pkt_h2.par = %p\n", pkt_h2, pkt_h2.par);

		// Assign random value to the header of pkt_h2
		pkt_h2.header = 8'd30;
		$display("assign 30 to the pkt_h2.header");
		// Display the properties of parent class and sub-class properties of pkt_h1 and pkt_h2
		// observe pkt_h1.header does not change
		$display("pkt_h1 = %p | pkt_h1.par = %p", pkt_h1, pkt_h1.par);
		$display("pkt_h2 = %p | pkt_h2.par = %p\n", pkt_h2, pkt_h2.par);

		// Change parity of pkt_h2 using subclass handle from the parent class packet_c
		// Ex: pkt_h2.par.parity=19;
		pkt_h2.par.parity = 8'd19;
		$display("assign 19 to the pkt_h2.par.parity");
		// Display the properties of parent class and sub-class properties of pkt_h1 and pkt_h2
		// observe that change reflected in pkt_h1 as the subclass handle in pkt_h1 and pkt_h2 are pointing to same subclass object
		$display("pkt_h1 = %p | pkt_h1.par = %p", pkt_h1, pkt_h1.par);
		$display("pkt_h2 = %p | pkt_h2.par = %p\n", pkt_h2, pkt_h2.par);

		// Perform deep copy by calling parent class copy method
		// Ex: pkt_h2=pkt_h1.copy;
		pkt_h2 = pkt_h1.copy;
		$display("deep copy pkt_h2 = pkt_h1.copy");
		// Display the properties of parent class and sub-class properties of pkt_h1 and pkt_h2
		// observe the parent and subclass properties
		$display("pkt_h1 = %p | pkt_h1.par = %p", pkt_h1, pkt_h1.par);
		$display("pkt_h2 = %p | pkt_h2.par = %p\n", pkt_h2, pkt_h2.par);

		// Change parity of pkt_h2
		// Ex: pkt_h2.par.parity=210;
		pkt_h2.par.parity = 8'd210;
		$display("assign 210 to the pkt_h2.par.parity");
		// Display the properties of parent class and sub-class properties of pkt_h1 and pkt_h2
		// observe that parity doesnot change for pkt_h1 as they are two different subclass objects
		$display("pkt_h1 = %p | pkt_h1.par = %p", pkt_h1, pkt_h1.par);
		$display("pkt_h2 = %p | pkt_h2.par = %p\n", pkt_h2, pkt_h2.par);
	end
endmodule
