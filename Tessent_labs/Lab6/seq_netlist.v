//
// Verilog description for cell seq_det, 
// Wed Apr  7 10:35:05 2021
//
// LeonardoSpectrum Level 3, 2018a.2 
//


module seq_det ( seq_in, clock, reset, det_o ) ;

    input seq_in ;
    input clock ;
    input reset ;
    output det_o ;

    wire nx42, nx88, state_1, state_0, nx10, nx99, nx101;
    wire [0:0] \$dummy ;




    GND ix89 (.Y (nx88)) ;
    tri01 tri_det_o (.Y (det_o), .A (nx88), .E (nx42)) ;
    and02 ix17 (.Y (nx42), .A0 (state_1), .A1 (state_0)) ;
    aoi21 ix11 (.Y (nx10), .A0 (nx99), .A1 (seq_in), .B0 (nx101)) ;
    dffr reg_state_1 (.Q (state_1), .QB (nx99), .D (nx10), .CLK (clock), .R (
         reset)) ;
    xnor2 ix102 (.Y (nx101), .A0 (seq_in), .A1 (state_0)) ;
    dffr reg_state_0 (.Q (state_0), .QB (\$dummy [0]), .D (seq_in), .CLK (clock)
         , .R (reset)) ;
endmodule

