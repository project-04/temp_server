module dff_tb();
  
  reg clk, rst, d;
  wire q, qb;
  
  parameter CYCLE = 10;
  
  dff DUT(clk, rst, d, q, qb);
  
  always
    begin
      #(CYCLE/2);
      clk = 1'b0;
      #(CYCLE/2);
      clk = ~clk;
    end
  
  task reset();
    begin
      @(negedge clk);
      rst = 1'b1;
      @(negedge clk);
      rst = 1'b0;
    end
  endtask
  
  task din(input i);
    begin
      @(negedge clk);
      d=i;
    end
  endtask
  
  initial
    begin
      reset();
      din(0);
      din(1);
      din(0);
      din(1);
      reset();
      din(1);
      din(1);
      din(0);
      #10 $finish;
    end
  
  initial
    begin
      $monitor("clk=%b, rst=%b, d=%b, q=%b, qb=%b", clk,rst,d,q,qb);
    end
endmodule
