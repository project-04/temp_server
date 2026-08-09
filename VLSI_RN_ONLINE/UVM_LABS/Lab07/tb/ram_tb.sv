/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename		:	ram_tb.sv

Description 	:	TB fule for Dual port RAM
  
Author Name		:   Putta Satish

Support e-mail	: 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

************************************************************************/
//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------
// Extend ram_tb from uvm_env
class ram_tb extends uvm_env;

    	// Factory Registration
   	`uvm_component_utils(ram_tb)

	// Declare handles for ram_wr_agt_top, ram_rd_agt_top 
	//and ram_virtual_sequencer as wagt_top,ragt_top and v_sequencer respectively
	ram_wr_agt_top wagt_top;
	ram_rd_agt_top ragt_top;
	ram_virtual_sequencer v_sequencer;

	// Declare handle for ram_env_config as m_cfg
	ram_env_config m_cfg;

	//------------------------------------------
	// Methods
	//------------------------------------------

	// Standard UVM Methods:
	extern function new(string name = "ram_tb", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

endclass: ram_tb
	
//-----------------  constructor new method  -------------------//
// Define Constructor new() function
function ram_tb::new(string name = "ram_tb", uvm_component parent);
	super.new(name, parent);
endfunction

//-----------------  build phase method  -------------------//
function void ram_tb::build_phase(uvm_phase phase);	
    //get configuration object ram_env_config from database using uvm_config_db() 
  	if(!uvm_config_db #(ram_env_config)::get(this, "", "ram_env_config", m_cfg))
      `uvm_fatal("RAM_ENV", "ram_env_config not geting");
	
  	//if ram_env_config parameter has_wagent=1
	  //set m_cfg.m_wr_cfg into config database "ram_wr_agent_config" using uvm_config_db
    //create instance for ram_wr_agt_top
    if(m_cfg.has_wagent)
      uvm_config_db #(ram_wr_agent_config)::set(this, "*", "ram_wr_agent_config", m_cfg.m_wr_cfg);
  	wagt_top = ram_wr_agt_top::type_id::create("ram_wr_agt_top", this);
	
  	//if ram_env_config parameter has_ragent=1
  	//set m_cfg.m_rd_cfg into config database  "ram_rd_agent_config" using uvm_config_db
    //create instance for ram_rd_agt_top
    if(m_cfg.has_ragent)
      uvm_config_db #(ram_rd_agent_config)::set(this, "*", "ram_rd_agent_config", m_cfg.m_rd_cfg);
  	ragt_top = ram_rd_agt_top::type_id::create("ram_rd_agt_top", this);
    
    super.build_phase(phase);
	
  	//if ram_env_config parameter has_virtual_sequencer=1
  	// Create the instance of v_sequencer handle 
    if(m_cfg.has_virtual_sequencer)
      v_sequencer = ram_virtual_sequencer::type_id::create("v_sequencer", this);
endfunction
//-----------------  connect phase method  -------------------//

// In connect phase, if ram_env_config parameter has_virtual_sequencer=1
// Connect virtual sequencers to UVC sequencers
// Hint : v_sequencer.wr_seqr = wagt_top.agnth.seqrh
// v_sequencer.rd_seqr = ragt_top.agnth.seqrh
function void ram_tb::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  if(m_cfg.has_virtual_sequencer)
  begin
    v_sequencer.wr_seqrh = wagt_top.agnth.seqrh;
    v_sequencer.rd_seqrh = ragt_top.agnth.seqrh;
  end
endfunction



