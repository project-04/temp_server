        

class apb_uart_sequencer extends uvm_sequencer#(apb_uart_trans);

	`uvm_component_utils(apb_uart_sequencer)

	function new (string name = "apb_uart_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction 

endclass	
