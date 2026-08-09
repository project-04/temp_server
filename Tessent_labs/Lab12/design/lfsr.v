 module lfsr    (out,enable,clk,reset);

   output [2:0] out;
   input enable, clk, reset;

   reg [2:0] out;
   wire      linear_feedback;

   assign linear_feedback = (out[1] ^ out[2]);

   always @(posedge clk)
      if (reset) 
         out <= 3'b111 ;
      else if (enable) 
         out <= {out[1], out[0], linear_feedback};

 endmodule
