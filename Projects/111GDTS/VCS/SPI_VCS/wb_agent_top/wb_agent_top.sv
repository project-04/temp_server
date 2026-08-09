class wb_agent_top extends uvm_agent;

	`uvm_component_utils(wb_agent_top)
wb_agent wbagth;
wb_agent_config wb_cfg;
extern function new(string name ="wb_agent_top" ,uvm_component parent);
extern function void build_phase(uvm_phase phase);

endclass

function wb_agent_top::new(string name ="wb_agent_top", uvm_component parent);
	super.new(name,parent);
endfunction

function void wb_agent_top::build_phase(uvm_phase phase);
	super.build_phase(phase);
uvm_config_db#(wb_agent_config)::get(this,"","wb_agent_config",wb_cfg);
//wb_cfg=wb_agent_config::type_id::create("wb_cfg");
if(wb_cfg.has_wb_agent)
wbagth=wb_agent::type_id::create("wbagth",this);
`uvm_info("wb_agent_top","This is in Wb_Agent_top",UVM_LOW)
endfunction
