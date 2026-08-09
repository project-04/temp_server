 class ahb_rst_trans extends uvm_sequence_item;
   `uvm_object_utils(ahb_rst_trans)
   rand bit hresetn;
   extern function new(string name="ahb_rst_trans");
   extern function void do_print(uvm_printer printer);
 endclass
 //------------------------- new -------------------------
 function ahb_rst_trans::new(string name="ahb_rst_trans");
   super.new(name);
 endfunction
 //------------------------ do print ----------------------
 function void ahb_rst_trans::do_print(uvm_printer printer);
   printer.print_field("hresetn", this.hresetn, 1, UVM_DEC);
 endfunction
