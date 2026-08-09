class master_monitor extends uvm_monitor;
	`uvm_component_utils(master_monitor)
   
      	virtual axi_if.MST_MON_MP mif;
      	
      	axi_xtn			     xtn_write, xtn_read;
      	master_config 		     master_cfg;
      	
      	uvm_analysis_port #(axi_xtn) mst_monitor_port_w;
      	uvm_analysis_port #(axi_xtn) mst_monitor_port_r;
      	
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
	
      	function new(string name="master_monitor",uvm_component parent);
        	super.new(name,parent);
        	
      	endfunction

	function void build_phase(uvm_phase phase);
	
		if(! uvm_config_db #(master_config)::get(this,"","master_config",master_cfg))
			`uvm_fatal(get_type_name(),"Have you set the config correctly?");

        	mst_monitor_port_w = new("mst_monitor_port_w", this);
        	mst_monitor_port_r = new("mst_monitor_port_r", this);
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		mif = master_cfg.mif;
	endfunction
	
	extern task run_phase(uvm_phase phase);
	extern task collect_data();
	
	extern task collect_aw();
	extern task collect_w (axi_xtn xtn_write);
	extern task collect_b (axi_xtn xtn_write);
	
	extern task collect_ar();
	extern task collect_r (axi_xtn xtn_read);
	
endclass

task master_monitor::run_phase(uvm_phase phase);

	forever
	       begin
	       	    collect_data();
	       end
		
endtask

task master_monitor::collect_data();
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

task master_monitor::collect_aw();

	//`uvm_info("MASTER_MONITOR", "Master Monitor starts collecting from Write Address Channel...", UVM_HIGH);
		
	        xtn_write = axi_xtn::type_id::create("xtn_write");
		
		wait(mif.mst_mon_cb.AWVALID && mif.mst_mon_cb.AWREADY);
		
		xtn_write.AWVALID	= 1;
		xtn_write.AWREADY	= 1;
		xtn_write.AWADDR 	= mif.mst_mon_cb.AWADDR;
		xtn_write.AWSIZE 	= mif.mst_mon_cb.AWSIZE;	
	     	xtn_write.AWID 		= mif.mst_mon_cb.AWID;
	     	xtn_write.AWLEN  	= mif.mst_mon_cb.AWLEN;
	     	xtn_write.AWBURST 	= mif.mst_mon_cb.AWBURST;

		q1.push_back(xtn_write);

		@(mif.mst_mon_cb);
	
	//`uvm_info("MASTER_MONITOR", "...end of collecting Write Address Channel.", UVM_HIGH);
	
endtask

task master_monitor::collect_w(axi_xtn xtn_write);

	//`uvm_info("MASTER_MONITOR", "Master Monitor starts collecting from Write Data Channel...", UVM_HIGH);
			     	
		xtn_write.WDATA		= new[xtn_write.AWLEN+1];
		xtn_write.WSTRB		= new[xtn_write.AWLEN+1];
			     
		foreach(xtn_write.WDATA[i])
					
			begin
			     wait(mif.mst_mon_cb.WVALID && mif.mst_mon_cb.WREADY)
			     
			     xtn_write.WVALID	    = 1;
			     xtn_write.WREADY	    = 1;
			     xtn_write.WID	    = mif.mst_mon_cb.WID;
			     
			     if(mif.mst_mon_cb.WSTRB == 15)//1111
			     	xtn_write.WDATA[i]  = mif.mst_mon_cb.WDATA[31:0];
			     	xtn_write.WSTRB[i]  = mif.mst_mon_cb.WSTRB;
			     	
			     if(mif.mst_mon_cb.WSTRB == 14)//1110
			     	xtn_write.WDATA[i]  = mif.mst_mon_cb.WDATA[31:8];
			     	xtn_write.WSTRB[i]  = mif.mst_mon_cb.WSTRB;
			     	
			     if(mif.mst_mon_cb.WSTRB == 12)//1100
			     	xtn_write.WDATA[i]  = mif.mst_mon_cb.WDATA[31:16];
			     	xtn_write.WSTRB[i]  = mif.mst_mon_cb.WSTRB;
			     	
			     if(mif.mst_mon_cb.WSTRB == 8)//1000
			     	xtn_write.WDATA[i]  = mif.mst_mon_cb.WDATA[31:24];
			     	xtn_write.WSTRB[i]  = mif.mst_mon_cb.WSTRB;

			     if(mif.mst_mon_cb.WSTRB == 4)//0100
			     	xtn_write.WDATA[i]  = mif.mst_mon_cb.WDATA[23:16];
			     	xtn_write.WSTRB[i]  = mif.mst_mon_cb.WSTRB;
			     	
			     if(mif.mst_mon_cb.WSTRB == 3)//0011
			     	xtn_write.WDATA[i]  = mif.mst_mon_cb.WDATA[15:0];
			     	xtn_write.WSTRB[i]  = mif.mst_mon_cb.WSTRB;
			     	
			     if(mif.mst_mon_cb.WSTRB == 2)//0010
			     	xtn_write.WDATA[i]  = mif.mst_mon_cb.WDATA[15:8];
			     	xtn_write.WSTRB[i]  = mif.mst_mon_cb.WSTRB;
			     	
			     if(mif.mst_mon_cb.WSTRB == 1)//0001
			     	xtn_write.WDATA[i]  = mif.mst_mon_cb.WDATA[7:0];
			     	xtn_write.WSTRB[i]  = mif.mst_mon_cb.WSTRB;
			     								
			     if(i == (xtn_write.AWLEN))
			        xtn_write.WLAST	= mif.mst_mon_cb.WLAST;
			        
			     @(mif.mst_mon_cb);
			       
			end
	
		q2.push_back(xtn_write);

	//`uvm_info("MASTER_MONITOR", "...end of collecting Write Data Channel.", UVM_HIGH);
