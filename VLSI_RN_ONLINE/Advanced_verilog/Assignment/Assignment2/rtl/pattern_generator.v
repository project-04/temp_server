module pattern_generator(
  input clk,rst,
  output reg [7:0] out);
  
  reg [7:0] temp;
  always@(posedge clk)
    begin
      if(rst)
        temp <= 8'd1;
//       else if (out[0] == 1)
//         temp <= temp;
      else if (temp[7] == 1)
        temp <= 8'd2;
      else
        temp <= temp << 1'b1;
    end
  
  always@(posedge clk)
    begin
      if(rst)
        out <= 8'd0;
      else if (out[0] == 1)
        fork //
          temp <= temp; //
          out <= temp;
        join //
      else
        out <= 8'd1;
    end
endmodule
