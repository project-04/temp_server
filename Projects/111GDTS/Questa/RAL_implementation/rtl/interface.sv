/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename		:   interface.sv

Description		:	Interface file for Peripheral 
  
Author Name		:   Gangadhar G

Support e-mail	: 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

************************************************************************/


interface intf(input logic clk);
    // Interface Signals
    logic        rst;
    logic        wr_en;
    logic        rd_en;
    logic [3:0]  addr;
    logic [7:0]  data_in;
    logic [7:0]  data_out;

    clocking mdcb @(posedge clk);
        default input #1 output #1;
        output rst;
        output wr_en;
        output addr;
        output data_in;
    endclocking

 clocking mmcb @(posedge clk);
        default input #1 output #1;
        input rst;
        input wr_en;
        input rd_en;
        input addr;
        input data_in;
        input data_out;
    endclocking

 clocking sdcb @(posedge clk);
        default input #1 output #1;
        input rst;
        output rd_en;
    endclocking


 clocking smcb @(posedge clk);
        default input #1 output #1;
        input rst;
        input rd_en;
        input data_out;
    endclocking

    modport MDMP (clocking mdcb);
endinterface

