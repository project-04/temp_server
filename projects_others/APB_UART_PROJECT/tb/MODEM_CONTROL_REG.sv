

class MODEM_CONTROL_REG extends uvm_reg;

	`uvm_object_utils(MODEM_CONTROL_REG)
	
	
	rand 	uvm_reg_field	dtr_bit;
	rand 	uvm_reg_field	rts_bit;
	rand	uvm_reg_field	out1_bit;
	rand 	uvm_reg_field	out2_bit;
	rand 	uvm_reg_field	loop_back_bit;
		uvm_reg_field	reserved_bit;


	function new (string name = "MODEM_CONTROL_REG");
		super.new(name,8,UVM_NO_COVERAGE);
	endfunction 

	
	function void build();
	

		// creating memory 

		dtr_bit 	= uvm_reg_field::type_id::create("dtr_bit");
		rts_bit		= uvm_reg_field::type_id::create("rts_bit");
		out1_bit	= uvm_reg_field::type_id::create("out1_bit");
		out2_bit	= uvm_reg_field::type_id::create("out2_bit");
		loop_back_bit	= uvm_reg_field::type_id::create("loop_back_bit");
		reserved_bit	= uvm_reg_field::type_id::create("reserved_bit");


		//configuration 

		dtr_bit		.configure(this,1,0,"RW",0,'h10,1,1,1);
		rts_bit		.configure(this,1,1,"RW",0,0,1,1,1);
		out1_bit	.configure(this,1,2,"RW",0,0,1,1,1);
		out2_bit	.configure(this,1,3,"RW",0,0,1,1,1);
		loop_back_bit	.configure(this,1,4,"RW",0,0,1,1,1);
		reserved_bit	.configure(this,3,5,"RW",0,0,1,0,0);

	endfunction 

endclass	
	

