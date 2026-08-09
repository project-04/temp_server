

class apb_monitor extends uvm_monitor;

	`uvm_component_utils(apb_monitor)

	function new(string name = "apb_monitor",uvm_component parent);
		super.new(name,parent);
	endfunction 

	apb_config apb_cfg;
	virtual apb_if.apb_mon_mp apb_f;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db#(apb_config)::get(this,"","apb_config",apb_cfg))
			`uvm_fatal("APB_MONITOR","failed to get config");


	endfunction 

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		this.apb_f = apb_cfg.apb_f;

	endfunction 


	task run_phase(uvm_phase phase);
	
	endtask

endclass

	
