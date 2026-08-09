/***********************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename		:   top.sv

Description 	: 	Top Module
  
Author Name		:   Putta Satish

Support e-mail	: 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

************************************************************************/

module top;

	import uvm_pkg::*;

	// import the  ram_pkg
    	import ram_pkg::*;

        
	// Declare handle for write_xtn as wr_xtnh	
	write_xtn wr_xtnh;
	
	// Add build method
	function void build();
		  // Create an instance of wr_xtnh using factory create()
		  // Randomize and print the transactions
		  wr_xtnh = write_xtn::type_id::create("wr_xtnh");
		  assert(wr_xtnh.randomize());
		  wr_xtnh.print(uvm_default_table_printer);
	endfunction
  
	// Within initial 

	initial
	    begin
	    		  //wr_xtnh = write_xtn::type_id::create("wr_xtnh");
			// Call build function 5 times (Without Overriding)
        	repeat(5) build();
			//call factory overriding method
				//Hint : Use factory.set_type_override_by_type Override 
			// Call build function 5 times 
        	//factory.set_type_override_by_type(write_xtn::get_type, short_xtn::get_type, 0);
        	factory.set_type_override_by_name("write_xtn","short_xtn",0);
		factory.set_inst_override_by_type(write_xtn::get_type, long_xtn::get_type, "wr_xtnh");
		
		repeat(5) build();

		//factory.set_type_override_by_type(write_xtn::get_type, long_xtn::get_type, 1);  //1 means override happens to long_xtn,
												//0 means override not happen and it remain same as short_xtn.
															
															
		factory.set_type_override_by_name("write_xtn","long_xtn",0);
		
		repeat(5) build();
		
		
		$display("%p",wr_xtnh.get_type);
		$display("%d",wr_xtnh.get_inst_id);
		$display("%p",wr_xtnh.get_object_type);
		$display("%d",wr_xtnh.get_inst_count);
		$display("%s",wr_xtnh.get_name);
		$display("%s",wr_xtnh.get_full_name); //path
		wr_xtnh.set_name("hehehe");
		$display("%s",wr_xtnh.get_name);
		
/*
'{type_name:"write_xtn", me:{ ref to class uvm_object_registry#(ram_pkg::write_xtn,"write_xtn")}, Tname:"write_xtn"}
        512
'{type_name:"long_xtn", me:{ ref to class uvm_object_registry#(ram_pkg::long_xtn,"long_xtn")}, Tname:"long_xtn"}
        515
wr_xtnh
wr_xtnh
hehehe
*/
      	end
endmodule
