interface axi_if(input bit CLK);

    //Declaration of Write Address Channel Signals
    logic ARESETn;
	logic [3:0] AWID;
	logic [31:0] AWADDR;
	logic [7:0] AWLEN;
	logic [2:0] AWSIZE;
	logic [1:0] AWBURST;
	logic AWVALID;
	logic AWREADY;
	
	//Declaration of Write Data Channel Signals
	logic  [3:0] WID;
	logic [31:0] WDATA;
	logic [3:0] WSTRB;
	logic WLAST;
	logic WVALID;
	logic WREADY;
	
	//Declaration of Write Response Channel Signals
	logic [3:0] BID;
	logic [1:0] BRESP;
	logic BVALID;
	logic BREADY;
	
	//Declaration of Read Address Channel Signals
	logic [3:0] ARID;
	logic [31:0] ARADDR;
	logic [7:0] ARLEN;
	logic [2:0] ARSIZE;
	logic [1:0] ARBURST;
	logic ARVALID;
	logic ARREADY;
	
	//Declaration of Read Data Channel Signals
	logic [3:0] RID;
	logic [31:0] RDATA;
	logic [1:0] RRESP;
	logic RLAST;
	logic RVALID;
	logic RREADY;
	
	
	//Master Driver Clocking Block
	clocking mst_drv_cb@(posedge CLK);
	    default input #1 output #1;
		
		//input signals from Write Address Channel
		input AWREADY;
		//input signals from Write Data Channel
		input WREADY;
		//input signals from Write Response Channel
		input BID,BRESP,BVALID;
		//input signals from Read Address Channel
		input ARREADY;
		//input signals from Read Data Channel
		input RID,RDATA,RRESP,RLAST,RVALID;
		
		//output from Write Address Channel
		output ARESETn, AWID,AWADDR,AWLEN,AWSIZE,AWBURST,AWVALID;
		//ouput from Write Data Channel
		output WID,WDATA,WSTRB,WLAST,WVALID;
		//output from Write Response Channel
		output BREADY;
		//output from Read Address Channel
		output ARID,ARADDR,ARLEN,ARSIZE,ARBURST,ARVALID;
		//output from Read Data Channel
		output RREADY;
	endclocking
	
	
	//Master Monitor Clocking Block
	clocking mst_mon_cb@(posedge CLK);
	    default input #1 output #1;
		
		//input signals from Write Address Channel
		input ARESETn, AWID,AWADDR,AWLEN,AWSIZE,AWBURST,AWVALID,AWREADY;
		//input signals from Write Data Channel
		input WID,WDATA,WSTRB,WLAST,WVALID,WREADY;
		//input signals from Write Response Channel
		input BID,BRESP,BVALID,BREADY;
		//input signals from Read Address Channel
		input ARID,ARADDR,ARLEN,ARSIZE,ARBURST,ARVALID,ARREADY;
		//input signals from Read Data Channel
		input RID,RDATA,RRESP,RLAST,RVALID,RREADY;
	endclocking
	
	//Slave Driver Clocking Block
	clocking slv_drv_cb@(posedge CLK);
	    default input #1 output #1;
		
		//input from Write Address Channel
		input ARESETn, AWID,AWADDR,AWLEN,AWSIZE,AWBURST,AWVALID;
		//ouput from Write Data Channel
		input WID,WDATA,WSTRB,WLAST,WVALID;
		//input from Write Response Channel
		input BREADY;
		//input from Read Address Channel
		input ARID,ARADDR,ARLEN,ARSIZE,ARBURST,ARVALID;
		//input from Read Data Channel
		input RREADY;
		
		//output signals from Write Address Channel
		output AWREADY;
		//output signals from Write Data Channel
		output WREADY;
		//output signals from Write Response Channel
		output BID,BRESP,BVALID;
		//output signals from Read Address Channel
		output ARREADY;
		//output signals from Read Data Channel
		output RID,RDATA,RRESP,RLAST,RVALID;
	endclocking
	
		//Slave Monitor Clocking Block
	clocking slv_mon_cb@(posedge CLK);
	    default input #1 output #1;
		
		//input signals from Write Address Channel
		input ARESETn, AWID,AWADDR,AWLEN,AWSIZE,AWBURST,AWVALID,AWREADY;
		//input signals from Write Data Channel
		input WID,WDATA,WSTRB,WLAST,WVALID,WREADY;
		//input signals from Write Response Channel
		input BID,BRESP,BVALID,BREADY;
		//input signals from Read Address Channel
		input ARID,ARADDR,ARLEN,ARSIZE,ARBURST,ARVALID,ARREADY;
		//input signals from Read Data Channel
		input RID,RDATA,RRESP,RLAST,RVALID,RREADY;
	endclocking
	
	
	modport MST_DRV(clocking mst_drv_cb);
	modport MST_MON(clocking mst_mon_cb);
	modport SLV_DRV(clocking slv_drv_cb);
	modport SLV_MON(clocking slv_mon_cb);
	
endinterface

