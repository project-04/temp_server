

interface apb_if(input bit clk);

	logic		Presetn;
	logic	[31:0] 	Paddr;
	logic		Psel;
	logic 		Pwrite;
	logic 		Penable;
	logic 	[31:0] 	Pwdata;
	logic 	[31:0] 	Prdata;
	logic 		Pready;
	logic 		Pslverr;

	logic		IRQ;
	logic		baud_o;

	clocking apb_drv_cb @(posedge clk);
		
	default input #1 output #0;
		
		output Presetn;
		output Paddr;
		output Psel;
		output Pwrite;
		output Penable;
		output Pwdata;
	
		input Pready;
		input Prdata;
		input Pslverr;
	
		input IRQ;
		input baud_o;

	endclocking


	clocking apb_mon_cb @(posedge clk);
		
	default input #1 output #0;

		input Presetn;
		input Paddr;
		input Psel;
		input Pwrite;
		input Penable;
		input Pwdata;
	
		input Pready;
		input Prdata;
		input Pslverr;
	
		input IRQ;
		input baud_o;

	endclocking


	modport DRV_MP (clocking apb_drv_cb);
	modport MON_MP (clocking apb_mon_cb);

endinterface	
			
	

	

