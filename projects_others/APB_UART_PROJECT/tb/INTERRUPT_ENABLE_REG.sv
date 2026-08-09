

class INTERRUPT_ENABLE_REG extends uvm_reg;

	`uvm_object_utils(INTERRUPT_ENABLE_REG)

	rand	uvm_reg_field	receive_data_ie;
	rand	uvm_reg_field	transmit_holding_ie;
	rand 	uvm_reg_field	receive_line_status_ie;
	rand	uvm_reg_field	modem_status_ie;
		uvm_reg_field	reserved;

	function new (string name = "INTERRUPT_ENABLE_REG");
		super.new(name,8,UVM_NO_COVERAGE);
	endfunction 

	function void build();
		
		//creating memory		
		receive_data_ie		= uvm_reg_field::type_id::create("receive_data_ie");
		transmit_holding_ie	= uvm_reg_field::type_id::create("transmit_holding_ie");
		receive_line_status_ie	= uvm_reg_field::type_id::create("receive_line_status_ie");
		modem_status_ie		= uvm_reg_field::type_id::create("modem_status_ie");
		reserved		= uvm_reg_field::type_id::create("reserved");


		//configuration 
		receive_data_ie		.configure(this,1,0,"RW",0,'h4,1,1,1);
		transmit_holding_ie	.configure(this,1,1,"RW",0,0,1,1,1);
		receive_line_status_ie	.configure(this,1,2,"RW",0,0,1,1,1);
		modem_status_ie		.configure(this,1,3,"RW",0,0,1,1,1);
		reserved		.configure(this,4,4,"RW",0,0,1,0,0);

	endfunction 

endclass
		

