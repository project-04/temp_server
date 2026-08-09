/********************************************************************************************

Copyright 2011-2012 - Maven Silicon Softech Pvt Ltd. All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is considered a trade secret and is not to be divulged or used by parties who 
have not received written authorization from Maven Silicon Softech Pvt Ltd.

Maven Silicon Softech 
Bangalore - 560076

Webpage: 	www.maven-silicon.com

Filename:	mem_dec.v   

Description:	2:4 decoder used to increase address width

Version:	1.0

*********************************************************************************************/


module mem_dec(mem_in1,
               mem_in0,
               mem_out3,
               mem_out2,
               mem_out1,
               mem_out0
               );

   input mem_in1,
         mem_in0;

   output reg mem_out3,
              mem_out2,
              mem_out1,
              mem_out0;

always@(mem_in1,mem_in0)
begin
   case ({mem_in1,mem_in0})
         2'b00 : {mem_out3,mem_out2,mem_out1,mem_out0}=4'b0001;
         2'b01 : {mem_out3,mem_out2,mem_out1,mem_out0}=4'b0010;
         2'b10 : {mem_out3,mem_out2,mem_out1,mem_out0}=4'b0100;
         2'b11 : {mem_out3,mem_out2,mem_out1,mem_out0}=4'b1000;
    endcase
end
endmodule

