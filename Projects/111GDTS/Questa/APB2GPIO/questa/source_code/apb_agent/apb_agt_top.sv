class apb_agent_top extends uvm_env;

   // Factory Registration
   `uvm_component_utils(apb_agent_top)
apb_agent agnth;
env_cfg e_cfg;	
	extern function new(string name = "apb_agent_top",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
endclass

function apb_agent_top::new(string name = "apb_agent_top",uvm_component parent);
	super.new(name,parent);
endfunction
     
function void apb_agent_top::build_phase(uvm_phase phase);
	super.build_phase(phase);
   	agnth=apb_agent::type_id::create("agnth",this);

if(!uvm_config_db #(env_cfg)::get(this,"","env_cfg",e_cfg))
		`uvm_fatal("ENV","config not able get in env")

uvm_config_db #(apb_cfg)::set(this,"*","apb_cfg",e_cfg.apb_cfgh);
endfunction


