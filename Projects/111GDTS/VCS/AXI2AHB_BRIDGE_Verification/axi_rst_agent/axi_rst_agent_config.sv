/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       axi_rst_agent_config.sv   

module Name             :       axi_rst_agent_config

Description             :       axi reset agent config for axi2ahb bridge verification

Author Name             :       Aishwarya,Naveen.

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.0
*********************************************************************************************/
 class axi_rst_agent_config extends uvm_object;
   `uvm_object_utils(axi_rst_agent_config)

   virtual axi_rst_if vif;
   uvm_active_passive_enum is_active=UVM_ACTIVE;

   extern function new(string name="axi_rst_agent_config");
 endclass
 //---------------------------- new -----------------------
 function axi_rst_agent_config::new(string name="axi_rst_agent_config");
   super.new(name);
 endfunction

