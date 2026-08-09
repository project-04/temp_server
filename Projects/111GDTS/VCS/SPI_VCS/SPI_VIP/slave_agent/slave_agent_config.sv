class slave_agent_config extends uvm_object;

//FACTORY
	`uvm_object_utils(slave_agent_config);

//VIRTUAL INTERFACE HANDEL
	virtual slave_if vif;

//DATA MEMBERS
	uvm_active_passive_enum is_active=UVM_ACTIVE;

//METHODS
	extern function new(string name = "slave_agent_config");

endclass

function slave_agent_config::new(string name = "slave_agent_config");
	super.new(name);
endfunction

