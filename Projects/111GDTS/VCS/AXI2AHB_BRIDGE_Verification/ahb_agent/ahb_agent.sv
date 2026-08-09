/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       ahb_agent.sv   

module Name             :       ahb_agent

Description             :       ahb agent for axi2ahb bridge verification

Author Name             :       Aishwarya,Naveen.

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.0
*********************************************************************************************/
 class ahb_agent extends uvm_agent;
   `uvm_component_utils(ahb_agent)

   ahb_driver drvh;
   ahb_sequencer seqrh;
   ahb_monitor monh;
   ahb_agent_config ahb_cfg;

   extern function new(string name="ahb_agent",uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
 endclass
 //constructor new method
 function ahb_agent::new(string name="ahb_agent",uvm_component parent);
   super.new(name,parent);
 endfunction
 //build phase
 function void ahb_agent::build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db#(ahb_agent_config)::get(this,"","ahb_agent_config",ahb_cfg))
     `uvm_fatal(get_type_name(),"configuration is not set properly for ahb agent")

   monh=ahb_monitor::type_id::create("monh",this);

   if(ahb_cfg.is_active==UVM_ACTIVE)
     begin
       drvh=ahb_driver::type_id::create("drvh",this);
       seqrh=ahb_sequencer::type_id::create("seqrh",this);
     end
   `uvm_info(get_type_name(),"ahb agent build_phase",UVM_HIGH)            
 endfunction
 //connect phase
 function void ahb_agent::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   drvh.seq_item_port.connect(seqrh.seq_item_export);	
   `uvm_info(get_type_name(),"ahb agent connect _phase",UVM_HIGH)
 endfunction
