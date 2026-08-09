class slave_monitor extends uvm_monitor;
	`uvm_component_utils(slave_monitor)

	// Properties
	axi_slv_agt_cfg m_slv_cfg;
	virtual axi_sif.SLV_MON_MP a_if;
	uvm_analysis_port #(axi_xtn) monitor_port;

	axi_xtn q1[$], q2[$];
	axi_xtn xtn, xtn1, xtn2, xtn3, xtn4;
	
	semaphore sem = new();
	semaphore sem1 = new();

	semaphore sem2 = new(1);
	semaphore sem3= new(1);
	semaphore sem4 = new(1);

	semaphore sem5 =new(1);
	semaphore sem6=new(1);
	semaphore sem7=new();

	// methods
	extern function new(string name ="slave_monitor", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
 	extern task run_phase(uvm_phase phase);
	extern task collect_data();
	extern task write_address_collect();
	extern task write_data_collect(axi_xtn xtn);
	extern task write_response_collect(axi_xtn xtn1);
	extern task read_address_collect();
	extern task read_data_collect(axi_xtn xtn3);
 	extern function void report_phase(uvm_phase phase);
endclass

function slave_monitor :: new(string name="slave_monitor", uvm_component parent);
	super.new(name, parent);
	monitor_port = new("monitor_port", this);
endfunction

function void slave_monitor :: build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db #(axi_slv_agt_cfg) :: get(this, "", "axi_slv_agt_cfg", m_slv_cfg))
		`uvm_fatal("AXI_SLAVE-MONITOR", "Cannot get m_slv_cfg from uvm_config_db. Have you set it?")
endfunction

function void slave_monitor :: connect_phase(uvm_phase phase);
	a_if = m_slv_cfg.a_if;
endfunction

task slave_monitor :: run_phase(uvm_phase phase);
	forever
		begin
			collect_data();
			m_slv_cfg.slv_mon_rcvd_xtn_cnt++; 		

		end
endtask

task slave_monitor :: collect_data();

	fork
		begin
			sem3.get(1);
			write_address_collect();
			sem.put(1);
			sem3.put(1);
		end

		begin
			sem.get(1);
			sem2.get(1);
			write_data_collect(q1.pop_front());
			sem1.put(1);
			sem2.put(1);
		end

		begin
			sem1.get(1);
			sem4.get(1);
			write_response_collect(q1.pop_front());
			sem4.put(1);
		end

		begin
			sem5.get(1);
			read_address_collect();
			sem7.put(1);
			sem5.put(1);
		end

		begin
			sem7.get(1);
			sem6.get(1);
			read_data_collect(q2.pop_front());
			sem6.put(1);		
		end

	join_any
	

	`uvm_info("AXI_SLAVE_Monitor", "Displaying Data from AXI Slave Monior ", UVM_LOW)
//	xtn.print();

endtask


task  slave_monitor :: write_address_collect()	;	
	axi_xtn xtn = axi_xtn::type_id::create("xtn");		
	@(a_if.slv_mon_cb);
	wait((a_if.slv_mon_cb.AWVALID)&&(a_if.slv_mon_cb.AWREADY))

		xtn.rst1=a_if.slv_mon_cb.rst1;
		xtn.AWID = a_if.slv_mon_cb.AWID;
		xtn.AWADDR = a_if.slv_mon_cb.AWADDR;
		xtn.AWLEN = a_if.slv_mon_cb.AWLEN;
		xtn.AWSIZE = a_if.slv_mon_cb.AWSIZE;
		xtn.AWBURST = a_if.slv_mon_cb.AWBURST;

                   xtn.AWLOCK=a_if.slv_mon_cb.AWLOCK;
                   xtn.AWPROT=a_if.slv_mon_cb.AWPROT;
                   xtn.AWCACHE=a_if.slv_mon_cb.AWCACHE;
                   xtn.AWUSER=a_if.slv_mon_cb.AWUSER;
                   xtn.AWQOS=a_if.slv_mon_cb.AWQOS;



		q1.push_back(xtn);
   `uvm_info("AXI_SLAVE_Monitor_Write_Address_Collect", "Displaying Data from AXI Slave Monior Write Address Collect", UVM_LOW)
	xtn.print();
		@(a_if.slv_mon_cb);

endtask

