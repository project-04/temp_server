class slave_monitor extends uvm_monitor;
	`uvm_component_utils(slave_monitor)
   
      	virtual axi_if.SLV_MON_MP sif;
      	
      	axi_xtn			     xtn_write, xtn_read;
      	slave_config 		     slave_cfg;
      	
      	uvm_analysis_port #(axi_xtn) slv_monitor_port_w;
      	uvm_analysis_port #(axi_xtn) slv_monitor_port_r;
      	
      	axi_xtn q1[$];
      	axi_xtn q2[$];
      	axi_xtn q3[$];

	semaphore sem_aw = new(1); 	//Write address channel
	semaphore sem_w  = new(1); 	//Write data channel
	semaphore sem_b  = new(1); 	//Write response channel
	semaphore sem_wdc  = new();
	semaphore sem_bdc  = new();
	
	semaphore sem_ar = new(1); 	//Read address channel
	semaphore sem_r  = new(1); 	//Read data channel
 	semaphore sem_rdc  = new();
	
      	function new(string name="slave_monitor",uvm_component parent);
        	super.new(name,parent);
        	
      	endfunction

	function void build_phase(uvm_phase phase);
	
		if(! uvm_config_db #(slave_config)::get(this,"","slave_config",slave_cfg))
			`uvm_fatal(get_type_name(),"Have you set the config correctly?");

        	slv_monitor_port_w = new("slv_monitor_port_w", this);
        	slv_monitor_port_r = new("slv_monitor_port_r", this);
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		sif = slave_cfg.sif;
	endfunction
	
	extern task run_phase(uvm_phase phase);
	extern task collect_data();
	
	extern task collect_aw();
	extern task collect_w (axi_xtn xtn_write);
	extern task collect_b (axi_xtn xtn_write);
	
	extern task collect_ar();
	extern task collect_r (axi_xtn xtn_read);
	
endclass

task slave_monitor::run_phase(uvm_phase phase);

	forever
	       begin
	       	    collect_data();
	       end
		
endtask

task slave_monitor::collect_data();
	fork
	
		begin
			sem_aw.get(1);
			collect_aw();
			sem_aw.put(1); 			
			
			sem_wdc.put(1);
			
		end
		  
		begin
			sem_wdc.get(1);
			
			sem_w.get(1);			
			collect_w(q1.pop_front());
			sem_w.put(1);

			sem_bdc.put(1);
						
		end	
		
		begin			
			sem_bdc.get(1);
			
			sem_b.get(1);
			collect_b(q2.pop_front());
			sem_b.put(1);
			
		end
		
		begin
			sem_ar.get(1);
			collect_ar();
			sem_ar.put(1);
			
			sem_rdc.put(1);
			
		end
		begin			
			sem_rdc.get(1);
			
			sem_r.get(1);
			collect_r(q3.pop_front());
			sem_r.put(1);

		end

	join_any

endtask

task slave_monitor::collect_aw();

	//`uvm_info("SLAVE_MONITOR", "Slave Monitor starts collecting from Write Address Channel...", UVM_HIGH);
		
	        xtn_write = axi_xtn::type_id::create("xtn_write");
		
		wait(sif.slv_mon_cb.AWVALID && sif.slv_mon_cb.AWREADY);
		
		xtn_write.AWVALID	= 1;
		xtn_write.AWREADY	= 1;
		xtn_write.AWADDR 	= sif.slv_mon_cb.AWADDR;
		xtn_write.AWSIZE 	= sif.slv_mon_cb.AWSIZE;
	     	xtn_write.AWID 		= sif.slv_mon_cb.AWID;
	     	xtn_write.AWLEN  	= sif.slv_mon_cb.AWLEN;
	     	xtn_write.AWBURST 	= sif.slv_mon_cb.AWBURST;
		
		q1.push_back(xtn_write);

		@(sif.slv_mon_cb);
	
	//`uvm_info("SLAVE_MONITOR", "...end of collecting Write Address Channel.", UVM_HIGH);
	
