interface counter_if(input clk);
	
	//logic clk;
	logic up;
	logic reset_n;
	logic load;
	logic [3:0] data_in;
	
	logic [3:0] data_out;
	
	clocking drv_cb @(posedge clk);
		default input #1 output #1;
		output up, reset_n, load, data_in;
		input data_out;
	endclocking
	
	clocking mon_cb @(posedge clk);
		default input #1 output #1;
		input up, reset_n, load, data_in;
		input data_out;
	endclocking
	
	modport DRV_MP(clocking drv_cb);
	
	modport MON_MP(clocking mon_cb);
	
endinterface
