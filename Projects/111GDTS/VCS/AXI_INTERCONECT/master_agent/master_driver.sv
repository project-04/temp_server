class master_driver extends uvm_driver #(axi_xtn);
	`uvm_component_utils(master_driver)

	// Properties
	axi_mast_agt_cfg m_mast_cfg;
	virtual axi_mif.MAST_DRV_MP a_if;
	axi_xtn q1[$], q2[$], q3[$],q4[$], q5[$];

	int w_mem[*];	

	semaphore sem = new();
	semaphore sem1 = new();

	semaphore sem2 = new(1);
	semaphore sem3= new(1);
	semaphore sem4 = new(1);

	semaphore sem5 =new(1);
	semaphore sem6=new(1);
	semaphore sem7=new();

	// Methods
	extern function new(string name ="master_driver", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task drive(axi_xtn xtn);
	extern task drive_write_address(axi_xtn xtn);
	extern task drive_write_data(axi_xtn xtn);
	extern task drive_write_response(axi_xtn xtn);
	extern task drive_read_address(axi_xtn xtn);
	extern task drive_read_data(axi_xtn xtn);
//	extern function void report_phase(uvm_phase phase);

endclass

function master_driver :: new(string name="master_driver", uvm_component parent);
	super.new(name, parent);
endfunction

function void master_driver :: build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db #(axi_mast_agt_cfg) :: get(this, "", "axi_mast_agt_cfg", m_mast_cfg))
		`uvm_fatal("AXI_MASTER-DRIVER", "Cannot get m_mast_cfg from uvm_config_db. Have you set it?")
endfunction

function void master_driver :: connect_phase(uvm_phase phase);
	a_if = m_mast_cfg.a_if;
endfunction

task master_driver :: run_phase (uvm_phase phase);

	forever
		begin
         
			seq_item_port.get_next_item(req);
			drive(req);

			m_mast_cfg.mast_drv_xtn_sent_cnt ++;
			seq_item_port.item_done();
		end
endtask

task master_driver :: drive(axi_xtn xtn);
	
	q1.push_back(xtn);
	q2.push_back(xtn);
	q3.push_back(xtn);
	
	q4.push_back(xtn);
	q5.push_back(xtn);

	fork
		begin
			sem3.get(1);
			drive_write_address(q1.pop_front());
			sem.put(1);
			sem3.put(1);
		end

		begin
			sem.get(1);
			sem2.get(1);
			drive_write_data(q2.pop_front());
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
			drive_read_address(q4.pop_front());
			sem7.put(1);
			sem5.put(1);
		end

		begin
			sem7.get(1);
			sem6.get(1);
			drive_read_data(q5.pop_front());
			sem6.put(1);		
		end

	join_any
		`uvm_info("AXI_MASTER_DRIVER", "Displaying Data from Master Driver", UVM_LOW)
		xtn.print();	
	
endtask

task master_driver :: drive_write_address(axi_xtn xtn);
	a_if.mast_drv_cb.AWVALID <= 1'b1;
	a_if.mast_drv_cb.AWID <= xtn.AWID;
	a_if.mast_drv_cb.AWADDR <= xtn.AWADDR;
	a_if.mast_drv_cb.AWLEN <= xtn.AWLEN;
	a_if.mast_drv_cb.AWSIZE <= xtn.AWSIZE;
	a_if.mast_drv_cb.AWBURST <= xtn.AWBURST;

        a_if.mast_drv_cb.AWLOCK<=xtn.AWLOCK;
        a_if.mast_drv_cb.AWPROT<=xtn.AWPROT;
        a_if.mast_drv_cb.AWCACHE<=xtn.AWCACHE;
        a_if.mast_drv_cb.AWUSER<=xtn.AWUSER;
        a_if.mast_drv_cb.AWQOS<=xtn.AWQOS;
	
	@(a_if.mast_drv_cb);
	wait(a_if.mast_drv_cb.AWREADY)

	a_if.mast_drv_cb.AWVALID <= 1'b0;

	repeat($urandom_range(1,5))
	@(a_if.mast_drv_cb);

	`uvm_info("AXI_MASTER_DRIVER_WRITE_ADDRESS", "Displaying Data from Master Driver Drive_Write_address channel", UVM_LOW)
 	xtn.print();


endtask