endtask

task slave_monitor::collect_w(axi_xtn xtn_write);

	//`uvm_info("SLAVE_MONITOR", "Slave Monitor starts collecting from Write Data Channel...", UVM_HIGH);
					     	
		xtn_write.WDATA		= new[xtn_write.AWLEN+1];
		xtn_write.WSTRB		= new[xtn_write.AWLEN+1];
	     
		foreach(xtn_write.WDATA[i])
					
			begin
			     wait(sif.slv_mon_cb.WVALID && sif.slv_mon_cb.WREADY)
			     
			     xtn_write.WVALID	    = 1;
			     xtn_write.WREADY	    = 1;
			     xtn_write.WID	    = sif.slv_mon_cb.WID;
			     
			     if(sif.slv_mon_cb.WSTRB == 15)
			     	xtn_write.WDATA[i]  = sif.slv_mon_cb.WDATA[31:0];
			     	xtn_write.WSTRB[i]  = sif.slv_mon_cb.WSTRB;
			     	
			     if(sif.slv_mon_cb.WSTRB == 14)
			     	xtn_write.WDATA[i]  = sif.slv_mon_cb.WDATA[31:8];
			     	xtn_write.WSTRB[i]  = sif.slv_mon_cb.WSTRB;
			     	
			     if(sif.slv_mon_cb.WSTRB == 12)
			     	xtn_write.WDATA[i]  = sif.slv_mon_cb.WDATA[31:16];
			     	xtn_write.WSTRB[i]  = sif.slv_mon_cb.WSTRB;
			     	
			     if(sif.slv_mon_cb.WSTRB == 8)
			     	xtn_write.WDATA[i]  = sif.slv_mon_cb.WDATA[31:24];
			     	xtn_write.WSTRB[i]  = sif.slv_mon_cb.WSTRB;
			
			     if(sif.slv_mon_cb.WSTRB == 4)
			     	xtn_write.WDATA[i]  = sif.slv_mon_cb.WDATA[23:16];
			     	xtn_write.WSTRB[i]  = sif.slv_mon_cb.WSTRB;
			     	
			     if(sif.slv_mon_cb.WSTRB == 3)
			     	xtn_write.WDATA[i]  = sif.slv_mon_cb.WDATA[15:0];
			     	xtn_write.WSTRB[i]  = sif.slv_mon_cb.WSTRB;
			     	
			     if(sif.slv_mon_cb.WSTRB == 2)
			     	xtn_write.WDATA[i]  = sif.slv_mon_cb.WDATA[15:8];
			     	xtn_write.WSTRB[i]  = sif.slv_mon_cb.WSTRB;
			     	
			     if(sif.slv_mon_cb.WSTRB == 1)
			     	xtn_write.WDATA[i]  = sif.slv_mon_cb.WDATA[7:0];
			     	xtn_write.WSTRB[i]  = sif.slv_mon_cb.WSTRB;
			     								
			     if(i == (xtn_write.AWLEN))
			        xtn_write.WLAST	= sif.slv_mon_cb.WLAST;
			        
			     @(sif.slv_mon_cb);
			       
			end
		
		q2.push_back(xtn_write);

	//`uvm_info("SLAVE_MONITOR", "...end of collecting Write Data Channel.", UVM_HIGH);
endtask

task slave_monitor::collect_b(axi_xtn xtn_write);

	//`uvm_info("SLAVE_MONITOR", "Slave Monitor starts collecting from Write Response Channel...", UVM_HIGH);
		
		wait(sif.slv_mon_cb.BVALID && sif.slv_mon_cb.BREADY);
		xtn_write.BVALID	    = 1;
		xtn_write.BREADY	    = 1;
		xtn_write.BID		    = sif.slv_mon_cb.BID;
		xtn_write.BRESP		    = sif.slv_mon_cb.BRESP;
		
		@(sif.slv_mon_cb);
		
		//$display($time," This is the slave write transaction:%s",xtn_write.sprint());
		slv_monitor_port_w.write(xtn_write);

		//`uvm_info("SLAVE MONITOR WRITE",$sformatf("%s", xtn_write.sprint()), UVM_LOW)
	
	//`uvm_info("SLAVE_MONITOR", "...end of collecting Write Response Channel.", UVM_HIGH);
	
