/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename		:	ram_env.sv

Description 	: 	Environment class for Dual Port RAm testbench
  
Author Name		:   Putta Satish

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

	// Declare the ram_wr_agent handle
 	ram_wr_agent wr_agenth;


	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
	extern function new(string name = "ram_env",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern function void end_of_elaboration_phase(uvm_phase phase);
	extern function void start_of_simulation_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern function void extract_phase(uvm_phase phase);
	extern function void check_phase(uvm_phase phase);
	extern function void report_phase(uvm_phase phase);

endclass
	
//-----------------  constructor new method  -------------------//
function ram_env::new(string name = "ram_env",uvm_component parent);
	super.new(name , parent);
endfunction

       
  
// Add UVM phases
// NOTE : Call super.*_phase() in every phase method ,* indicates build,connect,etc  
//        Print using `uvm_info("RAM_ENV","This is build phase",UVM_LOW)  in all the phases 
   

//-----------------  Add UVM build() phase   -------------------//
//Create the instance of ram_wr_agent in build phase
function void ram_env::build_phase(uvm_phase phase);
	super.build_phase(phase);
	wr_agenth=ram_wr_agent::type_id::create("wr_agenth",this);
	`uvm_info("RAM_ENV","This is build_phase in env", UVM_LOW)
endfunction
	
//-----------------  Add UVM connect() phase   -------------------//
function void ram_env::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	`uvm_info("RAM_ENV","This is connect_phase in env", UVM_LOW)
endfunction

//-----------------  Add UVM end_of_elaboration() phase   -------------------//
function void ram_env::end_of_elaboration_phase(uvm_phase phase);
	super.end_of_elaboration_phase(phase);
	`uvm_info("RAM_ENV","This is end_of_elaboration_phase in env", UVM_LOW)
endfunction

//-----------------  Add UVM start_of_simulation() phase   -------------------//
function void ram_env::start_of_simulation_phase(uvm_phase phase);
	super.start_of_simulation_phase(phase);
	`uvm_info("RAM_ENV","This is start_of_simulation_phase in env", UVM_LOW)
endfunction


//-----------------  Add UVM run() phase   -------------------//
// Raise and drop objections  
// With in raising ans dropping the objections add 100 delay in the run phase before printing
task ram_env::run_phase(uvm_phase phase);
	super.run();
	phase.raise_objection(this);
	#100;
	`uvm_info("RAM_ENV","This is run_phase in env", UVM_LOW)
	phase.drop_objection(this);
endtask


//-----------------  Add UVM extract() phase   -------------------//
function void ram_env::extract_phase(uvm_phase phase);
	super.extract_phase(phase);
	`uvm_info("RAM_ENV","This is extract_phase in env", UVM_LOW)
endfunction
   
//-----------------  Add UVM check() phase   -------------------//
function void ram_env::check_phase(uvm_phase phase);
	super.check_phase(phase);
	`uvm_info("RAM_ENV","This is check_phase in env", UVM_LOW)
endfunction

//-----------------  Add UVM report() phase   -------------------//
function void ram_env::report_phase(uvm_phase phase);
	super.report_phase(phase);
	`uvm_info("RAM_ENV","This is report_phase in env", UVM_LOW)
endfunction
