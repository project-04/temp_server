/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename		:	ram_env.sv

Description 	: 	Environment class for Dual Port RAm testbench
  
Author Name		:  Shanthi V A

Support e-mail	: 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

************************************************************************/

//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------


// Extend ram_env from uvm_env
class ram_env extends uvm_env;

   	// Factory Registration
	`uvm_component_utils(ram_env)

	// Declare the ram_wr_agt_top handle
 	ram_wr_agt_top agent_top_h;

	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
	extern function new(string name = "ram_env",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
endclass
	
//-----------------  constructor new method  -------------------//
function ram_env::new(string name="ram_env",uvm_component parent);
	super.new(name,parent);
endfunction

 //-----------------  Add UVM build() phase   -------------------//
function void ram_env::build_phase(uvm_phase phase);	
	super.build_phase(phase);
	// Create the instance of ram_wr_agt_top in the build phase
	agent_top_h = ram_wr_agt_top::type_id::create("agent_top_h", this);
endfunction
