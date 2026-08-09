/********************************************************************************************
Copyright 2019 - Maven Silicon Softech Pvt Ltd. 
 
All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.

It is not to be shared with or used by any third parties who have not enrolled for our paid training 

courses or received any written authorization from Maven Silicon.


Webpage:  www.maven-silicon.com

Filename:	   ram.v   

Description:      RTL for synchronous RAM 

Author Name:      Susmita Nayak

Version: 1.0

*********************************************************************************************/
   module sync_ram #(parameter WIDTH = 8,
                               DEPTH = 16,
															 ADDR  =  4)(clock,reset,read,write,
                                           rd_addr,wr_addr,
                                           data_in,
                                           data_out,
                                           err) ;
          input  clock,reset,read,write ;
          input  [ADDR-1:0]rd_addr,wr_addr;
          input  [WIDTH-1:0]data_in;
          output reg [WIDTH-1:0]data_out;
          output reg err;

          reg [WIDTH-1:0]mem[DEPTH-1:0];     

      always@(posedge clock,negedge reset)
        begin
          if(~reset)
            data_out <= 0;
          else if(read & ~write)
            data_out <= mem[rd_addr];
          else if(write & ~read)
            mem[wr_addr] <= data_in;
          else
            err <= 1;
       end

   endmodule 
    
         
