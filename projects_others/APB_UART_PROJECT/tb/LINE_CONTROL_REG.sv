

class LINE_CONTROL_REG extends uvm_reg;

	`uvm_object_utils(LINE_CONTROL_REG)

	rand 	uvm_reg_field 	character_bit;
	rand 	uvm_reg_field 	stop_bit;
	rand 	uvm_reg_field 	parity_bit;
	rand 	uvm_reg_field 	even_parity_bit;
	rand 	uvm_reg_field 	stick_parity_bit;
	rand 	uvm_reg_field 	break_control_bit;
		uvm_reg_field	reserved_bit;


	function new (string name = "LINE_CONTROL_REG");
		super.new(name,8,UVM_NO_COVERAGE);
	endfunction 
	

	function void build();
	

		// creating memory 

		character_bit	  = uvm_reg_field::type_id::create("character_bit");
		stop_bit 	  = uvm_reg_field::type_id::create("stop_bit");
		parity_bit 	  = uvm_reg_field::type_id::create("parity_bit");
		even_parity_bit   = uvm_reg_field::type_id::create("even_parity_bit");
		stick_parity_bit  = uvm_reg_field::type_id::create("stick_parity_bit");
		break_control_bit = uvm_reg_field::type_id::create("break_control_bit");
		reserved_bit 	  = uvm_reg_field::type_id::create("reserved_bit");

		//configuration 

		character_bit	 .configure(this,2,0,"RW",0,'h3,1,1,1);
		stop_bit	 .configure(this,1,2,"RW",0,0,1,1,1);
		parity_bit	 .configure(this,1,3,"RW",0,0,1,1,1);
		even_parity_bit	 .configure(this,1,4,"RW",0,0,1,1,1);
		stick_parity_bit .configure(this,1,5,"RW",0,0,1,1,1);
		break_control_bit.configure(this,1,6,"RW",0,0,1,1,1);
		reserved_bit	 .configure(this,1,7,"RW",0,0,1,0,0);	

	endfunction 

endclass	

		
	
