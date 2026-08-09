/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       axi_interface.sv   

module Name             :       axi_if

Description             :       axi interface for axi2ahb bridge verification

Author Name             :       Aishwarya,Naveen.

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.0
*********************************************************************************************/

 interface axi_if(input bit clock);
   logic aresetn;
   //aw channel
   logic [7:0] awid;
   logic [31:0] awaddr;
   logic [7:0] awlen;
   logic [2:0] awsize;
   logic [1:0] awburst;
   logic awvalid;
   logic awready;
   //w channel
   logic [7:0] wid;
   logic [63:0] wdata;
   logic [7:0] wstrb;
   logic wlast;
   logic wvalid;
   logic wready;
   //ar channel
   logic [7:0] arid;
   logic [31:0] araddr;
   logic [7:0] arlen;
   logic [2:0] arsize;
   logic [1:0] arburst;
   logic arvalid;
   logic arready;
   //b response
   logic [7:0] bid;
   logic [1:0] bresp;
   logic bvalid;
   logic bready;
   //r response
   logic [7:0] rid;
   logic [63:0] rdata;
   logic [1:0] rresp;
   logic rlast;
   logic rvalid;
   logic rready;
   clocking axi_drv_cb @(posedge clock);
     default input #1 output #1;
     output aresetn;
     output		awid;
     output		awaddr;
     output		awlen;
     output		awsize;
     output		awburst;
     output	awvalid;
     input 	awready;
     output		wid;
     output		wdata;
     output		wstrb;
     output	wlast;
     output	wvalid;
     input 	wready;
     output		arid;
     output		araddr;
     output		arlen;
     output		arsize;
     output		arburst;
     output	arvalid;
     input	arready;
     input 		bid;
     input 		bresp;
     input 	bvalid;
     output	bready;
     input		rid;
     input	rdata;
     input	rlast;
     input	rvalid;
     input 	rresp;
     output 	rready;
   endclocking
   clocking axi_mon_cb @(posedge clock);
     default input #1 output #1;
     input aresetn;
     input    awid;
     input    awaddr;
     input     awlen;
     input     awsize;
     input     awburst;
     input  awvalid;
     input   awready;
     input     wid;
     input    wdata;
     input     wstrb;
     input  wlast;
     input  wvalid;
     input   wready;
     input    arid;
     input    araddr;
     input     arlen;
     input     arsize;
     input     arburst;
     input  arvalid;
     input   arready;
     input      bid;
     input      bresp;
     input   bvalid;
     input  bready;
     input      rid;
     input     rdata;
     input   rlast;
     input   rvalid;
     input 	rresp;
     input  rready;
   endclocking
   modport AXI_DRV_MP (clocking axi_drv_cb);
   modport AXI_MON_MP (clocking axi_mon_cb);
 endinterface
