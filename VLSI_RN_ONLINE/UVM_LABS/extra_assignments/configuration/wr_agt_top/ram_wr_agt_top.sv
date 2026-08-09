/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename		:  	ram_wr_agt_top.sv

Description 	: 	Write agent top class for Dual port RAM TB
  
Author Name		:   Shanthi V A

Support e-mail	: 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

************************************************************************/
//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

// Extend ram_wr_agt_top from uvm_env;
class ram_wr_agt_top extends uvm_env;

   	// Factory Registration
	`uvm_component_utils(ram_wr_agt_top)

	// Declare a variable no_of_agents of int data type to get the configuration
    	int no_of_agents;

   	// Declare the dynamic array of agent handles
   	ram_wr_agent agnth[];

	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
	extern function new(string name = "ram_wr_agt_top" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass
//-----------------  constructor new method  -------------------//
// Define Constructor new() function
function ram_wr_agt_top::new(string name = "ram_wr_agt_top" , uvm_component parent);
	super.new(name,parent);
endfunction

    
//-----------------  build() phase method  -------------------//
function void ram_wr_agt_top::build_phase(uvm_phase phase);
	//Get the configuration from the config_db "int"
	super.build_phase(phase);
	if(!uvm_config_db #(int)::get(this, "", "int", no_of_agents))
		`uvm_fatal("no_of_agents", "cannot get the no_of_agents form int");

	// Give the size for the agnth array as equal to no_of_agents
	agnth = new[no_of_agents];

        // Create the instance of ram_wr_agent within foreach loop
	foreach(agnth[i])
		agnth[i] = ram_wr_agent::type_id::create($sformatf("agnth[%0d]",i), this);

	//set first two agents as active & third agent as passive in to config data base "bit"
	for(int i=0;i<2;i++)
		uvm_config_db #(bit)::set(this,$sformatf("agnth[%0d]",i),"bit",1);
	uvm_config_db #(bit)::set(this,"agnth[2]","bit",0);
	
endfunction


//-----------------  run() phase method  -------------------//
// Print the topology
task ram_wr_agt_top::run_phase(uvm_phase phase);
	uvm_top.print_topology;
endtask   
