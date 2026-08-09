/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       axi_rst_trans.sv   

module Name             :       axi_rst_trans

Description             :       axi reset transaction class for axi2ahb bridge verification

Author Name             :       Aishwarya,Naveen.

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.0
*********************************************************************************************/

 class axi_rst_trans extends uvm_sequence_item;
   `uvm_object_utils(axi_rst_trans)

   rand bit aresetn;
	
   logic bvalid;
   logic rvalid;

   extern function new(string name="axi_rst_trans");
   extern function void do_print(uvm_printer printer);
 endclass
 //------------------------- new -------------------------
 function axi_rst_trans::new(string name="axi_rst_trans");
   super.new(name);
 endfunction
 //------------------------ do print ----------------------
 function void axi_rst_trans::do_print(uvm_printer printer);
   printer.print_field("aresetn", this.aresetn, 1, UVM_DEC);
 endfunction
