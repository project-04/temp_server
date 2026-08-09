


class rd_monitor extends uvm_monitor;

	`uvm_component_utils(rd_monitor)
	
	function new (string name = "rd_monitor",uvm_component parent);
		super.new(name,parent);
	endfunction 

	rd_agent_config r_cfg;
	virtual fsm_if.rd_mon_mp v_if;
	trans t1;

	uvm_analysis_port#(trans)rd_p;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db#(rd_agent_config)::get(this,"","rd_agent_config",r_cfg))
			`uvm_fatal(get_type_name,"failed getting config")

		t1 = trans::type_id::create("t1");

		rd_p = new("rd_p",this);
		
	endfunction 

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
	
		this.v_if = r_cfg.v_if;

	endfunction 


	task run_phase(uvm_phase phase);
		super.run_phase(phase);
			
		//	@(v_if.rd_mon_cb)
		//	@(v_if.rd_mon_cb)
		//	@(v_if.rd_mon_cb)
		//	@(v_if.rd_mon_cb);


		forever
			begin 
				collect_frm_dut();
				rd_p.write(t1);	
			end
		
	endtask

	task collect_frm_dut();
		begin 
		
			@(v_if.rd_mon_cb);
		
			t1.dout = v_if.rd_mon_cb.dout;
		//	@(v_if.rd_mon_cb);


			`uvm_info(get_type_name(),"fetching frm dut [DUT OUTPUT]",UVM_LOW)
			t1.print();

	
		end
	endtask
			

endclass	
