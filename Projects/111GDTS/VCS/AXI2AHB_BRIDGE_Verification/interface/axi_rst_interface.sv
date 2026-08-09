/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       axi_rst_interface.sv   

module Name             :       axi_rst_if

Description             :       axi reset interface for axi2ahb bridge verification

Author Name             :       Aishwarya,Naveen.

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.0
*********************************************************************************************/
 interface axi_rst_if(input bit aclock);
   logic aresetn;
   clocking axi_rst_drv_cb @(posedge aclock);
     default input #1 output #1;
     output aresetn;
   endclocking
   clocking axi_rst_mon_cb @(posedge aclock);
     default input #1 output #1;
     input aresetn;
   endclocking
   modport AXI_RST_DRV_MP(clocking axi_rst_drv_cb);
   modport AXI_RST_MON_MP(clocking axi_rst_mon_cb);
 endinterface
