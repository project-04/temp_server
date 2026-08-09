
class uart_monitor extends uvm_monitor;

	`uvm_component_utils(uart_monitor)

	function new (string name = "uart_monitor",uvm_component parent);
		super.new(name,parent);
	endfunction 

	virtual apb_if apbf;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
	endfunction 

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
	endfunction 

	task run_phase(uvm_phase phase);
		super.run_phase(phase);


	endtask

endclass
