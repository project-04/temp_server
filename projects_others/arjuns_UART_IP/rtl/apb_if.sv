interface apb_if(input bit pclk);
	//bit PCLK;
	bit presetn;
	bit [31:0] paddr;
	bit [31:0] pwdata;
	bit pwrite;
	bit penable;
	bit psel;	//only connect the one the are needed 
	bit rxd;
	
	bit [31:0] prdata;
	bit pready;
	bit pslverr;
	bit irq;
	bit txd;
	
	bit baud_o;
	
	clocking drv_cb @(posedge pclk);
		default input #1 output #1;
		output  presetn, paddr, pwdata, pwrite, penable, psel; //RXD
		input prdata, pready, pslverr, irq, baud_o;
	endclocking
	
	clocking mon_cb @(posedge pclk);
		default input #1 output #1;
		input  presetn, paddr, pwdata, pwrite, penable, psel;
		input prdata, pready, pslverr, irq, baud_o;   //TXD
	endclocking
	
	modport DRV_MP(clocking drv_cb);
	
	modport MON_MP(clocking mon_cb);
	
endinterface

