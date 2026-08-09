class ahb_agent_top extends uvm_env;

`uvm_component_utils(ahb_agent_top) 

ahb_agent hagnt[];
env_config m_cfg;


extern function new(string name="ahb_agent_top",uvm_component parent);
extern function void build_phase(uvm_phase phase);

extern task run_phase(uvm_phase phase);

endclass

function ahb_agent_top::new(string name = "ahb_agent_top",uvm_component parent);
  super.new(name,parent);
endfunction

function void ahb_agent_top::build_phase(uvm_phase phase);
 
 if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
  `uvm_fatal("ahb_agent_top","cannot get cfg from uvm_config_db");
  super.build_phase(phase);

  hagnt = new[m_cfg.no_of_ahb_agent];
  
  foreach (hagnt[i])
   begin
   hagnt[i] = ahb_agent::type_id::create($sformatf("hagnt[%0d]",i),this);
   uvm_config_db #(ahb_agent_config)::set(this,$sformatf("hagnt[%0d]*",i),"ahb_agent_top",m_cfg.wcfg[i]);
   end
endfunction



task ahb_agent_top::run_phase(uvm_phase phase);
 uvm_top.print_topology();
endtask


