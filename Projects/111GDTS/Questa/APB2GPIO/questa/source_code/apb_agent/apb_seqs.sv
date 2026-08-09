class apb_sequence extends uvm_sequence#(apb_xtn);

	`uvm_object_utils(apb_sequence)

	extern function new(string name="apb_sequence");

endclass

function apb_sequence:: new(string name="apb_sequence");
	super.new(name);
endfunction

//////////////  input Sequence Class    ////////////////

class input_seqs extends apb_sequence;

	`uvm_object_utils(input_seqs)

	extern function new(string name="input_seqs");
	extern task body();

endclass

function input_seqs:: new(string name="input_seqs");
	super.new(name);
endfunction

task input_seqs::body();

	req=apb_xtn::type_id::create("req");
   begin
	
	// RGPIO_OE Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h2;PWDATA==0;})
       finish_item(req);


	// RGPIO_CTRL Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h6; PWDATA=='h0;})
       finish_item(req);

	// RGPIO_INTE (interrupt) Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h3;PWDATA=='h10;})
       finish_item(req);

         end

endtask

/////////////////    Read Sequence    /////////////////
class apb_read_seqs extends apb_sequence;

	`uvm_object_utils(apb_read_seqs)

	extern function new(string name="apb_read_seqs");
	extern task body();

endclass

function apb_read_seqs:: new(string name="apb_read_seqs");
	super.new(name);
endfunction

task apb_read_seqs::body();

	req=apb_xtn::type_id::create("req");
   begin
	
	// RGPIO_INTS(inturrupt status) Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b0; PADDR=='h7;PWDATA==0;})
       finish_item(req);

	// RGPIO_IN Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b0; PADDR=='h0;PWDATA=='h0;})
       finish_item(req);
   
   end

endtask


//////////////   Input Sequence in Interrupt Mode   ///////////////


class input_int_seqs extends apb_sequence;

	`uvm_object_utils(input_int_seqs)

	extern function new(string name="input_int_seqs");
	extern task body();

endclass

function input_int_seqs:: new(string name="input_int_seqs");
	super.new(name);
endfunction

task input_int_seqs::body();

	req=apb_xtn::type_id::create("req");
   begin
	
	// RGPIO_OE Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h2;PWDATA==0;})
       finish_item(req);

	// RGPIO_INTES (interrupt status) Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h7;PWDATA==0;})
       finish_item(req);

	
	// RGPIO_CTRL Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h6; PWDATA[1:0]=='b01;})
       finish_item(req);

	// RGPIO_INTE (interrupt) Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h3;PWDATA=='habcc_ffff;})
       finish_item(req);

	// RGPIO_PTRIG Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h4;PWDATA=='hffff00;})
       finish_item(req);

     end

endtask




//////////////  General-Purpose I/O as Output   ///////////////


class output_seqs extends apb_sequence;

	`uvm_object_utils(output_seqs)

	extern function new(string name="output_seqs");
	extern task body();

endclass

function output_seqs:: new(string name="output_seqs");
	super.new(name);
endfunction

task output_seqs::body();

	req=apb_xtn::type_id::create("req");
   begin
	
	// RGPIO_OE Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h2;PWDATA=='hffff_ffff;})
       finish_item(req);

	// RGPIO_OUT  Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h1;PWDATA=='h1234_5678;})
       finish_item(req);

	// RGPIO_INTE (interrupt) Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h3;PWDATA=='h0;})
       finish_item(req);


     end

endtask



//////////////  General-Purpose I/O as Bi-Directional I/O   ///////////////


class bi_directional_seqs extends apb_sequence;

	`uvm_object_utils(bi_directional_seqs)

	extern function new(string name="bi_directional_seqs");
	extern task body();

endclass

function bi_directional_seqs:: new(string name="bi_directional_seqs");
	super.new(name);
endfunction

task bi_directional_seqs::body();

	req=apb_xtn::type_id::create("req");
   begin
	
	// RGPIO_OE Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h2;PWDATA=='hffff_0000;})
       finish_item(req);

	// RGPIO_OUT  Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h1;PWDATA=='habcd_ef12;})
       finish_item(req);

	// RGPIO_INTE (interrupt) Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h3;PWDATA=='h0;})
       finish_item(req);


     end

endtask


//////////////  General-Purpose I/O as Auxiliary Input   ///////////////


class aux_seqs extends apb_sequence;

	`uvm_object_utils(aux_seqs)

	extern function new(string name="aux_seqs");
	extern task body();

endclass

function aux_seqs:: new(string name="aux_seqs");
	super.new(name);
endfunction

task aux_seqs::body();

	req=apb_xtn::type_id::create("req");
   begin
	
	// RGPIO_OE Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h2;PWDATA=='hffff_ffff;})
       finish_item(req);

	// RGPIO_OUT  Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h1;PWDATA=='h0;})
       finish_item(req);

	// RGPIO_INTE (interrupt) Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h3;PWDATA=='h0;})
       finish_item(req);

	// RGPIO_AUX Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h5;PWDATA=='hffff_ffff;})
       finish_item(req);

     end

endtask




//////////////  General-Purpose I/O as Output with Interrupt   ///////////////


class output_with_int_seqs extends apb_sequence;

	`uvm_object_utils(output_with_int_seqs)

	extern function new(string name="output_with_int_seqs");
	extern task body();

endclass

function output_with_int_seqs:: new(string name="output_with_int_seqs");
	super.new(name);
endfunction

task output_with_int_seqs::body();

	req=apb_xtn::type_id::create("req");
   begin
	
	// RGPIO_OE Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h2;PWDATA=='hffff_ffff;})
       finish_item(req);

       // RGPIO_INTES (interrupt status) Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h7;PWDATA==0;})
       finish_item(req);

	// RGPIO_OUT  Register
	repeat(3)
	begin
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h1;})
       finish_item(req);
	end
	
	// RGPIO_CTRL Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h6; PWDATA[1:0]=='b01;})
       finish_item(req);

	// RGPIO_INTE (interrupt) Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h3;PWDATA=='habcc_ffff;})
       finish_item(req);

	// RGPIO_PTRIG Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h4;PWDATA=='hffff00;})
       finish_item(req);

     end

endtask


//////////////  General-Purpose I/O as Auxiliary Input with ECLK  ///////////////


class eclk_seqs extends apb_sequence;

	`uvm_object_utils(eclk_seqs)

	extern function new(string name="eclk_seqs");
	extern task body();

endclass

function eclk_seqs:: new(string name="eclk_seqs");
	super.new(name);
endfunction

task eclk_seqs::body();

	req=apb_xtn::type_id::create("req");
   begin
	
	// ECLK Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h8;PWDATA=='hffff_ffff;})
       finish_item(req);

	// NEC Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h9;PWDATA=='h0000_ffff;})
       finish_item(req);

	// RGPIO_OE Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h2;PWDATA==0;})
       finish_item(req);

	// RGPIO_INTES (interrupt status) Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h7;PWDATA==0;})
       finish_item(req);

	
	// RGPIO_CTRL Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h6; PWDATA[1:0]=='b01;})
       finish_item(req);

	// RGPIO_INTE (interrupt) Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h3;PWDATA=='hffff_0000;})
       finish_item(req);

	// RGPIO_PTRIG Register
       start_item(req);
       assert(req.randomize() with {PWRITE==1'b1; PADDR=='h4;PWDATA=='h0000_ffff;})
       finish_item(req);

     end

endtask

