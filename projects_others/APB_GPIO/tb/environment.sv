class environment extends uvm_env;

	`uvm_component_utils(environment)

	apb_agent_top apb_agt_top;
	aux_agent_top aux_agt_top;
	io_agent_top  io_agt_top;
	scoreboard sb_h;

	function new(string name="environment",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	
	apb_agt_top = apb_agent_top::type_id::create("apb_agt_top",this);
	aux_agt_top = aux_agent_top::type_id::create("aux_agt_top",this);
	io_agt_top  = io_agent_top::type_id::create("io_agt_top",this);
	sb_h = scoreboard::type_id::create("sb_h",this);

	endfunction

endclass

