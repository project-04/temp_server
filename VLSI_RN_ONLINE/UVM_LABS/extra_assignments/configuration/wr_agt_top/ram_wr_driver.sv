/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename		:   ram_wr_driver.sv

Description 	:	Write Driver class for Dual port RAM TB
  
Author Name		:   Shanthi V A

Support e-mail	: 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version:	1.0

************************************************************************/

//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------


// Extend ram_wr_driver from uvm driver parameterized by write_xtn
class ram_wr_driver extends uvm_driver #(write_xtn);

   	// Factory Registration
	`uvm_component_utils(ram_wr_driver)


	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
     	
	extern function new(string name ="ram_wr_driver",uvm_component parent);
	extern task run_phase(uvm_phase phase);
	
endclass

//-----------------  constructor new method  -------------------//
// Define Constructor new() function
function ram_wr_driver::new(string name ="ram_wr_driver",uvm_component parent);
	super.new(name,parent);
endfunction


//-----------------  run() phase method  -------------------//
task ram_wr_driver::run_phase(uvm_phase phase);
   `uvm_info(get_type_name(), "This is Driver run phase", UVM_MEDIUM)
endtask
