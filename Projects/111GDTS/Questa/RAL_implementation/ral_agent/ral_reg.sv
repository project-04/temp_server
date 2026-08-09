class reg_data extends uvm_reg;

	`uvm_object_utils(reg_data)
	
	uvm_reg_field field;
	
	function new(string name ="reg_data");
		super.new(name, 8, UVM_NO_COVERAGE); //new(string, length of register, coverage disable command)
	endfunction

	virtual function void build();
		field = uvm_reg_field::type_id::create("field");
		
		field.configure(this, 8, 0, "RW", 0, 8'b0, 1, 1,0);
	endfunction
	
endclass
