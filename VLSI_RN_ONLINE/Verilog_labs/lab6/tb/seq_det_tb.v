/********************************************************************************************
Copyright 2019 - Maven Silicon Softech Pvt Ltd. 
 
All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.

It is not to be shared with or used by any third parties who have not enrolled for our paid training 

courses or received any written authorization from Maven Silicon.


Webpage     :      www.maven-silicon.com

Filename    :	   seq_det_tb.v   

Description :      Sequence detector Testbench

Author Name :      Susmita

Version     :      1.0
*********************************************************************************************/

module seq_det_tb();
		
  reg din, clock,  reset;
  wire dout;
  
  seq_det DUT(din, clock, reset, dout);
  
  initial {din, clock, reset}=0;
  
  always #10 clock = ~clock;
  
  task rst();
    begin
      #5 reset=1'b1;
      #10 reset=1'b0;
    end
  endtask
  
  task stim(input data);
      @(negedge clock) din = data;
  endtask
  
  initial $monitor("clock=%b, reset=%b, state=%b, din=%b, -> dout=%b", clock, reset, DUT.present_state, din, dout);
  
  always@(DUT.present_state or dout)
    begin
      if(DUT.present_state==2'b11 && dout==1)
        $display("Correct output at state %b",DUT.present_state);
    end
  
  initial begin
    rst();
    stim(0);
    stim(1);
    stim(0);
    stim(1);
    stim(0);
    stim(1);
    stim(1);
    rst;
    stim(1);
    stim(0);
    stim(1);
    stim(1);
    #10 $finish;
  end
endmodule
