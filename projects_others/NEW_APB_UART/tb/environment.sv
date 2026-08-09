
class environment extends uvm_env;

	`uvm_component_utils(environment)

	function new (string name = "environment",uvm_component parent);
		super.new(name,parent);
	endfunction 

	scoreboard sb;
	uart_agent_top	uart_agt_top;
	apb_agent_top apb_agt_top;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	
		sb =	scoreboard::type_id::create("sb",this);
		uart_agt_top = uart_agent_top::type_id::create("uart_agt_top",this);
		apb_agt_top = apb_agent_top::type_id::create("apb_agt_top",this);	
	
	endfunction

endclass	
	
