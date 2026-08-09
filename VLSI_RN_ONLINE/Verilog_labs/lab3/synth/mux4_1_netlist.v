/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : T-2022.03-SP4
// Date      : Wed Apr 29 12:10:10 2026
/////////////////////////////////////////////////////////////


module mux4_1 ( s, d, y );
  input [1:0] s;
  input [3:0] d;
  output y;


  MUX41P U6 ( .D0(d[0]), .D1(d[1]), .D2(d[2]), .D3(d[3]), .A(s[0]), .B(s[1]), 
        .Z(y) );
endmodule

