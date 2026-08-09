class slave_agent extends uvm_agent;

//FACTORY
	`uvm_component_utils(slave_agent);

//MEMBERS
	slave_driver drvh;
	slave_monitor monh;
	slave_sequencer seqh;

//CONFIG HADNDEL
	slave_agent_config m_cfg;

//METHODS

	extern function new(string name = "slave_agent",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);


endclass

//CONSTRUCTOR
	function slave_agent::new(string name = "slave_agent",uvm_component parent);
		super.new(name,parent);
	endfunction
//BUILD PHASE
	function void slave_agent::build_phase(uvm_phase phase);
		if(!uvm_config_db#(slave_agent_config)::get(this,"","slave_agent_config",m_cfg))
			`uvm_fatal("MASTER_DRIVER","UNABLE TO GET CONFIG")
		monh=slave_monitor::type_id::create("monh",this);
		
		if(m_cfg.is_active==UVM_ACTIVE)
				begin
					drvh=slave_driver::type_id::create("drvh",this);
					seqh=slave_sequencer::type_id::create("seqh",this);
				end
		
	endfunction
//CONNECT PHASE
	function void slave_agent::connect_phase(uvm_phase phase);
	 
		drvh.seq_item_port.connect(seqh.seq_item_export);
	
	endfunction
