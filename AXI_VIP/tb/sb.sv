class sb extends uvm_scoreboard;
	`uvm_component_utils(sb)
	
	uvm_tlm_analysis_fifo #(axi_xtn) mst_fifo_w[];
	uvm_tlm_analysis_fifo #(axi_xtn) mst_fifo_r[];
	
	uvm_tlm_analysis_fifo #(axi_xtn) slv_fifo_w[];
	uvm_tlm_analysis_fifo #(axi_xtn) slv_fifo_r[];
	
	env_config 	env_cfg;
	
	axi_xtn 	xtn_mst_r, xtn_slv_r;   //temp
	axi_xtn		xtn_mst, xtn_slv;	//For comparision.
	axi_xtn		wr_cov, rd_cov;		//For coverage.
	
	//int verified_xtns, total_no_of_xtns; these are in pkg file.
		
	covergroup wr_cg;
		option.name = "Write Address and control signals bin";
		option.per_instance = 1; // This doesn't affect anything as we are not creating multiple instances for this covergroup.
		
		AWADDR_CP : coverpoint wr_cov.AWADDR	{ bins AWADDR_bin    = {[0:4095]}  ;}
		AWBURST_CP: coverpoint wr_cov.AWBURST	{ bins AWBURST_bin[] = {[0:2]}     ;}
		AWSIZE_CP : coverpoint wr_cov.AWSIZE	{ bins AWSIZE_bin[]  = {[0:2]}	   ;}
		AWLEN_CP  : coverpoint wr_cov.AWLEN	{ bins AWLEN_bin     = {[0:11]}	   ;}
		BRESP_CP  : coverpoint wr_cov.BRESP	{ bins BRESP_bin     = {0}         ;}
		
		AW_CROSS  : cross      AWBURST_CP, AWSIZE_CP, AWLEN_CP;
		
	endgroup
	

	covergroup strobe_cg with function sample(int i);
		option.name = "Write strobe bins";
		option.per_instance = 1;

		WSTRB_CP  : coverpoint wr_cov.WSTRB[i]  { bins WSTRB_bin_15  = {4'b1111};
							  bins WSTRB_bin_12  = {4'b1100};
							  bins WSTRB_bin_14  = {4'b1110};
							  bins WSTRB_bin_8   = {4'b1000};
							  bins WSTRB_bin_4   = {4'b0100};
							  bins WSTRB_bin_3   = {4'b0011};
							  bins WSTRB_bin_2   = {4'b0010};
							  bins WSTRB_bin_1   = {4'b0001};   }
							  
	endgroup
	

	covergroup rd_cg;
		option.name = "Read Address and control signals bin";
		option.per_instance = 1;
		
		ARADDR_CP : coverpoint rd_cov.ARADDR	{ bins ARADDR_bin    = {[0:4095]}  ;}
		ARBURST_CP: coverpoint rd_cov.ARBURST	{ bins ARBURST_bin[] = {[0:2]}	   ;}
		ARSIZE_CP : coverpoint rd_cov.ARSIZE	{ bins ARSIZE_bin[]  = {[0:2]}	   ;}
		ARLEN_CP  : coverpoint rd_cov.ARLEN	{ bins ARLEN_bin     = {[0:11]}	   ;}
	
		AR_CROSS  : cross      ARBURST_CP, ARSIZE_CP, ARLEN_CP;
		
	endgroup
	

	covergroup rd_resp_cg with function sample(int i);
		option.name = "Read response signal bin";
		option.per_instance = 1;
				
		RRESP_CP: coverpoint rd_cov.RRESP[i]   { bins RRESP_bin     = {0}	   ;}
		
	endgroup



  	function new(string name = "sb",uvm_component parent);
  	
  		super.new(name,parent);
  		
		wr_cg  		= new();
		strobe_cg 	= new();
		rd_cg   	= new();
		rd_resp_cg 	= new();
			
  	endfunction
	
	function void build_phase(uvm_phase phase);
      		super.build_phase(phase);

    		if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
        	   `uvm_fatal("SCOREBOARD","Have you set the config correctly ?")

    		mst_fifo_w = new[env_cfg.no_of_master_agents];
    		mst_fifo_r = new[env_cfg.no_of_master_agents];
    		
    		slv_fifo_w = new[env_cfg.no_of_slave_agents];
    		slv_fifo_r = new[env_cfg.no_of_slave_agents];
 		
 		foreach(mst_fifo_w[i])
 			begin
 			     mst_fifo_w[i] = new($sformatf("mst_fifo_w[%0d]",i), this);
 			     mst_fifo_r[i] = new($sformatf("mst_fifo_r[%0d]",i), this);
 			end

 		foreach(slv_fifo_w[i])
 			begin
 			     slv_fifo_w[i] = new($sformatf("slv_fifo_w[%0d]",i), this);
 			     slv_fifo_r[i] = new($sformatf("slv_fifo_r[%0d]",i), this);
 			end

   	endfunction
    	
    	extern task run_phase(uvm_phase phase);
    	extern function void report_phase(uvm_phase phase);

