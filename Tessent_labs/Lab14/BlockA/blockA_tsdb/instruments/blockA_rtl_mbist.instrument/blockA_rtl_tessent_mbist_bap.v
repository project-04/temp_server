//--------------------------------------------------------
//
//  Copyright Mentor Graphics Corporation
//  All Rights Reserved
//
//  THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY
//  INFORMATION WHICH IS THE PROPERTY OF MENTOR GRAPHICS
//  CORPORATION OR ITS LICENSORS AND IS SUBJECT
//  TO LICENSE TERMS.
//
//--------------------------------------------------------
//  File created by: Tessent Shell
//          Version: 2019.1
//       Created on: Wed Aug 14 12:11:31 IST 2019
//--------------------------------------------------------

module blockA_rtl_tessent_mbist_bap (
// blockA_rtl_tessent_mbist_bap {{{
  reset,
  ijtag_select,
  si,
  capture_en,
  shift_en,
  shift_en_R,
  update_en,
  tck,
  tck_out,
  mcp_bounding_en,
  mcp_bounding_to_en,
  scan_en,
  scan_to_en,
  memory_bypass_en,
  memory_bypass_to_en,
  ltest_en,
  ltest_to_en,
  MBISTPG_GO,
  MBISTPG_DONE,
  ENABLE_MEM_RESET,
  REDUCED_ADDRESS_COUNT,
  BIST_SELECT_TEST_DATA,
  BIST_ALGO_MODE0,
  BIST_ALGO_MODE1,
  BIRA_EN,
  BIST_DIAG_EN,
  PRESERVE_FUSE_REGISTER,
  CHECK_REPAIR_NEEDED,
  BIST_ASYNC_RESET,
  FL_CNT_MODE0,
  FL_CNT_MODE1,
  BIST_CLK_EN,
  CHAIN_BYPASS_EN,
  BIST_HOLD,
  INVERT_ASYNC_TCK,
  TCK_MODE,
  BIST_SETUP,
  bistEn,
  toBist,
  fromBist,
  so
);
input               reset;
input               ijtag_select;
input               si;
input               capture_en;
input               shift_en;
input               mcp_bounding_en;
output              mcp_bounding_to_en;
input               scan_en;
output              scan_to_en;
input               memory_bypass_en;
output              memory_bypass_to_en;
input               ltest_en;
output              ltest_to_en;
output              shift_en_R;
input               update_en;
input               tck;
input  [0:0]        fromBist;
output [0:0]        bistEn;
output [0:0]        toBist;
output              tck_out;
input  [0:0]        MBISTPG_GO;
input  [0:0]        MBISTPG_DONE;
output              ENABLE_MEM_RESET;
output              REDUCED_ADDRESS_COUNT;
output              BIST_SELECT_TEST_DATA;
output              BIST_ALGO_MODE0;
output              BIST_ALGO_MODE1;
output              BIRA_EN;
output              BIST_DIAG_EN;
output              PRESERVE_FUSE_REGISTER;
output              CHECK_REPAIR_NEEDED;
output              BIST_ASYNC_RESET;
output              FL_CNT_MODE0;
output              FL_CNT_MODE1;
output              BIST_CLK_EN;
output              CHAIN_BYPASS_EN;
output              BIST_HOLD;
output              INVERT_ASYNC_TCK;
output              TCK_MODE;
output  [2:0]       BIST_SETUP;
output              so;
wire [0:0] sib_scan_out;
wire [0:0] sib_bist_en;
wire BIST_HOLD_int;
wire tdr_so;
wire  BIST_ASYNC_RESET_to_buf;
wire  BIST_CLK_EN_to_buf;
wire  INVERT_ASYNC_TCK_to_buf;
wire  TCK_MODE_to_buf;
assign ltest_to_en         = ltest_en;
assign memory_bypass_to_en = memory_bypass_en;
assign scan_to_en          = scan_en;
assign mcp_bounding_to_en  = mcp_bounding_en;
 
