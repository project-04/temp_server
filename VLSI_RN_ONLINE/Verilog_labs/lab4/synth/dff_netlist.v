/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : T-2022.03-SP4
// Date      : Wed Jan 28 14:07:47 2026
/////////////////////////////////////////////////////////////


module dff ( clock, reset, d_in, q_out, qb_out );
  input clock, reset, d_in;
  output q_out, qb_out;
  wire   N3, n3;

  FD1 q_out_reg ( .D(N3), .CP(clock), .Q(q_out), .QN(qb_out) );
  IVP U6 ( .A(d_in), .Z(n3) );
  NR2 U7 ( .A(reset), .B(n3), .Z(N3) );
endmodule

