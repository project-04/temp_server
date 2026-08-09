class aux_agent extends uvm_agent;

	`uvm_component_utils(aux_agent)

	aux_config 	aux_cfg;
	aux_driver 	aux_drv;
	aux_monitor	aux_mon;
	aux_sequencer 	aux_seqr;

	function new(string name="aux_agent",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(aux_config)::get(this,"","aux_config",aux_cfg))
			`uvm_fatal(get_full_name(),"Have you set it or not?")

		aux_mon=aux_monitor::type_id::create("aux_mon",this);

		if(aux_cfg.is_active==UVM_ACTIVE) begin
			aux_drv=aux_driver::type_id::create("aux_drv",this);
			aux_seqr=aux_sequencer::type_id::create("aux_seqr",this);
		end

	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		if(aux_cfg.is_active==UVM_ACTIVE) begin
			aux_drv.seq_item_port.connect(aux_seqr.seq_item_export);
		end
	endfunction

endclass
	

		

