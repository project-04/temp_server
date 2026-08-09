class slave_driver extends uvm_driver #(axi_xtn);
	`uvm_component_utils(slave_driver)

	// Properties
	axi_slv_agt_cfg m_slv_cfg;
	virtual axi_sif.SLV_DRV_MP a_if;

	int mem[*];

	axi_xtn q1[$], q2[$], q3[$];
	semaphore sem = new();
	semaphore sem1 = new();

	semaphore sem2 = new(1);
	semaphore sem3= new(1);
	semaphore sem4 = new(1);

	semaphore sem5 =new(1);
	semaphore sem6=new(1);
	semaphore sem7=new();


	//Methods
	extern function new(string name="slave_driver", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task drive(axi_xtn xtn);
	extern task drive_write_address();
	extern task drive_write_data(axi_xtn xtn);
	extern task drive_write_response(axi_xtn xtn);
	extern task drive_read_address();
	extern task drive_read_data(axi_xtn xtn);
//	extern function void report_phase(uvm_phase phase);
		
endclass

function slave_driver :: new(string name="slave_driver", uvm_component parent);
	super.new(name, parent);
endfunction

function void slave_driver :: build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db #(axi_slv_agt_cfg)::get(this, "", "axi_slv_agt_cfg", m_slv_cfg))
		`uvm_fatal("AXI_SLAVE_DRIVER", "Cannot get m_slv_cfg from uvm_config_db. Have you set it?")

endfunction

function void slave_driver :: connect_phase(uvm_phase phase);
	a_if = m_slv_cfg.a_if;
endfunction

task slave_driver :: run_phase(uvm_phase phase);

	forever
		begin
			seq_item_port.get_next_item(req);
			drive(req);
			 m_slv_cfg.slv_drv_xtn_sent_cnt++;
			seq_item_port.item_done();
		end

endtask

task slave_driver :: drive(axi_xtn xtn); 
	
	fork
		begin
			sem3.get(1);
			drive_write_address();
			sem.put(1);
			sem3.put(1);
		end

		begin
			sem.get(1);
			sem2.get(1);
			drive_write_data(q1.pop_front());
			sem1.put(1);
			sem2.put(1);
		end

		begin
			sem1.get(1);
			sem4.get(1);
			drive_write_response(q3.pop_front());
			sem4.put(1);
		end

		begin
			sem5.get(1);
			drive_read_address();
			sem7.put(1);
			sem5.put(1);
		end

		begin
			sem6.get(1);
			sem7.get(1);
			drive_read_data(q2.pop_front());
			sem6.put(1);		
		end

	join_any

	`uvm_info("AXI_SLAVE_DRIVER", "Data from Drive Task for AXI Slave", UVM_LOW)
	xtn.print();
		
endtask

task slave_driver :: drive_write_address();


	axi_xtn xtn;
	xtn =axi_xtn::type_id::create("xtn");	
		
		a_if.slv_drv_cb.AWREADY <= 1'b1;
		
		@(a_if.slv_drv_cb)
		wait(a_if.slv_drv_cb.AWVALID)
		xtn.AWID = a_if.slv_drv_cb.AWID;
		xtn.AWADDR = a_if.slv_drv_cb.AWADDR;
		xtn.AWLEN = a_if.slv_drv_cb.AWLEN;
		xtn.AWSIZE = a_if.slv_drv_cb.AWSIZE;
		xtn.AWBURST = a_if.slv_drv_cb.AWBURST;
		xtn.AWVALID = a_if.slv_drv_cb.AWVALID;
           
                   xtn.AWLOCK=a_if.slv_drv_cb.AWLOCK;
                   xtn.AWPROT=a_if.slv_drv_cb.AWPROT;
                   xtn.AWCACHE=a_if.slv_drv_cb.AWCACHE;
                   xtn.AWUSER=a_if.slv_drv_cb.AWUSER;
                   xtn.AWQOS=a_if.slv_drv_cb.AWQOS;


                

 		q1.push_back(xtn); 
		q3.push_back(xtn);

		a_if.slv_drv_cb.AWREADY <= 1'b0;

		repeat($urandom_range(1,5))
		@(a_if.slv_drv_cb);

    `uvm_info("AXI_SLAVE_DRIVER_WRITE_ADDRESS", "Data from the Drive_Write_address Task for AXI Slave", UVM_LOW)
 	xtn.print();
	
endtask

