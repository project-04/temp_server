interface ven_if(input clock);

	logic reset;
	logic [1:0] coin_in;
	logic done_out;
	logic [6:0] lsb7seg_out, msb7seg_out;
	
	clocking wr_drv_cb@(posedge clock);
		default input #1 output #1;
		output reset, coin_in;
		//input done_out, lsb7seg_out, msb7seg_out;
	endclocking
	
	clocking wr_mon_cb@(posedge clock);
		default input #1 output #1;
		input reset, coin_in;
		//input done_out, lsb7seg_out, msb7seg_out;
	endclocking
	
	clocking rd_mon_cb@(posedge clock);
		default input #1 output #1;
		input reset, coin_in;
		input done_out, lsb7seg_out, msb7seg_out;
	endclocking
	
	modport WR_DRV_MP(clocking wr_drv_cb);
	modport WR_MON_MP(clocking wr_mon_cb);
	modport RD_MON_MP(clocking rd_mon_cb);
endinterface
