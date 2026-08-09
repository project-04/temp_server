/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       io_pad_if.sv   

module Name             :       io_pad_if

Description             :       input output pado interface for GPIO TestBench

Author Name             :       Karthik Kumar Reddy Devarinti

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.1
*********************************************************************************************/

interface io_pad_if(input bit e_clk);

   wire[31:0]io_pad;
 
   clocking io_pad_drv_cb@(posedge e_clk);
     inout io_pad;
   endclocking

   clocking io_pad_mon_cb@(posedge e_clk);
     input io_pad;
   endclocking
   
   modport IO_PAD_DRV_MP(clocking io_pad_drv_cb);
   modport IO_PAD_MON_MP(clocking io_pad_mon_cb);

endinterface
    
