module clk_div (clk_in, clk_out, rst, ratio);

input clk_in, rst;
input [1:0] ratio;
output clk_out;

reg [1:0] sync_reset;
reg [2:0] clk_div;
always @ (posedge clk_in) begin
  sync_reset <= {sync_reset[0],rst};
  if (sync_reset[1] | rst) begin
    clk_div <= 4'hf;
  end else begin
    clk_div <= clk_div - 1;
  end
end

assign clk_out_3_2 = (ratio[0]) ? clk_div[2] : clk_div[1];
assign clk_out_1_0 = (ratio[0]) ? clk_div[0] : clk_in;

assign clk_out = (ratio[1]) ? clk_out_3_2 : clk_out_1_0;

endmodule