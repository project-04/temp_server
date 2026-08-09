module apb_gpio_top(
	input PCLK,PRESET,PSEL, PENABLE, PWRITE, ext_clk_pad_i,
	input [31:0] PADDR, PWDATA, aux_in,
	output [31:0] PRDATA,
	output PREADY,IRQ,
	inout [31:0] IO_pad);

	wire [31:0] gpio_addr,gpio_dat_i,gpio_dat_o, aux_i, out_pad_o, oen_padoe_o, in_pad_i;
	wire sys_rst, sys_clk, gpio_we, gpio_inta_o,gpio_eclk;

	apb_slave_interface ASI (.PCLK(PCLK),
				.PRESET(PRESET),
				.PSEL(PSEL),
				.PENABLE(PENABLE),
				.PWRITE(PWRITE),
				.PADDR(PADDR),
				.PWDATA(PWDATA),
				.gpio_inta_o(gpio_inta_o),
				.sys_clk(sys_clk),
				.sys_rst(sys_rst),
				.gpio_we(gpio_we),
				.gpio_addr(gpio_addr),
				.gpio_dat_i(gpio_dat_i),
				.gpio_dat_o(gpio_dat_o),
				.PRDATA(PRDATA),
				.PREADY(PREADY),
				.IRQ(IRQ));


	gpio_register GR (.sys_clk(sys_clk),
			.sys_rst(sys_rst),
			.gpio_we(gpio_we),
			.gpio_addr(gpio_addr),
			.gpio_dat_i(gpio_dat_i),
			.in_pad_i(in_pad_i),
			.gpio_eclk(gpio_eclk),
			.aux_i(aux_i),
			.gpio_inta_o(gpio_inta_o),
			.gpio_dat_o(gpio_dat_o),
			.out_pad_o(out_pad_o),
			.oen_padoe_o(oen_padoe_o));


	gpio_interface GI (.ext_clk_pad_i(ext_clk_pad_i),
			.out_pad_o(out_pad_o),
			.oen_padoe_o(oen_padoe_o),
			.in_pad_i(in_pad_i),
			.IO_pad(IO_pad),
			.gpio_eclk(gpio_eclk));


	aux_interface AI (.sys_clk(sys_clk),
			.sys_rst(sys_rst),
			.aux_in(aux_in),
			.aux_i(aux_i));
endmodule
