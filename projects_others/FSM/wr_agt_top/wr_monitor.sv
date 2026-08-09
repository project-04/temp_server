

class wr_monitor extends uvm_monitor;

	`uvm_component_utils(wr_monitor)
	
	function new (string name = "wr_monitor",uvm_component parent);
		super.new(name,parent);
	endfunction 

	wr_agent_config w_cfg;
	virtual fsm_if.wr_mon_mp v_if;
	trans t1;
	
	uvm_analysis_port#(trans) wr_p;
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db#(wr_agent_config)::get(this,"","wr_agent_config",w_cfg))
			`uvm_fatal(get_type_name,"failed to get config")

		t1 = trans::type_id::create("t1");
		wr_p = new("wr_p",this);
	
	endfunction 

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		this.v_if = w_cfg.v_if;	
		
	endfunction 


	task run_phase(uvm_phase phase);
		super.run_phase(phase);
	
	//	@(v_if.wr_mon_cb)	
	//	@(v_if.wr_mon_cb)
	//	@(v_if.wr_mon_cb)
	//	@(v_if.wr_mon_cb)
	
	
		forever
			begin 
				collect_frm_dut();
				wr_p.write(t1);	
			end
		
	endtask

	task collect_frm_dut();
		begin 
		
	//		@(v_if.wr_mon_cb);	
	
	//	wait(v_if.wr_mon_cb.rst === 0)
	
			t1.din = v_if.wr_mon_cb.din;
			t1.rst = v_if.wr_mon_cb.rst;
			@(v_if.wr_mon_cb);	

			`uvm_info(get_type_name(),"fetching frm dut [WR_DRIVER VALUE]",UVM_LOW)
			t1.print();
			
		end	 	
			
	endtask

endclass	
