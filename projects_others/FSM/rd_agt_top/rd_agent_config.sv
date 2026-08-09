



class rd_agent_config extends uvm_object;

	`uvm_object_utils(rd_agent_config)
	
	function new(string name = "rd_agent_config");
		super.new(name);
	endfunction 

	virtual fsm_if v_if;
	uvm_active_passive_enum is_active;

endclass		
