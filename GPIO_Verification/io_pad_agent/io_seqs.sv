class io_sequence extends uvm_sequence#(io_xtn);

	`uvm_object_utils(io_sequence)

	extern function new(string name="io_sequence");

endclass

function io_sequence:: new(string name="io_sequence");
	super.new(name);
endfunction



class io_seq1 extends io_sequence;

	`uvm_object_utils(io_seq1)

	extern function new(string name="io_seq1");
	extern task body();

endclass

function io_seq1:: new(string name="io_seq1");
	super.new(name);
endfunction

task io_seq1::body();

	req=io_xtn::type_id::create("req");
   begin
		// input
       start_item(req);
       assert(req.randomize() with {ctrl=='b01;});
       finish_item(req);

   end

endtask


class io_seq2 extends io_sequence;

	`uvm_object_utils(io_seq2)

	extern function new(string name="io_seq2");
	extern task body();

endclass

function io_seq2:: new(string name="io_seq2");
	super.new(name);
endfunction

task io_seq2::body();

	req=io_xtn::type_id::create("req");
   begin
  // bi directional
       start_item(req);
       assert(req.randomize() with {ctrl=='b11;});
       finish_item(req);

   end

endtask

class io_seq3 extends io_sequence;

	`uvm_object_utils(io_seq3)

	extern function new(string name="io_seq3");
	extern task body();

endclass

function io_seq3:: new(string name="io_seq3");
	super.new(name);
endfunction

task io_seq3::body();

	req=io_xtn::type_id::create("req");
   begin
  // output
       start_item(req);
       assert(req.randomize() with {ctrl=='b00;});
       finish_item(req);

   end

endtask



class io_seq4 extends io_sequence;

	`uvm_object_utils(io_seq4)

	extern function new(string name="io_seq4");
	extern task body();

endclass

function io_seq4:: new(string name="io_seq4");
	super.new(name);
endfunction

task io_seq4::body();

	req=io_xtn::type_id::create("req");
   begin
  // bi directional
       start_item(req);
       assert(req.randomize() with {ctrl=='b01;io_pad =='h8877_655;});
       finish_item(req);

   end

endtask

