

class wr_agent_config extends uvm_object;

	`uvm_object_utils(wr_agent_config)
	
	function new(string name = "wr_agent_config");
		super.new(name);
	endfunction 

	uvm_active_passive_enum is_active;
	
	virtual fsm_if v_if;

endclass		
