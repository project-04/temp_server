class s_agent extends uvm_agent;

	`uvm_component_utils(s_agent)

	s_sequencer s_seqr;
	s_driver s_drv;
	s_monitor s_mon;
	s_agent_config s_cfg;

	function new(string name="s_agent",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(s_agent_config)::get(this,"","s_agent_config",s_cfg))
			`uvm_fatal("S_AGENT","Cannot get s_cfg in s_agent")

		s_mon=s_monitor::type_id::create("s_mon",this);
	
		if(UVM_ACTIVE==is_active)
			begin
				s_seqr=s_sequencer::type_id::create("s_seqr",this);
				s_drv=s_driver::type_id::create("s_drv",this);
			end
	endfunction


     function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		s_drv.seq_item_port.connect(s_seqr.seq_item_export);
	endfunction

endclass

