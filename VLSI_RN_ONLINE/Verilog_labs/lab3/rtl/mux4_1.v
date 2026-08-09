module mux4_1(s,d,y);
  input [1:0] s;
  input [3:0] d;
  output reg y;
  
  always@(s,d) //always@(*)
    begin
      case(s)
        2'b00 : y = d[0];
        2'b01 : y = d[1];
        2'd2  : y = d[2];
        2'd3  : y = d[3];
        default: y= 1'bz;
      endcase
    end
endmodule