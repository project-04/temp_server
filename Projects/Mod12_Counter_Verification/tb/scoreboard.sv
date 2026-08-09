class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard)
	
	uvm_tlm_analysis_fifo #(wr_trans) wr_fifo;
	uvm_tlm_analysis_fifo #(rd_trans) rd_fifo;
	
	wr_trans wr_data, wr_trans_coverage;
	rd_trans rd_data, rd_trans_coverage;
	int no_of_trans;
	int no_of_coverage_trans;
	
	covergroup wr_mod12counter_covergroup;
		option.per_instance=1;
		
            	reset_n   : coverpoint wr_trans_coverage.reset_n;
                
                load : coverpoint wr_trans_coverage.load;
                
                up   : coverpoint wr_trans_coverage.up;
                
                data_in : coverpoint wr_trans_coverage.data_in
                {
                  bins valid[] = {[0:11]};
                }
	endgroup
	
	covergroup rd_mod12counter_covergroup;
		option.per_instance=1;
                
                data_out : coverpoint rd_trans_coverage.data_out
                {
                  bins valid[] = {[0:11]};
                }
	endgroup

	
    	function new(string name="scoreboard",uvm_component parent);
		super.new(name,parent);
		
	  	wr_fifo = new("wr_fifo", this);
	  	rd_fifo = new("rd_fifo", this);
	  	wr_mod12counter_covergroup = new();
	 	rd_mod12counter_covergroup = new();
	endfunction
	
	task run_phase(uvm_phase phase);
	  	//super.run_phase(phase);
	  	forever
	  	begin
		  	wr_fifo.get(wr_data);
		  	rd_fifo.get(rd_data);
		  	
	       		wr_trans_coverage = wr_data;
		  	rd_trans_coverage = rd_data;
		
		  	wr_mod12counter_covergroup.sample();
		  	rd_mod12counter_covergroup.sample();
		  	
	    		no_of_coverage_trans = no_of_coverage_trans+1;
	    		no_of_trans = no_of_trans+1;
	  	end
	endtask
	
	function void report_phase(uvm_phase phase);
		$display("\n\n\n------------------------ SCOREBOARD REPORT -----------------------");
	      	$display("wr Coverage = %0f", wr_mod12counter_covergroup.get_inst_coverage());
	      	$display("rd Coverage = %0f", rd_mod12counter_covergroup.get_inst_coverage());
        	$display("no_of_trans = %0d", no_of_trans);
        	$display("no_of_coverage_trans = %0d", no_of_coverage_trans);
	      	$display("------------------------------------------------------------------\n\n\n");
	endfunction
endclass
