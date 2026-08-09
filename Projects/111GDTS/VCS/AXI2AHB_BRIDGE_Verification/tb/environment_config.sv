/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       environment_config.sv   

module Name             :       environment_config

Description             :       environment config for axi2ahb bridge verification

Author Name             :       Aishwarya,Naveen.

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.0
*********************************************************************************************/
 class environment_config extends uvm_object;
   `uvm_object_utils(environment_config)
   bit has_axi_agent=1'b1;
   bit has_ahb_agent=1'b1;
   bit has_virtual_sequencer=1'b1;
   bit has_scoreboard=1'b1;
   bit has_axi_rst_agent=1'b1;
   bit has_ahb_rst_agent=1'b1;
   int no_of_axi_agent=1;
   int no_of_ahb_agent=1;
   int no_of_axi_rst_agent=1;
   int no_of_ahb_rst_agent=1;
   axi_agent_config axi_cfg[];
   ahb_agent_config ahb_cfg[];
   axi_rst_agent_config axi_rst_cfg[];
   ahb_rst_agent_config ahb_rst_cfg[];
   int ahb_length[$];
   int axi_length[$];
   extern function new(string name="environment_config");
 endclass
 //--------------------- new ----------------------
 function environment_config::new(string name="environment_config");
   super.new(name);
 endfunction

