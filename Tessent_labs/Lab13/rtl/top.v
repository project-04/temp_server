module top (clka, clkb, in1, out1, out2,tck,tdi,tdo,trst,tms,vddq,bisr_rstn);

input clka, clkb, in1, vddq;
input bisr_rstn;
output out1, out2;
input tck,tdi,trst,tms;
output tdo;

ipad clka_pad  (.PAD(clka), .C(clka_int));
ipad clkb_pad  (.PAD(clkb), .C(clkb_int));
ipad in1_pad ( .PAD (in1), .C(in1_int));
ipad bisr_rstn_pad (.PAD(bisr_rstn), .C() );
opad out1_pad ( .PAD(out1), .OEN(in1_int), .I(out1_int));
opad out2_pad ( .PAD(out2), .OEN(in1_int), .I(out2_int));
ipad tck_pad (.PAD(tck), .C());
ipad tdi_pad (.PAD(tdi), .C());
ipad trst_pad (.PAD(trst),.C());
ipad tms_pad (.PAD(tms),.C());
ipad vddq_pad  (.PAD(vddq), .C(vddq_int));
opad tdo_pad (.PAD(tdo), .OEN(1'b1), .I(1'b0));


cgand cgand1 ( .GCK(clka_gated) , .FE(out_int1) , .TE(1'b0) , .CK(clka_int) );
cgand cgand2 ( .GCK(clkb_gated) , .FE(out_int2) , .TE(1'b0) , .CK(clkb_int) );

core core_inst1 (.clka(clka_gated),
                 .clkb(clkb_gated),
                 .in(in1_int),
                 .out(out_int1));

core core_inst2 (.clka(clka_gated),
                 .clkb(clkb_gated),
                 .in(in1_int),
                 .out(out_int2));

my_fusebox_interface my_fusebox_interface (
   .clock(1'b0),
   .vddq(vddq),
   .address(10'b0),
   .write_en(1'b0),
   .select(1'b0),
   .access_en(1'b0),
   .scan_test(1'b0),
   .read_data(),
   .write_duration_count(32'b0),
   .done()
);


endmodule