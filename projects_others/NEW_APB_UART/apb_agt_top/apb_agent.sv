

class apb_agent extends uvm_agent;

	`uvm_component_utils(apb_agent)

	function new (string name = "apb_agent",uvm_component parent);
		super.new(name,parent);
	endfunction 

	apb_monitor a_mon;
	apb_driver a_drv;
	apb_sequencer a_seqr;

	apb_config a_cfg;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db#(apb_config)::get(this,"","apb_config",a_cfg))
			`uvm_fatal(get_type_name(),"FAILED GETTING APB CONFIG")

		a_mon = apb_monitor::type_id::create("a_mon",this);

		if(a_cfg.is_active == UVM_ACTIVE)
			begin 
				a_drv = apb_driver::type_id::create("a_drv",this);
				a_seqr = apb_sequencer::type_id::create("a_seqr",this);
			end	
			
		
	endfunction 

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
	endfunction 

	task run_phase(uvm_phase phase);
		super.run_phase(phase);


	endtask

endclass
