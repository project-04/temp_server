class master_xtn extends uvm_sequence_item;

//FACTORY
	`uvm_object_utils(master_xtn)

//DATA MEMBERS
	rand bit [4:0]adr_i;  //adress bits to select internal register
	
	rand bit [31:0]dat_i; //data to send to host processor
	
	bit [31:0]dat_o;
		
	rand bit we_i;

	logic ack_o;

	logic int_o;

	int unsigned tx0,tx1,tx2,tx3;
	
	int unsigned rx0,rx1,rx2,rx3;

	int unsigned control_reg,divider_reg,ss_reg;	




//CONSTRAINTS

	


//METHODS
	extern function new(string name = "master_xtn");
	extern function void do_print(uvm_printer printer);
//	extern function void post_randomize();
endclass

//CONSTRUCTOR
	function master_xtn::new(string name = "master_xtn");
		super.new(name);
	endfunction

	


	function void master_xtn::do_print(uvm_printer printer);
	
		printer.print_field("ADDRESS BITS",adr_i,5,UVM_HEX);
		printer.print_field("DATA_OUT",dat_o,32,UVM_DEC);
		printer.print_field("DATA_IN",dat_i,32,UVM_DEC);
		printer.print_field("ACKNOWLEDGMENT",ack_o,1,UVM_DEC);
		printer.print_field("INTERRUPT",int_o,1,UVM_DEC);
	        printer.print_field("CONTROL STATUS REG",control_reg,32,UVM_DEC);
	        printer.print_field("DIVIDER REG",divider_reg,32,UVM_DEC);
	        printer.print_field("SLAVE SELECT REG",ss_reg,32,UVM_DEC);
	        printer.print_field("TX_0 REG",tx0,32,UVM_BIN);
	        printer.print_field("TX_1 REG",tx1,32,UVM_BIN);
	        printer.print_field("TX_2 REG",tx2,32,UVM_DEC);
	        printer.print_field("TX_3 REG",tx3,32,UVM_DEC);
	        printer.print_field("RX_0 REG",rx0,32,UVM_DEC);
	        printer.print_field("RX_1 REG",rx1,32,UVM_DEC);
	        printer.print_field("RX_2 REG",rx2,32,UVM_DEC);
	        printer.print_field("RX_3 REG",rx3,32,UVM_DEC);
	endfunction
