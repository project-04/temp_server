/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       axi_rst_sequencer.sv   

module Name             :       axi_rst_sequencer

Description             :       axi reset sequencer for axi2ahb bridge verification

Author Name             :       Aishwarya,Naveen.

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.0
*********************************************************************************************/

 class axi_rst_sequencer extends uvm_sequencer#(axi_rst_trans);
   `uvm_component_utils(axi_rst_sequencer)

   extern function new(string name="axi_rst_sequencer", uvm_component parent);
 endclass
 //--------------------------- new --------------------
 function axi_rst_sequencer::new(string name="axi_rst_sequencer", uvm_component parent);
   super.new(name,parent);
 endfunction

