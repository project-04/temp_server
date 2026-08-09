module my_fusebox_interface (
   clock,
   address,
   write_en,
   select,
   access_en,
   vddq,
   scan_test,
   read_data,
   write_duration_count,
   done
);
 
 
input clock;
input [9:0] address;
input  write_en, select, access_en, vddq,scan_test;
input [31:0] write_duration_count;
output read_data, done;
 
// ==
// ================ Fuse Box Instanciation =======================
// ==
reg FuseBoxMux;
reg strobeEnableD, strobeEnableR;
reg strobeEnable;
reg access_en_OBS_R;
reg [31:0]  strobeCnt;
wire [7:0] fuseQ;
wire [2:0] FBMuxSel;
wire PGM_INT;
 
 
always @ (posedge clock) begin
   if (~select) begin
     strobeCnt <= {32{1'b0}};
     strobeEnable <= 1'b0;
   end else begin
     if (access_en) begin
       if (write_en) begin
          strobeCnt <= write_duration_count;
       end else begin
          strobeCnt <= {32{1'b0}};
       end
       strobeEnable <= 1'b1;
     end else begin
       if (strobeCnt != {32 { 1'b0 } }) begin
         strobeCnt <= strobeCnt - 1;
         strobeEnable <= 1'b1;
       end else begin
         strobeEnable <= 1'b0;
       end
     end
   end
end
always @ (posedge clock) begin
   if (~select) begin
	strobeEnableD <= 0;
   end else begin
	strobeEnableD <= strobeEnable;
   end
end
always @ (negedge clock) begin
	strobeEnableR <= strobeEnable;
end
always @(posedge clock) begin
  if ( scan_test ) begin
    access_en_OBS_R <= access_en;
  end else begin
    access_en_OBS_R <= 1'b0;
  end
end
assign done = strobeEnableD & ~strobeEnable;
assign PGM_INT = write_en & strobeEnableR;
 
my_fusebox fuse_box_instance (.CLK(clock),
                             .A({ address[9],
                                   address[8],
                                   address[7],
                                   address[6],
                                   address[5],
                                   address[4],
                                   address[3]
                                }),
                             .BWA({address[2],address[1],address[0]}),
                             .Q(fuseQ),
                             .PGM(PGM_INT & ~scan_test),
                             .OE(select & ~write_en),
                             .CS(select & ~scan_test));
 
assign FBMuxSel = {address[2],address[1],address[0]};
 
always @(fuseQ or FBMuxSel or address or select or write_en or access_en or scan_test or access_en_OBS_R) begin
    case (FBMuxSel)
        3'b000: FuseBoxMux <= scan_test ? (address[3]) : fuseQ[0];
        3'b001: FuseBoxMux <= scan_test ? (address[4]) : fuseQ[1];
        3'b010: FuseBoxMux <= scan_test ? (address[5]) : fuseQ[2];
        3'b011: FuseBoxMux <= scan_test ? (address[6]) : fuseQ[3];
        3'b100: FuseBoxMux <= scan_test ? (address[7]) : fuseQ[4];
        3'b101: FuseBoxMux <= scan_test ? (address[8]) : fuseQ[5];
        3'b110: FuseBoxMux <= scan_test ? (address[9]) : fuseQ[6];
        3'b111: FuseBoxMux <= scan_test ? select ^ write_en ^ access_en_OBS_R : fuseQ[7];
    endcase
end
 
assign read_data = FuseBoxMux;
 
endmodule