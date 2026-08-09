class sl_agent_config extends uvm_object;
	`uvm_object_utils(sl_agent_config)

virtual spi_if vif_1;
uvm_active_passive_enum is_active=UVM_ACTIVE;

function new(string name="sl_agent_config");
	super.new(name);
endfunction

endclass
