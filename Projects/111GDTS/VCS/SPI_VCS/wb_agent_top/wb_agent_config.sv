class wb_agent_config extends uvm_object;

	`uvm_object_utils(wb_agent_config)

bit has_wb_agent_top=1;
int has_wb_agent=1;
	virtual spi_if vif_0;	


uvm_active_passive_enum is_active = UVM_ACTIVE;

function new(string name ="wb_agent_config");	
	super.new(name);
endfunction

endclass
 
