`celldefine

module SYNC_1R1W_16x8 (
    CLKR, CLKW,
    AR, AW,
    D,
    Q,
    RE, WE, GWE,
    OE
);

input        CLKR, CLKW;
input  [3:0] AR, AW;
input  [7:0] D;
output [7:0] Q;
input [7:0] GWE;
input        RE, WE;
input        OE;

reg [7:0] MEM [0:15];
reg [7:0] Q_REG;

assign Q = (OE) ? Q_REG : 8'bz;

always @ (posedge CLKW) begin
    if (WE) begin
      MEM[AW] <= (GWE & D) | (~GWE & MEM[AW]);
    end
end

always @ (posedge CLKR) begin
    if (RE) begin
      Q_REG  <= MEM[AR];
    end   
end

// [start] : Adding CRC monitoring {{{
reg [31:0] CKSUM;
wire [31:0] SEED;
integer WriteCount=0;

assign SEED = {CKSUM[30:0],CKSUM[31]} ^ 32'h001A;
initial begin
    CKSUM = {32{1'b0}};
end

// Begin edits here -----------------
always @(posedge CLKW) begin
    if ( WE ) begin
        WriteCount = WriteCount + 1;
        CKSUM <= SEED ^ {AW,D};
//        $display("# [MONITOR] %M ADD[%h] <== %h WC:%4d CRC:%h",AW,D,WriteCount,CKSUM);
    end
end
// END edits here -----------------

// [end]   : Adding CRC monitoring }}}

`ifdef DEBUG_ADDRESS
always @ (AR or AW or RE or WE) begin
  if (AR == AW) begin
    if (RE & WE) begin
        $display("%d  %m  Simultaneous Read and Write to Address: %h",$time,AR);
    end
  end
end
`endif

endmodule

`endcelldefine