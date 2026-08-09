/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       ahb_rst_interface.sv   

module Name             :       ahb_rst_if

Description             :       ahb reset interface for axi2ahb bridge verification

Author Name             :       Aishwarya,Naveen.

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.0
*********************************************************************************************/

 interface ahb_rst_if(input bit clock);
   logic hresetn;
   //AHB DRIVER clocking block:
   clocking ahb_rst_drv_cb@(posedge clock);
     default input #1 output #1;
     output    hresetn;
   endclocking    
   //AHB MONITOR clocking block:
   clocking ahb_rst_mon_cb@(posedge clock);
     default input #1 output #1;
     input     hresetn;
   endclocking
   //DRIVER and MONITOR modport:
   modport AHB_RST_DRV_MP (clocking ahb_rst_drv_cb);
   modport AHB_RST_MON_MP (clocking ahb_rst_mon_cb);
 endinterface
