interface bridge_if(input bit Hclk);
	logic Hresetn;
	logic Hsel;
	logic Hreadyin;
	logic [1:0] Htrans;
     	logic [1:0] Hsize;
	logic Hwrite;
	logic [11:0] Haddr;
	logic [31:0] Hwdata;
        logic [2:0]Hburst;	
	logic Hreadyout;
	logic  Hresp;
	logic [31:0] Hrdata;
        logic[7:0] length;
 
//Master Driver Clocking Block
	clocking mdr_cb@(posedge Hclk);
		default input #1 output #1;
	        output Hburst;
		input Hresp;
		output Hsel;
		input Hreadyout;
		output Hresetn;
		output Htrans;
		output Hwrite;
		output Hreadyin;
	        output Hsize;	
		output Hwdata;
		output Haddr;
		output length;
	endclocking : mdr_cb
	
//Master Slave Clocking Block
	clocking mmon_cb@(posedge Hclk);
		default input #1 output #1;
		input Hresetn;
		input Htrans;
		input Hwrite;
		input Hsize;
		input Hsel;
		input Hreadyin;
		input Hreadyout;
		input Hresp;
		input Hwdata;
		input Hrdata;
		input Haddr;
               input Hburst;
               input length;
	endclocking:mmon_cb
				
	
	modport MDR_MP(clocking mdr_cb);
	
	modport MMON_MP(clocking mmon_cb);
	
	
endinterface
	


