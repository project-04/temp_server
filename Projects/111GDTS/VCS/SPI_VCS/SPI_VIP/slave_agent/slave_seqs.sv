class slave_seqs extends uvm_sequence#(slave_xtn);

//FACTORY
	`uvm_object_utils(slave_seqs);

//DATA MEMBERS


//METHODS
	extern function new(string name = "slave_seqs");



endclass


//CONSTRUCTOR
	function slave_seqs::new(string name= "slave_seqs");
		super.new(name);
	endfunction



class slave_seqs_1 extends slave_seqs;
//FACTORY
	`uvm_object_utils(slave_seqs_1);

//DATA MEMBERS


//METHODS
	extern function new(string name = "slave_seqs_1");
	extern task body();
endclass


//CONSTRUCTOR
	function slave_seqs_1::new(string name= "slave_seqs_1");
		super.new(name);
	endfunction

//BODY
	task slave_seqs_1::body();
	begin
		req=slave_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize());
		finish_item(req);
	end 	
	endtask




