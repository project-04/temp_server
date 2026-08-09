//Slave Sequence Class

class slv_seqs extends uvm_sequence #(axi_xtn);
	`uvm_object_utils(slv_seqs)

	// Properties

	//Methods
	extern function new(string name="slv_seqs");	

endclass

function slv_seqs :: new(string name="slv_seqs");
	super.new(name);
endfunction

//****************************************************************//

class slv_first_seq extends slv_seqs;
	`uvm_object_utils(slv_first_seq)

	extern function new(string name ="slv_first_seq");
	extern task body();
endclass

function slv_first_seq :: new(string name ="slv_first_seq");
	super.new(name);
endfunction

task slv_first_seq :: body();
	repeat(1)
		begin
			req = axi_xtn :: type_id :: create("req");
			start_item(req);
			assert(req.randomize()) ;
			finish_item(req);
		end
endtask


//****************************************************************//

class slv_second_seq extends slv_seqs;
	`uvm_object_utils(slv_second_seq)

	extern function new(string name ="slv_second_seq");
	extern task body();

endclass

function slv_second_seq :: new(string name ="slv_second_seq");
	super.new(name);
endfunction

task slv_second_seq :: body();
	repeat(4)
		begin
			req = axi_xtn :: type_id :: create("req");
			start_item(req);
				assert(req.randomize());
			finish_item(req);
		end
endtask

//****************************************************************//

class slv_third_seq extends slv_seqs;
	`uvm_object_utils(slv_third_seq)

	extern function new(string name ="slv_third_seq");
	extern task body();

endclass

function slv_third_seq :: new(string name ="slv_third_seq");
	super.new(name);
endfunction

task slv_third_seq :: body();
	repeat(1)
		begin
			req = axi_xtn :: type_id :: create("req");
			start_item(req);
				assert(req.randomize());
			finish_item(req);
		end
endtask

//****************************************************************//

class slv_fourth_seq extends slv_seqs;
	`uvm_object_utils(slv_fourth_seq)

	extern function new(string name ="slv_fourth_seq");
	extern task body();

endclass

function slv_fourth_seq :: new(string name ="slv_fourth_seq");
	super.new(name);
endfunction

task slv_fourth_seq :: body();
	repeat(1)
		begin
			req = axi_xtn :: type_id :: create("req");
			start_item(req);
				assert(req.randomize());
			finish_item(req);
		end
endtask

//****************************************************************//

class slv_fifth_seq extends slv_seqs;
	`uvm_object_utils(slv_fifth_seq)

	extern function new(string name ="slv_fifth_seq");
	extern task body();

endclass

function slv_fifth_seq :: new(string name ="slv_fifth_seq");
	super.new(name);
endfunction

task slv_fifth_seq :: body();
	repeat(1)
		begin
			req = axi_xtn :: type_id :: create("req");
			start_item(req);
				assert(req.randomize());
			finish_item(req);
		end
endtask

//****************************************************************//

class slv_sixth_seq extends slv_seqs;
	`uvm_object_utils(slv_sixth_seq)

	extern function new(string name ="slv_sixth_seq");
	extern task body();

endclass

function slv_sixth_seq :: new(string name ="slv_sixth_seq");
	super.new(name);
endfunction

task slv_sixth_seq :: body();
	repeat(1)
		begin
			req = axi_xtn :: type_id :: create("req");
			start_item(req);
				assert(req.randomize());
			finish_item(req);
		end
endtask

//****************************************************************//

class slv_seventh_seq extends slv_seqs;
	`uvm_object_utils(slv_seventh_seq)

	extern function new(string name ="slv_seventh_seq");
	extern task body();

endclass

function slv_seventh_seq :: new(string name ="slv_seventh_seq");
	super.new(name);
endfunction

task slv_seventh_seq :: body();
	repeat(1)
		begin
			req = axi_xtn :: type_id :: create("req");
			start_item(req);
				assert(req.randomize());
			finish_item(req);
		end
endtask


//****************************************************************//

class slv_eighth_seq extends slv_seqs;
	`uvm_object_utils(slv_eighth_seq)

	extern function new(string name ="slv_eighth_seq");
	extern task body();

endclass

function slv_eighth_seq :: new(string name ="slv_eighth_seq");
	super.new(name);
endfunction

task slv_eighth_seq :: body();
	repeat(2)
		begin
			req = axi_xtn :: type_id :: create("req");
			start_item(req);
				assert(req.randomize());
			finish_item(req);
		end
endtask

//****************************************************************//

class slv_ninth_seq extends slv_seqs;
	`uvm_object_utils(slv_ninth_seq)

	extern function new(string name ="slv_ninth_seq");
	extern task body();

endclass

function slv_ninth_seq :: new(string name ="slv_ninth_seq");
	super.new(name);
endfunction

task slv_ninth_seq :: body();
	repeat(2)
		begin
			req = axi_xtn :: type_id :: create("req");
			start_item(req);
				assert(req.randomize());
			finish_item(req);
		end
endtask

//****************************************************************//

class slv_tenth_seq extends slv_seqs;
	`uvm_object_utils(slv_tenth_seq)

	extern function new(string name ="slv_tenth_seq");
	extern task body();

endclass

function slv_tenth_seq :: new(string name ="slv_tenth_seq");
	super.new(name);
endfunction

task slv_tenth_seq :: body();
	repeat(2)
		begin
			req = axi_xtn :: type_id :: create("req");
			start_item(req);
				assert(req.randomize());
			finish_item(req);
		end
endtask

//****************************************************************//

class slv_eleventh_seq extends slv_seqs;
	`uvm_object_utils(slv_eleventh_seq)

	extern function new(string name ="slv_eleventh_seq");
	extern task body();

endclass

function slv_eleventh_seq :: new(string name ="slv_eleventh_seq");
	super.new(name);
endfunction

task slv_eleventh_seq :: body();
	repeat(2)
		begin
			req = axi_xtn :: type_id :: create("req");
			start_item(req);
				assert(req.randomize());
			finish_item(req);
		end
endtask

//****************************************************************//

class slv_twelveth_seq extends slv_seqs;
	`uvm_object_utils(slv_twelveth_seq)

	extern function new(string name ="slv_twelveth_seq");
	extern task body();

endclass

function slv_twelveth_seq :: new(string name ="slv_twelveth_seq");
	super.new(name);
endfunction

task slv_twelveth_seq :: body();
	repeat(1)
		begin
			req = axi_xtn :: type_id :: create("req");
			start_item(req);
				assert(req.randomize());
			finish_item(req);
		end
endtask

//****************************************************************//

class slv_thirteenth_seq extends slv_seqs;
	`uvm_object_utils(slv_thirteenth_seq)

	extern function new(string name ="slv_thirteenth_seq");
	extern task body();

endclass

function slv_thirteenth_seq :: new(string name ="slv_thirteenth_seq");
	super.new(name);
endfunction

task slv_thirteenth_seq :: body();
	repeat(1)
		begin
			req = axi_xtn :: type_id :: create("req");
			start_item(req);
				assert(req.randomize());
			finish_item(req);
		end
endtask

