class master_agent_config extends uvm_object;

//FACTORY 
	`uvm_object_utils(master_agent_config)

//VIRTUAL INTERFACE HANDEL
	virtual master_if vif;

//DATA MEMBERS
	uvm_active_passive_enum is_active=UVM_ACTIVE;

//METHODS
	extern function new(string name = "master_agent_config");

endclass

function master_agent_config::new(string name = "master_agent_config");
	super.new(name);
endfunction


