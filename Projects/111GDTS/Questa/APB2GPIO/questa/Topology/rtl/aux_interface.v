/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       aux_interface.v   

module Name             :       aux_interface

Description             :       To provide auxiliary inputs for the GPIO Design

Author Name             :       Raghavendra H

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.1
*********************************************************************************************/
 //auxiliary interface module
 module aux_interface(input clk,rst,
	              input [31:0]aux_in, 
		      output reg [31:0]aux_i);

   always@(posedge clk or posedge rst)
     begin
       if (rst)
         aux_i<=32'b0;
       else
         aux_i<=aux_in;
     end

 endmodule


