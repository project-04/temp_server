//
//  Tessent Shell  2013.3
//
//  Design  = c1.v
//  Created = Tue Nov 19 10:34:44 2013
//
//  Statistics:
//      Test Coverage   =  100.00%
//      Total Faults    =  34
//          DS (det_simulation)    =  33
//          RE (redundant)         =  1
//      Total            Patterns  =  5
//
//  Settings:
//      Simulation Mode =  combinational, seq_depth = 0
//      Fault Type      =  stuck
//      Fault Mode      =  uncollapsed
//      Pos_Det Credit  =  50%
//      Z external      =  X
//      Z internal      =  X
//      wired_net       =  WIRE
//
//  Warnings:
//

ASCII_PATTERN_FILE_VERSION = 2;


SETUP = 

    declare input bus "PI" = "/a", "/b", "/c", "/d";

    declare output bus "PO" = "/z";

end;

SCAN_TEST =

    pattern = 0;
    force   "PI" "0001" 0;
    measure "PO" "1" 1;

    pattern = 1;
    force   "PI" "1001" 0;
    measure "PO" "1" 1;

end;
