interface spi_if(input bit clk);

//Wishbone Interface Signals

	logic wb_clk_i;
	logic wb_rst_i;
	logic wb_adr_i;
	logic wb_dat_i;
	logic wb_dat_o;
	logic wb_sel_i;
	logic wb_we_i;
	logic wb_stb_i; 
	logic wb_cyc_i;	
	logic wb_ack_o;
	logic wb_err_o;	
	logic wb_int_o;

assign wb_clk_i = clk;
//SPI Interface Signals
	
	logic ss_pad_o;
	logic sclk_pad_o;
	logic mosi_pad_o;
	logic miso_pado_i;


//Wishbone Driver block
clocking wb_drv_cb (@posedge clk);
	default input #1 output #1;
		output wb_rst_i;
		output wb_adr_i;
		output wb_dat_i;
		output wb_sel_i;
		output wb_we_i;
		output wb_stb_i;
		output wb_cyc_i;
		input wb_dat_o;
		input wb_ack_o;
		input wb_err_o;
		input wb_int_o;
endclocking
//Wishbone Monitor block
clocking wb_mon_cb (@posedge clk);
	default input #1 output #1;
		input wb_rst_i;
		input wb_adr_i;
		input wb_dat_i;
		input wb_sel_i;
		input wb_we_i;
		input wb_stb_i;
		input wb_cyc_i;
		input wb_dat_o;
		input wb_ack_o;
		input wb_err_o;
		input wb_int_o;
endclocking
//Slave Driver block
clocking sl_drv_cb (@posedge clk);
	default input #1 output #1;
		output miso_pad_i;
		input mosi_pad_o;
		input sclk_pad_o;
		input ss_pad_o;
endclocking

//Slave Monitor block
clocking sl_mon_cb (@posedge clk);	
	default input #1 output #1;
		input miso_pad_i;	
		input mosi_pads_o;
		input sclk_pad_o;
		input ss_pad_o;
endclocking


	modport WB_DRV (clocking wb_drv_cb);
	modport WB_MON (clocking wb_mon_cb);
	modport SL_DRV (clocking sl_drv_cb);
	modport SL_DRV (clocking sl_mon_cb);

endinterface

