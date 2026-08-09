/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       axi_rst_agent.sv   

module Name             :       axi_rst_agent

Description             :       axi reset agent for axi2ahb bridge verification

Author Name             :       Aishwarya,Naveen.

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.0
*********************************************************************************************/
 class axi_rst_agent extends uvm_agent;
   `uvm_component_utils(axi_rst_agent)

   axi_rst_driver drvh;
   axi_rst_monitor monh;
   axi_rst_sequencer seqrh;
   axi_rst_agent_config rst_cfg;

   extern function new(string name="axi_rst_agent",uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);	
 endclass
 //---------------------------------- new ---------------------------------
 function axi_rst_agent::new(string name="axi_rst_agent",uvm_component parent);
   super.new(name,parent);
 endfunction
 //------------------------------- build phase ---------------------------
 function void axi_rst_agent::build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db#(axi_rst_agent_config)::get(this,"","axi_rst_agent_config",rst_cfg))
     `uvm_fatal(get_type_name(),"configuration is not getting properly in axi agent")
   monh=axi_rst_monitor::type_id::create("monh",this);
   if(rst_cfg.is_active==UVM_ACTIVE)
     begin
       drvh=axi_rst_driver::type_id::create("drvh",this);
       seqrh=axi_rst_sequencer::type_id::create("seqrh",this);
     end
   `uvm_info(get_type_name(),"axi rst agent  build_phase",UVM_HIGH)
 endfunction
 //------------------------------ connect phase -----------------------------
 function void axi_rst_agent::connect_phase(uvm_phase phase);
   super.connect_phase(phase);	
   if(rst_cfg.is_active==UVM_ACTIVE)
     drvh.seq_item_port.connect(seqrh.seq_item_export);
   `uvm_info(get_type_name(),"axi rst agent connnect_phase",UVM_HIGH)
 endfunction
