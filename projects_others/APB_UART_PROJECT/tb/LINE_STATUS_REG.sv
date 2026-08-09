

class LINE_STATUS_REG extends uvm_reg;

	`uvm_object_utils(LINE_STATUS_REG)

	rand 	uvm_reg_field 	data_ready_bit;
	rand 	uvm_reg_field 	overrun_error_bit;
	rand 	uvm_reg_field 	parity_error_bit;
	rand 	uvm_reg_field 	framing_error_bit;
	rand 	uvm_reg_field 	break_bit;
	rand 	uvm_reg_field 	tfifo_empty_bit;
	rand 	uvm_reg_field 	t_empty_bit;
	rand 	uvm_reg_field 	fifo_error_bit;


	function new (string name = "LINE_STATUS_REG");
		super.new(name,8,UVM_NO_COVERAGE);
	endfunction 
	

	function void build();
	

		// creating memory 

		data_ready_bit 		= uvm_reg_field::type_id::create("data_ready_bit");
		overrun_error_bit	= uvm_reg_field::type_id::create("overrun_error_bit");
		parity_error_bit 	= uvm_reg_field::type_id::create("parity_error_bit");
		framing_error_bit	= uvm_reg_field::type_id::create("framing_error_bit");
		break_bit 		= uvm_reg_field::type_id::create("break_bit");
		tfifo_empty_bit		= uvm_reg_field::type_id::create("tfifo_empty_bit");
		t_empty_bit 		= uvm_reg_field::type_id::create("t_empty_bit");
		fifo_error_bit 		= uvm_reg_field::type_id::create("fifo_error_bit");


		//configuration 

		data_ready_bit	 	.configure(this,1,0,"RW",0,'h14,1,1,1);
		overrun_error_bit	.configure(this,1,1,"RW",0,0,1,1,1);
		parity_error_bit	.configure(this,1,2,"RW",0,0,1,1,1);
		framing_error_bit	.configure(this,1,3,"RW",0,0,1,1,1);
		break_bit 		.configure(this,1,4,"RW",0,0,1,1,1);
		tfifo_empty_bit		.configure(this,1,5,"RW",0,0,1,1,1);
		t_empty_bit		.configure(this,1,6,"RW",0,0,1,1,1);
		fifo_error_bit		.configure(this,1,7,"RW",0,0,1,1,1);

	endfunction 

endclass	
