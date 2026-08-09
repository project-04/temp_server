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

Module blockA_rtl_tessent_sib_2 {
 
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
 
   ScanInterface client { 
     Port ijtag_si; 
     Port ijtag_so; 
     Port ijtag_sel;
   }
   ScanInterface host   { 
     Port ijtag_from_so; 
     Port ijtag_to_sel; 
   }
  
   Attribute keep_active_during_scan_test = "false";
  
   ScanRegister sib {
     ScanInSource    scan_in_mux;
     CaptureSource   1'b0;
     ResetValue      1'b0;
   }
 
   ScanMux scan_in_mux SelectedBy sib {
     1'b0 : ijtag_si;
     1'b1 : ijtag_from_so;
   }
 
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_instrument_type          = "mentor::ijtag_node";
   Attribute tessent_signature                = "7bc6f5608d3ad1c3110e3939581d85ee";
}
