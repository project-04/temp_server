`timescale 1ns/1ns
module moore_vending_mechine_tb();
  reg [1:0] coin;
  reg clock, reset;
  wire pr_en;
  integer i;
  
  moore_vending_mechine DUT(reset, clock, coin, pr_en);
  
  initial {coin, clock, reset,i}=0;
  
  always #1.95 clock = ~clock; // 256MHZ clock 
  
  task rst();
    begin
      #5 reset=1'b1;
      #10 reset=1'b0;
    end
  endtask
  
  task stim(input [1:0] data);
    @(negedge clock) coin = data;
  endtask
  
  initial $display("coins => 00=25, 01=50, 10=100, 11=no coin");  
  initial $monitor("reset=%b, state=%b, coin=%b, -> pr_en=%b", reset, DUT.ps, coin, pr_en);
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, moore_vending_mechine_tb);
    rst();
    stim(2'b11);
    stim(2'b00);
    stim(2'b00);
    stim(2'b01);
    
    stim(2'b11);
    stim(2'b01);
    stim(2'b01);
    
    stim(2'b11);
    stim(2'b10);
    
    stim(2'b00);
    stim(2'b00);
    stim(2'b11);
    
    #6000 $finish;
  end
endmodule