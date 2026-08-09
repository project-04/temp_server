class sl_agent_top extends uvm_agent;

	`uvm_component_utils(sl_agent_top)
sl_agent slagth;
extern function new(string name ="sl_agent_top" ,uvm_component parent);
extern function void build_phase(uvm_phase phase);

endclass

function sl_agent_top::new(string name ="sl_agent_top", uvm_component parent);
	super.new(name,parent);
endfunction

function void sl_agent_top::build_phase(uvm_phase phase);
	super.build_phase(phase);
slagth=sl_agent::type_id::create("slagth",this);
`uvm_info("sl_agent_top","This is in sl_Agent_top",UVM_LOW)
endfunction
