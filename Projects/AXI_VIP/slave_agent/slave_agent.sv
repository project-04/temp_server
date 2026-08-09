class slave_agent extends uvm_agent;
	`uvm_component_utils(slave_agent)

	slave_monitor 		slave_monh;
	slave_driver 		slave_drvh;
	slave_sequencer 	slave_seqrh;

	slave_config 		slave_cfg;

	function new(string name="slave_agent",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		slave_monh = slave_monitor::type_id::create("slave_monh",this);

		if(!uvm_config_db #(slave_config)::get(this,"","slave_config",slave_cfg))
			`uvm_fatal(get_type_name(),"Have you set the config correctly?");

		if(slave_cfg.is_active == UVM_ACTIVE)
		   begin
			slave_drvh  = slave_driver::type_id::create("slave_drvh",this);
			slave_seqrh = slave_sequencer::type_id::create("slave_seqrh",this);
		   end
			
	endfunction

	function void connect_phase(uvm_phase phase);
		if(slave_cfg.is_active == UVM_ACTIVE)
		   begin
			slave_drvh.seq_item_port.connect(slave_seqrh.seq_item_export);
		   end
	
	endfunction

endclass

