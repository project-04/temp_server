module blocking_non_blocking();
  reg [2:0]a,b;
  
  initial begin $monitor("time=%0t a=%0d b=%0d", $time, a, b); end
  
  initial
    begin
      a <= 2;
      a <= 4;
      b <= 6;
      a = 3;
      b = 4;
      a =1;
      #10 $finish;
    end
endmodule