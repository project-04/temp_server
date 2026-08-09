
class environment extends uvm_env;

	`uvm_component_utils(environment);
		
	function new (string name = "environment",uvm_component parent);
		super.new(name,parent);
	endfunction 


	apb_agent_top apb_agt_top;
	ahb_agent_top ahb_agt_top;

	scoreboard sb;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		apb_agt_top = apb_agent_top::type_id::create("apb_agt_top",this);
		ahb_agt_top = ahb_agent_top::type_id::create("ahb_agt_top",this);

		sb = scoreboard::type_id::create("sb",this);

	endfunction 

endclass
