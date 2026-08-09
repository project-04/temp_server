interface axi_if(input bit clk,bit rst);
	
	//Write Address Signals
	logic [7:0] AWID;
	logic [31:0] AWADDR;
	logic [7:0] AWLEN;
	logic [2:0] AWSIZE;
	logic [1:0] AWBURST;
	logic AWVALID;
	logic AWREADY;
        logic AWLOCK;
        logic[3:0] AWCACHE;
        logic[2:0]AWPROT;
        logic[3:0]AWQOS;
        logic AWUSER;
       

	//Write Data Channels Signals
	logic [7:0] WID;
	logic [31:0] WDATA;
	logic [3:0] WSTRB;
	logic WLAST;
	logic WVALID;
	logic WREADY;
        logic WUSER;

	//Write Response Channel Signals
	logic [7:0] BID;
	logic [1:0] BRESP;
	logic BVALID;
	logic BREADY;
        logic BUSER;
	
	// Read Address Channel Signals
	logic [7:0] ARID;
	logic [31:0] ARADDR;
	logic [7:0] ARLEN;
	logic [2:0] ARSIZE;
	logic [1:0] ARBURST;
	logic ARVALID;
	logic ARREADY;
        logic ARLOCK;
        logic[3:0] ARCACHE;
        logic[2:0]ARPROT;
        logic[3:0]ARQOS;
        logic ARUSER;


	//Read Data Channel Signals
	logic [7:0] RID;
	logic [31:0] RDATA;
	logic [1:0] RRESP;
	logic RLAST;
	logic RVALID;
	logic RREADY;
        logic RUSER;

	// Master Driver Clocking Block
	clocking mast_drv_cb @(posedge clk);
		default input #1 output #1;
		
		// Write Address Signals
		output AWID;
		output AWADDR;
		output AWLEN;
		output AWSIZE;
		output AWBURST;
		
		output AWVALID;
                output AWLOCK;
                output  AWCACHE;
                output AWPROT;
                output AWQOS;
                output AWUSER;

		input AWREADY;
		
		// Write Data Signals
		output WID;
		output WDATA;
		output WSTRB;
		output WLAST;
		
		output WVALID;
                output WUSER;

		input WREADY;

		//Write Response Signals
		input BID;
		input BRESP;
		
		input BVALID;
		output BREADY;
                input  BUSER;

		
		

		// Read Address Signals
		output ARID;
		output ARADDR;
		output ARLEN;
		output ARSIZE;
		output ARBURST;
	
		output ARVALID;
		input ARREADY;

                output ARLOCK;
                output  ARCACHE;
                output ARPROT;
                output ARQOS;
                output ARUSER;


		
		// Read Data Signals
		input RID;
		input RDATA;
		input RRESP;
		input RLAST;
		
		input RVALID;
		output RREADY;
                input RUSER;
	
	endclocking

        clocking slv_drv_cb @(posedge clk);
		default input #1 output #1;
		
		// Write Address Signals
		input AWID;
		input AWADDR;
		input AWLEN;
		input AWSIZE;
		input AWBURST;
		
		input AWVALID;
		output AWREADY;

                input AWLOCK;
                input  AWCACHE;
                input AWPROT;
                input AWQOS;
                input AWUSER;


		
		// Write Data Signals
		input WID;
		input WDATA;
		input WSTRB;
		input WLAST;
		
		input WVALID;
		output WREADY;
                input WUSER;

		//Write Response Signals
		output BID;
		output BRESP;
		
		output BVALID;
		input BREADY;
		output BUSER;

		// Read Address Signals
		input ARID;
		input ARADDR;
		input ARLEN;
		input ARSIZE;
		input ARBURST;
	
		input ARVALID;
		output ARREADY;
              
                input ARLOCK;
                input  ARCACHE;
                input ARPROT;
                input ARQOS;
                input ARUSER;


		
		// Read Data Signals
		output RID;
		output RDATA;
		output RRESP;
		output RLAST;
		
		output RVALID;
                output RUSER;
		input RREADY;

	endclocking



  
	clocking mast_mon_cb @(posedge clk);
		default input #1 output #1;
		
		// Write Address Signals
		input AWID;
		input AWADDR;
		input AWLEN;
		input AWSIZE;
		input AWBURST;
		
		input AWVALID;
		input AWREADY;
                
                input AWLOCK;
                input  AWCACHE;
                input AWPROT;
                input AWQOS;
                input AWUSER;

		
		// Write Data Signals
		input WID;
		input WDATA;
		input WSTRB;
		input WLAST;
		
		input WVALID;
		input WREADY;
                input WUSER;

		//Write Response Signals
		input BID;
		input BRESP;
		
		input BVALID;
		input BREADY;
	        input BUSER;

		// Read Address Signals
		input ARID;
		input ARADDR;
		input ARLEN;
		input ARSIZE;
		input ARBURST;
	
		input ARVALID;
		input ARREADY;
		
                input ARLOCK;
                input  ARCACHE;
                input ARPROT;
                input ARQOS;
                input ARUSER;



		// Read Data Signals
		input RID;
		input RDATA;
		input RRESP;
		input RLAST;
		
		input RVALID;
		input RREADY;
                input RUSER;

	endclocking

       	clocking slv_mon_cb @(posedge clk);
		default input #1 output #1;
		
		// Write Address Signals
		input AWID;
		input AWADDR;
		input AWLEN;
		input AWSIZE;
		input AWBURST;
		
		input AWVALID;
		input AWREADY;
                
                 input AWLOCK;
                input  AWCACHE;
                input AWPROT;
                input AWQOS;
                input AWUSER;


		
		// Write Data Signals
		input WID;
		input WDATA;
		input WSTRB;
		input WLAST;
		
		input WVALID;
		input WREADY;
                input WUSER;

		//Write Response Signals
		input BID;
		input BRESP;
		
		input BVALID;
		input BREADY;
		input BUSER;
		

		// Read Address Signals
		input ARID;
		input ARADDR;
		input ARLEN;
		input ARSIZE;
		input ARBURST;
	
		input ARVALID;
		input ARREADY;

                 input ARLOCK;
                input  ARCACHE;
                input ARPROT;
                input ARQOS;
                input ARUSER;


		
		// Read Data Signals
		input RID;
		input RDATA;
		input RRESP;
		input RLAST;
		
		input RVALID;
		input RREADY;
                input RUSER;

	endclocking




	modport MAST_DRV_MP (clocking mast_drv_cb,input rst);
	modport MAST_MON_MP(clocking mast_mon_cb,input rst);
        
 	modport SLV_DRV_MP (clocking slv_drv_cb,input rst);
        modport SLV_MON_MP (clocking slv_mon_cb,input rst);


