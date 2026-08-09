class master_driver extends uvm_driver #(axi_xtn);
      	`uvm_component_utils(master_driver)
   
      	virtual axi_if.MST_DRV_MP mif;  
      	master_config 	master_cfg;
 
 	axi_xtn xtn;
	axi_xtn q1[$], q2[$], q3[$], q4[$], q5[$];
	
	semaphore sem_aw = new(1); 	//Write address channel
	semaphore sem_w  = new(1); 	//Write data channel
	semaphore sem_b  = new(1); 	//Write response channel
	semaphore sem_wdc  = new();
	semaphore sem_bdc  = new();
	
	semaphore sem_ar = new(1); 	//Read address channel
	semaphore sem_r  = new(1); 	//Read data channel
 	semaphore sem_rdc  = new();
 	
	function new(string name="master_driver",uvm_component parent);
        	super.new(name,parent);
  	endfunction

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(master_config)::get(this, "", "master_config", master_cfg))
			`uvm_fatal(get_type_name(), "Have you set the config ???");
		super.build_phase(phase);
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		mif = master_cfg.mif;
	endfunction
	
	extern task run_phase(uvm_phase phase);
	extern task drive(axi_xtn xtn);
	extern task drive_aw(axi_xtn xtn);
	extern task drive_w(axi_xtn xtn);
	extern task catch_b(axi_xtn xtn);
	
	extern task drive_ar(axi_xtn xtn);
	extern task catch_r(axi_xtn xtn);
		
endclass

task master_driver::run_phase(uvm_phase phase);
	forever
	       begin
		    seq_item_port.get_next_item(req);
		    drive(req);
		    //req.print();
		    seq_item_port.item_done();
	       end
	       
endtask: run_phase

task master_driver::drive(axi_xtn xtn);
	//`uvm_info("MASTER DRIVER DRIVES", $sformatf("%s", xtn.sprint()), UVM_LOW);
	
	q1.push_back(xtn);
	q2.push_back(xtn);
	q3.push_back(xtn);
	q4.push_back(xtn);
	q5.push_back(xtn);
	
	fork
	
		begin
			sem_aw.get(1);
			drive_aw(q1.pop_front());
			sem_aw.put(1); 			
			
			sem_wdc.put(1);
			
		end
		  
		begin
			sem_wdc.get(1);	
			
			sem_w.get(1);	
			drive_w(q2.pop_front());
			sem_w.put(1);

			sem_bdc.put(1);
						
		end	
		
		begin			
			sem_bdc.get(1);	
			
			sem_b.get(1);		
			catch_b(q3.pop_front());
			sem_b.put(1);
			
		end
		
		begin
			sem_ar.get(1);
			drive_ar(q4.pop_front());
			sem_ar.put(1);
			
			sem_rdc.put(1);
			
		end
		begin	
			sem_rdc.get(1);
				
			sem_r.get(1);
			catch_r(q5.pop_front());
			sem_r.put(1);

		end

	join_any
	
endtask: drive

task master_driver::drive_aw(axi_xtn xtn);//*************************To drive the Write Address and it's Control Signals.

	//`uvm_info("MASTER DRIVER","Write Address Channel(Master-side) driving starts...\n", UVM_HIGH);

	begin
	     mif.mst_drv_cb.AWVALID 		<= 1;
	     mif.mst_drv_cb.AWADDR 		<= xtn.AWADDR;	
	     mif.mst_drv_cb.AWSIZE 		<= xtn.AWSIZE;	
	     mif.mst_drv_cb.AWID 		<= xtn.AWID;
	     mif.mst_drv_cb.AWLEN 		<= xtn.AWLEN;
	     mif.mst_drv_cb.AWBURST 		<= xtn.AWBURST;

	     @(mif.mst_drv_cb);
	     wait(mif.mst_drv_cb.AWREADY)
	          mif.mst_drv_cb.AWVALID 	<= 0;
	          mif.mst_drv_cb.AWADDR 	<= 'hx;	
	     	  mif.mst_drv_cb.AWSIZE 	<= 'hx;	
	     	  mif.mst_drv_cb.AWID 		<= 'hx;
	     	  mif.mst_drv_cb.AWLEN 		<= 'hx;
	     	  mif.mst_drv_cb.AWBURST 	<= 'hx;

	     repeat($urandom_range(1, 5))
		    @(mif.mst_drv_cb);
		    
	end
	
	//`uvm_info("MASTER DRIVER","...end of Write Address Channel(Master side) drive.\n", UVM_HIGH);
	
endtask: drive_aw

