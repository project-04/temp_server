/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : T-2022.03-SP4
// Date      : Fri Jun 12 15:09:45 2026
/////////////////////////////////////////////////////////////


module apb_gpio_top ( PCLK, PRESET, PSEL, PENABLE, PWRITE, ext_clk_pad_i, 
        PADDR, PWDATA, aux_in, PRDATA, PREADY, IRQ, IO_pad );
  input [31:0] PADDR;
  input [31:0] PWDATA;
  input [31:0] aux_in;
  output [31:0] PRDATA;
  inout [31:0] IO_pad;
  input PCLK, PRESET, PSEL, PENABLE, PWRITE, ext_clk_pad_i;
  output PREADY, IRQ;

  tri   PCLK;
  tri   PRESET;
  tri   PSEL;
  tri   PENABLE;
  tri   PWRITE;
  tri   ext_clk_pad_i;
  tri   [31:0] PADDR;
  tri   [31:0] PWDATA;
  tri   [31:0] aux_in;
  tri   [31:0] PRDATA;
  tri   PREADY;
  tri   IRQ;
  tri   [31:0] IO_pad;
  tri   gpio_inta_o;
  tri   sys_clk;
  tri   sys_rst;
  tri   gpio_we;
  tri   [31:0] gpio_addr;
  tri   [31:0] gpio_dat_i;
  tri   [31:0] gpio_dat_o;
  tri   [31:0] in_pad_i;
  tri   gpio_eclk;
  tri   [31:0] aux_i;
  tri   [31:0] out_pad_o;
  tri   [31:0] oen_padoe_o;

  apb_slave_interface ASI ( .PCLK(PCLK), .PRESET(PRESET), .PSEL(PSEL), 
        .PENABLE(PENABLE), .PWRITE(PWRITE), .PADDR(PADDR), .PWDATA(PWDATA), 
        .gpio_inta_o(gpio_inta_o), .sys_clk(sys_clk), .sys_rst(sys_rst), 
        .gpio_we(gpio_we), .gpio_addr(gpio_addr), .gpio_dat_i(gpio_dat_i), 
        .gpio_dat_o(gpio_dat_o), .PRDATA(PRDATA), .PREADY(PREADY), .IRQ(IRQ)
         );
  gpio_register GR ( .sys_clk(sys_clk), .sys_rst(sys_rst), .gpio_we(gpio_we), 
        .gpio_addr(gpio_addr), .gpio_dat_i(gpio_dat_i), .in_pad_i(in_pad_i), 
        .gpio_eclk(gpio_eclk), .aux_i(aux_i), .gpio_inta_o(gpio_inta_o), 
        .gpio_dat_o(gpio_dat_o), .out_pad_o(out_pad_o), .oen_padoe_o(
        oen_padoe_o) );
  gpio_interface GI ( .ext_clk_pad_i(ext_clk_pad_i), .out_pad_o(out_pad_o), 
        .oen_padoe_o(oen_padoe_o), .in_pad_i(in_pad_i), .IO_pad(IO_pad), 
        .gpio_eclk(gpio_eclk) );
  aux_interface AI ( .sys_clk(sys_clk), .sys_rst(sys_rst), .aux_in(aux_in), 
        .aux_i(aux_i) );
endmodule

