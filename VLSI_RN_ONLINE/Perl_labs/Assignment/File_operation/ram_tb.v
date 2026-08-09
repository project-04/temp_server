/********************************************************************************************
Copyright 2019 - Maven Silicon Softech Pvt Ltd. 
 
All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.

It is not to be shared with or used by any third parties who have not enrolled for our paid training 

courses or received any written authorization from Maven Silicon.


Webpage     :      www.maven-silicon.com

Filename    :	   ram_tb.v   

Description :      Test bench for RAM

Author Name :      Susmita Nayak

Version     :      1.0
*********************************************************************************************/

module ram_tb();

  parameter ADDR = 4;
  parameter WIDTH = 8;
  parameter DEPTH = 16;
  reg clock,reset,read,write;
  reg [ADDR-1:0]rd_ADDR,wr_ADDR;////4
  reg [WIDTH-1:0] data_in;///8
  wire [WIDTH-1:0] data_out;///8
  wire err;

reg [WIDTH-1:0]mem[DEPTH-1:0];

sync_ram uut(.clock(clock),
             .reset(reset),
             .read(read),
             .write(write),
             .rd_addr(rd_ADDR),
             .wr_addr(wr_ADDR),
             .data_in(data_in),
             .data_out(data_out),
             .err(err));

//Reset_task
task reset_t();
  begin
   @(negedge clock);
   reset = 1'b1;
   @(negedge clock);
   reset = 1'b0;
  end
endtask


//Tasks for Initialising the inputs
task initialize();
  begin
   clock = 1'b0;
   reset = 1'b0;
   write = 1'b0;
   read = 1'b0;
  end
endtask

always #10 clock = ~clock;



task write_t(input [7:0]a, input[3:0]b, input w);
        begin
             @(negedge clock);
                write=w;
                wr_ADDR=b;
                data_in=a;
        $display("data_in=%b, wr_ADDR=%d",data_in,wr_ADDR);
        end
endtask

task read_t(input [3:0]a, input r);
        begin
            @(negedge clock);
            read=r;
            rd_ADDR=a;
        $display("data_out=%b,rd_ADDR=%d",data_out,rd_ADDR);
        end
endtask

initial
   begin
        initialize;
        reset_t;

        if($test$plusargs("TEN"))
           begin
             repeat(10)
              write_t($urandom%256,$urandom%16,1'b1);
           end

        if($test$plusargs("TWO"))
          begin
            repeat(2)
          write_t($urandom%256,$urandom%16,1'b1);
          end

        if($test$plusargs("FOUR"))
          begin
            repeat(4)
        read_t($urandom%16,1'b1);
          end

        if($test$plusargs("FIVE"))
          begin
            repeat(5)
        read_t($urandom%16,1'b1);
          end 

        #1000 $finish;
    end

endmodule



