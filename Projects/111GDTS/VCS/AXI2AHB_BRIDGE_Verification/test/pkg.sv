/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       pkg.sv   

module Name             :       axi2ahb_pkg

Description             :       package file for axi2ahb bridge verification

Author Name             :       Aishwarya,Naveen.

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.0
*********************************************************************************************/

 package axi2ahb_pkg;	
   import uvm_pkg::*;
   `include "uvm_macros.svh"

   `include "ahb_agent_config.sv"
   `include "axi_agent_config.sv"
   `include "ahb_rst_agent_config.sv"
   `include "axi_rst_agent_config.sv"

   `include "environment_config.sv"

   `include "axi_trans.sv"
   `include "axi_sequence.sv"
   `include "axi_driver.sv"
   `include "axi_monitor.sv"
   `include "axi_sequencer.sv"
   `include "axi_agent.sv"

   `include "axi_rst_trans.sv"
   `include "axi_rst_sequence.sv"
   `include "axi_rst_driver.sv"
   `include "axi_rst_monitor.sv"
   `include "axi_rst_sequencer.sv"
   `include "axi_rst_agent.sv"

   `include "ahb_trans.sv"
   `include "ahb_sequence.sv"
   `include "ahb_monitor.sv"
   `include "ahb_sequencer.sv"
   `include "ahb_driver.sv"
   `include "ahb_agent.sv"

   `include "ahb_rst_trans.sv"
   `include "ahb_rst_sequence.sv"
   `include "ahb_rst_monitor.sv"
   `include "ahb_rst_sequencer.sv"
   `include "ahb_rst_driver.sv"
   `include "ahb_rst_agent.sv"

        
   `include "virtual_sequencer.sv"
   `include "virtual_sequence.sv"
   `include "scoreboard.sv"
        
   `include "environment.sv"
   `include "test.sv"
 endpackage 	
