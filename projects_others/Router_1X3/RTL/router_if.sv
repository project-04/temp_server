interface router_if(input bit clock);

	logic [7:0] data_in;
	logic pkt_valid,error,busy,resetn;
	logic [7:0] data_out;
	logic read_enb,valid_out;

clocking src_drv_cb @(posedge clock);
	default input #1 output #1;
	output pkt_valid;
	output data_in;
	output resetn;
	input busy;
	input error;
endclocking

clocking src_mon_cb @(posedge clock);
	default input #1 output #1;
	input pkt_valid;
	input data_in;
	input resetn;
	input busy;
	input error;
endclocking 

clocking dest_drv_cb @(posedge clock);
	default input #1 output #1;
	output read_enb;
	input  valid_out;
endclocking 

clocking dest_mon_cb @(posedge clock);
	default input #1 output #1;
	input read_enb;
	input data_out;
	input valid_out;
endclocking 

	modport SRC_DRV_MP(clocking src_drv_cb);

	modport SRC_MON_MP(clocking src_mon_cb);

	modport DEST_MON_MP(clocking dest_mon_cb);

	modport DEST_DRV_MP(clocking dest_drv_cb);

endinterface	
	
