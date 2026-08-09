interface axi_if(input bit ACLK);
	
	//Write Address Signals
	logic 	[7:0] AWID;
	logic 	[31:0] AWADDR;
	logic 	[7:0] AWLEN;
	logic 	[2:0] AWSIZE;
	logic 	[1:0] AWBURST;
	bit 	AWVALID;
	bit 	AWREADY; //o

	//Write Data Channels Signals
	logic 	[7:0] WID;
	logic 	[31:0] WDATA;
	logic 	[3:0] WSTRB;
	logic 	WLAST;
	bit 	WVALID;
	bit 	WREADY; //o

	//Write Response Channel Signals
	logic 	[7:0] BID; //o
	logic 	[1:0] BRESP; //o
	bit 	BVALID; //o
	bit 	BREADY;
	
	// Read Address Channel Signals
	logic 	[7:0] ARID;
	logic 	[31:0] ARADDR;
	logic 	[7:0] ARLEN;
	logic 	[2:0] ARSIZE;
	logic 	[1:0] ARBURST;
	bit 	ARVALID;
	bit 	ARREADY; //o

	//Read Data Channel Signals
	logic 	[7:0] RID; //o
	logic 	[31:0] RDATA; //o
	logic 	[1:0] RRESP; //o
	logic 	RLAST; //o
	bit 	RVALID; //o
	bit 	RREADY;

	// Master Driver Clocking Block
	clocking mst_drv_cb @(posedge ACLK);
		default input #1 output #1;
		
		// Write Address Signals
		output 	AWID;
		output 	AWADDR;
		output 	AWLEN;
		output 	AWSIZE;
		output 	AWBURST;
		output 	AWVALID;
           
		input 	AWREADY;
                
		// Write Data Signals
		output 	WID;
		output	WDATA;
		output 	WSTRB;
		output 	WLAST;
		output 	WVALID;

		input 	WREADY;

		//Write Response Signals
		output 	BREADY;

		input 	BID;
		input 	BRESP;		
		input 	BVALID;

		// Read Address Signals
		output 	ARID;
		output 	ARADDR;
		output 	ARLEN;
		output 	ARSIZE;
		output 	ARBURST;
		output 	ARVALID;
 
		input 	ARREADY;
		
		// Read Data Signals
		output 	RREADY;

		input 	RID;
		input 	RDATA;
		input 	RRESP;
		input 	RLAST;
		input 	RVALID;
	
	endclocking

	// Slave Driver Clocking Block
        clocking slv_drv_cb @(posedge ACLK);
		default input #1 output #1;
		
		// Write Address Signals
		output 	AWREADY;

		input 	AWID;
		input 	AWADDR;
		input 	AWLEN;
		input 	AWSIZE;
		input 	AWBURST;
		input 	AWVALID;

		// Write Data Signals
		output 	WREADY;

		input 	WID;
		input 	WDATA;
		input 	WSTRB;
		input 	WLAST;
		input 	WVALID;

		//Write Response Signals
		output 	BID;
		output 	BRESP;
		output 	BVALID;

		input 	BREADY;

		// Read Address Signals
		output 	ARREADY;

		input 	ARID;
		input 	ARADDR;
		input 	ARLEN;
		input 	ARSIZE;
		input 	ARBURST;
		input 	ARVALID;

		// Read Data Signals
		output 	RID;
		output 	RDATA;
		output 	RRESP;
		output 	RLAST;
		output 	RVALID;

		input 	RREADY;

	endclocking
        
  	// Master Monitor Clocking Block
	clocking mst_mon_cb @(posedge ACLK);
		default input #1 output #1;
		
		// Write Address Signals
		input 	AWID;
		input 	AWADDR;
		input 	AWLEN;
		input 	AWSIZE;
		input 	AWBURST;
		
		input 	AWVALID;
		input 	AWREADY;
  
		// Write Data Signals
		input 	WID;
		input 	WDATA;
		input 	WSTRB;
		input 	WLAST;
		
		input 	WVALID;
		input 	WREADY;

		//Write Response Signals
		input 	BID;
		input 	BRESP;
		
		input 	BVALID;
		input 	BREADY;

		// Read Address Signals
		input 	ARID;
		input 	ARADDR;
		input 	ARLEN;
		input 	ARSIZE;
		input 	ARBURST;
	
		input 	ARVALID;
		input 	ARREADY;
		
		// Read Data Signals
		input 	RID;
		input 	RDATA;
		input 	RRESP;
		input 	RLAST;
		
		input 	RVALID;
		input 	RREADY;

	endclocking
	
	// Slave Monitor Clocking Block
	clocking slv_mon_cb @(posedge ACLK);
		default input #1 output #1;
		
		// Write Address Signals
		input 	AWID;
		input 	AWADDR;
		input 	AWLEN;
		input 	AWSIZE;
		input 	AWBURST;
		
		input 	AWVALID;
		input 	AWREADY;
  
		// Write Data Signals
		input 	WID;
		input 	WDATA;
		input 	WSTRB;
		input 	WLAST;
		
		input 	WVALID;
		input 	WREADY;

		//Write Response Signals
		input 	BID;
		input 	BRESP;
		
		input 	BVALID;
		input 	BREADY;

		// Read Address Signals
		input 	ARID;
		input 	ARADDR;
		input 	ARLEN;
		input 	ARSIZE;
		input 	ARBURST;
	
		input 	ARVALID;
		input 	ARREADY;
		
		// Read Data Signals
		input 	RID;
		input 	RDATA;
		input 	RRESP;
		input 	RLAST;
		
		input 	RVALID;
		input 	RREADY;

	endclocking

	modport MST_DRV_MP (clocking mst_drv_cb);
	modport SLV_DRV_MP (clocking slv_drv_cb);
	modport MST_MON_MP (clocking mst_mon_cb);
	modport SLV_MON_MP (clocking slv_mon_cb);

    
    	// *************************************************************************************************
    	//                                      Assertions
    	// *************************************************************************************************
    	property AW;
		@(posedge ACLK) 
			(!AWREADY && AWVALID) 	|=> ($stable(AWADDR) && $stable(AWSIZE) && $stable(AWBURST) && $stable(AWLEN)) until AWREADY;
	endproperty

	property W;
		@(posedge ACLK) 
			(!WREADY && WVALID) 	|=> ($stable(WDATA) && $stable(WSTRB)) until WREADY;
	endproperty
	
	property B;
		@(posedge ACLK) 
			(!BREADY && BVALID) 	|=> ($stable(BRESP)) until BREADY;
	endproperty
	
	property AR;
		@(posedge ACLK) 
			(!ARREADY && ARVALID) 	|=> ($stable(ARADDR) && $stable(ARSIZE) && $stable(ARBURST) && $stable(ARLEN)) until ARREADY;
	endproperty
	
	property R;
		@(posedge ACLK) 
			(!RREADY && RVALID) 	|=> ($stable(RDATA)&& $stable(RRESP)) until RREADY;
	endproperty
	
	P1: assert property (AW)
		    //$display("The AW assertion pass ****************************************************");
		else
		    $display("The AW assertion failed ****************************************************");
			
	P2: assert property (W)
		    //$display("The W assertion pass ****************************************************");
		else
		    $display("The W assertion failed ****************************************************");
			
	P3: assert property (B)
		    //$display("The B assertion pass ****************************************************");
		else
		    $display("The B assertion failed ****************************************************");
			
	P4: assert property (AR)
		    //$display("The AR assertion pass ****************************************************");
		else
		    $display("The AR assertion failed ****************************************************");
			
	P5: assert property (R)
		    //$display("The R assertion pass ****************************************************");
		else
		    $display("The R assertion failed ****************************************************");

endinterface
