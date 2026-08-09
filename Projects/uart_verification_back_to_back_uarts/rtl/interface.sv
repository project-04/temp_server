interface uart_if(input PCLK);
	//logic PCLK;
	logic PRESETn;
	logic [31:0] PADDR;
	logic [31:0] PWDATA;
	logic PWRITE;
	logic PENABLE;
	logic PSEL;	//only connect the one the are needed 
	logic RXD;
	
	logic [31:0] PRDATA;
	logic PREADY;
	logic PSLVERR;
	logic IRQ;
	logic TXD;
	
	logic baud_o;
	
	clocking drv_cb @(posedge PCLK);
		default input #1 output #1;
		output  PRESETn, PADDR, PWDATA, PWRITE, PENABLE, PSEL; //RXD
		input PRDATA, PREADY, PSLVERR, IRQ, baud_o;
	endclocking
	
	clocking mon_cb @(posedge PCLK);
		default input #1 output #1;
		input  PRESETn, PADDR, PWDATA, PWRITE, PENABLE, PSEL;
		input PRDATA, PREADY, PSLVERR, IRQ, baud_o;   //TXD
	endclocking
	
	modport DRV_MP(clocking drv_cb);
	
	modport MON_MP(clocking mon_cb);
	
endinterface