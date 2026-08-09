

class MODEM_STATUS_REG extends uvm_reg;

	`uvm_object_utils(MODEM_STATUS_REG)

	rand 	uvm_reg_field 	dcts_bit;
	rand 	uvm_reg_field 	ddsr_bit;
	rand 	uvm_reg_field 	teri_bit;
	rand 	uvm_reg_field 	ddcd_bit;
	rand 	uvm_reg_field 	cts_bit;
	rand 	uvm_reg_field 	dst_bit;
	rand 	uvm_reg_field 	ri_bit;
	rand 	uvm_reg_field 	dcd_bit;


	function new (string name = "MODEM_STATUS_REG");
		super.new(name,8,UVM_NO_COVERAGE);
	endfunction 
	

	function void build();
	

		// creating memory 

		dcts_bit 	= uvm_reg_field::type_id::create("dcts_bit");
		ddsr_bit	= uvm_reg_field::type_id::create("ddsr_bit");
		teri_bit 	= uvm_reg_field::type_id::create("teri_bit");
		ddcd_bit	= uvm_reg_field::type_id::create("ddcd_bit");
		cts_bit 	= uvm_reg_field::type_id::create("cts_bit");
		dst_bit		= uvm_reg_field::type_id::create("dst_bit");
		ri_bit 		= uvm_reg_field::type_id::create("ri_bit");
		dcd_bit 	= uvm_reg_field::type_id::create("dcd_bit");


		//configuration 

		dcts_bit	.configure(this,1,0,"RW",0,'h18,1,1,1);
		ddsr_bit	.configure(this,1,1,"RW",0,0,1,1,1);
		teri_bit	.configure(this,1,2,"RW",0,0,1,1,1);
		ddcd_bit	.configure(this,1,3,"RW",0,0,1,1,1);
		cts_bit 	.configure(this,1,4,"RW",0,0,1,1,1);
		dst_bit		.configure(this,1,5,"RW",0,0,1,1,1);
		ri_bit		.configure(this,1,6,"RW",0,0,1,1,1);
		dcd_bit		.configure(this,1,7,"RW",0,0,1,1,1);

	endfunction 

endclass	
