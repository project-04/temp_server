/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       ahb_sequencer.sv   

module Name             :       ahb_sequencer

Description             :       ahb sequencer for axi2ahb bridge verification

Author Name             :       Aishwarya,Naveen.

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.1
*********************************************************************************************/
 class ahb_sequencer extends uvm_sequencer#(ahb_trans);
   `uvm_component_utils(ahb_sequencer)
   extern function new(string name = "ahb_sequencer",uvm_component parent);
 endclass
 //constructor new method 
 function ahb_sequencer ::new(string name = "ahb_sequencer",uvm_component parent);
   super.new(name,parent);
 endfunction


