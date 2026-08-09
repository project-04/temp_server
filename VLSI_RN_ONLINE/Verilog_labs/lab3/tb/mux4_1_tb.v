module mux4_1_tb();
  
  reg [1:0] s;
  reg [3:0] d;
  wire y;
  
  mux4_1 DUT(s,d,y);
  
  task initialize;
    begin
      {s,d}=0;
    end
  endtask
  
  task stimulus(input [1:0] i, input [3:0] j);    
    begin
      #10;
      s=i;
      d=j;
    end
  endtask
  
  initial
    begin
      initialize;
      stimulus(2'd0, 4'd5);
      stimulus(2'd1, 4'd5);
      stimulus(2'd2, 4'd5);
      stimulus(2'd3, 4'd5);
    end
  
  initial begin
      $monitor("%b, %b, %b",s,d,y);
    end
  
  initial begin
      #50 $finish;
    end
  
endmodule