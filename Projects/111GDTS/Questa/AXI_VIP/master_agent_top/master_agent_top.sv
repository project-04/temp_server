class master_agent_top extends uvm_env;
    `uvm_component_utils(master_agent_top)
   
    master_config mst_cfg_h;
    master_agent mst_agt_h[];
	
    extern function new(string name = "master_agent_top", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
endclass

   function master_agent_top::new(string name="master_agent_top",uvm_component parent);
       super.new(name,parent);
   endfunction

   function void master_agent_top:: build_phase(uvm_phase phase);
       mst_cfg_h=master_config::type_id::create("mst_cfg_h");
       if(!(uvm_config_db#(master_config)::get(this,"","master_config",mst_cfg_h)))
           `uvm_error("Master Agent Top","Unable to get master config, have you set it?");
       mst_agt_h=new[mst_cfg_h.no_of_master];
       foreach(mst_agt_h[i])
           mst_agt_h[i]=master_agent::type_id::create( $sformatf("mst_agt_h[%0d]",i), this);
   endfunction

   task master_agent_top::run_phase(uvm_phase phase);
   //   uvm_top.print_topology();
   endtask
