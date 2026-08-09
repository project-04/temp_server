/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename		: 	ram_test.sv

Description 	: 	Test case for Dual port RAM
  
Author Name		: 	Shanthi V A

Support e-mail	: 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

************************************************************************/
//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

// Extend ram_base_test from uvm_test;
class ram_base_test extends uvm_test;

   	// Factory Registration
	`uvm_component_utils(ram_base_test)
  
   	// Declare the ram_env handle
   	ram_env envh;
	ram_config tb_cfg;

	//Declare a variable no_of agents of int data type & initialize it to 3
    	int no_of_agents = 3;

	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
	extern function new(string name = "ram_base_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	
 endclass
//-----------------  constructor new method  -------------------//
// Define Constructor new() function
function ram_base_test::new(string name = "ram_base_test" , uvm_component parent);
	super.new(name,parent);
endfunction

//-----------------  build() phase method  -------------------//
function void ram_base_test::build_phase(uvm_phase phase);
	//tb_cfg = ram_config::type_id::create("tb_cfg");
	//uvm_config_db #(ram_config)::set(this, "*", "ram_config", tb_cfg);
	
    	// set the no_of_agents into UVM config DB  "int"
    	uvm_config_db #(int)::set(this, "envh.agent_top_h", "int", no_of_agents);
	
    	super.build_phase(phase);
	// create the instance for env
	envh = ram_env::type_id::create("envh", this);
endfunction

