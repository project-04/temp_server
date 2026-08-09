class slave_base_seq extends uvm_sequence #(axi_trans);
	`uvm_object_utils(slave_base_seq)

	function new(string name="slave_base_seq");
		super.new(name);
	endfunction
endclass
