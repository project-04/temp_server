class sb extends uvm_scoreboard;
	`uvm_component_utils(sb)
	
	uvm_tlm_analysis_fifo #(axi_xtn) mst_fifo[]; // The number of fifo should be equal to the number of master agents.
	uvm_tlm_analysis_fifo #(axi_xtn) slv_fifo[];
	
	env_config 	env_cfg;
	
	axi_xtn 	xtn_mst, xtn_slv;	//For comparision.
	axi_xtn		wr_cov, rd_cov;		//For coverage.
	
	int verified_read_xtns, verified_write_xtns, total_no_of_read_xtns, total_no_of_write_xtns;
		
	covergroup wr_cg;
		option.name = "Write Address and control signals bin";
		option.per_instance = 1; // This doesn't affect anything as we are not creating multiple instances for this covergroup.
		
		AWADDR_CP : coverpoint wr_cov.AWADDR	{ bins AWADDR_bin    = {[0:4095]}; }
		AWBURST_CP: coverpoint wr_cov.AWBURST	{ bins AWBURST_bin[] = {[0:2]};    }
		AWSIZE_CP : coverpoint wr_cov.AWSIZE	{ bins AWSIZE_bin[]  = {[0:2]};    }
		AWLEN_CP  : coverpoint wr_cov.AWLEN	{ bins AWLEN_bin     = {[0:11]};   }
		BRESP_CP  : coverpoint wr_cov.BRESP	{ bins BRESP_bin     = {0};        }
		
		AW_CROSS  : cross      AWBURST_CP, AWSIZE_CP, AWLEN_CP;
	endgroup
	

	covergroup strobe_cg with function sample(int i);
		option.name = "Write strobe bins";
		option.per_instance = 1;

		WSTRB_CP  : coverpoint wr_cov.WSTRB[i]	{ bins WSTRB_bin_15  = {4'b1111};
							  bins WSTRB_bin_14  = {4'b1110};
							  bins WSTRB_bin_12  = {4'b1100};
							  bins WSTRB_bin_8   = {4'b1000};
							  bins WSTRB_bin_4   = {4'b0100};
							  bins WSTRB_bin_3   = {4'b0011};
							  bins WSTRB_bin_2   = {4'b0010};
							  bins WSTRB_bin_1   = {4'b0001};	}
	endgroup
	

	covergroup rd_cg;
		option.name = "Read Address and control signals bin";
		option.per_instance = 1;
		
		ARADDR_CP : coverpoint rd_cov.ARADDR	{ bins ARADDR_bin    = {[0:4095]}; }
		ARBURST_CP: coverpoint rd_cov.ARBURST	{ bins ARBURST_bin[] = {[0:2]};    }
		ARSIZE_CP : coverpoint rd_cov.ARSIZE	{ bins ARSIZE_bin[]  = {[0:2]};    }
		ARLEN_CP  : coverpoint rd_cov.ARLEN	{ bins ARLEN_bin     = {[0:11]};   }
	
		AR_CROSS  : cross      ARBURST_CP, ARSIZE_CP, ARLEN_CP;
	endgroup
	

	covergroup rd_resp_cg with function sample(int i);
		option.name = "Read response signal bin";
		option.per_instance = 1;
				
		RRESP_CP: coverpoint rd_cov.RRESP[i]   { bins RRESP_bin     = {0};}
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

    		mst_fifo = new[env_cfg.no_of_master_agents];
    		slv_fifo = new[env_cfg.no_of_slave_agents];
 		
 		foreach(mst_fifo[i])
 			begin
 			     mst_fifo[i] = new($sformatf("mst_fifo[%0d]",i), this);
 			end

 		foreach(slv_fifo[i])
 			begin
 			     slv_fifo[i] = new($sformatf("slv_fifo[%0d]",i), this);
 			end
   	endfunction
    	
    	extern task run_phase(uvm_phase phase);
    	extern function void report_phase(uvm_phase phase);

endclass

task sb::run_phase(uvm_phase phase);
	    	forever
		begin
		   	foreach(mst_fifo[i])
		        	mst_fifo[i].get(xtn_mst);
		        		
			foreach(slv_fifo[i])
		                slv_fifo[i].get(xtn_slv);
		        
			   
		   	//$display("This is the master transaction:%s",xtn_mst.sprint());
			//$display("This is the slave transaction:%s",xtn_slv.sprint());
		   	
		   	if(xtn_mst.ARID != 8'h00 && xtn_slv.ARID != 8'h00)
		   	begin
		   		total_no_of_read_xtns++;
		        
		   		if(xtn_mst.compare(xtn_slv))
		   		begin
					verified_read_xtns++;
		   		     	//`uvm_info("SCOREBOARD", $sformatf("This is the master read transaction:%s",xtn_mst.sprint()),UVM_LOW)
		   
		   		     	//`uvm_info("SCOREBOARD", $sformatf("This is the slave read transaction:%s",xtn_slv.sprint()),UVM_LOW)
		   		     	$display("\n---------<<<<<-------READ COMPARISION SUCCESSFUL-------->>>>>--------\n");
		   		     
		   		     	rd_cov = xtn_slv;
		   		     	rd_cg.sample();
		   		     
		   		     	if(rd_cov.RVALID == 1)
		   		     	begin
						foreach(rd_cov.RDATA[i])
							rd_resp_cg.sample(i);	
		   		     	end
		   		     
		   		end
		   		
		   		else
		   		begin
		   		    	// `uvm_info("SCOREBOARD", $sformatf("This is the master read transaction:%s",xtn_mst.sprint()),UVM_LOW)
		   
		   		     	//`uvm_info("SCOREBOARD", $sformatf("This is the slave read transaction:%s",xtn_slv.sprint()),UVM_LOW)
		   		     	$display("\n---------<<<<<-------READ COMPARISION FAILED-------->>>>>--------\n");
		   		end
		   	end
		   
		   	else if(xtn_mst.AWID != 8'h00 && xtn_slv.AWID != 8'h00)
		   	begin
		        	total_no_of_write_xtns++;
		   		
		   		if(xtn_mst.compare(xtn_slv))
		   		begin
		   			verified_write_xtns++;
		   		     	//`uvm_info("SCOREBOARD", $sformatf("This is the master write transaction:%s",xtn_mst.sprint()),UVM_LOW)
		   
		   		     	//`uvm_info("SCOREBOARD", $sformatf("This is the slave write transaction:%s",xtn_slv.sprint()),UVM_LOW)
		   		     	$display("\n---------<<<<<-------WRITE COMPARISION SUCCESSFUL-------->>>>>--------\n");
		   		     
		   		     	wr_cov = xtn_mst;
		   		     	wr_cg.sample();
		   		     
		   		     	if(wr_cov.WVALID == 1)
		   		     	begin
						foreach(wr_cov.WDATA[i])
							strobe_cg.sample(i);
		   		     	end
		   		     
		   		end
		   		
		   		else
		   		begin
		   		    	//`uvm_info("SCOREBOARD", $sformatf("This is the master write transaction:%s",xtn_mst.sprint()),UVM_LOW)
		   
		   		     	//`uvm_info("SCOREBOARD", $sformatf("This is the slave write transaction:%s",xtn_slv.sprint()),UVM_LOW)
		   		     	$display("\n---------<<<<<-------WRITE COMPARISION FAILED-------->>>>>--------\n");
		   		end
		   	end
		end
endtask


function void sb::report_phase(uvm_phase phase);
                $display("\n\n\n------------------------ SCOREBOARD REPORT -----------------------");
      		$display("Read Data Verified  = %0d/%0d",verified_read_xtns,  total_no_of_read_xtns);      			$display("Write Data Verified = %0d/%0d",verified_write_xtns,total_no_of_write_xtns);
                $display("AXI VIP Coverage    = %.2f/100.00", wr_cg.get_coverage());
                $display("------------------------------------------------------------------\n\n\n");
endfunction