//    when valid is high until ready high control signals should be stable
      property awvalid;
      @(posedge clk) $rose(AWVALID) |-> $stable(AWID) && $stable (AWLEN) && $stable (AWBURST) && $stable (AWSIZE) && (AWADDR) until AWREADY[->1];
      endproperty
      
     property valid;
     @(posedge clk) $rose(WVALID) |-> $stable(WID) && $stable(WDATA) && $stable (WSTRB) && $stable(WLAST) until WREADY[->1];
     endproperty
  
 
   property arvalid;
    @(posedge clk) $rose(ARVALID) |-> $stable(ARID) && $stable (ARLEN) && $stable (ARBURST) && $stable (ARSIZE) && (ARADDR) until ARREADY[->1];
   endproperty

    property bvalid;
    @(posedge clk) $rose(BVALID) |-> $stable(BID) && $stable (BRESP) until BREADY[->1];
    endproperty
 
      
   property rvalid;
    @(posedge clk) $rose(RVALID) |-> $stable(RID) && $stable (RDATA) && $stable (RLAST)  && (RRESP) until RREADY[->1];
   endproperty

   assert property (bvalid);
   assert property (rvalid);
   assert property (awvalid);
   assert property (arvalid);
   assert property (valid);

//hanndshaking mechanism
   property awvalid_awready;
   @(posedge clk) AWVALID && !AWREADY |=> AWVALID;
   endproperty 
   
   property wvalid_wready;
   @(posedge clk) WVALID && !WREADY |=> WVALID;
   endproperty 
   
   property arvalid_arready;
   @(posedge clk) ARVALID && !ARREADY |=> ARVALID;
   endproperty 

    property bvalid_bready;
   @(posedge clk) BVALID && !BREADY |=> BVALID;
   endproperty 


   property rvalid_rready;
   @(posedge clk) RVALID && !RREADY |=> RVALID;
   endproperty 

   assert property (bvalid_bready);
   assert property (rvalid_rready);
   assert property (awvalid_awready);
   assert property (wvalid_wready);
   assert property (arvalid_arready);
	