endtask

task master_monitor::collect_b(axi_xtn xtn_write);

	//`uvm_info("MASTER_MONITOR", "Master Monitor starts collecting from Write Response Channel...", UVM_HIGH);
		
		wait(mif.mst_mon_cb.BVALID && mif.mst_mon_cb.BREADY);
		xtn_write.BVALID	    = 1;
		xtn_write.BREADY	    = 1;
		xtn_write.BID		    = mif.mst_mon_cb.BID;
		xtn_write.BRESP		    = mif.mst_mon_cb.BRESP;
		
		@(mif.mst_mon_cb);
		
		//$display($time," This is the master write transaction:%s",xtn_write.sprint());
		mst_monitor_port_w.write(xtn_write);

		//`uvm_info("MASTER MONITOR WRITE",$sformatf("%s", xtn_write.sprint()), UVM_LOW)
	
	//`uvm_info("MASTER_MONITOR", "...end of collecting Write Response Channel.", UVM_HIGH);
		
endtask

task master_monitor::collect_ar();

	//`uvm_info("MASTER_MONITOR", "Master Monitor starts collecting from Read Address Channel...", UVM_HIGH);
		
		xtn_read = axi_xtn::type_id::create("xtn_read");
	
		wait(mif.mst_mon_cb.ARVALID && mif.mst_mon_cb.ARREADY);
		
		xtn_read.ARVALID        = 1;
		xtn_read.ARREADY	= 1;
		xtn_read.ARID		= mif.mst_mon_cb.ARID;
		xtn_read.ARLEN		= mif.mst_mon_cb.ARLEN;
		xtn_read.ARSIZE		= mif.mst_mon_cb.ARSIZE;
		xtn_read.ARBURST	= mif.mst_mon_cb.ARBURST;	
		xtn_read.ARADDR		= mif.mst_mon_cb.ARADDR;
			
		q3.push_back(xtn_read);

		@(mif.mst_mon_cb);
		
	//`uvm_info("MASTER_MONITOR", "...end of collecting Read Address Channel.", UVM_HIGH);
	
endtask

task master_monitor::collect_r(axi_xtn xtn_read);

	//`uvm_info("MASTER_MONITOR", "Master Monitor starts collecting from Read Data Channel...", UVM_HIGH);
	
		xtn_read.RDATA		= new[xtn_read.ARLEN+1];
		xtn_read.RRESP		= new[xtn_read.ARLEN+1];
		
	 	foreach(xtn_read.RDATA[i])
	 		begin
	 		     wait(mif.mst_mon_cb.RVALID && mif.mst_mon_cb.RREADY)
	 		     
	 		     xtn_read.RVALID    = 1;
			     xtn_read.RREADY	= 1;
			     xtn_read.RID	= mif.mst_mon_cb.RID;
	 		     xtn_read.RDATA[i]	= mif.mst_mon_cb.RDATA;
	 		     xtn_read.RRESP[i]	= mif.mst_mon_cb.RRESP;
	 		     
	 		     if(i == (xtn_read.ARLEN))
	 		     	xtn_read.RLAST  = mif.mst_mon_cb.RLAST;
	 		     	
			     @(mif.mst_mon_cb);
			     
			end 
			
		//$display($time," This is the master read transaction:%s",xtn_read.sprint());
		mst_monitor_port_r.write(xtn_read);
		
		//`uvm_info("MASTER MONITOR READ",$sformatf("%s", xtn_read.sprint()), UVM_LOW)
		
	//`uvm_info("MASTER_MONITOR", "...end of collecting Read Data Channel.", UVM_HIGH)
	
endtask

/*
	semaphore sem_aw = new(1); 	//Write address channel
	semaphore sem_w  = new(); 	//Write data channel
	semaphore sem_b  = new(); 	//Write response channel
	
	semaphore sem_ar = new(1); 	//Read address channel
	semaphore sem_r  = new(); 	//Read data channel
*/

/*
task master_monitor::collect_data();
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

	join

endtask*/




