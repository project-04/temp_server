class apb_trans extends uvm_sequence_item;
      `uvm_object_utils(apb_trans)
   
      function new(string name="apb_trans");
               super.new(name);
      endfunction

      //Signals-Inputs	
      rand bit [7:0]PADDR;
      rand bit [7:0]PWDATA;
      rand bit PWRITE;
      bit PSEL;
      bit PRESETn;
      bit PENABLE;
      bit RXD;
      
      //Signals-Outputs
      bit [7:0]PRDATA;
      bit PREADY;
      bit PSLVERR;
      bit IRQ;
      bit TXD;

      //Registers 
      bit [7:0] THR [$];
      bit [7:0] RBR [$];

      static bit [7:0] IER;
      static bit [7:0] IIR;
      static bit [7:0] FCR;
      static bit [7:0] LCR;
      static bit [7:0] MCR;
      static bit [7:0] LSR;
      static bit [7:0] MSR;
      static bit [7:0] DIV1;
      static bit [7:0] DIV2;
 
      bit data_in_thr;
      bit data_in_rbr;

      function void do_print(uvm_printer printer);
	super.do_print(printer);

	//                   srting name   	bitstream value     size       radix for printing
   	printer.print_field( "PADDR", 		this.PADDR, 	    8,		 UVM_HEX		);
  	printer.print_field( "PWDATA", 		this.PWDATA, 	    8,		 UVM_DEC		);

    	printer.print_field( "PSEL", 		this.PSEL, 	    1,		 UVM_BIN		);    	
        printer.print_field( "PENABLE", 	this.PENABLE, 	    1,		 UVM_BIN		);
    	printer.print_field( "PWRITE", 		this.PWRITE, 	    1,		 UVM_BIN		);

	printer.print_field( "PRESETn", 	this.PRESETn, 	    1,		 UVM_BIN		);

	printer.print_field( "PREADY", 		this.PREADY, 	    1,		 UVM_BIN		);
	printer.print_field( "PRDATA", 		this.PRDATA, 	    8,		 UVM_DEC		);
	printer.print_field( "PSLVERR", 	this.PSLVERR, 	    1,		 UVM_BIN		);
        printer.print_field( "IRQ", 		this.IRQ, 	    1,		 UVM_BIN		);
        printer.print_field( "TXD", 		this.TXD, 	    1,		 UVM_BIN		);
	printer.print_field( "RXD", 		this.RXD, 	    1,		 UVM_BIN		);

	printer.print_field( "DIV2",            this.DIV2, 	    8,		 UVM_DEC		);
	printer.print_field( "DIV1",            this.DIV1, 	    8,		 UVM_DEC		);
	printer.print_field( "LCR", 		this.LCR, 	    8,		 UVM_DEC		);
    	printer.print_field( "FCR", 		this.FCR, 	    8,		 UVM_DEC		);
    	printer.print_field( "IER", 	        this.IER, 	    8,		 UVM_DEC		);
	printer.print_field( "MCR", 	        this.MCR, 	    8,		 UVM_DEC		);
	
      foreach(THR[i])
       begin
	printer.print_field($sformatf("THR[%0d]",i),	this.THR[i],	$bits(THR[i]),	UVM_HEX);
       end

	printer.print_field( "IIR", 	        this.IIR, 	    8,		 UVM_DEC		); 

      foreach(RBR[i])
       begin
	printer.print_field($sformatf("RBR[%0d]",i),	this.RBR[i],	$bits(RBR[i]),	UVM_HEX);
       end
        printer.print_field( "LSR", 		this.IRQ, 	    8,		 UVM_DEC		);
        printer.print_field( "MSR", 		this.TXD, 	    8,		 UVM_DEC		);
        
      
      endfunction

endclass
    