endinterface




//slave interface


interface axi_sif(input bit clk,bit rst1);
	
	logic rst1;
	//Write Address Signals
	logic [7:0] AWID;
	logic [31:0] AWADDR;
	logic [7:0] AWLEN;
	logic [2:0] AWSIZE;
	logic [1:0] AWBURST;
	logic AWVALID;
	logic AWREADY;
        logic AWLOCK;
        logic[3:0] AWCACHE;
        logic[2:0]AWPROT;
        logic[3:0]AWQOS;
        logic AWUSER;
       

	//Write Data Channels Signals
	logic [7:0] WID;
	logic [31:0] WDATA;
	logic [3:0] WSTRB;
	logic WLAST;
	logic WVALID;
	logic WREADY;
        logic WUSER;

	//Write Response Channel Signals
	logic [7:0] BID;
	logic [1:0] BRESP;
	logic BVALID;
	logic BREADY;
        logic BUSER;
	
	// Read Address Channel Signals
	logic [7:0] ARID;
	logic [31:0] ARADDR;
	logic [7:0] ARLEN;
	logic [2:0] ARSIZE;
	logic [1:0] ARBURST;
	logic ARVALID;
	logic ARREADY;
        logic ARLOCK;
        logic[3:0] ARCACHE;
        logic[2:0]ARPROT;
        logic[3:0]ARQOS;
        logic ARUSER;


	//Read Data Channel Signals
	logic [7:0] RID;
	logic [31:0] RDATA;
	logic [1:0] RRESP;
	logic RLAST;
	logic RVALID;
	logic RREADY;
        logic RUSER;

	// Master Driver Clocking Block

        clocking slv_drv_cb @(posedge clk);
		default input #1 output #1;
		
		// Write Address Signals
		input AWID;
		input AWADDR;
		input AWLEN;
		input AWSIZE;
		input AWBURST;
		
		input AWVALID;
		output AWREADY;

                input AWLOCK;
                input  AWCACHE;
                input AWPROT;
                input AWQOS;
                input AWUSER;


		
		// Write Data Signals
		input WID;
		input WDATA;
		input WSTRB;
		input WLAST;
		
		input WVALID;
		output WREADY;
                input WUSER;

		//Write Response Signals
		output BID;
		output BRESP;
		
		output BVALID;
		input BREADY;
		output BUSER;

		// Read Address Signals
		input ARID;
		input ARADDR;
		input ARLEN;
		input ARSIZE;
		input ARBURST;
	
		input ARVALID;
		output ARREADY;
              
                input ARLOCK;
                input  ARCACHE;
                input ARPROT;
                input ARQOS;
                input ARUSER;


		
		// Read Data Signals
		output RID;
		output RDATA;
		output RRESP;
		output RLAST;
		
		output RVALID;
                output RUSER;
		input RREADY;

	endclocking



  
	
       	clocking slv_mon_cb @(posedge clk);
		default input #1 output #1;
		
		// Write Address Signals
		input AWID;
		input AWADDR;
		input AWLEN;
		input AWSIZE;
		input AWBURST;
		
		input AWVALID;
		input AWREADY;
                
                 input AWLOCK;
                input  AWCACHE;
                input AWPROT;
                input AWQOS;
                input AWUSER;


		
		// Write Data Signals
		input WID;
		input WDATA;
		input WSTRB;
		input WLAST;
		
		input WVALID;
		input WREADY;
                input WUSER;

		//Write Response Signals
		input BID;
		input BRESP;
		
		input BVALID;
		input BREADY;
		input BUSER;
		

		// Read Address Signals
		input ARID;
		input ARADDR;
		input ARLEN;
		input ARSIZE;
		input ARBURST;
	
		input ARVALID;
		input ARREADY;

                 input ARLOCK;
                input  ARCACHE;
                input ARPROT;
                input ARQOS;
                input ARUSER;


		
		// Read Data Signals
		input RID;
		input RDATA;
		input RRESP;
		input RLAST;
		
		input RVALID;
		input RREADY;
                input RUSER;

	endclocking




        
 	modport SLV_DRV_MP (clocking slv_drv_cb,input rst1);
        modport SLV_MON_MP (clocking slv_mon_cb,input rst1);


