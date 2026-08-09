

class FIFO_CONTROL_REG extends uvm_reg;

	`uvm_object_utils(FIFO_CONTROL_REG)

	     	uvm_reg_field reserved; 	
	rand 	uvm_reg_field rx_flush;
	rand 	uvm_reg_field tx_flush;
		uvm_reg_field reserved1;
	rand 	uvm_reg_field threshold;

	function new (string name = "FIFO_CONTROL_REG");
		super.new(name,8,UVM_NO_COVERAGE);
	endfunction 

	
	function void build();
		
		//creating memory
		reserved  = uvm_reg_field::type_id::create("reserved");
		rx_flush  = uvm_reg_field::type_id::create("rx_flush");
		tx_flush  = uvm_reg_field::type_id::create("tx_flush");
		reserved1 = uvm_reg_field::type_id::create("reserved1");
		threshold = uvm_reg_field::type_id::create("threshold");
	

		//configuration 
		reserved  .configure(this,1,0,"RW",0,0,0,0,1);
		rx_flush  .configure(this,1,1,"RW",0,0,0,1,1);
		tx_flush  .configure(this,1,2,"RW",0,0,0,1,1);
		reserved1 .configure(this,3,3,"RW",0,0,0,0,1);
		threshold .configure(this,2,6,"RW",0,0,0,1,1);

	endfunction 

endclass

		
