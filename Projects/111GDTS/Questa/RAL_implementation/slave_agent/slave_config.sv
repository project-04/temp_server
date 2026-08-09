class s_agent_config extends uvm_object;

	`uvm_object_utils(s_agent_config)

	virtual intf vif;

	uvm_active_passive_enum is_active=UVM_ACTIVE;

	function new(string name="s_agent_config");
		super.new(name);
	endfunction

endclass

