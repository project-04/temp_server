class axi_xtn extends uvm_sequence_item;

	`uvm_object_utils(axi_xtn)
	
	function new(string name="axi_xtn");
		super.new(name);
	endfunction

	//Write Address Signals
	rand logic [7:0] 	AWID; //i
	rand logic [31:0] AWADDR; //i
	rand logic [3:0] 	AWLEN; //i
	rand logic [2:0] 	AWSIZE; //i
	rand logic [1:0] 	AWBURST; //i
	
	logic 		AWVALID; //i
	logic 		AWREADY; //o
       
	//Write Data Channels Signals
	rand logic [7:0] 	WID; //i
	rand logic [31:0] WDATA[]; //i
	
	logic      [3:0] 	WSTRB[]; //i
	logic 		WLAST; //i
	logic 		WVALID; //i
	logic 		WREADY; //o

	//Write Response Channel Signals
	rand logic [7:0] 	BID; //o

	logic 	 [1:0] 	BRESP; //o
	logic 		BVALID; //o
	logic 		BREADY; //i
	
	// Read Address Channel Signals
	rand logic [7:0] 	ARID; //i
	rand logic [31:0] ARADDR; //i
	rand logic [3:0] 	ARLEN; //i
	rand logic [2:0] 	ARSIZE; //i
	rand logic [1:0] 	ARBURST; //i

	logic 		ARVALID; //i
	logic 		ARREADY; //o

	//Read Data Channel Signals
	rand logic [7:0] 	RID; //o
	
	logic      [31:0] RDATA[]; //o
	logic 	 [1:0] 	RRESP[]; //o
	logic 		RLAST; //o
	logic 		RVALID; //o
	logic 		RREADY; //i



	//Logic Variables
	bit 	 [31:0]	waddr[];
	int 		no_wbytes;
	bit 	[31:0]	aligned_waddr;
	bit 	[31:0]	start_waddr;

	bit 	 [31:0]	raddr[];
	int 		no_rbytes;
	bit 	[31:0]	aligned_raddr;
	bit 	[31:0]	start_raddr;

	constraint wdata		{WDATA.size()==(AWLEN+1);}

	//constraint rdata		{RDATA.size()==(ARLEN+1);}
	
	//constraint w_strobe		{WSTRB.size()==(AWLEN+1);}

	constraint aw_burst		{AWBURST inside {[0:2]};}

	constraint ar_burst		{ARBURST inside {[0:2]};}

	constraint write_id		{AWID==WID; BID==AWID;}

	constraint read_id		{RID==ARID;}

	constraint aw_size		{AWSIZE dist{0:=10, 1:=10, 2:=10};}  //Maximum bytes per beat.

	constraint ar_size		{ARSIZE dist{0:=10, 1:=10, 2:=10};}

	constraint aw_length		{if(AWBURST==2) 
			 		   (AWLEN+1) inside {2,4,8,16};}     //Addresses of WRAP burst must be power multiple of 2.

	constraint ar_length		{if(ARBURST==2) 
			 		   (ARLEN+1) inside {2,4,8,16};}

	constraint write_alignment2	{((AWBURST==2'b10 || AWBURST==2'b00) && AWSIZE==1) -> AWADDR%2==0;} //0,2,4,6,8------------Only Aligned transfer for Fixed and INCR.

	constraint read_alignment2	{((ARBURST==2'b10 || ARBURST==2'b00) && ARSIZE==1) -> ARADDR%2==0;} //0,2,4,6,8

	constraint write_alignment4	{((AWBURST==2'b10 || AWBURST==2'b00) && AWSIZE==2) -> AWADDR%4==0;} //0,4,8,12,16

	constraint read_alignment4	{((ARBURST==2'b10 || ARBURST==2'b00) && ARSIZE==2) -> ARADDR%4==0;} //0,4,8,12,16

	constraint max_w		{(AWADDR%4096 + (2**AWSIZE)*(AWLEN+1))<4096;} //In AXI3, in each burst the address cannot cross the 4kB boundary. 32,768 bits.

	constraint max_r		{(ARADDR%4096 + (2**ARSIZE)*(ARLEN+1))<4096;}

	constraint awlen		{AWLEN inside {[0:15]};} //Since the AWLEN is 4 bits.

	constraint arlen		{ARLEN inside {[0:15]};}



function void calc_waddr();

		bit wb; 		//To indicate that the WRAP Boundary has been reached.
		int burst_len		= AWLEN + 1; //burst lenth means no of elements in array.
		int N			= burst_len;
		int no_wbytes		= 2**AWSIZE;
		bit 	[31:0]	wrap_boundary	= (int'(AWADDR/(no_wbytes*burst_len)))*(no_wbytes*burst_len);
		bit 	[31:0]	 next_addr	= (wrap_boundary+(no_wbytes*burst_len)); 

		//no_wbytes		= 2**AWSIZE;    //Number_bytes. Number of bytes per write beat.
		waddr			= new[AWLEN+1]; //Address_N. This is a static array with element size = burst_length.

		waddr[0]		= AWADDR; 	//Starting address is AWADDR sent by the master.

		aligned_waddr		= (int'(AWADDR/no_wbytes))*no_wbytes;

		start_waddr		= AWADDR;

		for(int i = 2; i<(burst_len+1); i++)
		   begin
			if(AWBURST==0)
			   waddr[i-1]	= AWADDR; 	//Every beat starts at the same address in Fixed burst.

			if(AWBURST==1)
			   waddr[i-1]	= aligned_waddr + ((i-1)*no_wbytes); //INCR burst.

			if(AWBURST==2)
			   begin
				if(wb==0) //First beat within a burst.	
				   begin
					waddr[i-1] = aligned_waddr+(i-1)*no_wbytes; //WRAP burst.
	
					if(waddr[i-1]==(wrap_boundary+(no_wbytes*burst_len))) //Reached the maximum range of the WRAP burst.
					   begin
						waddr[i-1] = wrap_boundary;
						wb++;
					   end
				   end
				else	//Subsequent beats within a burst.
				        waddr[i-1] = start_waddr+((i-1)*no_wbytes)-(no_wbytes*burst_len);
			   end

		   end

	endfunction: calc_waddr

	function void strb_calc();

		int lower_byte_lane, upper_byte_lane;
		int data_bus_bytes	= 4;
		int no_wbytes		= 2**AWSIZE;
		int lower_byte_lane_0	= start_waddr-((int'(start_waddr/data_bus_bytes))*data_bus_bytes); 		     //Lower lane for the 1st beat.
		int aligned_waddr		= (int'(AWADDR/no_wbytes))*no_wbytes;
		int upper_byte_lane_0	= (aligned_waddr+(no_wbytes-1))-((int'(start_waddr/data_bus_bytes))*data_bus_bytes); //Upper lane for the 1st beat.
		
		WSTRB = new[AWLEN+1];
		
		foreach(WSTRB[i]) 
			WSTRB[i] = 'b0;
		
		for(int j = lower_byte_lane_0; j<= upper_byte_lane_0; j++) //Everything in between the upper and lower lane must be 1.
		    begin
		    	WSTRB[0][j]=1;
		    end

		for(int i = 1; i<(AWLEN+1); i++)
		    begin
			lower_byte_lane	= waddr[i]-(int'(waddr[i]/data_bus_bytes))*data_bus_bytes;
			upper_byte_lane	= lower_byte_lane+(no_wbytes-1);
		
			for(int j = lower_byte_lane; j<=upper_byte_lane; j++)
			    begin
				WSTRB[i][j] = 1;
			    end
		    end
		    
	endfunction: strb_calc
				
	function void calc_raddr();

		bit wb;
		int burst_len 	  	= ARLEN+1;
		int N 		  	= burst_len;
		int no_rbytes		= 2**ARSIZE;
		int wrap_boundary 	= (int'(ARADDR/(no_rbytes*burst_len)))*(no_rbytes*burst_len);
		int next_addr     	= wrap_boundary+(no_rbytes*burst_len);

		raddr		  	= new[ARLEN+1];

		raddr[0]	  	= ARADDR;
	
		aligned_raddr	  	= (int'(ARADDR/no_rbytes))*no_rbytes;

		start_raddr	  	= ARADDR;

		for(int i = 2; i<(burst_len+1); i++)
		    begin
			if(ARBURST==0)
			   raddr[i-1]	= ARADDR;

			if(ARBURST==1)
			   raddr[i-1]	= aligned_raddr+(i-1)*no_rbytes;

			if(ARBURST==2)
			   begin
				if(wb==0)	
				   begin
				   	raddr[i-1] = aligned_raddr+(i-1)*no_rbytes;
				   	
					if(raddr[i-1]==(wrap_boundary+(no_rbytes*burst_len)))
					   begin
						raddr[i-1] = wrap_boundary;
						wb++;
					   end
				   end
				   
				else	
					raddr[i-1] = start_raddr+((i-1)*no_rbytes)-(no_rbytes*burst_len);
					
			   end

			/*if(ARBURST==2)
			   begin
				if(wb==0)	
				   begin
					if(raddr[i-1]==(wrap_boundary+(no_rbytes*burst_len)))
					   begin
						raddr[i-1] = wrap_boundary;
						wb++;
					   end
					   
					else
						raddr[i-1] = aligned_raddr+(i-1)*no_rbytes;

				   end
				else	
					raddr[i-1] = start_raddr+((i-1)*no_rbytes)-(no_rbytes*burst_len);
			   end*/
		     end

	endfunction: calc_raddr
	
	function void post_randomize();

		//------------------For Write.
	 	no_wbytes	= 2**AWSIZE;
           	aligned_waddr	= (int'(AWADDR/no_wbytes))*no_wbytes;
		start_waddr	= AWADDR;

		calc_waddr();
		strb_calc();
		
		//------------------For Read.
		no_rbytes	= 2**ARSIZE;
		aligned_raddr	= (int'(ARADDR/no_rbytes))*no_rbytes;
		start_raddr	= ARADDR;
		RDATA		= new[ARLEN+1];
		
		calc_raddr();
		
		//this.print();

	// Display the generated addresses
        $display("\n////////////////////// write_addr //////////////////////////\nwr_addr=%0p", waddr);
        //$display("////////////////////// write_addr_AWADDR ///////////////////\nAWADDR=%0p", awaddr);
        $display("////////////////////// read_addr ///////////////////////////\nrd_add=%0p",  raddr);
        //$display("////////////////////// write_addr_ARADDR ///////////////////\nARADDR=%0p\n", araddr);
        $display("////////////////////// WSTRB ///////////////////\nWSTRB=%0p\n", WSTRB);
    
    endfunction    
		
	function void do_print(uvm_printer printer);

		super.do_print(printer);

		//Write Address Signals
		printer.print_field(	"AWID",     this.AWID,    $bits(this.AWID),	UVM_HEX);
		printer.print_field(	"AWADDR",   this.AWADDR,  $bits(this.AWADDR),	UVM_HEX);
		foreach(waddr[i])
		begin
		     printer.print_field($sformatf("Write Address[%0d]",i),   this.waddr[i],   $bits(waddr[i]) ,UVM_DEC);
		end		
		printer.print_field(	"AWBURST",  this.AWBURST, $bits(this.AWBURST), 	UVM_BIN);	
		printer.print_field(	"AWLEN",    this.AWLEN,   $bits(this.AWLEN), 	UVM_HEX);
		printer.print_field(	"AWSIZE",   this.AWSIZE,  $bits(this.AWSIZE), 	UVM_HEX);
		printer.print_field(	"AWVALID",  this.AWVALID, $bits(this.AWVALID), 	UVM_BIN);	
		printer.print_field(	"AWREADY",  this.AWREADY, $bits(this.AWREADY), 	UVM_BIN);

		//Write Data Channels Signals	
		printer.print_field(	"WID",     this.WID,     $bits(this.WID), 	UVM_HEX);
		foreach(WDATA[i])
		begin
	    	     printer.print_field($sformatf("WDATA[%0d]",i),   this.WDATA[i], $bits(this.WDATA[i]), 	UVM_HEX);
		     printer.print_field($sformatf("WSTRB[%0d]",i),   this.WSTRB[i],  $bits(this.WSTRB[i]), 	UVM_BIN);
		end
		printer.print_field(	"WLAST",   this.WLAST,   $bits(this.WLAST), 	UVM_BIN);
		printer.print_field(	"WVALID",  this.WVALID,  $bits(this.WVALID), 	UVM_BIN);
		printer.print_field(	"WREADY",  this.WREADY,  $bits(this.WREADY), 	UVM_BIN);		

		//Write Response Channel Signals		
		printer.print_field(	"BID",     this.BID,     $bits(this.BID), 	UVM_HEX);	
		printer.print_field(	"BRESP",   this.BRESP,   $bits(this.BRESP), 	UVM_HEX);
		printer.print_field(	"BVALID",  this.BVALID,  $bits(this.BVALID), 	UVM_BIN);	
		printer.print_field(	"BREADY",  this.BREADY,  $bits(this.BREADY), 	UVM_BIN);		

		// Read Address Channel Signals			
		printer.print_field(	"ARID",    this.ARID,    $bits(this.ARID), 	UVM_HEX);	
		printer.print_field(	"ARADDR",  this.ARADDR,  $bits(this.ARADDR),	UVM_HEX);
		foreach(raddr[i])
		begin
		     printer.print_field($sformatf("Read Address[%0d]",i),   this.raddr[i],   $bits(raddr[i]), UVM_DEC);
		end
		printer.print_field(	"ARBURST", this.ARBURST, $bits(this.ARBURST), 	UVM_BIN);	
		printer.print_field(	"ARLEN",   this.ARLEN,   $bits(this.ARLEN), 	UVM_HEX);	
		printer.print_field(	"ARSIZE",  this.ARSIZE,  $bits(this.ARSIZE), 	UVM_HEX);
		printer.print_field(	"ARVALID", this.ARVALID, $bits(this.ARVALID), 	UVM_BIN);	
		printer.print_field(	"ARREADY", this.ARREADY, $bits(this.ARREADY), 	UVM_BIN);			
	
		//Read Data Channel Signals
		printer.print_field(	"RID",     this.RID,     $bits(this.RID), 	UVM_HEX);
		foreach(RDATA[i])
		begin
		     printer.print_field($sformatf("RDATA[%0d]",i),   this.RDATA[i],   $bits(this.RDATA[i]), UVM_HEX);
		     printer.print_field($sformatf("RRESP[%0d]",i),   this.RRESP[i],   $bits(this.RRESP[i]), UVM_HEX);
		end
		printer.print_field(	"RLAST",   this.RLAST,   $bits(this.RLAST), 	UVM_BIN);
		printer.print_field(	"RVALID",  this.RVALID,  $bits(this.RVALID), 	UVM_BIN);	
		printer.print_field(	"RREADY",  this.RREADY,  $bits(this.RREADY), 	UVM_BIN);
		
	endfunction: do_print
	
	
	function void do_copy(uvm_object rhs);
		axi_xtn rhs_;

		if(!$cast(rhs_, rhs))
			`uvm_fatal(get_type_name(), "cannot cast rhs in do_copy")

		super.do_copy(rhs);
		/*
		//Write Address Channel
		this.AWID = rhs_.AWID;
		this.AWADDR = rhs_.AWADDR;
		this.AWLEN = rhs_.AWLEN;
		this.AWSIZE = rhs_.AWSIZE;
		this.AWBURST = rhs_.AWBURST;
		this.AWVALID = rhs_.AWVALID;
		this.AWREADY = rhs_.AWREADY;

		//Write Data Channel
		this.WID = rhs_.WID;
		this.WDATA = rhs_.WDATA;
		this.WSTRB = rhs_.WSTRB;
		this.WLAST = rhs_.WLAST;
		this.WVALID = rhs_.WVALID;
		this.WREADY = rhs_.WREADY;

		//Write Response Channel
		this.BID = rhs_.BID;
		this.BRESP = rhs_.BRESP;
		this.BVALID = rhs_.BVALID;
		this.BREADY = rhs_.BREADY;
		*/
		
		//Read Address Channel
		this.ARID = rhs_.ARID;
		this.ARADDR = rhs_.ARADDR;
		this.ARLEN = rhs_.ARLEN;
		this.ARSIZE = rhs_.ARSIZE;
		this.ARBURST = rhs_.ARBURST;
		this.ARVALID = rhs_.ARVALID;
		this.ARREADY = rhs_.ARREADY;
	
		//Read Data Channel
		this.RID = rhs_.RID;
		this.RDATA = rhs_.RDATA;
		this.RRESP = rhs_.RRESP;
		this.RLAST = rhs_.RLAST;
		this.RVALID = rhs_.RVALID;
		this.RREADY = rhs_.RREADY;
	endfunction

	function bit do_compare(uvm_object rhs, uvm_comparer comparer);
		axi_xtn rhs_;

		if(!$cast(rhs_, rhs))
		begin
			`uvm_fatal(get_type_name(), "cannot cast rhs in do_compare")
			return 0;
		end

    		return super.do_compare(rhs,comparer) &&
    
		//Write Address Channel
		this.AWID == rhs_.AWID &&
		this.AWADDR == rhs_.AWADDR &&
		this.AWLEN == rhs_.AWLEN &&
		this.AWSIZE == rhs_.AWSIZE &&
		this.AWBURST == rhs_.AWBURST &&
		this.AWVALID == rhs_.AWVALID &&
		this.AWREADY == rhs_.AWREADY &&

		//Write Data Channel
		this.WID == rhs_.WID &&
		this.WDATA == rhs_.WDATA &&
		this.WSTRB == rhs_.WSTRB &&
		this.WLAST == rhs_.WLAST &&
		this.WVALID == rhs_.WVALID &&
		this.WREADY == rhs_.WREADY &&

		//Write Response Channel
		this.BID == rhs_.BID &&
		this.BRESP == rhs_.BRESP &&
		this.BVALID == rhs_.BVALID &&
		this.BREADY == rhs_.BREADY &&
	
		//Read Address Channel
		this.ARID == rhs_.ARID &&
		this.ARADDR == rhs_.ARADDR &&
		this.ARLEN == rhs_.ARLEN &&
		this.ARSIZE == rhs_.ARSIZE &&
		this.ARBURST == rhs_.ARBURST &&
		this.ARVALID == rhs_.ARVALID &&
		this.ARREADY == rhs_.ARREADY &&
	
		//Read Data Channel
		this.RID == rhs_.RID &&
		this.RDATA == rhs_.RDATA &&
		this.RRESP == rhs_.RRESP &&
		this.RLAST == rhs_.RLAST &&
		this.RREADY == rhs_.RREADY;	
			
	endfunction

endclass: axi_xtn




