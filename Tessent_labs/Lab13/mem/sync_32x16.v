`celldefine
// Must use system-verilog to compile this module
module SYNC_1RW_32x16_RC_BISR (CLK,
                  D,
                  Q,
                  BWE,
                  WE,
                  OE,
                  A,
                  RR0,
                  RR1,
                  CR0
                  );

parameter ROWS         = 8;
parameter ROW_BITS     = 3;
parameter COL_BITS     = 2;
parameter IO           = 16;
parameter IO_FUSE_BITS = 4;

// Fault insertion
reg [4:0] FaultAddrEn;
reg [ROW_BITS+COL_BITS-1:0] FaultAddr [0:4];
reg [IO-1:0] FaultIO [0:4];

parameter CR0_SIZE = COL_BITS + IO_FUSE_BITS;
parameter NumCols = 2**COL_BITS;
parameter NumRows = ROWS * NumCols;

initial begin
    $display("===");
    $display("=== Simulating with MGC behavioral memory model. ===");
    $display("===");
    $display("=== Number of rows    : %d",NumRows);
    $display("=== Number of columns : %d",NumCols);
end
input        CLK;
input        WE;
input [IO-1:0]  BWE;
input        OE;
input  [IO-1:0] D;
output [IO-1:0] Q;
input  [ROW_BITS+COL_BITS-1:0] A;
input  [ROW_BITS:0] RR0,RR1;
input  [CR0_SIZE : 0] CR0;


// CR bitmap:
// <RepairEnable><Col Addr><IO Address>

// RR bitmap:
// <RepairEnable><RowAddr[MSB]:RowAddr[LSB]}

reg [IO-1:0] MEM [0:NumRows-1];
reg [IO-1:0] Q_REG;

reg [IO-1:0] q_to_reg,row_to_reg;
reg [IO-1:0] Faults [0:4];
wire [IO-1:0] data_to_mem,data_from_mem;

wire [ROW_BITS+COL_BITS-1:0] ADD;

wire [COL_BITS-1:0] COL_ADD;
wire [ROW_BITS-1:0] ROW_ADD;
assign COL_ADD = A[COL_BITS-1:0];
assign ROW_ADD = A[ROW_BITS+COL_BITS-1:COL_BITS];

// [start] : Spare Row wires/regs {{{
wire RR0_EN,RR0_ADD_MATCH;
wire RR1_EN,RR1_ADD_MATCH;
reg [IO-1:0] RR0_SPARE [0:NumCols-1];
reg [IO-1:0] RR1_SPARE [0:NumCols-1];
// [end]   : Spare Row wires/regs }}}
// [start] : Spare Col wires/regs {{{
wire CR0_EN,CR0_ADD_MATCH;
wire [IO_FUSE_BITS-1:0] IO_INDEX;
reg  [IO-1:0] IO_MASK;
wire [COL_BITS-1:0] CR0_COL_ADD;
wire [CR0_SIZE-1:0] CR0_IO_ADD;
reg [ROWS-1:0] CR0_SPARE;
// [end]   : Spare Col wires/regs }}}

assign ADD = {ROW_ADD,COL_ADD};
assign RR0_EN = RR0[ROW_BITS];
assign RR1_EN = RR1[ROW_BITS];
assign RR0_ADD_MATCH = RR0_EN && (ROW_ADD == RR0[ROW_BITS-1:0]);
assign RR1_ADD_MATCH = RR1_EN && (ROW_ADD == RR1[ROW_BITS-1:0]);

assign CR0_EN        = CR0[CR0_SIZE];
assign IO_INDEX      = CR0[IO_FUSE_BITS-1:0];
assign CR0_ADD_MATCH = CR0_EN && (COL_ADD == CR0[COL_BITS + IO_FUSE_BITS -1:IO_FUSE_BITS]);

initial begin 
    Faults[0] = {IO{1'b0}};
    Faults[1] = {IO{1'b0}};
    Faults[2] = {IO{1'b0}};
    Faults[3] = {IO{1'b0}};
    Faults[4] = {IO{1'b0}};
end

assign Q = (OE) ? Q_REG : 8'bz;
assign data_to_mem   = D ^ {Faults[0]|Faults[1]|Faults[2]|Faults[3]|Faults[4]};
assign data_from_mem = MEM[ADD];

// [start] : Generate Faults[0] wire {{{
always @(A or FaultAddr[0] or FaultIO[0]) begin
    if( FaultAddrEn[0] ) begin
      if (FaultAddr[0] == A) begin
      `ifdef FI_VERBOSE
        $display("Injecting fault[0] at address %d ==> %d",A,FaultIO[0]);
      `endif
        Faults[0] = FaultIO[0];
      end else begin
        Faults[0] = {IO{1'b0}};
      end
    end else begin
      Faults[0] ={IO{1'b0}};
    end
end
// [end]   : Generate Faults wire }}}
// [start] : Generate Faults[1] wire {{{
always @(A or FaultAddr[1] or FaultIO[1]) begin
    if( FaultAddrEn[1] ) begin
      if (FaultAddr[1] == A) begin
      `ifdef FI_VERBOSE
        $display("Injecting fault[1] at address %d ==> %d",A,FaultIO[1]);
      `endif
        Faults[1] = FaultIO[1];
      end else begin
        Faults[1] = {IO{1'b0}};
      end
    end else begin
      Faults[1] ={IO{1'b0}};
    end
end
// [end]   : Generate Faults wire }}}
// [start] : Generate Faults[2] wire {{{
always @(A or FaultAddr[2] or FaultIO[2]) begin
    if( FaultAddrEn[2] ) begin
      if (FaultAddr[2] == A) begin
        Faults[2] = FaultIO[2];
      `ifdef FI_VERBOSE
        $display("Injecting fault[2] at address %d ==> %d",A,FaultIO[2]);
      `endif
      end else begin
        Faults[2] = {IO{1'b0}};
      end
    end else begin
      Faults[2] ={IO{1'b0}};
    end
end
// [end]   : Generate Faults wire }}}
// [start] : Generate Faults[3] wire {{{
always @(A or FaultAddr[3] or FaultIO[3]) begin
    if( FaultAddrEn[3] ) begin
      if (FaultAddr[3] == A) begin
        Faults[3] = FaultIO[3];
      `ifdef FI_VERBOSE
        $display("Injecting fault[3] at address %d ==> %d",A,FaultIO[3]);
      `endif
      end else begin
        Faults[3] = {IO{1'b0}};
      end
    end else begin
      Faults[3] ={IO{1'b0}};
    end
end
// [end]   : Generate Faults wire }}}
// [start] : Generate Faults[4] wire {{{
always @(A or FaultAddr[4] or FaultIO[4]) begin
    if( FaultAddrEn[4] ) begin
      if (FaultAddr[4] == A) begin
        Faults[4] = FaultIO[4];
      `ifdef FI_VERBOSE
        $display("Injecting fault[4] at address %d ==> %d",A,FaultIO[4]);
      `endif
      end else begin
        Faults[4] = {IO{1'b0}};
      end
    end else begin
      Faults[4] ={IO{1'b0}};
    end
end
// [end]   : Generate Faults wire }}}

always @ (posedge CLK) begin
   if (WE) begin
     MEM[ADD] <= (BWE & data_to_mem ) | (~BWE & MEM[ADD]);
   end 
   // [start] : Assign RR0_SPARE {{{
   if (WE && RR0_ADD_MATCH) begin
       RR0_SPARE[COL_ADD] <= (BWE & D) | (~BWE & RR0_SPARE[COL_ADD]);
   end
   // [end]   : Assign RR0_SPARE }}}
   // [start] : Assign RR1_SPARE {{{
   if (WE && RR1_ADD_MATCH) begin
       RR1_SPARE[COL_ADD] <= (BWE & D) | (~BWE & RR1_SPARE[COL_ADD]);
   end
   // [end]   : Assign RR0_SPARE }}}
   // [start] : Assign CR0_SPARE {{{
   if (WE && CR0_ADD_MATCH) begin
      CR0_SPARE[ROW_ADD] = (D[IO_INDEX] & BWE[IO_INDEX]) | (~BWE[IO_INDEX] & CR0_SPARE[ROW_ADD]);
   end
   // [end]   : Assign CR0_SPARE }}}
   // [start] : Assign Q_REG {{{
   if ( ~WE ) begin
    Q_REG <= q_to_reg;
   end
   // [end]   : Assign Q_REG }}}
end
// [start] : Mux out mem array and spares {{{
always @(A or RR0_ADD_MATCH or RR1_ADD_MATCH or RR0_SPARE[COL_ADD] or RR1_SPARE[COL_ADD] or row_to_reg or data_from_mem or WE or COL_ADD) begin
   if ( RR0_ADD_MATCH ) begin
       row_to_reg = RR0_SPARE[COL_ADD];
   end else 
   if ( RR1_ADD_MATCH ) begin
       row_to_reg = RR1_SPARE[COL_ADD];
   end else 
   if ( ~WE ) begin
       row_to_reg = data_from_mem;
   end else begin
       row_to_reg = row_to_reg;
   end   
end
// [end]   : Mux out mem array and spares }}}
// [start] : Mux out the IO with the repaired one {{{
always @(CR0_ADD_MATCH or A or COL_ADD or CR0_EN or CR0_SPARE or IO_INDEX or ROW_ADD or IO_MASK or row_to_reg) begin
    if ( CR0_ADD_MATCH ) begin
       IO_MASK = {IO{1'b1}};
       IO_MASK[IO_INDEX] = 1'b0;
       q_to_reg = (row_to_reg & IO_MASK); // Mask out the failing IO
       q_to_reg[IO_INDEX] = CR0_SPARE[ROW_ADD]; // Swap failing IO with spare
    end else begin
      q_to_reg = row_to_reg;
    end
end
// [end]   : Mux out the IO with the repaired one }}}

integer FaultNum = 0;
task injectSA;
  input [ROW_BITS + COL_BITS - 1:0] Add;
  input [IO-1:0] FIO;
  begin
    $display("** Fault[%2d]::Injecting fault at address %d on IO(s): %d",FaultNum,Add,FIO);
    FaultAddrEn[FaultNum] = 1;
    FaultAddr[FaultNum] = Add;  
    FaultIO[FaultNum] = FIO;  
    FaultNum=FaultNum+1;
  end
endtask

endmodule

`endcelldefine