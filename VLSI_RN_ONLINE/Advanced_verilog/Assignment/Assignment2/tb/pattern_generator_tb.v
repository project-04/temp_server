module pattern_generator_tb();
  reg clock,  reset;
  wire [7:0] out;
  
  pattern_generator DUT(clock, reset, out);
  
  initial {clock, reset}=0;
  
  always #10 clock = ~clock;
  
  task rst();
    begin
      #5 reset=1'b1;
      #10 reset=1'b0;
    end
  endtask
  
  initial $monitor("reset=%b, -> out=%b",reset, out);
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, pattern_generator_tb);
    rst();
    #370 
    $finish;
  end
endmodule
