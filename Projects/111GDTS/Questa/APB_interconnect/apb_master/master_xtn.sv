class master_xtn extends uvm_sequence_item;

	`uvm_object_utils(master_xtn)

	rand bit Pwrite;
	rand bit[31:0] Paddr;
	rand bit[31:0] Pwdata;
	bit Preset_n;
	bit transfer;
	bit pready;
	bit[31:0]Prdata;
	bit pslverr;
    
    constraint c1{ if(!Pwrite) 
                      Pwdata==0;}

	extern function new(string name = "master_xtn");
	extern function void do_print(uvm_printer printer);


 endclass

        
	function master_xtn::new(string name = "master_xtn");
		super.new(name);
	endfunction

	function void master_xtn::do_print (uvm_printer printer);
		printer.print_field("Preset_n",this.Preset_n,1,UVM_DEC);
		printer.print_field("Pwrite",this.Pwrite,1,UVM_DEC);
		printer.print_field("Paddr",this.Paddr,32,UVM_HEX);
		printer.print_field("Pwdata",this.Pwdata,32,UVM_HEX);
		printer.print_field("Prdata",this.Prdata,32,UVM_HEX);
		printer.print_field("transfer",this.transfer,1,UVM_DEC);
		printer.print_field("pslverr",this.pslverr,1,UVM_DEC);

	
	endfunction

	