// TDR instance {{{
blockA_rtl_tessent_mbist_bap_tdr tdr_inst (
  .reset            (reset),
  .ijtag_select     (ijtag_select),
  .si               (si),
  .capture_en       (capture_en),
  .shift_en         (shift_en),
  .update_en        (update_en),
  .tck              (tck),
  .ltest_en         (ltest_en),
  .MBISTPG_GO       ( MBISTPG_GO),
  .MBISTPG_DONE     ( MBISTPG_DONE),
  .ENABLE_MEM_RESET ( ENABLE_MEM_RESET ),
  .REDUCED_ADDRESS_COUNT( REDUCED_ADDRESS_COUNT ),
  .BIST_SELECT_TEST_DATA( BIST_SELECT_TEST_DATA ),
  .BIST_ALGO_MODE0  ( BIST_ALGO_MODE0 ),
  .BIST_ALGO_MODE1  ( BIST_ALGO_MODE1 ),
  .BIRA_EN          ( BIRA_EN ),
  .BIST_DIAG_EN     ( BIST_DIAG_EN ),
  .PRESERVE_FUSE_REGISTER( PRESERVE_FUSE_REGISTER ),
  .CHECK_REPAIR_NEEDED( CHECK_REPAIR_NEEDED ),
  .BIST_ASYNC_RESET ( BIST_ASYNC_RESET_to_buf ),
  .FL_CNT_MODE0     ( FL_CNT_MODE0 ),
  .FL_CNT_MODE1     ( FL_CNT_MODE1 ),
  .BIST_CLK_EN      ( BIST_CLK_EN_to_buf ),
  .CHAIN_BYPASS_EN  ( CHAIN_BYPASS_EN ),
  .BIST_HOLD        ( BIST_HOLD_int ),
  .INVERT_ASYNC_TCK ( INVERT_ASYNC_TCK_to_buf ),
  .TCK_MODE         ( TCK_MODE_to_buf ),
  .BIST_SETUP       ( BIST_SETUP ),
  .so               (tdr_so)
);
// TDR instance }}}
 
wire ChainBypassMode_int;
assign ChainBypassMode_int = CHAIN_BYPASS_EN | BIST_SETUP[1];
reg [0:0] fromBist_retime;
// SIB 0 instance {{{
blockA_rtl_tessent_mbist_bap_sib blockA_rtl_tessent_mbist_controller_sib_inst0 (
  .reset             (reset),
  .si                (tdr_so),
  .capture_en        (capture_en),
  .shift_en          (shift_en),
  .update_en         (update_en),
  .tck               (tck),
  .ijtag_select      (ijtag_select),
  .bistEn            (sib_bist_en[0]),
  .from_scan_out     (fromBist_retime[0]),
  .ChainBypassMode   (ChainBypassMode_int),
  .so                (sib_scan_out[0])); 
 
// SIB 0 instance }}}
// --------- Bist hold  ---------
assign BIST_HOLD = BIST_HOLD_int;
assign shift_en_R = ijtag_select & shift_en & ~ChainBypassMode_int;
reg [0:0] toBist;
reg                 retiming_so ;
always @ (negedge tck) begin 
  retiming_so <= sib_scan_out[0];
end
always @ (negedge tck) begin 
  fromBist_retime <= fromBist;
end
assign so = retiming_so;
always @ (negedge tck) begin 
  toBist[0] <= tdr_so;
end
// --------- tck_out (inversion) -----------
wire tck_inv_from_inverter;
inv01 tck_inverter_inst (.A(tck),.Y(tck_inv_from_inverter));
mux21 tessent_persistent_cell_tck_out (.A0(tck),.A1(tck_inv_from_inverter),.S0(INVERT_ASYNC_TCK),.Y(tck_out));
// --------- Persistent Buffers for SDC anchors -----------
buf02 tessent_persistent_cell_INVERT_ASYNC_TCK (.A(INVERT_ASYNC_TCK_to_buf),.Y(INVERT_ASYNC_TCK));
buf02 tessent_persistent_cell_bistEn_0 (.A(sib_bist_en[0]),.Y(bistEn[0]));
buf02 tessent_persistent_cell_BIST_CLK_EN (.A(BIST_CLK_EN_to_buf),.Y(BIST_CLK_EN));
buf02 tessent_persistent_cell_BIST_ASYNC_RESET (.A(BIST_ASYNC_RESET_to_buf),.Y(BIST_ASYNC_RESET));
buf02 tessent_persistent_cell_TCK_MODE (.A(TCK_MODE_to_buf),.Y(TCK_MODE));
// blockA_rtl_tessent_mbist_bap }}}
endmodule
 
