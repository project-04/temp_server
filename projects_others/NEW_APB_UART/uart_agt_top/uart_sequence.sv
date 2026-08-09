

class uart_base_seq extends uvm_sequence#(uart_trans);

	`uvm_object_utils(uart_base_seq)

	function new(string name = "uart_base_seq");
		super.new(name);
	endfunction 

	task body();
		begin 

		end
	endtask

endclass		
