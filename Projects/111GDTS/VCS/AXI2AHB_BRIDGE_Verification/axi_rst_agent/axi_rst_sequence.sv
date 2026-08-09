/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       axi_rst_sequence.sv   

module Name             :       axi_rst_sequence

Description             :       axi reset sequence for axi2ahb bridge verification

Author Name             :       Aishwarya,Naveen.

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.0
*********************************************************************************************/
 class axi_rst_sequence_base extends uvm_sequence#(axi_rst_trans);	
   `uvm_object_utils(axi_rst_sequence_base)

   extern function new(string name="axi_rst_sequence_base");
 endclass
 //----------------------- new -----------------------
 function axi_rst_sequence_base::new(string name="axi_rst_sequence_base");
   super.new(name);
 endfunction 
 //=======================================================================
 //reset sequence 
 class axi_rst_seq extends axi_rst_sequence_base;
   //register with factory
   `uvm_object_utils(axi_rst_seq)
   //methods
   extern function new(string name="axi_rst_seq");
   extern task body();
 endclass
 //---------------------------- new -----------------------------
 function axi_rst_seq::new(string name="axi_rst_seq");
   super.new(name);
 endfunction
 //-------------------------- body -------------------------------
 task axi_rst_seq::body();
   req = axi_rst_trans::type_id::create("req");

   start_item(req);
   assert(req.randomize() with {aresetn==1'b0;});
   finish_item(req);
 endtask
