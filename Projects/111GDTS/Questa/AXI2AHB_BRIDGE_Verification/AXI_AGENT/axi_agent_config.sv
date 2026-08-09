 class axi_agent_config extends uvm_object;
   `uvm_object_utils(axi_agent_config)
   virtual axi_if vif;
   uvm_active_passive_enum is_active=UVM_ACTIVE;
   extern function new(string name="axi_agent_config");
 endclass
 //---------------------------- new -----------------------
 function axi_agent_config::new(string name="axi_agent_config");
   super.new(name);
 endfunction
