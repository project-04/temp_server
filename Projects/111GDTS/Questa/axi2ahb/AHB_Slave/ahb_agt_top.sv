
class ahb_agent_top extends uvm_env;

   // Factory Registration
   `uvm_component_utils(ahb_agent_top)
ahb_agt agnth;
 axi_env_config env_cfg_h;

	extern function new(string name = "ahb_agent_top",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
endclass

function ahb_agent_top::new(string name = "ahb_agent_top",uvm_component parent);
	super.new(name,parent);
endfunction
     
function void ahb_agent_top::build_phase(uvm_phase phase);
	super.build_phase(phase);
   	agnth=ahb_agt::type_id::create("agnth",this);

if(!uvm_config_db#(axi_env_config)::get(this,"","axi_env_config",env_cfg_h))
`uvm_fatal("AXI Env","Unable to get axi env config, have you set it in test?")
    


uvm_config_db #(ahb_cfg)::set(this,"*","ahb_cfg",env_cfg_h.m_cfg);


endfunction



