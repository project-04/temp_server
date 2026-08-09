class apb_agent extends uvm_agent;
	`uvm_component_utils(apb_agent)

	apb_monitor apb_monh;
	apb_driver apb_drvh;
	apb_seqr apb_seqrh;

	apb_config apb_cfg;

	function new(string name="apb_agent",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		apb_monh = apb_monitor::type_id::create("apb_monh",this);

		if(!uvm_config_db #(apb_config)::get(this,"","apb_config",apb_cfg))
			`uvm_fatal(get_type_name(),"Have you set the config correctly?");

		if(apb_cfg.is_active == UVM_ACTIVE)begin
			apb_drvh = apb_driver::type_id::create("apb_drvh",this);
			apb_seqrh = apb_seqr::type_id::create("apb_seqrh",this);
		end
			
	endfunction

	function void connect_phase(uvm_phase phase);
		if(apb_cfg.is_active == UVM_ACTIVE)begin
			apb_drvh.seq_item_port.connect(apb_seqrh.seq_item_export);
		end
	
	endfunction

endclass
