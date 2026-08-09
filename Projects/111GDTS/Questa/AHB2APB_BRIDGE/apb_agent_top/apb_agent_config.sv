class apb_agent_config extends uvm_object;

 `uvm_object_utils(apb_agent_config)

        virtual bridge_if vif1;

        uvm_active_passive_enum is_active = UVM_ACTIVE;
		
		// 		standard uvm methods    //
        extern function new (string name = "apb_agent_config");

endclass

        //      construct new method    //
function apb_agent_config::new(string name = "apb_agent_config");
	super.new(name);
endfunction




