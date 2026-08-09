/********************************************************************************************
Copyright 2019 - Maven Silicon Softech Pvt Ltd. 
 
All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.

It is not to be shared with or used by any third parties who have not enrolled for our paid training 

courses or received any written authorization from Maven Silicon.


Webpage     :      www.maven-silicon.com

Filename    :	   ram_tb.v   

Description :      Testbench for Single Port RAM


Author Name :      Susmita

Version     :      1.0
*********************************************************************************************/

module ram_tb();
  reg we, enable;
  reg [3:0] addr;
  wire [7:0] data;
  
  reg [7:0] temp_data;
  integer l;
  
  ram DUT(we, enable, addr, data);
  
  assign data = (we && !enable) ? temp_data : 8'bz;
  
  task init();
    begin
      we=1'b0;
      enable=1'b0;
      addr=4'b0;
      temp_data=8'b0;
    end
  endtask
  
  task stim(input [3:0]i, input [7:0]j);
    begin
      addr=i;
      temp_data=j;
    end
  endtask
  
  task write();
    begin
      we=1'b1;
      enable=1'b0;
    end
  endtask
  
  task read();
    begin
      we=1'b0;
      enable=1'b1;
    end
  endtask
  
  task delay;
    begin
      #10;
    end
  endtask
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0, ram_tb);
      $display("----------write");
      init;
      delay;
      write;
      for(l=0; l<16; l=l+1)
        begin
          stim(l,l*l);
          delay;
        end
      $display("----------read");
      init;
      delay;
      read;
      for(l=0; l<16; l=l+1)
        begin
          stim(l,8'd0);
          delay;
        end
      delay;
      #10 $finish;
    end
  
  initial
    begin
      $monitor("we=%b, enable=%b, addr=%b, data=%b, temp_data=%b", we,enable,addr,data,temp_data);
    end
endmodule
