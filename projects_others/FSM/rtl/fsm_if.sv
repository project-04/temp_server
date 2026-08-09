
interface fsm_if(input bit clk);
	
	logic rst;
	logic din;
	logic dout;
	
	clocking wr_drv_cb @(posedge clk);
		
		default input#1 output#0;

		output rst;
		output din;

	endclocking 

	clocking wr_mon_cb @(posedge clk);
		
		default input#1 output#0;

		input rst;
		input din;

	endclocking 

	clocking rd_mon_cb @(posedge clk);
		
		default input#1 output#0;

		input dout;

	endclocking			
	
	
	modport wr_drv_mp (clocking wr_drv_cb);
	modport wr_mon_mp (clocking wr_mon_cb);
	modport rd_mon_mp (clocking rd_mon_cb);
	
	
endinterface	
