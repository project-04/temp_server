/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       apb_if.sv   

module Name             :       apb_if

Description             :       apb interface for GPIO TestBench

Author Name             :       Karthik Kumar Reddy Devarinti

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.1
*********************************************************************************************/
`timescale 1ns/10ps

interface apb_if(input bit clk);
    logic psel;
    logic penable;
    logic pwrite;
    logic reset;
    logic[31:0]paddr;
    logic[31:0]pwdata;
    logic pready;
    logic irq;
    logic [31:0] prdata;


   clocking apb_drv_cb@(posedge clk);
     default input #1 output #0;
       output psel;
       output penable;
       output pwrite;
       output reset;
       output pwdata;
       output paddr;

       input pready;
       input irq;
       input prdata;
  endclocking

  clocking apb_mon_cb@(posedge clk);
     default input #1 output #0;
       input psel;
       input penable;
       input pwrite;
       input reset;
       input pwdata;
       input paddr;

       input pready;
       input irq;
       input prdata;
  endclocking

  modport APB_DRV_MP (clocking apb_drv_cb );
  modport APB_MON_MP (clocking apb_mon_cb);
 
endinterface


    
  
