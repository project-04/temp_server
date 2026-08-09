


class rd_agent extends uvm_agent;

	`uvm_component_utils(rd_agent)
	
	function new (string name = "rd_agent",uvm_component parent);
		super.new(name,parent);
	endfunction

	rd_sequencer rd_seqr;
	rd_monitor rd_mon;
	rd_driver rd_drv;

	rd_agent_config rd_cfg;
 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db#(rd_agent_config)::get(this,"","rd_agent_config",rd_cfg))
			`uvm_fatal(get_type_name,"failed getting config")

		rd_mon = rd_monitor::type_id::create("rd_mon",this);

		if(rd_cfg.is_active == UVM_ACTIVE)
			begin 
				rd_seqr = rd_sequencer::type_id::create("rd_seqr",this);
				rd_drv = rd_driver::type_id::create("rd_drv",this);
			end

		
	endfunction 

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		if(rd_cfg.is_active == UVM_ACTIVE)
			rd_drv.seq_item_port.connect(rd_seqr.seq_item_export);


	endfunction 



endclass	
