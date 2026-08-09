/********************************************************************************************
Copyright 2019 - Maven Silicon Softech Pvt Ltd. 

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.

It is not to be shared with or used by any third parties who have not enrolled for our paid training 

courses or received any written authorization from Maven Silicon.


Webpage     :      www.maven-silicon.com

Filename    :	   dual_port_ram.v   

Description :      16x8 dual-port ram

Author Name :      Susmita Nayak

Version     :      1.0
*********************************************************************************************/

module dual_port_ram #(parameter WIDTH=8,DEPTH=16,ADDR=4)(
  input clock, reset, we, re, 
  input [ADDR-1:0] wr_addr, rd_addr,
  input [WIDTH-1:0] data_in, 
  output reg [WIDTH-1:0] data_out);
  
  integer i;
  
  //Internal memory declaration 
  reg [WIDTH-1:0] mem [DEPTH-1:0] ;

  //Memory reset & read & write operation
  always@(posedge clock or posedge reset)
    begin
      if(reset)
        begin
          for(i=0; i<=15; i=i+1)
              mem[i] <= 0;
          data_out <= 0;
        end
      else
        begin
          if(we)
            mem[wr_addr] <= data_in;
          if(re)
            data_out <= mem[rd_addr];
        end
    end
endmodule