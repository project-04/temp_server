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
-       Created on: Wed Aug 14 12:11:30 IST 2019                                 -
----------------------------------------------------------------------------------


*/
   // ============================================================================
// == Description     : ICL description for blockA_LVISION_MBISTPG_CTRL
// == Tool Name       : membistipCommonGenerate
// == Tool Version    : 2019.1      Fri Feb 15 21:15:11 GMT 2019
// ============================================================================
Module blockA_rtl_tessent_mbist_c1_controller {
  ClockPort     BIST_CLK { Attribute forced_low_input_port_list = "TCK_MODE"; }
  DataInPort    BIST_CLK_EN;
  DataInPort    MBISTPG_EN;
  DataInPort    BIST_HOLD;
  DataInPort    LV_TM { Attribute connection_rule_option = "allowed_tied_low"; }
  DataInPort           MEM_BYPASS_EN {
    Attribute connection_rule_option = "allowed_tied_low";}
  DataInPort           MCP_BOUNDING_EN {
    Attribute connection_rule_option = "allowed_tied_low";}
  DataInPort    MBIST_RA_PRSRV_FUSE_VAL {RefEnum OnOff;}
  DataInPort    MBISTPG_BIRA_EN {RefEnum OnOff;}
  DataInPort    CHECK_REPAIR_NEEDED {RefEnum OnOff;}
  DataInPort    MBISTPG_ASYNC_RESETN {RefEnum AsyncResetN;}
  DataInPort    MBISTPG_DIAG_EN;
  DataInPort    BIST_SETUP2;
  DataInPort    BIST_SETUP[1:0];
  DataInPort    TCK_MODE;
  DataInPort    MBISTPG_REDUCED_ADDR_CNT_EN {RefEnum OnOff;}
  DataInPort    MBISTPG_MEM_RST {RefEnum OnOff;}
  DataInPort    MBISTPG_TESTDATA_SELECT {RefEnum OnOff;}
  DataInPort    FL_CNT_MODE[1:0];
  DataInPort    MBISTPG_ALGO_MODE[1:0];
  DataOutPort   MBISTPG_GO   {RefEnum PassFail;}
  DataOutPort   MBISTPG_DONE {RefEnum PassFail;}
  TCKPort       TCK;                       
  ScanInPort    BIST_SI;
  ScanOutPort   MBISTPG_SO {Source BIST_SO_INT;}
  ShiftEnPort   BIST_SHIFT {Attribute connection_rule_option = "allowed_no_source";}
  ToShiftEnPort  BIST_SHIFT_COLLAR {Attribute connection_rule_option = "allowed_no_destination";}
  DataOutPort   BIST_COLLAR_EN0 {Attribute tessent_memory_alias = "m1";}
  ScanOutPort   MEM0_BIST_COLLAR_SI { Source MEM0_BIST_COLLAR_SI_INT;}
  ScanInPort    MEM0_BIST_COLLAR_SO;
  ScanInterface Client {
    Port BIST_SI;
    Port MBISTPG_SO;
    Port BIST_SHIFT;
  }
  ScanInterface MEM0_INTERFACE { 
    Port BIST_SHIFT_COLLAR;
    Port MEM0_BIST_COLLAR_SI;
    Port MEM0_BIST_COLLAR_SO;
  }
  Alias        SETUP_MODE[2:0] = BIST_SETUP2,BIST_SETUP[1:0] { RefEnum SetupModes; }
  Alias        RUN_MODE[3:0]   = MBISTPG_EN,BIST_SETUP2,BIST_SETUP[1:0] { RefEnum RunModes; }
  Enum         PassFail {
                    Pass = 1'b1;
                    Fail = 1'b0;
                    Ignore = 1'bx;
               }
  Enum         AsyncResetN {
                    On = 1'b0;
                    Off = 1'b1;
               }
  Enum         SetupModes {
                    Short = 3'b000; 
                    Long  = 3'b001; 
                    Bira  = 3'b100;
               }
  Enum         OnOff {
                    On  = 1'b1;
                    Off = 1'b0;
               }
  Enum         RunModes   {
                    HWDefault   = 4'b1010; 
                    RunTimeProg = 4'b1011;
                    Idle        = 4'bxx0x;
                    Off         = 4'b0xxx;
               }
  LogicSignal  BIRA_SETUP  { MBISTPG_EN,SETUP_MODE[2:0] == 1'b1,3'b100;}
  LogicSignal  LONG_SETUP  { MBISTPG_EN,SETUP_MODE[2:0] == 1'b1,3'b001;}
  LogicSignal  SHORT_SETUP { MBISTPG_EN,SETUP_MODE[2:0] == 1'b1,3'b000;}
 
// [start] : LONG_SETUP / SHORT_SETUP chain registers {{{
  ScanRegister DIAG_EN_REG[0:0] {
      ScanInSource   BIST_SI;
  }
  ScanRegister BIRA_EN_REG[0:0] {
      ScanInSource   DIAG_EN_REG[0];
  }
  ScanRegister CMP_EN_MASK_EN[0:0] {
      ScanInSource   BIRA_EN_REG[0];
  }
  ScanRegister CMP_EN_PARITY[0:0] {
      ScanInSource   CMP_EN_MASK_EN[0];
  }
  ScanRegister MEM_SELECT_REG0[0:0] {
      ResetValue     1'd1;
      ScanInSource   CMP_EN_PARITY[0];
  }
  ScanRegister REDUCED_ADDR_CNT_EN_REG[0:0] {
      ScanInSource   MEM_SELECT_REG0[0];
      RefEnum        OnOff;
  }
  ScanRegister ALGO_SEL_CNT_REG[0:0] {
      ScanInSource   REDUCED_ADDR_CNT_EN_REG[0];
      RefEnum        OnOff;
  }
  ScanRegister SELECT_COMMON_OPSET_REG[0:0] {
      ScanInSource   ALGO_SEL_CNT_REG[0];
      RefEnum        OnOff;
  }
  ScanRegister SELECT_COMMON_DATA_PAT_REG[0:0] {
      ScanInSource   SELECT_COMMON_OPSET_REG[0];
      RefEnum        OnOff;
  }
  ScanRegister MICROCODE_EN_REG[0:0] {
      ScanInSource   SELECT_COMMON_DATA_PAT_REG[0];
  }
  ScanRegister INST_POINTER_REG_HW[0:4] {
      ScanInSource   MICROCODE_EN_REG[0];
  }
  Alias INST_POINTER_REG[4:0] = INST_POINTER_REG_HW[4:0];
  ScanRegister A_ADD_REG_Y_HW[0:3] {
      ScanInSource   INST_POINTER_REG_HW[4];
  }
  Alias A_ADD_REG_Y[3:0] = A_ADD_REG_Y_HW[3:0];
  ScanRegister A_ADD_REG_X_HW[0:8] {
      ScanInSource   A_ADD_REG_Y_HW[3];
  }
  Alias A_ADD_REG_X[8:0] = A_ADD_REG_X_HW[8:0];
  ScanRegister B_ADD_REG_Y_HW[0:3] {
      ScanInSource   A_ADD_REG_X_HW[8];
  }
  Alias B_ADD_REG_Y[3:0] = B_ADD_REG_Y_HW[3:0];
  ScanRegister B_ADD_REG_X_HW[0:8] {
      ScanInSource   B_ADD_REG_Y_HW[3];
  }
  Alias B_ADD_REG_X[8:0] = B_ADD_REG_X_HW[8:0];
  ScanRegister OPSET_SELECT_REG[0:0] {
      ScanInSource   B_ADD_REG_X_HW[8];
  }
  ScanRegister WDATA_REG_HW[0:1] {
      ScanInSource   OPSET_SELECT_REG[0];
  }
  Alias WDATA_REG[1:0] = WDATA_REG_HW[1:0];
  ScanRegister EDATA_REG_HW[0:1] {
      ScanInSource   WDATA_REG_HW[1];
  }
  Alias EDATA_REG[1:0] = EDATA_REG_HW[1:0];
  ScanRegister X_ADDR_BIT_SEL_REG[0:0] {
      ScanInSource   EDATA_REG_HW[1];
  }
  ScanRegister Y_ADDR_BIT_SEL_REG[0:0] {
      ScanInSource   X_ADDR_BIT_SEL_REG[0];
  }
  ScanRegister REPEATLOOP_A_CNTR_REG_HW[0:1] {
      ScanInSource   Y_ADDR_BIT_SEL_REG[0];
  }
  Alias REPEATLOOP_A_CNTR_REG[1:0] = REPEATLOOP_A_CNTR_REG_HW[1:0];
  ScanRegister REPEATLOOP_B_CNTR_REG_HW[0:1] {
      ScanInSource   REPEATLOOP_A_CNTR_REG_HW[1];
  }
  Alias REPEATLOOP_B_CNTR_REG[1:0] = REPEATLOOP_B_CNTR_REG_HW[1:0];
  ScanMux BIST_TO_COLLAR_SO_MUX SelectedBy LONG_SETUP,SHORT_SETUP {
      2'b01 : Y_ADDR_BIT_SEL_REG[0];
      2'b10 : REPEATLOOP_B_CNTR_REG_HW[1];
  }
  ScanMux MEM0_TO_COLLAR_SI_MUX SelectedBy BIRA_SETUP {
      1'b0 : BIST_TO_COLLAR_SO_MUX;
      1'b1 : BIST_SI;
  }
  Alias MEM0_BIST_COLLAR_SI_INT = MEM0_TO_COLLAR_SI_MUX;
  ScanRegister PRESERVE_BIRA_FUSE_REG[0:0] {
      ScanInSource   MEM0_BIST_COLLAR_SO;
  }
  ScanRegister LOAD_BISR_FUSE_REG[0:0] {
      ScanInSource   PRESERVE_BIRA_FUSE_REG[0];
  }
  ScanRegister STOP_ON_ERROR_REG[0:0] {
      ScanInSource   LOAD_BISR_FUSE_REG[0];
  }
  ScanRegister FREEZE_STOP_ERROR_REG[0:0] {
      ScanInSource   STOP_ON_ERROR_REG[0];
  }
  ScanRegister STOP_ERROR_CNT_REG_HW[0:11] {
      ScanInSource   FREEZE_STOP_ERROR_REG[0];
  }
  Alias STOP_ERROR_CNT_REG[11:0] = STOP_ERROR_CNT_REG_HW[11:0];
 ScanMux CONTROLLER_SETUP_CHAIN SelectedBy MBISTPG_EN,SETUP_MODE[2:0] {
     1'b1,3'b00x : STOP_ERROR_CNT_REG_HW[11];
 }
// [end]   : LONG_SETUP / SHORT_SETUP chain registers }}}
//---------------------------------------------
// BIRA shift Chain Description
//---------------------------------------------
// The BIRA registers are on a dedicated setup chain.
// Variable LV_BIRA_SETUP is the chain length.
// Bit 0 is towards BIST_SO.
  ScanMux BIRA_SETUP_MUX SelectedBy BIRA_SETUP {
      1'b0 : CONTROLLER_SETUP_CHAIN;
      1'b1 : MEM0_BIST_COLLAR_SO;
  }
  Alias BIST_SO_INT = BIRA_SETUP_MUX;
  Attribute     tessent_instrument_container           = "blockA_rtl_mbist";
  Attribute     tessent_instrument_type                = "mentor::memory_bist";
  Attribute     tessent_instrument_subtype             = "controller";
  Attribute     tessent_signature                      = "4fc27619b98688e4ac73671684dfe455";
  Attribute     tessent_ignore_during_icl_verification = "on";
  Attribute     keep_active_during_scan_test           = "false";
  Attribute     tessent_use_in_dft_specification       = "false";
  Attribute     tessent_bist_clk_persistent_cell_output_list     = "tessent_persistent_cell_GATING_BIST_CLK/GCK";
}
