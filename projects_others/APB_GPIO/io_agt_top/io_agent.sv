class io_agent extends uvm_agent;

	`uvm_component_utils(io_agent)

	io_config 	io_cfg;
	io_driver 	io_drv;
	io_monitor	io_mon;
	io_sequencer 	io_seqr;

	function new(string name="io_agent",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(io_config)::get(this,"","io_config",io_cfg))
			`uvm_fatal(get_full_name(),"Have you set it or not?")

		io_mon=io_monitor::type_id::create("io_mon",this);

		if(io_cfg.is_active==UVM_ACTIVE) begin
			io_drv=io_driver::type_id::create("io_drv",this);
			io_seqr=io_sequencer::type_id::create("io_seqr",this);
		end

	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		if(io_cfg.is_active==UVM_ACTIVE) begin
			io_drv.seq_item_port.connect(io_seqr.seq_item_export);
		end
	endfunction

endclass
	

		

