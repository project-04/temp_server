
class io_agent_top extends uvm_env;

   // Factory Registration
   `uvm_component_utils(io_agent_top)
io_agent agnth;
env_cfg e_cfg;	
	extern function new(string name = "io_agent_top",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
endclass

function io_agent_top::new(string name = "io_agent_top",uvm_component parent);
	super.new(name,parent);
endfunction
     
function void io_agent_top::build_phase(uvm_phase phase);
	super.build_phase(phase);
   	agnth=io_agent::type_id::create("agnth",this);

if(!uvm_config_db #(env_cfg)::get(this,"","env_cfg",e_cfg))
		`uvm_fatal("ENV","config not able get in env")

uvm_config_db #(io_cfg)::set(this,"*","io_cfg",e_cfg.io_cfgh);
endfunction


