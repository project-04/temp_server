/*
----------------------------------------------------------------------------------
-                                                                                -
-  Copyright Mentor Graphics Corporation                                         -
-  All Rights Reserved                                                           -
-                                                                                -
-  THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY                               -
-  INFORMATION WHICH IS THE PROPERTY OF MENTOR GRAPHICS                          -
-  CORPORATION OR ITS LICENSORS AND IS SUBJECT                                   -
-  TO LICENSE TERMS.                                                             -
-                                                                                -
----------------------------------------------------------------------------------
-  File created by: Tessent Shell                                                -
-          Version: 2019.1                                                       -
-       Created on: Wed Aug 14 12:11:29 IST 2019                                 -
----------------------------------------------------------------------------------


*/
`timescale 100 ps / 10 ps

/*------------------------------------------------------------------------------
     Module      :  blockA_rtl_tessent_mbist_c1_interface_m1
 
     Description :  This module contains the interface logic for the memory
                    module SYNC_8192X32_BISR
 
--------------------------------------------------------------------------------
     Interface Options in Effect
 
     BistDataPipelineStages        : 0;
     BitGrouping                   : 32;
     BitSliceWidth                 : 1;
     ConcurrentWrite               : OFF 
     ConcurrentRead                : OFF 
     ControllerType                : PROG;
     DataOutStage                  : NONE;
     DefaultAlgorithm              : SMARCHCHKB;
     DefaultOperationSet           : SYNC;
     InternalScanLogic             : OFF;
     LocalComparators              : ON;
     MemoryType                    : RAM;
     ObservationLogic              : ON;
     OutputEnableControl           : ALWAYSON;
     PipelineSerialDataOut         : OFF;
     ScanWriteThru                 : OFF;
     ShadowRead                    : OFF;
     ShadowWrite                   : OFF;
     Stop-On-Error Limit           : 4096;
     TransparentMode               : SYNCMUX;
 
-------------------------------------------------------- (c) Mentor Graphics */

module blockA_rtl_tessent_mbist_c1_interface_m1 (
                      WEB_IN,
                      WEB,
                      BWEB_IN,
                      BWEB,
                      CEB_IN,
                      CEB,
                      A_IN,
                      A,
                      D_IN,
                      D,
                      Q_IN,
                      Q,
                      SCAN_OBS_FLOPS,
                      BIST_CMP,
                      BIST_WRITEENABLE,
                      BIST_SELECT,
                      BIST_COL_ADD,
                      BIST_ROW_ADD,
                      BIST_TESTDATA_SELECT_TO_COLLAR,
                      MEM_BYPASS_EN,
                      SCAN_SHIFT_EN,
                      MCP_BOUNDING_EN,
                      BIST_ON,
                      BIST_RUN,
                      BIST_WRITE_DATA,
                      BIST_CLK,
                      BIST_ASYNC_RESETN,                // Asynchronous reset enable (active low)
                      BIST_SHIFT_COLLAR,
                      BIST_EXPECT_DATA,
                      BIST_SO,
                      BIST_SI,
                      BIST_COLLAR_SETUP,
                      BIST_COLLAR_HOLD,
                      BIST_SETUP2,
                      BIST_SETUP1,
                      BIST_SETUP0,
                      BIST_BIRA_EN,
                      CHECK_REPAIR_NEEDED,
                      BIST_DIAG_EN,
                      BIST_CLEAR_DEFAULT,
                      BIST_CLEAR,
                      BIST_GO,
                      LV_TM,
                      CHKBCI_PHASE,
                      BIST_COLLAR_EN,
                     Seg1_SCOL0_FUSE_REG          ,
                     FROM_BISR_Seg1_SCOL0_FUSE_REG               ,
                     Seg1_SCOL0_ALLOC_REG         ,
                     FROM_BISR_Seg1_SCOL0_ALLOC_REG              ,
                     Seg1_SCOL0_FUSE_ADD_REG      ,
                     FROM_BISR_Seg1_SCOL0_FUSE_ADD_REG           ,
                     REPAIR_STATUS                 ,
                      RESET_REG_SETUP2            ,
                      ERROR_CNT_ZERO,
                      BIST_CLEAR_BIRA             ,
                      BIST_SHIFT_BIRA_COLLAR      ,
                      BIST_IO_RA_PRSRV_FUSE_VAL_TO_COLLAR        ,
                      BIST_EN
);


wire                 MBISTPG_BIRA_SETUP;
input                BIST_CLEAR_BIRA;
wire  [3:0]          BIRA_COL_ADD;
input                WEB_IN;
output               WEB;
input  [31:0]        BWEB_IN;
output [31:0]        BWEB;
input                CEB_IN;
output               CEB;
input  [12:0]        A_IN;
output [12:0]        A;
input  [31:0]        D_IN;
output [31:0]        D;
input  [31:0]        Q_IN;
output [31:0]        Q;
output [15:0]        SCAN_OBS_FLOPS;
input                BIST_CMP;
wire                 CMP_EN;
input                BIST_WRITEENABLE;
input                BIST_SELECT;
input  [3:0]         BIST_COL_ADD;
input  [8:0]         BIST_ROW_ADD;
input  [1:0]         BIST_WRITE_DATA;
wire   [31:0]        BIST_WRITE_DATA_REP;
wire   [31:0]        BIST_WRITE_DATA_INT;
input                CHKBCI_PHASE;
input                BIST_EN;
input                BIST_TESTDATA_SELECT_TO_COLLAR;
input                MEM_BYPASS_EN;
input                SCAN_SHIFT_EN;
input                MCP_BOUNDING_EN;
input                BIST_ON;
input                BIST_RUN;
input                BIST_ASYNC_RESETN;
reg                  BIST_INPUT_SELECT;
wire                 BIST_EN_RST;
input                BIST_CLK;
wire                 BIST_CLK_INT;
input                BIST_SHIFT_COLLAR;
input  [1:0]         BIST_EXPECT_DATA;
wire   [31:0]        BIST_EXPECT_DATA_REP;
wire   [31:0]        BIST_EXPECT_DATA_INT;
wire                 BIST_CLK_EN;
input                BIST_SI;
output               BIST_SO;
 
input                BIST_COLLAR_SETUP;
input                BIST_COLLAR_HOLD;
input                BIST_BIRA_EN;
input                CHECK_REPAIR_NEEDED;
input                BIST_DIAG_EN;
input                BIST_CLEAR_DEFAULT;
input                BIST_CLEAR;
output               BIST_GO;
wire BIST_GO_FROM_STATUS;
input                BIST_SETUP2;
input                BIST_SETUP1;
input                BIST_SETUP0;
input                LV_TM;
input                BIST_COLLAR_EN;
wire                 GO_EN;
wire                 COLLAR_STATUS_SO;
wire                 STATUS_SO;
output [4:0]         Seg1_SCOL0_FUSE_REG;
input [4:0]          FROM_BISR_Seg1_SCOL0_FUSE_REG;
output               Seg1_SCOL0_ALLOC_REG;
input                FROM_BISR_Seg1_SCOL0_ALLOC_REG;
output [3:0]         Seg1_SCOL0_FUSE_ADD_REG;
input [3:0]          FROM_BISR_Seg1_SCOL0_FUSE_ADD_REG;
output [1:0] REPAIR_STATUS;
input                BIST_SHIFT_BIRA_COLLAR;
input                RESET_REG_SETUP2;
input                ERROR_CNT_ZERO;
wire                 BIST_COLLAR_BIRA_SO;
wire                 BIRA_STATUS_SO;
input                BIST_IO_RA_PRSRV_FUSE_VAL_TO_COLLAR;
wire                 BIST_SO_RA;
wire                 BIST_ON_TO_IO_RA;
wire [12:0]          BIST_ADD;
wire                 COLLAR_STATUS_SI;
wire                 BIST_INPUT_SELECT_INT;
wire [0:0] ERROR,ERROR_R;
wire [0:0] MultiBitError_R;
wire [0:0] ERROR_R_A;
wire [4:0]           IOIndex0_R;
wire PriorityColumn;
wire ErrorGlobal, RepairedBySpareColumn, RepairableBySpareColumn;
wire RepairableBySpareRow, RepairedBySpareRow;
wire   [31:0]        RAW_CMP_STAT;
reg    [15:0]        SCAN_OBS_FLOPS;
wire   [31:0]        DATA_TO_MEM;
wire   [31:0]        DATA_FROM_MEM;
wire   [31:0]        DATA_FROM_MEM_EXP;
wire                 WEB_TEST_IN;
reg                  WEB_NOT_GATED;
wire                 WEB_TO_MUX;
wire   [31:0]        BWEB_TEST_IN;
reg    [31:0]        BWEB_NOT_GATED;
wire   [31:0]        BWEB_TO_MUX;
wire                 CEB_TEST_IN;
reg                  CEB_NOT_GATED;
wire                 CEB_TO_MUX;
wire   [12:0]        A_TEST_IN;
reg    [12:0]        A;
wire   [31:0]        D_DIN_OBS;
wire   [31:0]        Q_TO_BYPASS;
wire   [31:0]        Q_FROM_BYPASS;
reg    [31:0]        D;
wire   [31:0]        D_TEST_IN;
reg    [31:0]        Q;
reg    [31:0]        Q_SCAN_IN;
wire                 EDATA_CKB_EN;
wire                 EDATA_COL_ADD_BIT0;
wire                 LOGIC_HIGH = 1'b1;
wire                 USE_DEFAULTS;
 
wire                 BIST_COLLAR_HOLD_INT;
reg                  BIST_COLLAR_EN_REG;
wire                 FREEZE_STOP_ERROR_RST;
wire                 HOLD_EN;
// Address Pipeline {{{
reg [3:0]            BIST_COL_ADD_R2;
reg [3:0]            BIST_COL_ADD_R3;
reg [3:0]            BIST_COL_ADD_R4;
 
// synopsys async_set_reset "BIST_ASYNC_RESETN"
always @(posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN ) begin
  if (~BIST_ASYNC_RESETN) begin
    BIST_COL_ADD_R2 <= 4'b0000;
    BIST_COL_ADD_R3 <= 4'b0000;
    BIST_COL_ADD_R4 <= 4'b0000;
  end else begin
    BIST_COL_ADD_R2 <= BIST_COL_ADD;
    BIST_COL_ADD_R3 <= BIST_COL_ADD_R2;
    BIST_COL_ADD_R4 <= BIST_COL_ADD_R3;
 end
end
// Address Pipeline }}}
// Bira Fuse Address busses {{{
 
wire [3:0] BIRA_COL_ADD_A,BIRA_COL_ADD_B;
 
assign BIRA_COL_ADD_A[0] = BIST_COL_ADD_R3[0];
assign BIRA_COL_ADD_A[1] = BIST_COL_ADD_R3[1];
assign BIRA_COL_ADD_A[2] = BIST_COL_ADD_R3[2];
assign BIRA_COL_ADD_A[3] = BIST_COL_ADD_R3[3];
assign BIRA_COL_ADD_B[0] = BIST_COL_ADD_R4[0];
assign BIRA_COL_ADD_B[1] = BIST_COL_ADD_R4[1];
assign BIRA_COL_ADD_B[2] = BIST_COL_ADD_R4[2];
assign BIRA_COL_ADD_B[3] = BIST_COL_ADD_R4[3];
// Bira Fuse Address busses }}}
wire                 BIST_SETUP0_SYNC;
wire                 BIST_SETUP1_SYNC;
wire                 BIST_SETUP2_SYNC;


//---------------------------
// Memory Interface Main Code
//---------------------------
//----------------------
//-- BIST_ON Sync-ing --
//----------------------
    and02 tessent_persistent_cell_AND_BIST_SETUP0_SYNC (
        .A0         ( BIST_SETUP0                                ),
        .A1         ( BIST_ON                                    ),
        .Y          ( BIST_SETUP0_SYNC                           )
    );

    and02 tessent_persistent_cell_AND_BIST_SETUP1_SYNC (
        .A0         ( BIST_SETUP1                                ),
        .A1         ( BIST_ON                                    ),
        .Y          ( BIST_SETUP1_SYNC                           )
    );

    and02 tessent_persistent_cell_AND_BIST_SETUP2_SYNC (
        .A0         ( BIST_SETUP2                                ),
        .A1         ( BIST_ON                                    ),
        .Y          ( BIST_SETUP2_SYNC                           )
    );

//-------------------
//-- Collar Enable --
//-------------------
    // synopsys async_set_reset "BIST_ASYNC_RESETN"
    always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
        if (~BIST_ASYNC_RESETN) begin
            BIST_COLLAR_EN_REG      <= 1'b0;
        end else begin
            BIST_COLLAR_EN_REG      <= BIST_COLLAR_EN;
        end
    end
//----------------------
//-- BIST_EN Retiming --
//----------------------
    assign BIST_EN_RST              = ~BIST_ASYNC_RESETN;
    always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
       if (~BIST_ASYNC_RESETN)
          BIST_INPUT_SELECT <= 1'b0;
       else
       if (~MCP_BOUNDING_EN) begin
          BIST_INPUT_SELECT <= BIST_RUN | BIST_TESTDATA_SELECT_TO_COLLAR;
       end
   end

    buf02 tessent_persistent_cell_BIST_INPUT_SELECT_INT (
        .A                          (BIST_INPUT_SELECT & (~LV_TM|MEM_BYPASS_EN)),
        .Y                          (BIST_INPUT_SELECT_INT)
    );    
    assign MBISTPG_BIRA_SETUP = BIST_SETUP2 & ~BIST_SETUP1 & ~BIST_SETUP0;
    assign USE_DEFAULTS = ~BIST_SETUP0_SYNC;
 
    assign BIST_COLLAR_HOLD_INT = BIST_COLLAR_HOLD | HOLD_EN;
//-----------------------
//-- Observation Logic --
//-----------------------
  // synopsys async_set_reset "BIST_ASYNC_RESETN"
  always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
    if (~BIST_ASYNC_RESETN)
      SCAN_OBS_FLOPS    <= 16'b0000000000000000;
    else
      SCAN_OBS_FLOPS    <= {16{MEM_BYPASS_EN} } & {
                          WEB_NOT_GATED        ^ BWEB_NOT_GATED[31]   ^ BWEB_NOT_GATED[30]   ,
                          BWEB_NOT_GATED[29]   ^ BWEB_NOT_GATED[28]   ^ BWEB_NOT_GATED[27]   ,
                          BWEB_NOT_GATED[26]   ^ BWEB_NOT_GATED[25]   ^ BWEB_NOT_GATED[24]   ,
                          BWEB_NOT_GATED[23]   ^ BWEB_NOT_GATED[22]   ^ BWEB_NOT_GATED[21]   ,
                          BWEB_NOT_GATED[20]   ^ BWEB_NOT_GATED[19]   ^ BWEB_NOT_GATED[18]   ,
                          BWEB_NOT_GATED[17]   ^ BWEB_NOT_GATED[16]   ^ BWEB_NOT_GATED[15]   ,
                          BWEB_NOT_GATED[14]   ^ BWEB_NOT_GATED[13]   ^ BWEB_NOT_GATED[12]   ,
                          BWEB_NOT_GATED[11]   ^ BWEB_NOT_GATED[10]   ^ BWEB_NOT_GATED[9]    ,
                          BWEB_NOT_GATED[8]    ^ BWEB_NOT_GATED[7]    ^ BWEB_NOT_GATED[6]    ,
                          BWEB_NOT_GATED[5]    ^ BWEB_NOT_GATED[4]    ^ BWEB_NOT_GATED[3]    ,
                          BWEB_NOT_GATED[2]    ^ BWEB_NOT_GATED[1]    ^ BWEB_NOT_GATED[0]    ,
                          CEB_NOT_GATED        ^ A[12]                ^ A[11]                ,
                          A[10]                ^ A[9]                 ^ A[8]                 ,
                          A[7]                 ^ A[6]                 ^ A[5]                 ,
                          A[4]                 ^ A[3]                 ^ A[2]                 ,
                          A[1]                 ^ A[0]                 
                           };
  end
 
//--------------------------
//-- Replicate Write Data --
//--------------------------
   assign BIST_WRITE_DATA_REP      = {
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA
                                     };
 
//-----------------------
//-- Checkerboard Data --
//-----------------------
   assign BIST_WRITE_DATA_INT       = BIST_WRITE_DATA_REP;
   assign DATA_TO_MEM              = BIST_WRITE_DATA_INT;
 
 
 
 

//--------------------------
//-- Memory Control Ports --
//--------------------------

   // Port: WEB LogicalPort: ## Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( WEB_IN or WEB_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : WEB_NOT_GATED = WEB_IN;
      1'b1 : WEB_NOT_GATED = WEB_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign WEB                       = WEB_NOT_GATED | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));

   // Control logic during memory test
   assign WEB_TEST_IN               = ~(BIST_COLLAR_EN & WEB_TO_MUX);
   assign WEB_TO_MUX                = BIST_WRITEENABLE;

   // Port: WEB }}}

   // Port: BWEB LogicalPort: ## Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( BWEB_IN or BWEB_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : BWEB_NOT_GATED = BWEB_IN;
      1'b1 : BWEB_NOT_GATED = BWEB_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign BWEB[31]                  = BWEB_NOT_GATED[31] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[30]                  = BWEB_NOT_GATED[30] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[29]                  = BWEB_NOT_GATED[29] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[28]                  = BWEB_NOT_GATED[28] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[27]                  = BWEB_NOT_GATED[27] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[26]                  = BWEB_NOT_GATED[26] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[25]                  = BWEB_NOT_GATED[25] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[24]                  = BWEB_NOT_GATED[24] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[23]                  = BWEB_NOT_GATED[23] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[22]                  = BWEB_NOT_GATED[22] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[21]                  = BWEB_NOT_GATED[21] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[20]                  = BWEB_NOT_GATED[20] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[19]                  = BWEB_NOT_GATED[19] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[18]                  = BWEB_NOT_GATED[18] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[17]                  = BWEB_NOT_GATED[17] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[16]                  = BWEB_NOT_GATED[16] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[15]                  = BWEB_NOT_GATED[15] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[14]                  = BWEB_NOT_GATED[14] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[13]                  = BWEB_NOT_GATED[13] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[12]                  = BWEB_NOT_GATED[12] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[11]                  = BWEB_NOT_GATED[11] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[10]                  = BWEB_NOT_GATED[10] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[9]                   = BWEB_NOT_GATED[9] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[8]                   = BWEB_NOT_GATED[8] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[7]                   = BWEB_NOT_GATED[7] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[6]                   = BWEB_NOT_GATED[6] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[5]                   = BWEB_NOT_GATED[5] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[4]                   = BWEB_NOT_GATED[4] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[3]                   = BWEB_NOT_GATED[3] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[2]                   = BWEB_NOT_GATED[2] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[1]                   = BWEB_NOT_GATED[1] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign BWEB[0]                   = BWEB_NOT_GATED[0] | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));

   // Control logic during memory test
   assign BWEB_TEST_IN              = {
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[31]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[30]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[29]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[28]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[27]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[26]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[25]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[24]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[23]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[22]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[21]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[20]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[19]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[18]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[17]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[16]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[15]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[14]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[13]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[12]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[11]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[10]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[9]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[8]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[7]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[6]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[5]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[4]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[3]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[2]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[1]),
                                       ~(BIST_COLLAR_EN & BWEB_TO_MUX[0]) 
                                      };
   assign BWEB_TO_MUX               = {
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE,
                                       BIST_WRITEENABLE 
                                      };

   // Port: BWEB }}}

   // Port: CEB LogicalPort: ## Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( CEB_IN or CEB_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : CEB_NOT_GATED = CEB_IN;
      1'b1 : CEB_NOT_GATED = CEB_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign CEB                       = CEB_NOT_GATED | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));

   // Control logic during memory test
   assign CEB_TEST_IN               = ~(BIST_COLLAR_EN & CEB_TO_MUX);
   assign CEB_TO_MUX                = BIST_SELECT;

   // Port: CEB }}}

//--------------------------
//-- Memory Address Ports --
//--------------------------

   // Port: A LogicalPort: ## Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( A_IN or A_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A = A_IN;
      1'b1 : A = A_TEST_IN;
      endcase
   end
   // Address logic during memory test
   wire   [3:0]                     BIST_COL_ADD_SHADOW;
   wire   [8:0]                     BIST_ROW_ADD_SHADOW;
   assign BIST_ROW_ADD_SHADOW[8] = BIST_ROW_ADD[8];
   assign BIST_ROW_ADD_SHADOW[7] = BIST_ROW_ADD[7];
   assign BIST_ROW_ADD_SHADOW[6] = BIST_ROW_ADD[6];
   assign BIST_ROW_ADD_SHADOW[5] = BIST_ROW_ADD[5];
   assign BIST_ROW_ADD_SHADOW[4] = BIST_ROW_ADD[4];
   assign BIST_ROW_ADD_SHADOW[3] = BIST_ROW_ADD[3];
   assign BIST_ROW_ADD_SHADOW[2] = BIST_ROW_ADD[2];
   assign BIST_ROW_ADD_SHADOW[1] = BIST_ROW_ADD[1];
   assign BIST_ROW_ADD_SHADOW[0] = BIST_ROW_ADD[0];
   assign BIST_COL_ADD_SHADOW[3] = BIST_COL_ADD[3];
   assign BIST_COL_ADD_SHADOW[2] = BIST_COL_ADD[2];
   assign BIST_COL_ADD_SHADOW[1] = BIST_COL_ADD[1];
   assign BIST_COL_ADD_SHADOW[0] = BIST_COL_ADD[0];
   assign A_TEST_IN                 = {
                                         BIST_ROW_ADD_SHADOW[8],
                                         BIST_ROW_ADD_SHADOW[7],
                                         BIST_ROW_ADD_SHADOW[6],
                                         BIST_ROW_ADD_SHADOW[5],
                                         BIST_ROW_ADD_SHADOW[4],
                                         BIST_ROW_ADD_SHADOW[3],
                                         BIST_ROW_ADD_SHADOW[2],
                                         BIST_ROW_ADD_SHADOW[1],
                                         BIST_ROW_ADD_SHADOW[0],
                                         BIST_COL_ADD_SHADOW[3],
                                         BIST_COL_ADD_SHADOW[2],
                                         BIST_COL_ADD_SHADOW[1],
                                         BIST_COL_ADD_SHADOW[0] 
                                      };

   // Port: A }}}

//--------------------
//-- Data To Memory --
//--------------------


   // Intercept functional signal with test mux
   always @( D_IN or D_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : D = D_IN;
      1'b1 : D = D_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign D_TEST_IN                 = {
                                        DATA_TO_MEM[31],
                                        DATA_TO_MEM[30],
                                        DATA_TO_MEM[29],
                                        DATA_TO_MEM[28],
                                        DATA_TO_MEM[27],
                                        DATA_TO_MEM[26],
                                        DATA_TO_MEM[25],
                                        DATA_TO_MEM[24],
                                        DATA_TO_MEM[23],
                                        DATA_TO_MEM[22],
                                        DATA_TO_MEM[21],
                                        DATA_TO_MEM[20],
                                        DATA_TO_MEM[19],
                                        DATA_TO_MEM[18],
                                        DATA_TO_MEM[17],
                                        DATA_TO_MEM[16],
                                        DATA_TO_MEM[15],
                                        DATA_TO_MEM[14],
                                        DATA_TO_MEM[13],
                                        DATA_TO_MEM[12],
                                        DATA_TO_MEM[11],
                                        DATA_TO_MEM[10],
                                        DATA_TO_MEM[9],
                                        DATA_TO_MEM[8],
                                        DATA_TO_MEM[7],
                                        DATA_TO_MEM[6],
                                        DATA_TO_MEM[5],
                                        DATA_TO_MEM[4],
                                        DATA_TO_MEM[3],
                                        DATA_TO_MEM[2],
                                        DATA_TO_MEM[1],
                                        DATA_TO_MEM[0] 
                                      };
   // External memory bypass during logic test
   assign D_DIN_OBS                 = {
                                        D[31],
                                        D[30],
                                        D[29],
                                        D[28],
                                        D[27],
                                        D[26],
                                        D[25],
                                        D[24],
                                        D[23],
                                        D[22],
                                        D[21],
                                        D[20],
                                        D[19],
                                        D[18],
                                        D[17],
                                        D[16],
                                        D[15],
                                        D[14],
                                        D[13],
                                        D[12],
                                        D[11],
                                        D[10],
                                        D[9],
                                        D[8],
                                        D[7],
                                        D[6],
                                        D[5],
                                        D[4],
                                        D[3],
                                        D[2],
                                        D[1],
                                        D[0] 
                                      };
//-------------------
//-- Memory Bypass --
//-------------------
   always @( Q_IN or Q_FROM_BYPASS or MEM_BYPASS_EN) begin
      case (MEM_BYPASS_EN) // synopsys infer_mux
      1'b0 : Q = Q_IN;
      1'b1 : Q = Q_FROM_BYPASS;
      endcase
   end

   assign Q_FROM_BYPASS             = Q_SCAN_IN;

   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      Q_SCAN_IN                     <= 32'd0;
   else
      Q_SCAN_IN                     <= {32{MEM_BYPASS_EN}} & Q_TO_BYPASS;
   end
 
   assign Q_TO_BYPASS               = {
                                        D_DIN_OBS[31],
                                        D_DIN_OBS[30],
                                        D_DIN_OBS[29],
                                        D_DIN_OBS[28],
                                        D_DIN_OBS[27],
                                        D_DIN_OBS[26],
                                        D_DIN_OBS[25],
                                        D_DIN_OBS[24],
                                        D_DIN_OBS[23],
                                        D_DIN_OBS[22],
                                        D_DIN_OBS[21],
                                        D_DIN_OBS[20],
                                        D_DIN_OBS[19],
                                        D_DIN_OBS[18],
                                        D_DIN_OBS[17],
                                        D_DIN_OBS[16],
                                        D_DIN_OBS[15],
                                        D_DIN_OBS[14],
                                        D_DIN_OBS[13],
                                        D_DIN_OBS[12],
                                        D_DIN_OBS[11],
                                        D_DIN_OBS[10],
                                        D_DIN_OBS[9],
                                        D_DIN_OBS[8],
                                        D_DIN_OBS[7],
                                        D_DIN_OBS[6],
                                        D_DIN_OBS[5],
                                        D_DIN_OBS[4],
                                        D_DIN_OBS[3],
                                        D_DIN_OBS[2],
                                        D_DIN_OBS[1],
                                        D_DIN_OBS[0] 
                                      };
 

//----------------------
//-- Data From Memory --
//----------------------
 
   assign DATA_FROM_MEM             = {
                                       Q[31],
                                       Q[30],
                                       Q[29],
                                       Q[28],
                                       Q[27],
                                       Q[26],
                                       Q[25],
                                       Q[24],
                                       Q[23],
                                       Q[22],
                                       Q[21],
                                       Q[20],
                                       Q[19],
                                       Q[18],
                                       Q[17],
                                       Q[16],
                                       Q[15],
                                       Q[14],
                                       Q[13],
                                       Q[12],
                                       Q[11],
                                       Q[10],
                                       Q[9],
                                       Q[8],
                                       Q[7],
                                       Q[6],
                                       Q[5],
                                       Q[4],
                                       Q[3],
                                       Q[2],
                                       Q[1],
                                       Q[0] 
                                      };
 
    assign EDATA_CKB_EN             = CHKBCI_PHASE;

    assign EDATA_COL_ADD_BIT0       = BIST_COL_ADD[0:0];

//---------------------------
//-- Replicate Expect Data --
//---------------------------
 
   assign BIST_EXPECT_DATA_REP      = { // 
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA
                                     };
//-----------------
//-- Expect Data --
//-----------------
   assign BIST_EXPECT_DATA_INT      = BIST_EXPECT_DATA_REP;
   assign DATA_FROM_MEM_EXP         = BIST_EXPECT_DATA_INT;
assign CMP_EN = BIST_CMP;

//-----------------------
//-- Local Comparators --
//-----------------------
 
   assign RAW_CMP_STAT[31]          = ~(DATA_FROM_MEM[31] == DATA_FROM_MEM_EXP[31]);
   assign RAW_CMP_STAT[30]          = ~(DATA_FROM_MEM[30] == DATA_FROM_MEM_EXP[30]);
   assign RAW_CMP_STAT[29]          = ~(DATA_FROM_MEM[29] == DATA_FROM_MEM_EXP[29]);
   assign RAW_CMP_STAT[28]          = ~(DATA_FROM_MEM[28] == DATA_FROM_MEM_EXP[28]);
   assign RAW_CMP_STAT[27]          = ~(DATA_FROM_MEM[27] == DATA_FROM_MEM_EXP[27]);
   assign RAW_CMP_STAT[26]          = ~(DATA_FROM_MEM[26] == DATA_FROM_MEM_EXP[26]);
   assign RAW_CMP_STAT[25]          = ~(DATA_FROM_MEM[25] == DATA_FROM_MEM_EXP[25]);
   assign RAW_CMP_STAT[24]          = ~(DATA_FROM_MEM[24] == DATA_FROM_MEM_EXP[24]);
   assign RAW_CMP_STAT[23]          = ~(DATA_FROM_MEM[23] == DATA_FROM_MEM_EXP[23]);
   assign RAW_CMP_STAT[22]          = ~(DATA_FROM_MEM[22] == DATA_FROM_MEM_EXP[22]);
   assign RAW_CMP_STAT[21]          = ~(DATA_FROM_MEM[21] == DATA_FROM_MEM_EXP[21]);
   assign RAW_CMP_STAT[20]          = ~(DATA_FROM_MEM[20] == DATA_FROM_MEM_EXP[20]);
   assign RAW_CMP_STAT[19]          = ~(DATA_FROM_MEM[19] == DATA_FROM_MEM_EXP[19]);
   assign RAW_CMP_STAT[18]          = ~(DATA_FROM_MEM[18] == DATA_FROM_MEM_EXP[18]);
   assign RAW_CMP_STAT[17]          = ~(DATA_FROM_MEM[17] == DATA_FROM_MEM_EXP[17]);
   assign RAW_CMP_STAT[16]          = ~(DATA_FROM_MEM[16] == DATA_FROM_MEM_EXP[16]);
   assign RAW_CMP_STAT[15]          = ~(DATA_FROM_MEM[15] == DATA_FROM_MEM_EXP[15]);
   assign RAW_CMP_STAT[14]          = ~(DATA_FROM_MEM[14] == DATA_FROM_MEM_EXP[14]);
   assign RAW_CMP_STAT[13]          = ~(DATA_FROM_MEM[13] == DATA_FROM_MEM_EXP[13]);
   assign RAW_CMP_STAT[12]          = ~(DATA_FROM_MEM[12] == DATA_FROM_MEM_EXP[12]);
   assign RAW_CMP_STAT[11]          = ~(DATA_FROM_MEM[11] == DATA_FROM_MEM_EXP[11]);
   assign RAW_CMP_STAT[10]          = ~(DATA_FROM_MEM[10] == DATA_FROM_MEM_EXP[10]);
   assign RAW_CMP_STAT[9]           = ~(DATA_FROM_MEM[9] == DATA_FROM_MEM_EXP[9]);
   assign RAW_CMP_STAT[8]           = ~(DATA_FROM_MEM[8] == DATA_FROM_MEM_EXP[8]);
   assign RAW_CMP_STAT[7]           = ~(DATA_FROM_MEM[7] == DATA_FROM_MEM_EXP[7]);
   assign RAW_CMP_STAT[6]           = ~(DATA_FROM_MEM[6] == DATA_FROM_MEM_EXP[6]);
   assign RAW_CMP_STAT[5]           = ~(DATA_FROM_MEM[5] == DATA_FROM_MEM_EXP[5]);
   assign RAW_CMP_STAT[4]           = ~(DATA_FROM_MEM[4] == DATA_FROM_MEM_EXP[4]);
   assign RAW_CMP_STAT[3]           = ~(DATA_FROM_MEM[3] == DATA_FROM_MEM_EXP[3]);
   assign RAW_CMP_STAT[2]           = ~(DATA_FROM_MEM[2] == DATA_FROM_MEM_EXP[2]);
   assign RAW_CMP_STAT[1]           = ~(DATA_FROM_MEM[1] == DATA_FROM_MEM_EXP[1]);
   assign RAW_CMP_STAT[0]           = ~(DATA_FROM_MEM[0] == DATA_FROM_MEM_EXP[0]);
  
wire                                FREEZE_GO_ID;
reg                                 FREEZE_STOP_ERROR_EARLY_R; 
assign FREEZE_GO_ID = BIST_SHIFT_COLLAR | ~(BIST_CMP & BIST_COLLAR_EN) | FREEZE_STOP_ERROR_EARLY_R;
   
//----------------
// STOP_ON_ERROR  
//----------------
wire                                SOE_ERROR;
wire                                FREEZE_STOP_ERROR_CLEAR;
wire                                FREEZE_STOP_ERROR_EARLY;
assign SOE_ERROR = |ERROR & BIST_ON;
assign FREEZE_STOP_ERROR_EARLY = ERROR_CNT_ZERO & SOE_ERROR;
  
// synopsys sync_set_reset "FREEZE_STOP_ERROR_CLEAR"
assign FREEZE_STOP_ERROR_CLEAR = ~GO_EN & ~BIST_COLLAR_HOLD & ~BIST_SHIFT_COLLAR;
 
// synopsys async_set_reset "BIST_ASYNC_RESETN"
always @(posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
  if (~BIST_ASYNC_RESETN) begin
    FREEZE_STOP_ERROR_EARLY_R <= 1'b0;
  end else 
  if (FREEZE_STOP_ERROR_CLEAR) begin
    FREEZE_STOP_ERROR_EARLY_R <= 1'b0;
  end else begin
    if (BIST_SHIFT_COLLAR) begin
      FREEZE_STOP_ERROR_EARLY_R <= BIRA_STATUS_SO;
    end else 
    if (~BIST_COLLAR_HOLD & GO_EN) begin
        FREEZE_STOP_ERROR_EARLY_R <= FREEZE_STOP_ERROR_EARLY | FREEZE_STOP_ERROR_EARLY_R;
    end
  end
end

assign HOLD_EN = BIST_COLLAR_HOLD | FREEZE_STOP_ERROR_EARLY_R;
    
    wire Seg1_SEGMENT_RANGE_EN;
 
assign Seg1_SEGMENT_RANGE_EN = 1'b1;
      

 
assign COLLAR_STATUS_SI = FREEZE_STOP_ERROR_EARLY_R;
 
blockA_rtl_tessent_mbist_c1_interface_m1_STATUS MBISTPG_STATUS (
    .BIST_CLK                      ( BIST_CLK_INT              ),
    .BIST_ASYNC_RESETN             (BIST_ASYNC_RESETN           ),
    .BIST_COLLAR_EN                (BIST_COLLAR_EN_REG          ), 
    .FREEZE_GO_ID                  (FREEZE_GO_ID                ),
    .CMP_EN                        (CMP_EN                      ),
    .FREEZE_STOP_ERROR_EARLY_R     (FREEZE_STOP_ERROR_EARLY_R   ),
   .GO_EN                          (GO_EN                      ),
   .BIST_COLLAR_SETUP              (BIST_COLLAR_SETUP          ),
   .BIST_COLLAR_HOLD               (BIST_COLLAR_HOLD_INT       ),
   .BIST_SHIFT_COLLAR              (BIST_SHIFT_COLLAR          ),
   .BIST_ON                        (BIST_ON                    ),
   .BIST_CLEAR_DEFAULT             (BIST_CLEAR_DEFAULT         ),
   .BIST_CLEAR                     (BIST_CLEAR                 ),
   .USE_DEFAULTS                   (USE_DEFAULTS               ),
   .SI                             (COLLAR_STATUS_SI           ),
   .ERROR                          ( ERROR               ),
   .ERROR_R                        ( ERROR_R             ),
   .MultiBitError_R                ( MultiBitError_R     ),
   .ERROR_R_A                      ( ERROR_R_A           ),
   .IOIndex0_R                     ( IOIndex0_R          ),
   .Seg1_SEGMENT_RANGE_EN          (Seg1_SEGMENT_RANGE_EN ),
   .BIST_DIAG_EN                   (BIST_DIAG_EN               ),
   .BIST_BIRA_EN                   (BIST_BIRA_EN               ),
   .RAW_CMP_STAT                   (RAW_CMP_STAT               ),
   .BIST_GO                        (BIST_GO_FROM_STATUS     ),
   .SO                             (COLLAR_STATUS_SO           )
);
assign BIST_GO = (BIST_BIRA_EN) ? ~(CHECK_REPAIR_NEEDED ? REPAIR_STATUS[0] : REPAIR_STATUS[1]) : BIST_GO_FROM_STATUS;
assign PriorityColumn = 1'b1;
wire COL_BIRA_SO,ROW_BIRA_SO;
blockA_rtl_tessent_mbist_c1_interface_m1_ColumnRedundancyAnalysis MBIST_ColumnRedundancyAnalysis (
            .BIST_CLK              (BIST_CLK_INT),
            .BIRA_FUSE_ADD_A       (BIRA_COL_ADD_A),
            .BIRA_FUSE_ADD_B       (BIRA_COL_ADD_B),
            .IOIndex0              (IOIndex0_R), 
            .BIST_ASYNC_RESETN                           (BIST_ASYNC_RESETN),
            .BIST_HOLD                                   (BIST_COLLAR_HOLD_INT),
            .BIST_SHIFT                                  (BIST_SHIFT_BIRA_COLLAR),
            .RepairedBySpareRow                          (RepairedBySpareRow), 
            .RepairableBySpareRow                        (RepairableBySpareRow), 
            .PriorityColumn                              (PriorityColumn),
            .MultiBitError_R                             (MultiBitError_R), 
            .CLEAR                                       (BIST_CLEAR_BIRA),
            .MBIST_RA_PRSRV_FUSE_VAL                     (BIST_IO_RA_PRSRV_FUSE_VAL_TO_COLLAR),
            .Seg1_SCOL0_FUSE_REG   (Seg1_SCOL0_FUSE_REG),
            .FROM_BISR_Seg1_SCOL0_FUSE_REG               (FROM_BISR_Seg1_SCOL0_FUSE_REG),
            .Seg1_SCOL0_ALLOC_REG  (Seg1_SCOL0_ALLOC_REG),
            .FROM_BISR_Seg1_SCOL0_ALLOC_REG(FROM_BISR_Seg1_SCOL0_ALLOC_REG),
            .Seg1_SCOL0_FUSE_ADD_REG                     (Seg1_SCOL0_FUSE_ADD_REG),
            .FROM_BISR_Seg1_SCOL0_FUSE_ADD_REG           (FROM_BISR_Seg1_SCOL0_FUSE_ADD_REG),
            .ErrorGlobal                                 (ErrorGlobal), 
            .RepairedBySpareColumn                       (RepairedBySpareColumn), 
            .RepairableBySpareColumn                     (RepairableBySpareColumn), 
            .ERROR                                       (ERROR_R_A),
            .LV_TM                                       (LV_TM),
            .BIRA_SI                                     (BIST_SI),
            .BIRA_SO                                     (COL_BIRA_SO)
        );
         
blockA_rtl_tessent_mbist_c1_interface_m1_RowRedundancyAnalysis MBIST_RowRedundancyAnalysis_INST (
         .RepairedBySpareRow       (RepairedBySpareRow ) , 
         .RepairableBySpareRow     (RepairableBySpareRow ) ,
         .LV_TM                    (LV_TM),
         .BIRA_SI                  (COL_BIRA_SO ) , 
         .BIRA_SO                  (ROW_BIRA_SO)  
        );
        
reg  [1:0] REPAIR_STATUS;
reg  [1:0] REPAIR_STATUS_SHADOW;
wire [1:0] REPAIR_STATUS_INT;
 
assign REPAIR_STATUS_INT[0] = ErrorGlobal & BIST_BIRA_EN & (RepairableBySpareColumn | RepairableBySpareRow);
assign REPAIR_STATUS_INT[1] = ErrorGlobal & (~BIST_BIRA_EN | (~RepairedBySpareColumn & ~RepairableBySpareColumn & ~RepairableBySpareRow & ~RepairedBySpareRow));
 
always @(posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
  if ( ~ BIST_ASYNC_RESETN ) begin
    REPAIR_STATUS <= 2'b00;
  end else
  if ( BIST_CLEAR_BIRA & ~BIST_IO_RA_PRSRV_FUSE_VAL_TO_COLLAR) begin
    REPAIR_STATUS <= 2'b00;
  end else begin
    if ( BIST_SHIFT_BIRA_COLLAR )
    REPAIR_STATUS <= {REPAIR_STATUS[0] , ROW_BIRA_SO};
    else
      if ( ~BIST_COLLAR_HOLD_INT & GO_EN )
        REPAIR_STATUS <= REPAIR_STATUS | REPAIR_STATUS_INT;
  end
end
always @(posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
  if ( ~ BIST_ASYNC_RESETN ) begin
    REPAIR_STATUS_SHADOW <= 2'b00;
  end else
  if ( BIST_CLEAR_BIRA & ~BIST_IO_RA_PRSRV_FUSE_VAL_TO_COLLAR) begin
    REPAIR_STATUS_SHADOW <= 2'b00;
  end else begin
    if ( BIST_SHIFT_COLLAR )
    REPAIR_STATUS_SHADOW <= {REPAIR_STATUS_SHADOW[0] , BIST_SI};
    else
      if ( ~BIST_COLLAR_HOLD_INT & GO_EN )
        REPAIR_STATUS_SHADOW <= REPAIR_STATUS;
  end
end

assign BIRA_STATUS_SO = REPAIR_STATUS_SHADOW[1];
assign BIST_COLLAR_BIRA_SO = REPAIR_STATUS[1];
         
 
assign STATUS_SO = (MBISTPG_BIRA_SETUP) ? BIST_COLLAR_BIRA_SO : COLLAR_STATUS_SO;
    
assign BIST_SO                      = STATUS_SO;
 
 
    assign BIST_CLK_EN  = BIST_RUN | BIST_COLLAR_SETUP|BIST_CLEAR|BIST_CLEAR_DEFAULT|BIST_SHIFT_COLLAR|BIST_CLEAR_BIRA | BIST_SHIFT_BIRA_COLLAR|RESET_REG_SETUP2|(BIST_INPUT_SELECT ^ BIST_TESTDATA_SELECT_TO_COLLAR);
//---------------------
//-- BIST_CLK Gating --
//---------------------
    cgand tessent_persistent_cell_GATING_BIST_CLK (
        .CK         ( BIST_CLK                    ),
        .TE         ( 1'b0         ),
        .FE         ( BIST_CLK_EN  ),
        .GCK        ( BIST_CLK_INT                )
    );
 
endmodule // blockA_rtl_tessent_mbist_c1_interface_m1


module blockA_rtl_tessent_mbist_c1_interface_m1_STATUS (
                          BIST_CLK                               ,
                          BIST_ASYNC_RESETN                       ,
                          BIST_CLEAR                             ,
                          BIST_CLEAR_DEFAULT                     ,
                          FREEZE_STOP_ERROR_EARLY_R              ,
                          FREEZE_GO_ID                            ,
                          CMP_EN                                  ,
                          GO_EN                                  ,
                          BIST_COLLAR_SETUP                      ,
                          BIST_COLLAR_HOLD                       ,
                          BIST_SHIFT_COLLAR                      ,
                          BIST_ON                                ,
                          USE_DEFAULTS                           ,
                          SI                                     ,
                          BIST_COLLAR_EN                         ,
                          BIST_DIAG_EN                           ,
                          BIST_BIRA_EN                           ,
                          ERROR                                  ,
                          ERROR_R                                ,
                          MultiBitError_R                        ,
                          ERROR_R_A                              ,
                          IOIndex0_R              ,
                          Seg1_SEGMENT_RANGE_EN   ,
                          RAW_CMP_STAT                           ,
                          BIST_GO                                ,
                          SO                                     
);
input                BIST_COLLAR_EN;
   input             BIST_CLEAR;
   input             BIST_CLEAR_DEFAULT;
   input             FREEZE_STOP_ERROR_EARLY_R;
   input             FREEZE_GO_ID;
   input             CMP_EN;
   input             BIST_ASYNC_RESETN;
   input             BIST_CLK;
   output            GO_EN;
   input             BIST_COLLAR_SETUP;
   input             BIST_COLLAR_HOLD;
   input             BIST_SHIFT_COLLAR;
   input             BIST_ON;
   input             USE_DEFAULTS;
   input             SI;
   input             BIST_DIAG_EN;
   input             BIST_BIRA_EN;
   input  [31:0]     RAW_CMP_STAT;
   output [0:0]      ERROR;
   output [0:0]      ERROR_R;
   output [0:0]      MultiBitError_R;
   output [0:0]      ERROR_R_A;
   output [4:0]      IOIndex0_R;
   input             Seg1_SEGMENT_RANGE_EN;
   output            SO;
   wire              GO_ID_REG_RST;
   reg    [31:0]     GO_ID_REG;
   output            BIST_GO;
 
   reg               GO_EN;
   wire              BIST_GO_INT;
   wire   [31:0]     ROW_DATA_MAP;
   wire              GO_ID_FEEDBACK_EN;
 
   //----------------
   // Row Data Map --
   //----------------
 assign ROW_DATA_MAP = RAW_CMP_STAT;
 
   //-----------
   //-- GO_EN --
   //-----------
   //synopsys sync_set_reset "BIST_ON"
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK or negedge BIST_ASYNC_RESETN) begin
      if (~BIST_ASYNC_RESETN)
         GO_EN       <= 1'b0;
      else
      if (~BIST_ON) begin
         GO_EN       <= 1'b0;
      end else begin
         if (BIST_COLLAR_SETUP) begin
            GO_EN    <= 1'b1; 
         end
      end
   end
   assign GO_ID_FEEDBACK_EN         = ~ (BIST_DIAG_EN|BIST_BIRA_EN) ;
   assign BIST_GO_INT               = ~|ERROR_R; 
   assign BIST_GO    = GO_EN & BIST_GO_INT;
 
 
 
   //---------------
   //-- GO_ID_REG --
   //---------------
reg  CMP_EN_R;
  // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK or negedge BIST_ASYNC_RESETN) begin
      if (~BIST_ASYNC_RESETN) begin
         CMP_EN_R    <= 1'b0;
      end else begin
         CMP_EN_R    <= ~FREEZE_GO_ID & ~BIST_COLLAR_HOLD;
      end
   end

   wire HOLD_OR_RESET;
    
wire [31:0] GO_ID_REG_MUX, BIST_SHIFT_COLLAR_MUX;
wire [31:0] GO_ID_REG_MUX_SEL ;
wire GO_ID_REG_CLR;
  // synopsys sync_set_reset "BIST_CLEAR"
   assign HOLD_OR_RESET = BIST_CLEAR | BIST_COLLAR_HOLD | ~GO_EN;
   assign GO_ID_REG_CLR = BIST_CLEAR | (~BIST_COLLAR_HOLD & ~GO_ID_FEEDBACK_EN & CMP_EN) | (CMP_EN_R & BIST_COLLAR_HOLD & ~FREEZE_STOP_ERROR_EARLY_R);
// Instantiate persistent GO_ID_REG_MUX cells {{{
    mux21 tessent_persistent_cell_MUX_GO_ID_REG0 (
            .S0      ( GO_ID_REG_MUX_SEL[0]        ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[0] & ~GO_ID_REG_CLR  ),
            .A0      ( ROW_DATA_MAP[0]             ),
            .Y       ( GO_ID_REG_MUX[0]            )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG1 (
            .S0      ( GO_ID_REG_MUX_SEL[1]        ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[1] & ~GO_ID_REG_CLR  ),
            .A0      ( ROW_DATA_MAP[1]             ),
            .Y       ( GO_ID_REG_MUX[1]            )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG2 (
            .S0      ( GO_ID_REG_MUX_SEL[2]        ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[2] & ~GO_ID_REG_CLR  ),
            .A0      ( ROW_DATA_MAP[2]             ),
            .Y       ( GO_ID_REG_MUX[2]            )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG3 (
            .S0      ( GO_ID_REG_MUX_SEL[3]        ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[3] & ~GO_ID_REG_CLR  ),
            .A0      ( ROW_DATA_MAP[3]             ),
            .Y       ( GO_ID_REG_MUX[3]            )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG4 (
            .S0      ( GO_ID_REG_MUX_SEL[4]        ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[4] & ~GO_ID_REG_CLR  ),
            .A0      ( ROW_DATA_MAP[4]             ),
            .Y       ( GO_ID_REG_MUX[4]            )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG5 (
            .S0      ( GO_ID_REG_MUX_SEL[5]        ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[5] & ~GO_ID_REG_CLR  ),
            .A0      ( ROW_DATA_MAP[5]             ),
            .Y       ( GO_ID_REG_MUX[5]            )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG6 (
            .S0      ( GO_ID_REG_MUX_SEL[6]        ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[6] & ~GO_ID_REG_CLR  ),
            .A0      ( ROW_DATA_MAP[6]             ),
            .Y       ( GO_ID_REG_MUX[6]            )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG7 (
            .S0      ( GO_ID_REG_MUX_SEL[7]        ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[7] & ~GO_ID_REG_CLR  ),
            .A0      ( ROW_DATA_MAP[7]             ),
            .Y       ( GO_ID_REG_MUX[7]            )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG8 (
            .S0      ( GO_ID_REG_MUX_SEL[8]        ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[8] & ~GO_ID_REG_CLR  ),
            .A0      ( ROW_DATA_MAP[8]             ),
            .Y       ( GO_ID_REG_MUX[8]            )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG9 (
            .S0      ( GO_ID_REG_MUX_SEL[9]        ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[9] & ~GO_ID_REG_CLR  ),
            .A0      ( ROW_DATA_MAP[9]             ),
            .Y       ( GO_ID_REG_MUX[9]            )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG10 (
            .S0      ( GO_ID_REG_MUX_SEL[10]       ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[10] & ~GO_ID_REG_CLR                ),
            .A0      ( ROW_DATA_MAP[10]            ),
            .Y       ( GO_ID_REG_MUX[10]           )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG11 (
            .S0      ( GO_ID_REG_MUX_SEL[11]       ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[11] & ~GO_ID_REG_CLR                ),
            .A0      ( ROW_DATA_MAP[11]            ),
            .Y       ( GO_ID_REG_MUX[11]           )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG12 (
            .S0      ( GO_ID_REG_MUX_SEL[12]       ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[12] & ~GO_ID_REG_CLR                ),
            .A0      ( ROW_DATA_MAP[12]            ),
            .Y       ( GO_ID_REG_MUX[12]           )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG13 (
            .S0      ( GO_ID_REG_MUX_SEL[13]       ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[13] & ~GO_ID_REG_CLR                ),
            .A0      ( ROW_DATA_MAP[13]            ),
            .Y       ( GO_ID_REG_MUX[13]           )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG14 (
            .S0      ( GO_ID_REG_MUX_SEL[14]       ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[14] & ~GO_ID_REG_CLR                ),
            .A0      ( ROW_DATA_MAP[14]            ),
            .Y       ( GO_ID_REG_MUX[14]           )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG15 (
            .S0      ( GO_ID_REG_MUX_SEL[15]       ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[15] & ~GO_ID_REG_CLR                ),
            .A0      ( ROW_DATA_MAP[15]            ),
            .Y       ( GO_ID_REG_MUX[15]           )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG16 (
            .S0      ( GO_ID_REG_MUX_SEL[16]       ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[16] & ~GO_ID_REG_CLR                ),
            .A0      ( ROW_DATA_MAP[16]            ),
            .Y       ( GO_ID_REG_MUX[16]           )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG17 (
            .S0      ( GO_ID_REG_MUX_SEL[17]       ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[17] & ~GO_ID_REG_CLR                ),
            .A0      ( ROW_DATA_MAP[17]            ),
            .Y       ( GO_ID_REG_MUX[17]           )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG18 (
            .S0      ( GO_ID_REG_MUX_SEL[18]       ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[18] & ~GO_ID_REG_CLR                ),
            .A0      ( ROW_DATA_MAP[18]            ),
            .Y       ( GO_ID_REG_MUX[18]           )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG19 (
            .S0      ( GO_ID_REG_MUX_SEL[19]       ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[19] & ~GO_ID_REG_CLR                ),
            .A0      ( ROW_DATA_MAP[19]            ),
            .Y       ( GO_ID_REG_MUX[19]           )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG20 (
            .S0      ( GO_ID_REG_MUX_SEL[20]       ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[20] & ~GO_ID_REG_CLR                ),
            .A0      ( ROW_DATA_MAP[20]            ),
            .Y       ( GO_ID_REG_MUX[20]           )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG21 (
            .S0      ( GO_ID_REG_MUX_SEL[21]       ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[21] & ~GO_ID_REG_CLR                ),
            .A0      ( ROW_DATA_MAP[21]            ),
            .Y       ( GO_ID_REG_MUX[21]           )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG22 (
            .S0      ( GO_ID_REG_MUX_SEL[22]       ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[22] & ~GO_ID_REG_CLR                ),
            .A0      ( ROW_DATA_MAP[22]            ),
            .Y       ( GO_ID_REG_MUX[22]           )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG23 (
            .S0      ( GO_ID_REG_MUX_SEL[23]       ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[23] & ~GO_ID_REG_CLR                ),
            .A0      ( ROW_DATA_MAP[23]            ),
            .Y       ( GO_ID_REG_MUX[23]           )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG24 (
            .S0      ( GO_ID_REG_MUX_SEL[24]       ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[24] & ~GO_ID_REG_CLR                ),
            .A0      ( ROW_DATA_MAP[24]            ),
            .Y       ( GO_ID_REG_MUX[24]           )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG25 (
            .S0      ( GO_ID_REG_MUX_SEL[25]       ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[25] & ~GO_ID_REG_CLR                ),
            .A0      ( ROW_DATA_MAP[25]            ),
            .Y       ( GO_ID_REG_MUX[25]           )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG26 (
            .S0      ( GO_ID_REG_MUX_SEL[26]       ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[26] & ~GO_ID_REG_CLR                ),
            .A0      ( ROW_DATA_MAP[26]            ),
            .Y       ( GO_ID_REG_MUX[26]           )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG27 (
            .S0      ( GO_ID_REG_MUX_SEL[27]       ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[27] & ~GO_ID_REG_CLR                ),
            .A0      ( ROW_DATA_MAP[27]            ),
            .Y       ( GO_ID_REG_MUX[27]           )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG28 (
            .S0      ( GO_ID_REG_MUX_SEL[28]       ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[28] & ~GO_ID_REG_CLR                ),
            .A0      ( ROW_DATA_MAP[28]            ),
            .Y       ( GO_ID_REG_MUX[28]           )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG29 (
            .S0      ( GO_ID_REG_MUX_SEL[29]       ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[29] & ~GO_ID_REG_CLR                ),
            .A0      ( ROW_DATA_MAP[29]            ),
            .Y       ( GO_ID_REG_MUX[29]           )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG30 (
            .S0      ( GO_ID_REG_MUX_SEL[30]       ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[30] & ~GO_ID_REG_CLR                ),
            .A0      ( ROW_DATA_MAP[30]            ),
            .Y       ( GO_ID_REG_MUX[30]           )
            );
    mux21 tessent_persistent_cell_MUX_GO_ID_REG31 (
            .S0      ( GO_ID_REG_MUX_SEL[31]       ),
            .A1      ( BIST_SHIFT_COLLAR_MUX[31] & ~GO_ID_REG_CLR                ),
            .A0      ( ROW_DATA_MAP[31]            ),
            .Y       ( GO_ID_REG_MUX[31]           )
            );
// Instantiate persistent GO_ID_REG_MUX cells }}}
   assign GO_ID_REG_MUX_SEL = (GO_ID_REG & {32{GO_ID_FEEDBACK_EN}})  | {32 {HOLD_OR_RESET | FREEZE_GO_ID }};
   assign BIST_SHIFT_COLLAR_MUX = BIST_SHIFT_COLLAR ? {SI,GO_ID_REG[31:1]} : GO_ID_REG;
 
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK or negedge BIST_ASYNC_RESETN) begin
      if (~BIST_ASYNC_RESETN)
         GO_ID_REG   <= {32{1'b0}};
      else
         GO_ID_REG   <= GO_ID_REG_MUX;
   end

reg  [0:0] MultiBitError,MultiBitError_R2;
wire [0:0] MultiBitError_R1;
wire [0:0] MultiBitError_R;
wire [31:0] IO_RANGE0;
reg  [4:0] IOIndex0;
wire [4:0] IOIndex0_R;

    
wire [0:0] ERROR, IO_SEG_GLOBAL_GO_ID;
wire [0:0] ERROR_R;
wire [0:0] ERROR_R_A;
reg  [0:0] ERROR_R1;
reg  [0:0] ERROR_R2;
 
  assign IO_SEG_GLOBAL_GO_ID[0] = |GO_ID_REG;
  assign ERROR[0] = GO_EN & IO_SEG_GLOBAL_GO_ID[0] & (CMP_EN_R | ( GO_ID_FEEDBACK_EN & ~BIST_BIRA_EN) | BIST_COLLAR_HOLD);
  // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK  or negedge BIST_ASYNC_RESETN) begin
        if (~BIST_ASYNC_RESETN) begin
         ERROR_R1    <= {1{1'b0}};
         ERROR_R2    <= {1{1'b0}};
      end else 
      if ( BIST_CLEAR ) begin
         ERROR_R1    <= {1{1'b0}};
         ERROR_R2    <= {1{1'b0}};
      end else begin
         ERROR_R1    <= ERROR;
         ERROR_R2    <= ERROR_R1;
      end
   end
  assign ERROR_R   = ERROR_R1;
  assign ERROR_R_A = ERROR_R2;
   
    
 
  // [start] : IO_RANGE0 bus assignment {{{
assign IO_RANGE0[0] = GO_ID_REG[0];
assign IO_RANGE0[1] = GO_ID_REG[1];
assign IO_RANGE0[2] = GO_ID_REG[2];
assign IO_RANGE0[3] = GO_ID_REG[3];
assign IO_RANGE0[4] = GO_ID_REG[4];
assign IO_RANGE0[5] = GO_ID_REG[5];
assign IO_RANGE0[6] = GO_ID_REG[6];
assign IO_RANGE0[7] = GO_ID_REG[7];
assign IO_RANGE0[8] = GO_ID_REG[8];
assign IO_RANGE0[9] = GO_ID_REG[9];
assign IO_RANGE0[10] = GO_ID_REG[10];
assign IO_RANGE0[11] = GO_ID_REG[11];
assign IO_RANGE0[12] = GO_ID_REG[12];
assign IO_RANGE0[13] = GO_ID_REG[13];
assign IO_RANGE0[14] = GO_ID_REG[14];
assign IO_RANGE0[15] = GO_ID_REG[15];
assign IO_RANGE0[16] = GO_ID_REG[16];
assign IO_RANGE0[17] = GO_ID_REG[17];
assign IO_RANGE0[18] = GO_ID_REG[18];
assign IO_RANGE0[19] = GO_ID_REG[19];
assign IO_RANGE0[20] = GO_ID_REG[20];
assign IO_RANGE0[21] = GO_ID_REG[21];
assign IO_RANGE0[22] = GO_ID_REG[22];
assign IO_RANGE0[23] = GO_ID_REG[23];
assign IO_RANGE0[24] = GO_ID_REG[24];
assign IO_RANGE0[25] = GO_ID_REG[25];
assign IO_RANGE0[26] = GO_ID_REG[26];
assign IO_RANGE0[27] = GO_ID_REG[27];
assign IO_RANGE0[28] = GO_ID_REG[28];
assign IO_RANGE0[29] = GO_ID_REG[29];
assign IO_RANGE0[30] = GO_ID_REG[30];
assign IO_RANGE0[31] = GO_ID_REG[31];
  // [end]   : IO_RANGE0 }}}
 
  // [start] : BIRA signal assignments for IO_RANGE0 {{{
always @( IO_RANGE0 or Seg1_SEGMENT_RANGE_EN ) begin
    case( IO_RANGE0 )
        32'b00000000000000000000000000000000 : begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = 5'b00000;
                    end
        32'b00000000000000000000000000000001: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b00000);
                    end
        32'b00000000000000000000000000000010: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b00001);
                    end
        32'b00000000000000000000000000000100: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b00010);
                    end
        32'b00000000000000000000000000001000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b00011);
                    end
        32'b00000000000000000000000000010000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b00100);
                    end
        32'b00000000000000000000000000100000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b00101);
                    end
        32'b00000000000000000000000001000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b00110);
                    end
        32'b00000000000000000000000010000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b00111);
                    end
        32'b00000000000000000000000100000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b01000);
                    end
        32'b00000000000000000000001000000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b01001);
                    end
        32'b00000000000000000000010000000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b01010);
                    end
        32'b00000000000000000000100000000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b01011);
                    end
        32'b00000000000000000001000000000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b01100);
                    end
        32'b00000000000000000010000000000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b01101);
                    end
        32'b00000000000000000100000000000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b01110);
                    end
        32'b00000000000000001000000000000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b01111);
                    end
        32'b00000000000000010000000000000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b10000);
                    end
        32'b00000000000000100000000000000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b10001);
                    end
        32'b00000000000001000000000000000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b10010);
                    end
        32'b00000000000010000000000000000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b10011);
                    end
        32'b00000000000100000000000000000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b10100);
                    end
        32'b00000000001000000000000000000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b10101);
                    end
        32'b00000000010000000000000000000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b10110);
                    end
        32'b00000000100000000000000000000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b10111);
                    end
        32'b00000001000000000000000000000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b11000);
                    end
        32'b00000010000000000000000000000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b11001);
                    end
        32'b00000100000000000000000000000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b11010);
                    end
        32'b00001000000000000000000000000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b11011);
                    end
        32'b00010000000000000000000000000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b11100);
                    end
        32'b00100000000000000000000000000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b11101);
                    end
        32'b01000000000000000000000000000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b11110);
                    end
        32'b10000000000000000000000000000000: begin
                         MultiBitError[0] = 1'b0;
                         IOIndex0 = ({5 {Seg1_SEGMENT_RANGE_EN}} & 5'b11111);
                    end
        default :   begin
                        MultiBitError[0] = 1'b1;
                        IOIndex0 = 5'b00000;
                    end
    endcase
end
  // [end]   : IO_RANGE0 }}}
assign MultiBitError_R = MultiBitError_R2;
    and02 tessent_persistent_cell_AND_MultiBitError_R1_cell0 (            .A0(MultiBitError[0]),            .A1(BIST_BIRA_EN & ERROR_R1[0]),            .Y(MultiBitError_R1[0]));
  // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK or negedge BIST_ASYNC_RESETN) begin
      if (~BIST_ASYNC_RESETN) begin
         MultiBitError_R2           <= {1{1'b0}};
      end else begin
         MultiBitError_R2           <= MultiBitError_R1;
      end
   end
      and02 tessent_persistent_cell_AND_IOIndex0_R_cell0 (.A0(IOIndex0[0]),.A1(BIST_BIRA_EN & ERROR_R1[0]),.Y(IOIndex0_R[0]));
      and02 tessent_persistent_cell_AND_IOIndex0_R_cell1 (.A0(IOIndex0[1]),.A1(BIST_BIRA_EN & ERROR_R1[0]),.Y(IOIndex0_R[1]));
      and02 tessent_persistent_cell_AND_IOIndex0_R_cell2 (.A0(IOIndex0[2]),.A1(BIST_BIRA_EN & ERROR_R1[0]),.Y(IOIndex0_R[2]));
      and02 tessent_persistent_cell_AND_IOIndex0_R_cell3 (.A0(IOIndex0[3]),.A1(BIST_BIRA_EN & ERROR_R1[0]),.Y(IOIndex0_R[3]));
      and02 tessent_persistent_cell_AND_IOIndex0_R_cell4 (.A0(IOIndex0[4]),.A1(BIST_BIRA_EN & ERROR_R1[0]),.Y(IOIndex0_R[4]));

                       
   //------
   // SO --
   //------
   assign SO         = GO_ID_REG[0];
endmodule // blockA_rtl_tessent_mbist_c1_interface_m1_STATUS



module blockA_rtl_tessent_mbist_c1_interface_m1_ColumnRedundancyAnalysis (
        BIST_CLK,
        BIST_HOLD,
        BIST_SHIFT,
        BIST_ASYNC_RESETN          ,
        BIRA_FUSE_ADD_A            ,
        BIRA_FUSE_ADD_B            ,
        IOIndex0    ,
        MultiBitError_R,
        CLEAR,
        MBIST_RA_PRSRV_FUSE_VAL,
        RepairedBySpareRow,
        RepairableBySpareRow,
        PriorityColumn,
                     Seg1_SCOL0_FUSE_REG          ,
                     FROM_BISR_Seg1_SCOL0_FUSE_REG               ,
                     Seg1_SCOL0_ALLOC_REG         ,
                     FROM_BISR_Seg1_SCOL0_ALLOC_REG              ,
                     Seg1_SCOL0_FUSE_ADD_REG      ,
                     FROM_BISR_Seg1_SCOL0_FUSE_ADD_REG           ,

        ErrorGlobal,
        RepairedBySpareColumn,
        RepairableBySpareColumn,
        ERROR,
        LV_TM,   
        BIRA_SI,
        BIRA_SO
        ); 
input BIST_CLK;
input BIST_ASYNC_RESETN;
input BIST_HOLD,BIST_SHIFT;
input  [3:0]         BIRA_FUSE_ADD_A,BIRA_FUSE_ADD_B;
input  [0:0]         MultiBitError_R;
input  [4:0]        IOIndex0;
input CLEAR,MBIST_RA_PRSRV_FUSE_VAL;
input  RepairedBySpareRow,RepairableBySpareRow;
input  PriorityColumn;
output [4:0]         Seg1_SCOL0_FUSE_REG;
input [4:0]          FROM_BISR_Seg1_SCOL0_FUSE_REG;
output               Seg1_SCOL0_ALLOC_REG;
input                FROM_BISR_Seg1_SCOL0_ALLOC_REG;
output [3:0]         Seg1_SCOL0_FUSE_ADD_REG;
input [3:0]          FROM_BISR_Seg1_SCOL0_FUSE_ADD_REG;

input  [0:0]         ERROR;
input  LV_TM;
input  BIRA_SI;
output BIRA_SO;
output ErrorGlobal,RepairedBySpareColumn,RepairableBySpareColumn;
wire Seg1_SEGMENT_RANGE_EN_A,Seg1_SEGMENT_RANGE_EN_B;
 
assign Seg1_SEGMENT_RANGE_EN_A = 1'b1;
assign Seg1_SEGMENT_RANGE_EN_B = 1'b1;
      

wire LOCAL_RESET;
wire SpareColumnNeeded;
wire [0:0]           Repaired,RepairableBySpareColumnIORange,RepairedBySpareColumnIORange;
reg [4:0]           IOIndex0_R0;
wire [4:0]          IOIndex0_A;
wire [4:0]          IOIndex0_B;
reg                  IO_RANGE0_ERROR_MATCH_R;
reg                  IO_RANGE0_SPARES_AVAILABLE_R;
wire                 IO_RANGE0_SPARES_AVAILABLE;
wire [3:0]           IO_RANGE0_FUSE0_ADD_REG;
wire [4:0]           IO_RANGE0_FUSE0_REG;
wire                 IO_RANGE0_FUSE0_ALLOC;
wire                 IO_RANGE0_FUSE0_ERROR_MATCH;
wire                 IO_RANGE0_FUSE0_PAST_ALLOC;
wire                 IO_RANGE0_FUSE0_ERROR_MATCH_CONDITION;
wire                 IO_RANGE0_FUSE0_ERROR_MATCH_RESET_FLAG;
reg  [3:0]           Seg1_FUSE0_ADD_REG;
reg  [4:0]           Seg1_FUSE0_REG;
reg                  Seg1_FUSE0_ALLOC_REG;
reg                  Seg1_FUSE0_PAST_ALLOC_REG;
reg  [3:0]           Seg1_FUSE0_ADD_REG_INT;
reg  [4:0]           Seg1_FUSE0_REG_INT;
reg                  Seg1_FUSE0_ALLOC_REG_INT;
 
assign IO_RANGE0_FUSE0_ADD_REG =  ( Seg1_SEGMENT_RANGE_EN_A ) ? Seg1_FUSE0_ADD_REG_INT  :  { 4 {1'b0}};
assign IO_RANGE0_FUSE0_REG =  ( Seg1_SEGMENT_RANGE_EN_A ) ? Seg1_FUSE0_REG_INT   :  { 5 {1'b0}};
assign IO_RANGE0_FUSE0_ALLOC =  ( Seg1_SEGMENT_RANGE_EN_A ) ? Seg1_FUSE0_ALLOC_REG_INT   :  1'b0;
assign IO_RANGE0_FUSE0_PAST_ALLOC =  ( Seg1_SEGMENT_RANGE_EN_A ) ? Seg1_FUSE0_PAST_ALLOC_REG   :  1'b0;
 
always @(ERROR[0] or Repaired[0] or SpareColumnNeeded or Seg1_FUSE0_ALLOC_REG or
         Seg1_FUSE0_REG  or Seg1_FUSE0_ADD_REG or
          IOIndex0_B or BIRA_FUSE_ADD_B or Seg1_SEGMENT_RANGE_EN_B) begin
  if ( ERROR[0] & ~Repaired[0] & Seg1_SEGMENT_RANGE_EN_B & SpareColumnNeeded & ~Seg1_FUSE0_ALLOC_REG) begin
    Seg1_FUSE0_ADD_REG_INT         = BIRA_FUSE_ADD_B;
    Seg1_FUSE0_REG_INT             = IOIndex0_B;
    Seg1_FUSE0_ALLOC_REG_INT       = 1'b1;
  end else begin
    Seg1_FUSE0_ADD_REG_INT         = Seg1_FUSE0_ADD_REG;
    Seg1_FUSE0_REG_INT             = Seg1_FUSE0_REG;
    Seg1_FUSE0_ALLOC_REG_INT       = Seg1_FUSE0_ALLOC_REG;
  end
end
always @(posedge BIST_CLK or negedge BIST_ASYNC_RESETN) begin
  if ( ~ BIST_ASYNC_RESETN ) begin
    Seg1_FUSE0_ADD_REG             <= 4'b0000;
    Seg1_FUSE0_REG                  <= 5'b00000;
    Seg1_FUSE0_ALLOC_REG            <= 1'b0;
    Seg1_FUSE0_PAST_ALLOC_REG       <= 1'b0;
  end else
  if ( LOCAL_RESET ) begin
    Seg1_FUSE0_ADD_REG             <=FROM_BISR_Seg1_SCOL0_FUSE_ADD_REG ;
    Seg1_FUSE0_REG                  <= FROM_BISR_Seg1_SCOL0_FUSE_REG;
    Seg1_FUSE0_ALLOC_REG            <= FROM_BISR_Seg1_SCOL0_ALLOC_REG;
    Seg1_FUSE0_PAST_ALLOC_REG       <= FROM_BISR_Seg1_SCOL0_ALLOC_REG;
  end else begin
    if ( BIST_SHIFT ) begin
      Seg1_FUSE0_ADD_REG           <= {Seg1_FUSE0_ADD_REG[2:0],Seg1_FUSE0_ALLOC_REG};
      Seg1_FUSE0_REG                <= { Seg1_FUSE0_REG[3:0],BIRA_SI};
      Seg1_FUSE0_ALLOC_REG          <= Seg1_FUSE0_REG[4];
    end else begin
      if ( ~BIST_HOLD ) begin
        Seg1_FUSE0_ADD_REG         <= Seg1_FUSE0_ADD_REG_INT;
        Seg1_FUSE0_REG              <= Seg1_FUSE0_REG_INT;
        Seg1_FUSE0_ALLOC_REG        <= Seg1_FUSE0_ALLOC_REG_INT;
      end
    end
  end
end
assign BIRA_SO = Seg1_FUSE0_ADD_REG[3];
always @(posedge BIST_CLK or negedge BIST_ASYNC_RESETN) begin
  if ( ~ BIST_ASYNC_RESETN ) begin
     IOIndex0_R0     <= 5'b00000;
  end else
  if ( LOCAL_RESET ) begin
     IOIndex0_R0     <= 5'b00000;
  end else begin
     IOIndex0_R0     <= IOIndex0;
  end
end
assign IOIndex0_A = IOIndex0;
assign IOIndex0_B = IOIndex0_R0;
assign IO_RANGE0_FUSE0_ERROR_MATCH_CONDITION = IO_RANGE0_FUSE0_ALLOC &
                                           ( IO_RANGE0_FUSE0_ADD_REG  == BIRA_FUSE_ADD_A) &
                                           ( IO_RANGE0_FUSE0_REG == IOIndex0_A);
assign IO_RANGE0_FUSE0_ERROR_MATCH = IO_RANGE0_FUSE0_ALLOC &(~IO_RANGE0_FUSE0_PAST_ALLOC)&IO_RANGE0_FUSE0_ERROR_MATCH_CONDITION;
assign IO_RANGE0_FUSE0_ERROR_MATCH_RESET_FLAG = IO_RANGE0_FUSE0_PAST_ALLOC&IO_RANGE0_FUSE0_ERROR_MATCH_CONDITION;
always @(posedge BIST_CLK or negedge BIST_ASYNC_RESETN) begin
  if ( ~ BIST_ASYNC_RESETN ) begin
    IO_RANGE0_ERROR_MATCH_R <= 1'b0;
  end else
  IO_RANGE0_ERROR_MATCH_R <= IO_RANGE0_FUSE0_ERROR_MATCH;
 
end
 
 
assign IO_RANGE0_SPARES_AVAILABLE = ~(IO_RANGE0_FUSE0_ALLOC)&(~IO_RANGE0_FUSE0_ERROR_MATCH_RESET_FLAG);
always @(posedge BIST_CLK or negedge BIST_ASYNC_RESETN) begin
  if ( ~ BIST_ASYNC_RESETN ) begin
    IO_RANGE0_SPARES_AVAILABLE_R <= 1'b0;
  end else
  IO_RANGE0_SPARES_AVAILABLE_R <= IO_RANGE0_SPARES_AVAILABLE;
end
assign ErrorGlobal = |ERROR;
assign SpareColumnNeeded = ~RepairableBySpareRow | (PriorityColumn & RepairableBySpareColumn);
assign Repaired[0] = RepairedBySpareRow | RepairedBySpareColumnIORange[0];
assign LOCAL_RESET = CLEAR & ~MBIST_RA_PRSRV_FUSE_VAL & ~BIST_HOLD & ~BIST_SHIFT & ~LV_TM;
assign RepairedBySpareColumnIORange[0] = ~ERROR[0] | (~MultiBitError_R[0] & IO_RANGE0_ERROR_MATCH_R & ERROR[0]);
 
assign RepairedBySpareColumn = RepairedBySpareColumnIORange[0];
assign RepairableBySpareColumnIORange[0] = ((IO_RANGE0_SPARES_AVAILABLE_R & ERROR[0]) | ~ERROR[0] | RepairedBySpareColumnIORange[0] ) & ~MultiBitError_R[0];
assign RepairableBySpareColumn = RepairableBySpareColumnIORange[0];
assign Seg1_SCOL0_FUSE_REG = Seg1_FUSE0_REG;
assign Seg1_SCOL0_ALLOC_REG = Seg1_FUSE0_ALLOC_REG;
assign Seg1_SCOL0_FUSE_ADD_REG = Seg1_FUSE0_ADD_REG;
 
endmodule

module blockA_rtl_tessent_mbist_c1_interface_m1_RowRedundancyAnalysis (
        RepairedBySpareRow,
        RepairableBySpareRow,
        LV_TM,
        BIRA_SI,
        BIRA_SO
        );
input  LV_TM;
input BIRA_SI;
output BIRA_SO;
output RepairedBySpareRow,RepairableBySpareRow;
assign RepairedBySpareRow = 1'b0;
assign RepairableBySpareRow = 1'b0;
assign BIRA_SO        = BIRA_SI;
 
endmodule
 
