/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       ahb_trans.sv   

module Name             :       ahb_trans

Description             :       ahb transaction class for axi2ahb bridge verification

Author Name             :       Aishwarya,Naveen.

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.1
*********************************************************************************************/
 class ahb_trans extends uvm_sequence_item;
   `uvm_object_utils(ahb_trans)
   //properties
   bit hwrite;
   bit [2:0] hsize;
   bit [1:0] htrans;
   bit [31:0] haddr;
   bit [2:0] hburst;
   bit [63:0] hwdata;
   bit hbusreq;
   bit hlock;
   rand bit [63:0] hrdata;
   bit hready;
   bit [1:0]hresp;
   bit [3:0]hmaster;
   rand int delay_cycles; 
   rand enum { okay,okay_with_wait_state,error} resp;
   //constraints
   constraint delay_c {delay_cycles inside {[2:5]};}
   constraint h_resp_c	{hresp inside {[0:1]};}
   //methods
   extern function new(string name = "ahb_trans");
   extern function void do_print(uvm_printer printer);
 endclass
 //---------------------- new -----------------------------
 function ahb_trans::new(string name = "ahb_trans");
   super.new(name);
 endfunction
 //---------------------- do print --------------------------
 function void ahb_trans::do_print(uvm_printer printer);
   super.do_print(printer);
   printer.print_field("hwrite", this.hwrite, 1, UVM_DEC);
   printer.print_field("haddr", this.haddr, 32, UVM_DEC);
   printer.print_field("htrans", this.htrans, 2, UVM_DEC);
   printer.print_field("hsize", this.hsize, 3, UVM_DEC);
   printer.print_field("hburst", this.hburst, 3, UVM_DEC);
   printer.print_field("hrdata", this.hrdata, 64, UVM_DEC);
   printer.print_field("hwdata", this.hwdata, 64, UVM_DEC);
   printer.print_field("hready", this.hready, 1, UVM_DEC);
   printer.print_field("hresp", this.hresp, 1, UVM_DEC);
   printer.print_field("hmaster", this.hmaster, 1, UVM_DEC);
 endfunction