endtask

task slave_monitor::collect_ar();

	//`uvm_info("SLAVE_MONITOR", "Slave Monitor starts collecting from Read Address Channel...", UVM_HIGH);
		
		xtn_read = axi_xtn::type_id::create("xtn_read");
	
		wait(sif.slv_mon_cb.ARVALID && sif.slv_mon_cb.ARREADY);
		
		xtn_read.ARVALID        = 1;
		xtn_read.ARREADY	= 1;
		xtn_read.ARID		= sif.slv_mon_cb.ARID;
		xtn_read.ARLEN		= sif.slv_mon_cb.ARLEN;
		xtn_read.ARSIZE		= sif.slv_mon_cb.ARSIZE;
		xtn_read.ARBURST	= sif.slv_mon_cb.ARBURST;	
		xtn_read.ARADDR		= sif.slv_mon_cb.ARADDR;
			
		q3.push_back(xtn_read);

		@(sif.slv_mon_cb);
		
	//`uvm_info("SLAVE_MONITOR", "...end of collecting Read Address Channel.", UVM_HIGH);
	
endtask

task slave_monitor::collect_r(axi_xtn xtn_read);

	//`uvm_info("SLAVE_MONITOR", "Slave Monitor starts collecting from Read Data Channel...", UVM_HIGH)
	
		xtn_read.RDATA		= new[xtn_read.ARLEN+1];
		xtn_read.RRESP		= new[xtn_read.ARLEN+1];
		
	 	foreach(xtn_read.RDATA[i])
	 		begin
	 		     wait(sif.slv_mon_cb.RVALID && sif.slv_mon_cb.RREADY)
	 		     
	 		     xtn_read.RVALID    = 1;
			     xtn_read.RREADY	= 1;
			     xtn_read.RID	= sif.slv_mon_cb.RID;
	 		     xtn_read.RDATA[i]	= sif.slv_mon_cb.RDATA;
	 		     xtn_read.RRESP[i]	= sif.slv_mon_cb.RRESP;
	 		     
	 		     if(i == (xtn_read.ARLEN))
	 		     	xtn_read.RLAST  = sif.slv_mon_cb.RLAST;
	 		     	
			     @(sif.slv_mon_cb);
			     
			end 
			
		//$display($time," This is the slave read transaction:%s",xtn_read.sprint());
		slv_monitor_port_r.write(xtn_read);

		//`uvm_info("SLAVE MONITOR READ",$sformatf("%s", xtn_read.sprint()), UVM_LOW)
		
	//`uvm_info("SLAVE_MONITOR", "...end of collecting Read Data Channel.", UVM_HIGH)
	
endtask

/*
task slave_monitor::collect_data();
	fork
	
		begin
			sem_aw.get(1);
			collect_aw();
			sem_aw.put(1); 			
			
			sem_w.put(1);
			
		end
		  
		begin
			sem_w.get(2);			
			collect_w(q1.pop_front());
			sem_w.put(1);

			sem_b.put(1);
						
		end	
		
		begin			
			sem_b.get(2);
			collect_b(q2.pop_front());
			sem_b.put(1);
			
		end
		
		begin
			sem_ar.get(1);
			collect_ar();
			sem_ar.put(1);
			
			sem_r.put(1);
			
		end
		begin			
			sem_r.get(2);
			collect_r(q3.pop_front());
			sem_r.put(1);

		end

	join_any

endtask*/




