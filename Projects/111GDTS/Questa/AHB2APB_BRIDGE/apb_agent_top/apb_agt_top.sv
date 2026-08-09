class apb_agt_top extends uvm_env;

  `uvm_component_utils(apb_agt_top)
  
//int i;
apb_agent hagnt[];
env_config cfg_h;
extern function new(string name = "apb_agt_top",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

function apb_agt_top::new(string name = "apb_agt_top" , uvm_component parent);
        super.new(name,parent);
endfunction


function void apb_agt_top::build_phase(uvm_phase phase);
                super.build_phase(phase);
         if (!uvm_config_db #(env_config)::get(this,"","env_config",cfg_h))
        `uvm_fatal("APB AGENT TOP","failed to get database")
        hagnt=new[cfg_h.no_of_apb_agent];

		foreach(hagnt[i])  
		begin
			uvm_config_db #(apb_agent_config)::set(this,$sformatf("hagnt[%0d]*",i),"apb_agent_config", cfg_h.apb_cfg[i]);
			hagnt[i]=apb_agent::type_id::create($sformatf("hagnt[%0d]",i),this);
		end
endfunction

task apb_agt_top::run_phase(uvm_phase phase);
uvm_top.print_topology;
endtask




