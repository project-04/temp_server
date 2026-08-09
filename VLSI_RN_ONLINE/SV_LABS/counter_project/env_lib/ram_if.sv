interface ram_if(input bit clk);
bit [3:0] data_in;
bit reset_n,load,up;
logic [3:0] data_out;


clocking wr_drv_cb @(posedge clk);
	default input #1 output #1;
	output reset_n;
	output load;
	output up;
	output data_in;
endclocking

clocking wr_mon_cb @(posedge clk);
        default input #1 output #1;
        input reset_n;
	input load;
	input up;
	input data_in;
endclocking

clocking rd_mon_cb @(posedge clk);
        default input #1 output #1;
        input data_out;
endclocking

modport WR_DRV_MP(clocking wr_drv_cb);
modport WR_MON_MP(clocking wr_mon_cb);
modport RD_MON_MP(clocking rd_mon_cb);

endinterface

