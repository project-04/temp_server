class master_agent extends uvm_agent;

//FACTORY
	`uvm_component_utils(master_agent);

//MEMBERS
	master_driver drvh;
	master_monitor monh;
	master_sequencer seqh;

//CONFIG HADNDEL
	master_agent_config m_cfg;

//METHODS

	extern function new(string name = "master_agent",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);


endclass

//CONSTRUCTOR
	function master_agent::new(string name = "master_agent",uvm_component parent);
		super.new(name,parent);
	endfunction
//BUILD PHASE
	function void master_agent::build_phase(uvm_phase phase);
		if(!uvm_config_db#(master_agent_config)::get(this,"","master_agent_config",m_cfg))
			`uvm_fatal("MASTER_DRIVER","UNABLE TO GET CONFIG")
		monh=master_monitor::type_id::create("monh",this);
		
		if(m_cfg.is_active==UVM_ACTIVE)
				begin
					drvh=master_driver::type_id::create("drvh",this);
					seqh=master_sequencer::type_id::create("seqh",this);
				end
		
	endfunction
//CONNECT PHASE
	function void master_agent::connect_phase(uvm_phase phase);
	 
		drvh.seq_item_port.connect(seqh.seq_item_export);
	
	endfunction
