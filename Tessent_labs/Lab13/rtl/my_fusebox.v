`celldefine
 
module my_fusebox (
    CLK,        // Clock
    A,          // Word Address [6:0]
    BWA,        // Bit Write Address [3:0], Active High
    Q,          // Output [7:0]
    PGM,        // Program Enable, Active High
    OE,         // Output Enable, Active High
    CS          // Chip Select, Active High
);
 
input        CLK;
input        CS;
input  [6:0] A;
input  [2:0] BWA;
input        PGM;
input        OE;
output [7:0] Q;
//synopsys translate_off
`ifdef LV_scanmodel
// Mentor Graphics scan model
`else
reg  [7:0] FB_ARRAY [0:127];
reg  [7:0] Q_REG;
reg  [7:0] FBWord_w;
wire [7:0] FuseBoxOut;
 
assign Q = (OE) ? Q_REG : 8'bz;
 
parameter FBOX_INIT_FILE="init.fbox";
initial
begin:INITIALISE
    integer N;
    for (N=0; N <= 127; N=N+1) begin
        FB_ARRAY[N] <= 0;
    end
    $display("**");
    $display("** WARNING");
    $display("**");
    $display("** You are using the LVFuseBox model as your fuse box simulation model.");
    $display("** This fuse box model is instantiated inside the top_rtl_genericFuseBox");
    $display("** module and should only be used for early verification of the BISR logic.");
    $display("** You must edit the top_rtl_genericFuseBox module and instanciate");
    $display("** the actual fuse box model that was provided by your fuse box vendor.");
    $display("**");
end
 
assign FuseBoxOut = FB_ARRAY[A];
 
always @( FuseBoxOut or BWA ) begin
    case (BWA) 
        3'b000: begin
            FBWord_w = FuseBoxOut | 8'b00000001; 
        end
        3'b001: begin
            FBWord_w = FuseBoxOut | 8'b00000010; 
        end
        3'b010: begin
            FBWord_w = FuseBoxOut | 8'b00000100; 
        end
        3'b011: begin
            FBWord_w = FuseBoxOut | 8'b00001000; 
        end
        3'b100: begin
            FBWord_w = FuseBoxOut | 8'b00010000; 
        end
        3'b101: begin
            FBWord_w = FuseBoxOut | 8'b00100000; 
        end
        3'b110: begin
            FBWord_w = FuseBoxOut | 8'b01000000; 
        end
        3'b111: begin
            FBWord_w = FuseBoxOut | 8'b10000000; 
        end
    endcase
end
 
reg Msg;
always @ (posedge CLK) begin
  if ( CS ) begin
      if ( PGM ) begin
        if ( ~ Msg ) 
            $display ($time," ** Writing Fuse Address[10'd%0d] <= 1",{A,BWA});
        FB_ARRAY[A] <= FBWord_w;
        Q_REG  <= 8'bxxxxxxxx;
      end else 
        Q_REG  <= FuseBoxOut;
  end else
    Q_REG <= Q_REG;  
  Msg <= PGM;    
end
`endif 
//synopsys translate_on
 
endmodule
 
`endcelldefine