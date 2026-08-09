class apb_agent extends uvm_agent;

 `uvm_component_utils(apb_agent)

        apb_driver driver_h;
        apb_monitor hmon;
        apb_agent_config apb_cfg;
		
        //      standard uvm methods    //
        extern function new (string name = "apb_agent",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
endclass


        //      construct new method    //

function apb_agent::new(string name = "apb_agent",uvm_component parent);
	super.new(name,parent);
endfunction

        // build phase method   //

function void apb_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
      if(!uvm_config_db#(apb_agent_config)::get(this,"","apb_agent_config",apb_cfg))
      `uvm_fatal("config","can not get uvm config db from apb_cfg have you set it?")

         hmon = apb_monitor::type_id::create("hmon",this);
    if(apb_cfg.is_active==UVM_ACTIVE)
      begin
                driver_h = apb_driver::type_id::create("driver_h",this);
      end
endfunction



