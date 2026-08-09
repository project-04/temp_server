
 class axi_rst_trans extends uvm_sequence_item;
   `uvm_object_utils(axi_rst_trans)

   rand bit aresetn;
	
   logic bvalid;
   logic rvalid;

   extern function new(string name="axi_rst_trans");
   extern function void do_print(uvm_printer printer);
 endclass
 //------------------------- new -------------------------
 function axi_rst_trans::new(string name="axi_rst_trans");
   super.new(name);
 endfunction
 //------------------------ do print ----------------------
 function void axi_rst_trans::do_print(uvm_printer printer);
   printer.print_field("aresetn", this.aresetn, 1, UVM_DEC);
 endfunction
