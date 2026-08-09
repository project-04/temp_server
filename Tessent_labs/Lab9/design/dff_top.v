

module dff_top(input A_p,B_p, clk_p, rst_p, input tms_p1,
         trst_p, tdi_p, tck_p, output Y_p, tdo_p); 

 wire [2:0]q;
wire w1, w2, w3, w4, w5, w6, w7;

dflipflop_design DFF1(clk, rst, w1, w2, q[0]);
dflipflop_design DFF2(clk, rst, w3, w4, q[1]);
dflipflop_design DFF3(clk, rst, w5, w6, q[2]);

and AND1(w1, A, B);
and AND3(w3, w1, w2);
or OR1(w7, A, w3);
and AND2(w5, w7, w4);
or OR2(Y, w5, w6);

  ipad tms_i ( .PAD(tms_p1), .C() );
  ipad trst_i ( .PAD(trst_p), .C() );
  ipad tdi_i ( .PAD(tdi_p), .C() );
  ipad tck_i ( .PAD(tck_p), .C() );
  
  opad tdo_i ( .I(), .OEN(1'b1), .PAD(tdo_p) );

  ipad clk_pad4 ( .PAD(clk_p), .C(clk) );
  ipad A_pad4 ( .PAD(A_p), .C(A) );
  ipad B_pad4 ( .PAD(B_p), .C(B) );
  ipad rst_pad4 ( .PAD(rst_p), .C(rst) );
  
  opad Y_pad7 ( .I(Y), .OEN(1'b1), .PAD(Y_p) );
endmodule