module blockA_rtl_tessent_mbist_bap_tdr (
// blockA_rtl_tessent_mbist_bap_tdr {{{
  reset,
  ijtag_select,
  si,
  capture_en,
  shift_en,
  update_en,
  tck,
  ltest_en,
  MBISTPG_GO,
  MBISTPG_DONE,
  ENABLE_MEM_RESET,
  REDUCED_ADDRESS_COUNT,
  BIST_SELECT_TEST_DATA,
  BIST_ALGO_MODE0,
  BIST_ALGO_MODE1,
  BIRA_EN,
  BIST_DIAG_EN,
  PRESERVE_FUSE_REGISTER,
  CHECK_REPAIR_NEEDED,
  BIST_ASYNC_RESET,
  FL_CNT_MODE0,
  FL_CNT_MODE1,
  BIST_CLK_EN,
  CHAIN_BYPASS_EN,
  BIST_HOLD,
  INVERT_ASYNC_TCK,
  TCK_MODE,
  BIST_SETUP,
  so
);
input               reset;
input               ijtag_select;
input               si;
input               capture_en;
input               shift_en;
input               update_en;
input               tck;
input               ltest_en;
input  [0:0]        MBISTPG_GO;
input  [0:0]        MBISTPG_DONE;
output              ENABLE_MEM_RESET;
output              REDUCED_ADDRESS_COUNT;
output              BIST_SELECT_TEST_DATA;
output              BIST_ALGO_MODE0;
output              BIST_ALGO_MODE1;
output              BIRA_EN;
output              BIST_DIAG_EN;
output              PRESERVE_FUSE_REGISTER;
output              CHECK_REPAIR_NEEDED;
output              BIST_ASYNC_RESET;
output              FL_CNT_MODE0;
output              FL_CNT_MODE1;
output              BIST_CLK_EN;
output              CHAIN_BYPASS_EN;
output              BIST_HOLD;
output              INVERT_ASYNC_TCK;
output              TCK_MODE;
output  [2:0]       BIST_SETUP;
output              so;
// Shift Register {{{
reg    [19:0]       tdr;
reg                 tdr_latch19;
reg                 tdr_latch18;
reg                 tdr_latch17;
reg                 tdr_latch16;
reg                 tdr_latch15;
reg                 tdr_latch14;
reg                 tdr_latch13;
reg                 tdr_latch12;
reg                 tdr_latch11;
reg                 tdr_latch10;
reg                 tdr_latch9;
reg                 tdr_latch8;
reg                 tdr_latch7;
reg                 tdr_latch6;
reg                 tdr_latch5;
reg                 tdr_latch4;
reg                 tdr_latch3;
reg                 tdr_latch2;
reg                 tdr_latch1;
reg                 tdr_latch0;
always @ (posedge tck) begin
  if (capture_en & ijtag_select) begin
    tdr <= { tdr_latch19,
             tdr_latch18,
             tdr_latch17,
             tdr_latch16,
             tdr_latch15,
             tdr_latch14,
             tdr_latch13,
             tdr_latch12,
             tdr_latch11,
             tdr_latch10,
             tdr_latch9,
             tdr_latch8,
             tdr_latch7,
             tdr_latch6,
             tdr_latch5,
             tdr_latch4,
             tdr_latch3,
             tdr_latch2,
             MBISTPG_DONE[0],
             MBISTPG_GO[0]};
  end else if (shift_en & ijtag_select) begin
    tdr <= {si,tdr[19:1]};
  end
end
// Shift Register }}}
// Update Latches {{{
// --------- DataOutPort 19 ---------
always @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch19 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch19 <= tdr[19];
    end
  end
end
// --------- DataOutPort 18 ---------
always @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch18 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch18 <= tdr[18];
    end
  end
end
// --------- DataOutPort 17 ---------
always @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch17 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch17 <= tdr[17];
    end
  end
end
// --------- DataOutPort 16 ---------
always @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch16 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch16 <= tdr[16];
    end
  end
end
// --------- DataOutPort 15 ---------
always @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch15 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch15 <= tdr[15];
    end
  end
end
// --------- DataOutPort 14 ---------
always @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch14 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch14 <= tdr[14];
    end
  end
end
// --------- DataOutPort 13 ---------
always @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch13 <= 1'b1;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch13 <= tdr[13];
    end
  end
end
// --------- DataOutPort 12 ---------
always @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch12 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch12 <= tdr[12];
    end
  end
end
// --------- DataOutPort 11 ---------
always @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch11 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch11 <= tdr[11];
    end
  end
