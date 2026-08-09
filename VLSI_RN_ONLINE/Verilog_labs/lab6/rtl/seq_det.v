/********************************************************************************************
Copyright 2019 - Maven Silicon Softech Pvt Ltd. 

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.

It is not to be shared with or used by any third parties who have not enrolled for our paid training 

courses or received any written authorization from Maven Silicon.


Webpage     :      www.maven-silicon.com

Filename    :	   seq_det.v   

Description :      Sequence detector detecting "101"

Author Name :      Susmita

Version     :      1.0
*********************************************************************************************/

module seq_det(
  input seq_in, clock, reset,
  output det_o
);
  
  parameter S0 = 2'b00,
  			S1 = 2'b01,
  			S2 = 2'b10,
  			S3 = 2'b11;
  
  reg [1:0] present_state, next_state;
  
  always@(posedge clock, posedge reset)
    begin
      if(reset)
        present_state <= S0;
      else
        present_state <= next_state;
    end
  
  always@(present_state, seq_in)
    begin
      next_state = S0;
      case(present_state)
        S0 : if(seq_in==1) next_state = S1;
        	 else		   next_state = S0;
        
        S1 : if(seq_in==0) next_state = S2;
        	 else		   next_state = S1;
        
        S2 : if(seq_in==1) next_state = S3;
        	 else		   next_state = S0;
        
        S3 : if(seq_in==1) next_state = S1;
        	 else		   next_state = S2;
        default: next_state=S0;
      endcase
    end
  
  assign det_o = (present_state == S3) ? 1'b1: 1'b0;
endmodule