//    when valid is high until ready high control signals should be stable

    property bvalid;
    @(posedge clk) $rose(BVALID) |-> $stable(BID) && $stable (BRESP) until BREADY[->1];
    endproperty
 
      
   property rvalid;
    @(posedge clk) $rose(RVALID) |-> $stable(RID) && $stable (RDATA) && $stable (RLAST)  && (RRESP) until RREADY[->1];
   endproperty

   assert property (bvalid);
   assert property (rvalid);

//hanndshaking mechanism

    property bvalid_bready;
   @(posedge clk) BVALID && !BREADY |=> BVALID;
   endproperty 


   property rvalid_rready;
   @(posedge clk) RVALID && !RREADY |=> RVALID;
   endproperty 

   assert property (bvalid_bready);
   assert property (rvalid_rready);
	
endinterface



//master interface

interface axi_mif(input bit clk,bit rst2);
	
	logic rst2;
	//Write Address Signals
	logic [7:0] AWID;
	logic [31:0] AWADDR;
	logic [7:0] AWLEN;
	logic [2:0] AWSIZE;
	logic [1:0] AWBURST;
	logic AWVALID;
	logic AWREADY;
        logic AWLOCK;
        logic[3:0] AWCACHE;
        logic[2:0]AWPROT;
        logic[3:0]AWQOS;
        logic AWUSER;
       

	//Write Data Channels Signals
	logic [7:0] WID;
	logic [31:0] WDATA;
	logic [3:0] WSTRB;
	logic WLAST;
	logic WVALID;
	logic WREADY;
        logic WUSER;

	//Write Response Channel Signals
	logic [7:0] BID;
	logic [1:0] BRESP;
	logic BVALID;
	logic BREADY;
        logic BUSER;
	
	// Read Address Channel Signals
	logic [7:0] ARID;
	logic [31:0] ARADDR;
	logic [7:0] ARLEN;
	logic [2:0] ARSIZE;
	logic [1:0] ARBURST;
	logic ARVALID;
	logic ARREADY;
        logic ARLOCK;
        logic[3:0] ARCACHE;
        logic[2:0]ARPROT;
        logic[3:0]ARQOS;
        logic ARUSER;


	//Read Data Channel Signals
	logic [7:0] RID;
	logic [31:0] RDATA;
	logic [1:0] RRESP;
	logic RLAST;
	logic RVALID;
	logic RREADY;
        logic RUSER;

	// Master Driver Clocking Block
	clocking mast_drv_cb @(posedge clk);
		default input #1 output #1;
		
		// Write Address Signals
		output AWID;
		output AWADDR;
		output AWLEN;
		output AWSIZE;
		output AWBURST;
		
		output AWVALID;
                output AWLOCK;
                output  AWCACHE;
                output AWPROT;
                output AWQOS;
                output AWUSER;

		input AWREADY;
		
		// Write Data Signals
		output WID;
		output WDATA;
		output WSTRB;
		output WLAST;
		
		output WVALID;
                output WUSER;

		input WREADY;

		//Write Response Signals
		input BID;
		input BRESP;
		
		input BVALID;
		output BREADY;
                input  BUSER;

		
		

		// Read Address Signals
		output ARID;
		output ARADDR;
		output ARLEN;
		output ARSIZE;
		output ARBURST;
	
		output ARVALID;
		input ARREADY;

                output ARLOCK;
                output  ARCACHE;
                output ARPROT;
                output ARQOS;
                output ARUSER;


		
		// Read Data Signals
		input RID;
		input RDATA;
		input RRESP;
		input RLAST;
		
		input RVALID;
		output RREADY;
                input RUSER;
	
	endclocking

        
  
	clocking mast_mon_cb @(posedge clk);
		default input #1 output #1;
		
		// Write Address Signals
		input AWID;
		input AWADDR;
		input AWLEN;
		input AWSIZE;
		input AWBURST;
		
		input AWVALID;
		input AWREADY;
                
                input AWLOCK;
                input  AWCACHE;
                input AWPROT;
                input AWQOS;
                input AWUSER;

		
		// Write Data Signals
		input WID;
		input WDATA;
		input WSTRB;
		input WLAST;
		
		input WVALID;
		input WREADY;
                input WUSER;

		//Write Response Signals
		input BID;
		input BRESP;
		
		input BVALID;
		input BREADY;
	        input BUSER;

		// Read Address Signals
		input ARID;
		input ARADDR;
		input ARLEN;
		input ARSIZE;
		input ARBURST;
	
		input ARVALID;
		input ARREADY;
		
                input ARLOCK;
                input  ARCACHE;
                input ARPROT;
                input ARQOS;
                input ARUSER;



		// Read Data Signals
		input RID;
		input RDATA;
		input RRESP;
		input RLAST;
		
		input RVALID;
		input RREADY;
                input RUSER;

	endclocking




	modport MAST_DRV_MP (clocking mast_drv_cb,input rst2);
	modport MAST_MON_MP(clocking mast_mon_cb,input rst2);
        


