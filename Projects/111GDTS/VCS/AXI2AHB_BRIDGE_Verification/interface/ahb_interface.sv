/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       ahb_interface.sv   

module Name             :       ahb_interface

Description             :       ahb interface for axi2ahb bridge verification

Author Name             :       Aishwarya,Naveen.

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.0
*********************************************************************************************/

 interface ahb_if(input bit clock);
   logic hresetn;
   //ahb output 
   logic 	[31:0]	haddr;
   logic 	[1:0] 	htrans;
   logic		hwrite;
   logic 	[2:0]  	hsize;
   logic   [2:0] 	hburst;
   logic   [63:0] 	hwdata;
   logic         	hbusreq;
   logic         	hlock;
   //ahb input
   logic 	[63:0]	hrdata;
   logic         	hready;
   logic  	[1:0] 	hresp;
   logic          	hgrant;
   logic 	[3:0] 	hmaster;
   //AHB DRIVER clocking block:
   clocking ahb_drv_cb@(posedge clock);
     default input #1 output #1;
     input	haddr;
     input 	htrans;
     input      hwrite;
     input  	hsize;
     input 	hburst;
     input  	hwdata;
     input      hbusreq;
     input      hlock;
     output 	hrdata;
     output     hready;
     output 	hresp;
     output     hgrant;
     output 	hmaster;
     output 	hresetn;
   endclocking
   //AHB MONITOR clocking block:
   clocking ahb_mon_cb@(posedge clock);
     default input #1 output #1;
     input 	 	haddr;
     input  	 	htrans;
     input          	hwrite;
     input  	  	hsize;
     input     	hburst;
     input  	 	hwdata;
     input          	hbusreq;
     input          	hlock;
     input  	 	hrdata;
     input          	hready;
     input  	  	hresp;
     input          	hgrant;
     input  	  	hmaster;
     input          	hresetn;
   endclocking
   //DRIVER and MONITOR modport:
   modport AHB_DRV_MP (clocking ahb_drv_cb);
   modport AHB_MON_MP (clocking ahb_mon_cb);
 endinterface
