interface bridge_if(input bit Hclk);
	logic Hresetn;
	logic [1:0] Htrans;
	logic Hwrite;
    logic [2:0]Hburst;	
	logic Hreadyin;
	logic Hreadyout;
	logic [1:0] Hresp;
	logic [31:0] Hwdata;
	logic [31:0] Hrdata;
	logic [31:0] Haddr;
    logic Penable;
	logic Pwrite;
	logic [31:0] Pwdata;
	logic [31:0] Prdata;
	logic [31:0] Paddr;
	logic [3:0] Pselx;
     logic [2:0] Hsize;
	
//Master Driver Clocking Block
	clocking mdr_cb@(posedge Hclk);
		default input #1 output #1;
	        output Hburst;
		input Hresp;
		input Hreadyout;
		output Hresetn;
		output Htrans;
		output Hwrite;
		output Hreadyin;
	        output Hsize;	
		output Hwdata;
		output Haddr;
	endclocking : mdr_cb
	
//Master Slave Clocking Block
	clocking mmon_cb@(posedge Hclk);
		default input #1 output #1;
		input Hresetn;
		input Htrans;
		input Hwrite;
		input Hsize;
		input Hreadyin;
		input Hreadyout;
		input Hresp;
		input Hwdata;
		input Hrdata;
		input Haddr;
        input Hburst;
	endclocking:mmon_cb
				
		//Slave Driver Clocking Block
	clocking sdr_cb@(posedge Hclk);
		default input #1 output #1;
		input Penable;
		input Pwrite;
		input Pwdata;
		input Paddr;	
        	input Pselx;
		output Prdata;
	endclocking : sdr_cb
	
//Slave Monitor Clocking Block
	clocking smon_cb@(posedge Hclk);
		default input #1 output #1;
		input Penable;
		input Pwrite;
		input Pwdata;
		input Paddr;
		input Pselx;
		input Prdata;
	endclocking : smon_cb

	modport MDR_MP(clocking mdr_cb);
	
	modport MMON_MP(clocking mmon_cb);
	
	modport SDR_MP(clocking sdr_cb);
	
	modport SMON_MP(clocking smon_cb);
	
endinterface
	



