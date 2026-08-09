

class wr_agent extends uvm_agent;

	`uvm_component_utils(wr_agent)
	
	function new (string name = "wr_agent",uvm_component parent);
		super.new(name,parent);
	endfunction

	wr_sequencer wr_seqr;
	wr_driver wr_drv;
	wr_monitor wr_mon;
 
	wr_agent_config w_cfg;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db#(wr_agent_config)::get(this,"","wr_agent_config",w_cfg))
			`uvm_fatal(get_type_name(),"failed to get  config")

		wr_mon = wr_monitor::type_id::create("wr_mon",this);
	
		if(w_cfg.is_active == UVM_ACTIVE)
			begin 
				
				wr_seqr = wr_sequencer::type_id::create("wr_seqr",this);
				wr_drv = wr_driver::type_id::create("wr_drv",this);
			end
		
		
	endfunction 

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		if(w_cfg.is_active == UVM_ACTIVE)
			wr_drv.seq_item_port.connect(wr_seqr.seq_item_export);

		
	endfunction 


endclass	