task slave_driver :: drive_write_data(axi_xtn xtn);

	xtn.write_addr_cal();
	xtn.WDATA = new[xtn.AWLEN+1];
	foreach(xtn.WDATA[i])
		begin
			a_if.slv_drv_cb.WREADY <= 1'b1;
			
			@(a_if.slv_drv_cb);
			wait(a_if.slv_drv_cb.WVALID)
			
			
			if(xtn.WSTRB[i] == 4'b1111)
				mem[xtn.w_addr[i]] = a_if.slv_drv_cb.WDATA;
			else if(xtn.WSTRB[i] == 4'b0111)
				mem[xtn.w_addr[i]] = a_if.slv_drv_cb.WDATA[23:0];
			else if(xtn.WSTRB[i] == 4'b0011)
				mem[xtn.w_addr[i]] = a_if.slv_drv_cb.WDATA[15:0];
			else if(xtn.WSTRB[i] == 4'b0001)
				mem[xtn.w_addr[i]] = a_if.slv_drv_cb.WDATA[7:0];
			else if(xtn.WSTRB[i] == 4'b1110)
				mem[xtn.w_addr[i]] = a_if.slv_drv_cb.WDATA[31:8];
			else if(xtn.WSTRB[i] == 4'b1100)
				mem[xtn.w_addr[i]] = a_if.slv_drv_cb.WDATA[31:16];
			else if(xtn.WSTRB[i] == 4'b1000)
				mem[xtn.w_addr[i]] = a_if.slv_drv_cb.WDATA[31:24];
			else if(xtn.WSTRB[i] == 4'b0100)
				mem[xtn.w_addr[i]] = a_if.slv_drv_cb.WDATA[23:16];
			else if(xtn.WSTRB[i] == 4'b0010)
				mem[xtn.w_addr[i]] = a_if.slv_drv_cb.WDATA[15:8];
			
                        xtn.WUSER=a_if.slv_drv_cb.WUSER;
			xtn.WDATA[i] = a_if.slv_drv_cb.WDATA;
				
			a_if.slv_drv_cb.WREADY <= 1'b0;

			repeat($urandom_range(1,5))
			 @(a_if.slv_drv_cb);

		end


 	`uvm_info("AXI_SLAVE_DRIVER_WRITE_DATA", "Data from the Drive_Write_data Task for AXI Slave", UVM_LOW)
 		xtn.print();
endtask

task slave_driver :: drive_write_response(axi_xtn xtn);

	a_if.slv_drv_cb.BVALID <= 1'b1;
	a_if.slv_drv_cb.BID <= xtn.AWID;
	a_if.slv_drv_cb.BUSER <= xtn.BUSER;
        
	a_if.slv_drv_cb.BRESP <= {$random}%3;

	@(a_if.slv_drv_cb);
	wait(a_if.slv_drv_cb.BREADY)

	a_if.slv_drv_cb.BVALID <= 1'b0;
//	a_if.slv_drv_cb.BRESP <= 'hx;
	
	repeat($urandom_range(1,5))
		@(a_if.slv_drv_cb);

  `uvm_info("AXI_SLAVE_DRIVER_WRITE_RESPONSE", "Data from the Drive_Write_response Task for AXI Slave", UVM_LOW)
   xtn.print();
endtask

task slave_driver :: drive_read_address();

	axi_xtn xtn = axi_xtn::type_id::create("xtn");
	
	repeat($urandom_range(1, 5))
	@(a_if.slv_drv_cb);

	a_if.slv_drv_cb.ARREADY <= 1'b1;
	
	@(a_if.slv_drv_cb);
	wait(a_if.slv_drv_cb.ARVALID)

		xtn.ARID = a_if.slv_drv_cb.ARID;
		xtn.ARADDR = a_if.slv_drv_cb.ARADDR;
		xtn.ARLEN = a_if.slv_drv_cb.ARLEN;
		xtn.ARSIZE = a_if.slv_drv_cb.ARSIZE;
		xtn.ARBURST = a_if.slv_drv_cb.ARBURST;
             
                   xtn.ARLOCK=a_if.slv_drv_cb.ARLOCK;
                   xtn.ARPROT=a_if.slv_drv_cb.ARPROT;
                   xtn.ARCACHE=a_if.slv_drv_cb.ARCACHE;
                   xtn.ARUSER=a_if.slv_drv_cb.ARUSER;
                   xtn.ARQOS=a_if.slv_drv_cb.ARQOS;

       	q2.push_back(xtn);

	a_if.slv_drv_cb.ARREADY <=1'b0;

	repeat($urandom_range(1, 5))
	@(a_if.slv_drv_cb);
	
	`uvm_info("AXI_SLAVE_DRIVER_READ_ADDRESS", "Data from the Drive_read_address Task for AXI Slave", UVM_LOW)
	xtn.print();	
endtask

task slave_driver :: drive_read_data(axi_xtn xtn);

	xtn.read_addr_cal();

	xtn.RDATA = new[xtn.ARLEN+1];

	for(int i=0; i<(xtn.ARLEN+1); i++)
		begin
		
			a_if.slv_drv_cb.RVALID <= 1'b1;
			a_if.slv_drv_cb.RID <= xtn.ARID;
			a_if.slv_drv_cb.RUSER <= xtn.RUSER;
                       
			a_if.slv_drv_cb.RDATA <= $urandom;
			a_if.slv_drv_cb.RRESP[i] <= ($urandom_range(0,3));

			if(i==(xtn.ARLEN))
				a_if.slv_drv_cb.RLAST <= 1'b1;
			else
				a_if.slv_drv_cb.RLAST <= 1'b0;
			
			@(a_if.slv_drv_cb);
			wait(a_if.slv_drv_cb.RREADY)
					
			a_if.slv_drv_cb.RVALID <= 1'b0;
			a_if.slv_drv_cb.RLAST <= 1'b0;
					
			repeat($urandom_range(1,5))
				@(a_if.slv_drv_cb);	
		end
	`uvm_info("AXI_SLAVE_DRIVER_READ_DATA", "Data from the Drive_read_data Task for AXI Slave", UVM_LOW)
	xtn.print();
endtask

/*function void slave_driver :: report_phase(uvm_phase phase);
	`uvm_info("AXI_SLAVE_DRIVER-REPORT_PHASE",$sformatf( "Report: Slave Driver has sent %0d transactions", m_slv_cfg.slv_drv_xtn_sent_cnt), UVM_LOW)

endfunction*/