task master_driver :: drive_write_data(axi_xtn xtn);
	foreach(xtn.WDATA[i])
		begin
			a_if.mast_drv_cb.WVALID <= 1'b1;
			a_if.mast_drv_cb.WID <= xtn.WID;
			a_if.mast_drv_cb.WDATA <= xtn.WDATA[i];
			a_if.mast_drv_cb.WSTRB <= xtn.WSTRB[i];

                        a_if.mast_drv_cb.WUSER<=xtn.WUSER;
			

			if(i == (xtn.AWLEN))
				a_if.mast_drv_cb.WLAST <= 1'b1;
			else
				a_if.mast_drv_cb.WLAST <= 1'b0;
				
			@(a_if.mast_drv_cb);
			wait(a_if.mast_drv_cb.WREADY)
			a_if.mast_drv_cb.WVALID <= 1'b0;
			a_if.mast_drv_cb.WLAST <= 1'b0;
				
			repeat($urandom_range(1,5))
				@(a_if.mast_drv_cb);

		end
	`uvm_info("AXI_MASTER_DRIVER_WRITE_DATA", "Displaying Data from Master Driver Drive_Write_data channel", UVM_LOW)
	xtn.print();
	
endtask
	
task master_driver :: drive_write_response(axi_xtn xtn);

	a_if.mast_drv_cb.BREADY <= 1'b1;

	@(a_if.mast_drv_cb);
	wait(a_if.mast_drv_cb.BVALID)

	a_if.mast_drv_cb.BREADY <= 1'b0;
	
	repeat($urandom_range(1,5))
	@(a_if.mast_drv_cb);


	`uvm_info("AXI_MASTER_DRIVER_WRITE_RESPONSE", "Displaying Data from Master Driver Drive_Write_Response channel", UVM_LOW)
	xtn.print();

endtask

task master_driver :: drive_read_address(axi_xtn xtn);
	

	repeat($urandom_range(1,5))
	@(a_if.mast_drv_cb);

	a_if.mast_drv_cb.ARVALID <= 1'b1;
	a_if.mast_drv_cb.ARID <= xtn.ARID;
	a_if.mast_drv_cb.ARADDR <= xtn.ARADDR;
	a_if.mast_drv_cb.ARLEN <= xtn.ARLEN;
	a_if.mast_drv_cb.ARSIZE <= xtn.ARSIZE;
	a_if.mast_drv_cb.ARBURST <= xtn.ARBURST;
        
         a_if.mast_drv_cb.ARLOCK<=xtn.ARLOCK;
        a_if.mast_drv_cb.ARPROT<=xtn.ARPROT;
        a_if.mast_drv_cb.ARCACHE<=xtn.ARCACHE;
        a_if.mast_drv_cb.ARUSER<=xtn.ARUSER;
        a_if.mast_drv_cb.ARQOS<=xtn.ARQOS;


	@(a_if.mast_drv_cb);

	wait(a_if.mast_drv_cb.ARREADY)
	a_if.mast_drv_cb.ARVALID <= 1'b0;

	repeat($urandom_range(1,5))
	@(a_if.mast_drv_cb);


       `uvm_info("AXI_MASTER_DRIVER_READ_ADDRESS", "Displaying Data from Master Driver Drive_Read_address channel", UVM_LOW)
	xtn.print();
			
endtask

task master_driver :: drive_read_data(axi_xtn xtn);
	
	xtn.read_addr_cal();

	xtn.RDATA=new[xtn.ARLEN+1];

	for(int i=0; i<(xtn.ARLEN+1); i++)
	begin
	
	a_if.mast_drv_cb.RREADY <= 1'b1;
	
	@(a_if.mast_drv_cb);
	wait(a_if.mast_drv_cb.RVALID)

	w_mem[xtn.r_addr[i]] =a_if.mast_drv_cb.RDATA[i];
	w_mem[xtn.r_addr[i]] = a_if.mast_drv_cb.RRESP[i];
        xtn.RUSER=a_if.mast_drv_cb.RUSER;

	a_if.mast_drv_cb.RREADY <= 1'b0;

	repeat($urandom_range(1,5))
	@(a_if.mast_drv_cb);
			

	end

	`uvm_info("AXI_MASTER_DRIVER_READ_DATA", "Displaying Data from Master Driver Drive_Read_data channel", UVM_LOW)
	xtn.print();

endtask

/*function void master_driver :: report_phase(uvm_phase phase);
	`uvm_info("AXI_MASTER_DRIVER-REPORT_PHASE",$sformatf( "Report: Master Driver has sent %0d transactions", m_mast_cfg.mast_drv_xtn_sent_cnt), UVM_LOW)
endfunction*/

