/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : T-2022.03-SP4
// Date      : Tue Aug 26 15:12:50 2025
/////////////////////////////////////////////////////////////


module full_adder ( a_in, b_in, c_in, sum_out, carry_out );
  input a_in, b_in, c_in;
  output sum_out, carry_out;


  FA1A U2 ( .A(c_in), .B(a_in), .CI(b_in), .CO(carry_out), .S(sum_out) );
endmodule

