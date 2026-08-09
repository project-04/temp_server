


class rd_driver extends uvm_driver#(trans);

	`uvm_component_utils(rd_driver)
	
	function new (string name = "rd_driver",uvm_component parent);
		super.new(name,parent);
	endfunction 

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
