      1 module blockB(CLK,in,out);
      2 input CLK,in;
      3 output out;
      4 
      5 wire [31:0] data_from_mem;
      6 
      7 assign out = ^data_from_mem;
      8 
      9 SYNC_8192X32_BISR memA (
     10                           .CLK(CLK),
     11                           .CEB(1'b0),
     12                           .WEB(1'b0),
     13                           .RSTB(1'b0),
     14                           .SCLK(1'b0),
     15                           .SDIN(1'b0),
     16                           .SDOUT(),
     17                           .A(13'd0),
     18                           .D(32'd0),
     19                           .BWEB(32'd0),
     20                           .TSEL(2'b01),
     21                           .Q(data_from_mem)
     22                         );
     23 endmodule