task slave_monitor :: write_data_collect(axi_xtn xtn);
	 xtn1 = axi_xtn::type_id::create("xtn1");
	
	xtn1 = xtn;

	xtn1.write_addr_cal();


	xtn1.WDATA = new[xtn1.AWLEN+1];
	xtn1.WSTRB = new[xtn1.WDATA.size()];
	xtn1.strobe_cal();
	foreach(xtn1.WDATA[i])
		begin
			@(a_if.slv_mon_cb);
		wait((a_if.slv_mon_cb.WVALID)&&(a_if.slv_mon_cb.WREADY))	
		
                        xtn1.WUSER = a_if.slv_mon_cb.WUSER;

			xtn1.WID = a_if.slv_mon_cb.WID;
			xtn1.WDATA[i] = a_if.slv_mon_cb.WDATA;
			
	        	if(i==(xtn1.AWLEN))
			xtn1.WLAST = a_if.slv_mon_cb.WLAST;

			@(a_if.slv_mon_cb);
		end
  `uvm_info("AXI_SLAVE_Monitor_Write_DATA_Collect", "Displaying Data from AXI Slave Monior Write DATA Collect", UVM_LOW)
	xtn1.print();
	q1.push_back(xtn1);
endtask

task slave_monitor :: write_response_collect(axi_xtn xtn1);
	 xtn2 = axi_xtn::type_id::create("xtn2");
	 xtn2 = xtn1;

	wait((a_if.slv_mon_cb.BVALID)&&(a_if.slv_mon_cb.BREADY)) 
		xtn2.BID = a_if.slv_mon_cb.BID;
		xtn2.BRESP = a_if.slv_mon_cb.BRESP;
                xtn2.BUSER = a_if.slv_mon_cb.BUSER;


	`uvm_info("AXI_SLAVE_Monitor_Write_Response_Collect", "Displaying Data from AXI Slave Monior Write Response Collect", UVM_LOW)
	xtn2.print();
	monitor_port.write(xtn2);
	@(a_if.slv_mon_cb);
endtask

task slave_monitor :: read_address_collect();	

	 xtn3=axi_xtn::type_id::create("xtn3");		
		
	@(a_if.slv_mon_cb);
	wait((a_if.slv_mon_cb.ARVALID)&&(a_if.slv_mon_cb.ARREADY))

		xtn3.ARID = a_if.slv_mon_cb.ARID;
		xtn3.ARADDR = a_if.slv_mon_cb.ARADDR;
		xtn3.ARLEN = a_if.slv_mon_cb.ARLEN;
		xtn3.ARSIZE = a_if.slv_mon_cb.ARSIZE;
		xtn3.ARBURST = a_if.slv_mon_cb.ARBURST;

                   xtn3.ARLOCK=a_if.slv_mon_cb.ARLOCK;
                   xtn3.ARPROT=a_if.slv_mon_cb.ARPROT;
                   xtn3.ARCACHE=a_if.slv_mon_cb.ARCACHE;
                   xtn3.ARUSER=a_if.slv_mon_cb.ARUSER;
                   xtn3.ARQOS=a_if.slv_mon_cb.ARQOS;


		@(a_if.slv_mon_cb);
		

  `uvm_info("AXI_SLAVE_Monitor_Read_Address_Collect", "Displaying Data from AXI Slave Monior Read Address Collect", UVM_LOW)
     xtn3.print();
	q2.push_back(xtn3);	
endtask

task slave_monitor :: read_data_collect(axi_xtn xtn3);
	 xtn4=axi_xtn::type_id::create("xtn4");
	xtn4=xtn3;	
	
	xtn4.RDATA = new[xtn4.ARLEN+1];
	xtn4.RRESP = new[xtn4.ARLEN+1];
	xtn4.read_addr_cal();

	foreach(xtn4.RDATA[i])
		begin
			@(a_if.slv_mon_cb);
			wait((a_if.slv_mon_cb.RVALID)&&(a_if.slv_mon_cb.RREADY))
			xtn4.RID = a_if.slv_mon_cb.RID;
			xtn4.RDATA[i] = a_if.slv_mon_cb.RDATA;
			xtn4.RRESP[i] = a_if.slv_mon_cb.RRESP;
                        xtn4.RUSER = a_if.slv_mon_cb.RUSER;

		
			if(i==(xtn4.RDATA.size()-1))
			xtn4.RLAST = a_if.slv_mon_cb.RLAST;

			@(a_if.slv_mon_cb);
		end
`uvm_info("AXI_SLAVE_Monitor_Read_Data_Collect", "Displaying Data from AXI Slave Monior Read Data Collect", UVM_LOW)
	xtn4.print();
	monitor_port.write(xtn4);
endtask
	
function void slave_monitor :: report_phase(uvm_phase phase);
	`uvm_info("AXI_SLAVE_MONITOR-Report_Phase", $sformatf("Report:Slave Monitor collected %0d transactions", m_slv_cfg.slv_mon_rcvd_xtn_cnt ), UVM_LOW) 
endfunction


