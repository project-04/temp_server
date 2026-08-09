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
//       Created on: Wed Aug 14 12:11:28 IST 2019
//--------------------------------------------------------

Module blockA_rtl_tessent_sib_1 {
 
   ResetPort     ijtag_reset            { ActivePolarity 0;      }
   SelectPort    ijtag_sel;
   ScanInPort    ijtag_si;
   CaptureEnPort ijtag_ce;
   ShiftEnPort   ijtag_se;
   UpdateEnPort  ijtag_ue;
   TCKPort       ijtag_tck;
   ScanOutPort   ijtag_so               { Source sib;            }
   ToSelectPort  ijtag_to_sel           { 
     Attribute connection_rule_option = "allowed_no_destination"; 
   }
   ScanInPort    ijtag_from_so          { 
     Attribute connection_rule_option = "allowed_no_source"; 
   }
   ToResetPort   to_ijtag_reset         { Source ijtag_reset; ActivePolarity 0;}
   ScanOutPort   to_ijtag_si            { Source ijtag_si;
     Attribute connection_rule_option = "allowed_no_destination";
   }
   ToCaptureEnPort to_ijtag_ce          { Source ijtag_ce; 
     Attribute connection_rule_option = "allowed_no_destination";
   }
   ToShiftEnPort to_ijtag_se            { Source ijtag_se; 
     Attribute connection_rule_option = "allowed_no_destination";
   }
   ToUpdateEnPort to_ijtag_ue           { Source ijtag_ue; 
     Attribute connection_rule_option = "allowed_no_destination";
   }
   ToTCKPort     to_ijtag_tck           { 
     Attribute connection_rule_option = "allowed_no_destination";
   }
   DataInPort    ltest_en               {
     Attribute explicit_iwrite_only = 1'b1;
     Attribute connection_rule_option = "allowed_tied_low";
   }
   DataInPort    ltest_occ_en           {
     Attribute explicit_iwrite_only = 1'b1;
     Attribute connection_rule_option = "allowed_tied_low";
   }
   DataInPort    ltest_static_clock_control_mode                 {
     Attribute connection_rule_option = "allowed_tied_low";
   }
   DataOutPort   ltest_to_en            { 
     Attribute connection_rule_option = "allowed_no_destination";
     Source ltest_en;
   }
   DataInPort    ltest_mem_bypass_en    {
     Attribute connection_rule_option = "allowed_tied";
   }
   DataOutPort   ltest_to_mem_bypass_en                          { 
     Attribute connection_rule_option = "allowed_no_destination";
     Source ltest_to_mem_bypass_en_int;
   }
   DataInPort    ltest_mcp_bounding_en  {
     Attribute explicit_iwrite_only = 1'b1;
     Attribute connection_rule_option = "allowed_tied";
   }
   DataOutPort   ltest_to_mcp_bounding_en                        { 
     Attribute connection_rule_option = "allowed_no_destination";
     Source ltest_to_mcp_bounding_en_int;
   }
 
   ScanInterface client { 
     Port ijtag_si; 
     Port ijtag_so; 
     Port ijtag_sel;
   }
   ScanInterface host   { 
     Port ijtag_from_so; 
     Port ijtag_to_sel; 
     Port to_ijtag_si;
   }
  
   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_dft_function = "scan_tested_instrument_host";
  
   LogicSignal ltest_to_mem_bypass_en_int {
     ltest_mem_bypass_en & ltest_en;
   }
   LogicSignal ltest_to_mcp_bounding_en_int {
     ltest_mcp_bounding_en & ltest_en;
   }
   
   ScanRegister sib {
     ScanInSource    scan_in_mux;
     CaptureSource   1'b0;
     ResetValue      1'b0;
   }
 
   ScanMux scan_in_mux SelectedBy sib,ltest_en {
     2'b10 : ijtag_from_so;
     2'bxx : ijtag_si;
   }
 
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_instrument_type          = "mentor::ijtag_node";
   Attribute tessent_signature                = "1a099af55b9e24e48186a7174c637a24";
}