task master_driver::drive_w(axi_xtn xtn);//**************************To drive the Write Data and Write Strobe.

	//`uvm_info("MASTER DRIVER","Write Data Channel(Master side) driving starts:...\n", UVM_HIGH);
		
	foreach(xtn.WDATA[i])
		begin
		    //$display("\nDriven Beat Number: %0d", i+1);
		    mif.mst_drv_cb.WVALID 	<= 1;
		    mif.mst_drv_cb.WDATA 	<= xtn.WDATA[i];
		    mif.mst_drv_cb.WSTRB 	<= xtn.WSTRB[i];
		    mif.mst_drv_cb.WID 		<= xtn.WID;	    					    

		    if(i == (xtn.AWLEN))
			mif.mst_drv_cb.WLAST    <= 1;
		    else
		        mif.mst_drv_cb.WLAST 	<= 0;

			
		    @(mif.mst_drv_cb);
		    wait(mif.mst_drv_cb.WREADY)
		    	 mif.mst_drv_cb.WVALID 	<= 0;
		    	 mif.mst_drv_cb.WDATA	<= 'hx;
			 mif.mst_drv_cb.WSTRB 	<= 'hx;
			 mif.mst_drv_cb.WID 	<= 'hx;
			 mif.mst_drv_cb.WLAST 	<= 0; 
			 
		    repeat($urandom_range(1, 5))
			   @(mif.mst_drv_cb);

		end

	//`uvm_info("MASTER DRIVER","...end of Write Data Channel(Master side)  drive.\n", UVM_HIGH);
	
endtask: drive_w

task master_driver::catch_b(axi_xtn xtn);//**************************To drive the Write Response READY.

	//`uvm_info("MASTER DRIVER","Write Respose Channel(Master side) driving starts:...\n", UVM_HIGH);
	
	mif.mst_drv_cb.BREADY 	<= 1;
	
	@(mif.mst_drv_cb);
	wait(mif.mst_drv_cb.BVALID)
	
	mif.mst_drv_cb.BREADY 	<= 0;
	
	repeat($urandom_range(1, 5))
		@(mif.mst_drv_cb);
		
	//`uvm_info("MASTER DRIVER","...end of Write Response Channel(Master side) drive.\n", UVM_HIGH);		

endtask: catch_b

task master_driver::drive_ar(axi_xtn xtn);//*************************To drive the Read Data and it's Control Signals.

	//`uvm_info("MASTER DRIVER","Read Address Channel(Master side) driving starts:...\n", UVM_HIGH);
		
	mif.mst_drv_cb.ARID 	<= xtn.ARID;
	mif.mst_drv_cb.ARLEN 	<= xtn.ARLEN;
	mif.mst_drv_cb.ARSIZE 	<= xtn.ARSIZE;
	mif.mst_drv_cb.ARBURST 	<= xtn.ARBURST;
	mif.mst_drv_cb.ARADDR 	<= xtn.ARADDR;
	mif.mst_drv_cb.ARVALID 	<= 1;
	
	@(mif.mst_drv_cb);
	wait(mif.mst_drv_cb.ARREADY)
	
	     mif.mst_drv_cb.ARID 	<= 'hx;
	     mif.mst_drv_cb.ARLEN 	<= 'hx;
	     mif.mst_drv_cb.ARSIZE 	<= 'hx;
	     mif.mst_drv_cb.ARBURST 	<= 'hx;
	     mif.mst_drv_cb.ARADDR 	<= 'hx;
	     mif.mst_drv_cb.ARVALID 	<= 0;
	
	repeat($urandom_range(1, 5))
		@(mif.mst_drv_cb);
		
	//`uvm_info("MASTER DRIVER","...end of Read Address Channel(Master side) drive.\n", UVM_HIGH);	
	
endtask: drive_ar

task master_driver::catch_r(axi_xtn xtn);//**************************To drive the Read Data READY.

	//`uvm_info("MASTER DRIVER","Read Data Channel(Master side) driving starts:...\n", UVM_HIGH);
	
	repeat(xtn.ARLEN+1)
	       begin
		   mif.mst_drv_cb.RREADY <= 1;
		   
		   @(mif.mst_drv_cb);
		   wait(mif.mst_drv_cb.RVALID)
		        
		        mif.mst_drv_cb.RREADY <= 0;
		
		   repeat($urandom_range(1, 5))
		          @(mif.mst_drv_cb);
		
	       end

	//`uvm_info("MASTER DRIVER","...end of Read Data Channel(Master side) drive.\n", UVM_HIGH);
	
endtask: catch_r

/*
	semaphore sem_aw = new(1); 	//Write address channel
	semaphore sem_w  = new(); 	//Write data channel
	semaphore sem_b  = new(); 	//Write response channel
	
	semaphore sem_ar = new(1); 	//Read address channel
	semaphore sem_r  = new(); 	//Read data channel
*/
/*
fork
	
		begin
			sem_aw.get(1);
			drive_aw(q1.pop_front());
			sem_aw.put(1); 			
			
			sem_w.put(1);
			
		end
		  
		begin
			sem_w.get(2);	
			drive_w(q2.pop_front());
			sem_w.put(1);

			sem_b.put(1);
						
		end	
		
		begin			
			sem_b.get(2);	
			catch_b(q3.pop_front());
			sem_b.put(1);
			
		end
		
		begin
			sem_ar.get(1);
			drive_ar(q4.pop_front());
			sem_ar.put(1);
			
			sem_r.put(1);
			
		end
		begin	
			sem_r.get(2);
			catch_r(q5.pop_front());
			sem_r.put(1);

		end

	join
	
*/



