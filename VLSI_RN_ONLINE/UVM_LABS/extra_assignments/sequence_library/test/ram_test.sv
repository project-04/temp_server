/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename		: 	ram_test.sv

Description 	: 	Test case for Dual port RAM
  
Author Name		: 	Putta Satish

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

  
    // Declare the ram_env and ram_wr_agent_config handles
    ram_env ram_envh;
    ram_wr_agent_config m_ram_cfg;
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
	// Create the instance of config_object
    m_ram_cfg=ram_wr_agent_config::type_id::create("m_ram_cfg");
	// set is_active to UVM_ACTIVE 
    m_ram_cfg.is_active = UVM_ACTIVE;
    // set the config object into UVM config DB  
	uvm_config_db #(ram_wr_agent_config)::set(this,"*","ram_wr_agent_config",m_ram_cfg);
    super.build_phase(phase);
	// create the instance for env
	ram_envh=ram_env::type_id::create("ram_envh", this);
endfunction

//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

   // Extend ram_seqr_arb_test from ram_base_test;
	class ram_seq_lib_test extends ram_base_test;

  
   // Factory Registration
	`uvm_component_utils(ram_seq_lib_test)

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
 	extern function new(string name = "ram_seq_lib_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern function void end_of_elaboration_phase(uvm_phase phase);
	
endclass

//-----------------  constructor new method  -------------------//

 // Define Constructor new() function
   	function ram_seq_lib_test::new(string name = "ram_seq_lib_test" , uvm_component parent);
		super.new(name,parent);
	endfunction


//-----------------  build() phase method  -------------------//
            
	function void ram_seq_lib_test::build_phase(uvm_phase phase);
            super.build_phase(phase);
	endfunction
	
	function void ram_seq_lib_test::end_of_elaboration_phase(uvm_phase phase);
// print the topology        
		uvm_top.print_topology();
	endfunction

	
//-----------------  run() phase method  -------------------//
task ram_seq_lib_test::run_phase(uvm_phase phase);
		
	
     //Declare the handle of sequence library & create the instance 
     ram_wr_seq_lib ram_wr_seq_libh = ram_wr_seq_lib::type_id::create("ram_wr_seq_libh");
              
     //raise objection
     phase.raise_objection(this);
		 
     // add write even sequence to seqeunce library using add_sequence method
		 ram_wr_seq_libh.add_sequence(ram_even_wr_xtns::get_type());
      
		 //Set the library mode to RANDC mode
     ram_wr_seq_libh.selection_mode = UVM_SEQ_LIB_RANDC;
     
		 //set min_random_count & max_random_count of sequence library to 5 & 15
		 ram_wr_seq_libh.min_random_count = 5;
     ram_wr_seq_libh.max_random_count = 15;
     
		 // randomize the sequence library
     assert(ram_wr_seq_libh.randomize());
		 
		 // start the sequence library on agent sequencer
     ram_wr_seq_libh.start(ram_envh.wr_agnth.seqrh);
     
     //drop objection
     phase.drop_objection(this);

endtask


