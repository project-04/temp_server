/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       aux_input_if.sv   

module Name             :       aux_input_if

Description             :       auxiliary input interface for GPIO TestBench

Author Name             :       Karthik Kumar Reddy Devarinti

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.1
*********************************************************************************************/

interface aux_input_if(input bit clk);

   logic[31:0]aux_in;
 
   clocking aux_input_drv_cb@(posedge clk);
     output aux_in;
   endclocking

   clocking aux_input_mon_cb@(posedge clk);
     input aux_in;
   endclocking
   
   modport AUX_INPUT_DRV_MP(clocking aux_input_drv_cb);
   modport AUX_INPUT_MON_MP(clocking aux_input_mon_cb);

endinterface
    