//    when valid is high until ready high control signals should be stable
      property awvalid;
      @(posedge clk) $rose(AWVALID) |-> $stable(AWID) && $stable (AWLEN) && $stable (AWBURST) && $stable (AWSIZE) && (AWADDR) until AWREADY[->1];
      endproperty
      
     property valid;
     @(posedge clk) $rose(WVALID) |-> $stable(WID) && $stable(WDATA) && $stable (WSTRB) && $stable(WLAST) until WREADY[->1];
     endproperty
  
 
   property arvalid;
    @(posedge clk) $rose(ARVALID) |-> $stable(ARID) && $stable (ARLEN) && $stable (ARBURST) && $stable (ARSIZE) && (ARADDR) until ARREADY[->1];
   endproperty


   assert property (awvalid);
   assert property (valid);
   assert property (arvalid);



//hanndshaking mechanism
   property awvalid_awready;
   @(posedge clk) AWVALID && !AWREADY |=> AWVALID;
   endproperty 
   
   property wvalid_wready;
   @(posedge clk) WVALID && !WREADY |=> WVALID;
   endproperty 
   
   property arvalid_arready;
   @(posedge clk) ARVALID && !ARREADY |=> ARVALID;
   endproperty 


   assert property (awvalid_awready);
   assert property (wvalid_wready);
   assert property (arvalid_arready);
	
endinterface
