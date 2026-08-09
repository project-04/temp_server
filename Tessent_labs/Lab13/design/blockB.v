
module blockB(input CLK,in,output out);

      wire [31:0] data_from_mem;
      
       assign out = ^data_from_mem;
      
       SYNC_8192X32_BISR memA (
                                .CLK(CLK),
                                .CEB(1'b0),
                                .WEB(1'b0),
                                .RSTB(1'b0),
                                .SCLK(1'b0),
                               .SDIN(1'b0),
                               .SDOUT(),
                               .A(13'd0),
                               .D(32'd0),
                               .BWEB(32'd0),
                               .TSEL(2'b01),
                               .Q(data_from_mem)
                             );
      endmodule