end
// --------- DataOutPort 10 ---------
always @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch10 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch10 <= tdr[10];
    end
  end
end
// --------- DataOutPort 9 ---------
always @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch9 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch9 <= tdr[9];
    end
  end
end
// --------- DataOutPort 8 ---------
always @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch8 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch8 <= tdr[8];
    end
  end
end
// --------- DataOutPort 7 ---------
always @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch7 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch7 <= tdr[7];
    end
  end
end
// --------- DataOutPort 6 ---------
always @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch6 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch6 <= tdr[6];
    end
  end
end
// --------- DataOutPort 5 ---------
always @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch5 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch5 <= tdr[5];
    end
  end
end
// --------- DataOutPort 4 ---------
always @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch4 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch4 <= tdr[4];
    end
  end
end
// --------- DataOutPort 3 ---------
always @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch3 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch3 <= tdr[3];
    end
  end
end
// --------- DataOutPort 2 ---------
always @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch2 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch2 <= tdr[2];
    end
  end
end
// --------- DataOutPort 1 ---------
always @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch1 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch1 <= tdr[1];
    end
  end
end
// --------- DataOutPort 0 ---------
always @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch0 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch0 <= tdr[0];
    end
  end
end
// Update Latches }}}
// Data Output Ports {{{
assign BIST_SETUP[2] = tdr_latch19;
assign BIST_SETUP[1] = tdr_latch18;
assign BIST_SETUP[0] = tdr_latch17;
assign TCK_MODE     = tdr_latch16;
assign INVERT_ASYNC_TCK = tdr_latch15;
assign BIST_HOLD    = tdr_latch14;
assign CHAIN_BYPASS_EN = tdr_latch13;
assign BIST_CLK_EN  = tdr_latch12;
assign FL_CNT_MODE1 = tdr_latch11;
assign FL_CNT_MODE0 = tdr_latch10;
assign BIST_ASYNC_RESET = ltest_en ? reset : tdr_latch9;
assign CHECK_REPAIR_NEEDED = tdr_latch8;
assign PRESERVE_FUSE_REGISTER = tdr_latch7;
assign BIST_DIAG_EN = tdr_latch6;
assign BIRA_EN      = tdr_latch5;
assign BIST_ALGO_MODE1 = tdr_latch4;
assign BIST_ALGO_MODE0 = tdr_latch3;
assign BIST_SELECT_TEST_DATA = tdr_latch2;
assign REDUCED_ADDRESS_COUNT = tdr_latch1;
assign ENABLE_MEM_RESET = tdr_latch0;
// Data Output Ports }}}
  
assign so = tdr[0];
// blockA_rtl_tessent_mbist_bap_tdr }}}
endmodule
 
module blockA_rtl_tessent_mbist_bap_sib (
// blockA_rtl_tessent_mbist_controller_sib {{{
   reset            , // i
   ijtag_select     , // i
   si               , // i
   capture_en       , // i
   shift_en         , // i
   update_en        , // i
   tck              , // i
   so               , // o
   from_scan_out    , // i
   ChainBypassMode  , //i
   bistEn             // o
);
   input          reset;
   input          ijtag_select;
   input          si;
   input          capture_en;
   input          shift_en;
   input          update_en;
   input          tck;
   input          from_scan_out;
   output         so;
   output         bistEn;
   input          ChainBypassMode;
   reg            sib;
   reg            sib_latch;
   reg            to_enable_int;
   assign bistEn = to_enable_int;
   always @ (negedge tck or negedge reset) begin
      if (~reset) begin
         sib_latch     <= 1'b0;
      end else if (update_en & ijtag_select) begin
         sib_latch     <= sib;
      end
   end
   always @ (negedge tck or negedge reset) begin
      if (~reset) begin
         to_enable_int <= 1'b0;
      end else  begin
         to_enable_int <= sib_latch;
      end
   end
 
   assign so = sib;
 
   always @ (posedge tck) begin
      if (capture_en & ijtag_select) begin
         sib <= sib_latch;
      end else if (shift_en & ijtag_select) begin
         if (sib_latch & (ChainBypassMode==0)) begin
            sib <= from_scan_out;
         end else begin
            sib <= si;
         end
      end
   end
// blockA_rtl_tessent_mbist_controller_sib }}}
endmodule
