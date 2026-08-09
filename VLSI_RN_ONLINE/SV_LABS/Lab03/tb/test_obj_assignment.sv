/********************************************************************************************

Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename		:	test_obj_assignment.sv   

Description		:	Example for class and handles

Author Name		:	Putta Satish

Support e-mail  : 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

*********************************************************************************************/


module test_obj_assignment;


	// Declare class packet
	class packet;

		// Within the class packet
		// Declare the below class properties
		// data (bit type, size 4)
		// addr (bit type, size 16) 
		// mem  (bit type, size 16)
		bit [3:0] data;
		bit [15:0] addr;
		bit [15:0] mem;

	endclass: packet
	
	// Declare two handles for the packet class "pkt_h1" and "pkt_h2"
	packet pkt_h1,pkt_h2;

	// Within initial block
	initial begin
		// Construct pkt_h1 object
		pkt_h1 = new();

		$display("handler address pkt_h1 %d",pkt_h1);
		$display("handler address pkt_h2 %d",pkt_h2);

		// Assign random values to the addr, data and mem of pkt_h1 object
		pkt_h1.data = 4'd8;
		pkt_h1.addr = 16'd1024;
		pkt_h1.mem = 16'd2048;

		// Display the object pkt_h1
		$display("\npkt_h1 = %p", pkt_h1);
		$display("pkt_h2 = %p", pkt_h2);

		// Assign pkt_h1 to pkt_h2
		pkt_h2 = pkt_h1;

		$display("\nAfter assigning one object to the other,");
		$display("pkt_h1 %p",pkt_h1);
		$display("pkt_h2 %p",pkt_h2);

		// Display the objects pkt_h1 & pkt_h2		
		// Make changes to address and data using handle pkt_h2
		pkt_h2.addr = 16'd512;
		pkt_h2.data = 4'd4;

		$display("\nAfter changing the values of properties with one handle,");
		
		// Display the object pkt_h1 & pkt_h2
		$display("pkt_h1.data=%d, pkt_h1.addr=%d, pkt_h1.mem=%d",pkt_h1.data, pkt_h1.addr, pkt_h1.mem);
		$display("pkt_h2.data=%d, pkt_h2.addr=%d, pkt_h2.mem=%d\n",pkt_h2.data, pkt_h2.addr, pkt_h2.mem);
	
		
		
		$display("handler address pkt_h1 %d",pkt_h1);
		$display("handler address pkt_h2 %d",pkt_h2);

		// observe that pkth1 and pkth2 will display the same contents because,
		// both the handles point to the same object
end	
endmodule