endclass

task sb::run_phase(uvm_phase phase);
	    	forever
		begin
		   	foreach(mst_fifo_w[i])
		        	mst_fifo_w[i].get(xtn_mst);
		        foreach(mst_fifo_r[i])
		        	mst_fifo_r[i].get(xtn_mst_r);
		        xtn_mst.copy(xtn_mst_r);
		        
			foreach(slv_fifo_w[i])
		                slv_fifo_w[i].get(xtn_slv);
		        foreach(slv_fifo_r[i])
		        	slv_fifo_r[i].get(xtn_slv_r);
		        xtn_slv.copy(xtn_slv_r);
			   
		   	//$display("This is the master transaction:%s",xtn_mst.sprint());
			//$display("This is the slave transaction:%s",xtn_slv.sprint());
		   	
		   	total_no_of_xtns++;
		        
		   	if(xtn_mst.compare(xtn_slv))
		   	begin
		   		//`uvm_info("SCOREBOARD", $sformatf("This is the master read transaction:%s",xtn_mst.sprint()),UVM_LOW)
		   
		   	     	//`uvm_info("SCOREBOARD", $sformatf("This is the slave read transaction:%s",xtn_slv.sprint()),UVM_LOW)
				verified_xtns++;
		   	     	$display("\n---------<<<<<-------COMPARISION SUCCESSFUL-------->>>>>--------\n");
		   		wr_cov = xtn_mst;
		   		wr_cg.sample();
	  		     	foreach(wr_cov.WDATA[i])
					strobe_cg.sample(i);
		   		     	 
		   		rd_cov = xtn_slv;
		   	     	rd_cg.sample();
		   		     	
		   		foreach(rd_cov.RDATA[i])
					rd_resp_cg.sample(i);	
	   		 end
		   		
			else
			begin
		  		// `uvm_info("SCOREBOARD", $sformatf("This is the master read transaction:%s",xtn_mst.sprint()),UVM_LOW)
		   
		   	     	//`uvm_info("SCOREBOARD", $sformatf("This is the slave read transaction:%s",xtn_slv.sprint()),UVM_LOW)
		   	     	$display("\n---------<<<<<-------COMPARISION FAILED-------->>>>>--------\n");
			end
		end
endtask


function void sb::report_phase(uvm_phase phase);
		
		real total_avg;
                $display("\n\n\n------------------------ SCOREBOARD REPORT -----------------------");
      		$display("Transations Verified = %0d/%0d",verified_xtns, total_no_of_xtns);
                $display("AXI VIP Coverage     = %.2f/100.00", $get_coverage());
                
                $display("\n--- AXI VIP Coverage ---");
		$display("Write Ctrl Coverage (wr_cg)       = %.2f%%", wr_cg.get_coverage());
		$display("Write Strobe Coverage (strobe_cg) = %.2f%%", strobe_cg.get_coverage());
		$display("Read Ctrl Coverage (rd_cg)        = %.2f%%", rd_cg.get_coverage());
		$display("Read Resp Coverage (rd_resp_cg)   = %.2f%%", rd_resp_cg.get_coverage());

		// Calculate and display the combined average
		total_avg = (wr_cg.get_coverage() + strobe_cg.get_coverage() + rd_cg.get_coverage() + rd_resp_cg.get_coverage()) / 4.0;
		$display("Total Combined Coverage           = %.2f%%", total_avg);
                $display("------------------------------------------------------------------\n\n\n");
endfunction


