class rd_agent_top extends uvm_env;
	`uvm_component_utils(rd_agent_top)
	rd_agent agenth;
	
	function new(string name = "rd_agent_top", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		agenth = rd_agent::type_id::create("agenth", this);
	endfunction
endclass
