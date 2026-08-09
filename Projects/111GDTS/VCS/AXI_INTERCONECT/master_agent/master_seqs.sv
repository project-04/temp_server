// Master Sequence Class

class mast_seqs extends uvm_sequence #(axi_xtn);
	`uvm_object_utils(mast_seqs)

	// Properties

	// Methods
	extern function new(string name="mast_seqs");

endclass

function mast_seqs :: new(string name ="mast_seqs");
	super.new(name);
endfunction

// *************************************************//

class mast_first_seq extends mast_seqs;
	`uvm_object_utils(mast_first_seq)

	bit[1:0] read_addr;
	bit[1:0] write_addr;

	extern function new(string name="mast_first_seq");
	extern task body();
endclass

function mast_first_seq :: new(string name="mast_first_seq");
	super.new(name);
endfunction

task mast_first_seq :: body();
	repeat(1)
		begin
                    
			if(!uvm_config_db #(bit[1:0])::get(null, get_full_name(), "read_addr", read_addr))
				`uvm_fatal(get_type_name(), "Cannot get read_addr from uvm_config_db")

			if(!uvm_config_db #(bit[1:0])::get(null, get_full_name(), "write_addr", write_addr))
				`uvm_fatal(get_type_name(), "Cannot get write_addr from uvm_config_db")

			req = axi_xtn :: type_id :: create("req");
			start_item(req);
		assert(req.randomize() with {write_slave == write_addr; read_slave == read_addr; });
			finish_item(req);
			
		end
endtask

// *************************************************//

class mast_second_seq extends mast_seqs;
	`uvm_object_utils(mast_second_seq)

	bit[1:0] read_addr;
	bit[1:0] write_addr;


	extern function new(string name="mast_second_seq");
	extern task body();
endclass

function mast_second_seq :: new(string name="mast_second_seq");
	super.new(name);
endfunction

task mast_second_seq :: body();
	repeat(1)
		begin
			if(!uvm_config_db #(bit[1:0])::get(null, get_full_name(), "read_addr", read_addr))
				`uvm_fatal(get_type_name(), "Cannot get read_addr from uvm_config_db")

			if(!uvm_config_db #(bit[1:0])::get(null, get_full_name(), "write_addr", write_addr))
				`uvm_fatal(get_type_name(), "Cannot get write_addr from uvm_config_db")

			req = axi_xtn :: type_id :: create("req");
			start_item(req);
	        	assert(req.randomize() with {write_slave == write_addr; read_slave == read_addr; });
			finish_item(req);
			
		end
endtask

// *************************************************//

class mast_third_seq extends mast_seqs;
	`uvm_object_utils(mast_third_seq)

	extern function new(string name="mast_third_seq");
	extern task body();
endclass

function mast_third_seq :: new(string name="mast_third_seq");
	super.new(name);
endfunction

task mast_third_seq :: body();
	repeat(1)
		begin
			req = axi_xtn :: type_id :: create("req");
			start_item(req);
			assert(req.randomize() with { write_slave == 0; read_slave == 0;  });
			finish_item(req);
			
		end
endtask

// *************************************************//

class mast_fourth_seq extends mast_seqs;
	`uvm_object_utils(mast_fourth_seq)

	extern function new(string name="mast_fourth_seq");
	extern task body();
endclass

function mast_fourth_seq :: new(string name="mast_fourth_seq");
	super.new(name);
endfunction

task mast_fourth_seq :: body();
	repeat(1)
		begin
			req = axi_xtn :: type_id :: create("req");
			start_item(req);
			assert(req.randomize() with { write_slave == 1; read_slave == 1;  });
			finish_item(req);
			
		end
endtask
// *************************************************//

class mast_fifth_seq extends mast_seqs;
	`uvm_object_utils(mast_fifth_seq)

	extern function new(string name="mast_fifth_seq");
	extern task body();
endclass

function mast_fifth_seq :: new(string name="mast_fifth_seq");
	super.new(name);
endfunction

task mast_fifth_seq :: body();
	repeat(1)
		begin
			req = axi_xtn :: type_id :: create("req");
			start_item(req);
			assert(req.randomize() with { write_slave == 2; read_slave ==2;  });
			finish_item(req);
			
		end
endtask
// *************************************************//

class mast_sixth_seq extends mast_seqs;
	`uvm_object_utils(mast_sixth_seq)

	extern function new(string name="mast_sixth_seq");
	extern task body();
endclass

function mast_sixth_seq :: new(string name="mast_sixth_seq");
	super.new(name);
endfunction

task mast_sixth_seq :: body();
	repeat(1)
		begin
			req = axi_xtn :: type_id :: create("req");
			start_item(req);
			assert(req.randomize() with { write_slave ==3; read_slave == 3; });
			finish_item(req);
			
		end
endtask

// *************************************************//

class mast_seventh_seq extends mast_seqs;
	`uvm_object_utils(mast_seventh_seq)

	extern function new(string name="mast_seventh_seq");
	extern task body();
endclass

function mast_seventh_seq :: new(string name="mast_seventh_seq");
	super.new(name);
endfunction

task mast_seventh_seq :: body();
	repeat(1)
		begin
			req = axi_xtn :: type_id :: create("req");
			start_item(req);
                        assert(req.randomize() with { write_slave==1; read_slave==1; AWVALID ==1; ARVALID ==0; });

			finish_item(req);
			
		end
endtask

// *************************************************//

class mast_eighth_seq extends mast_seqs;
	`uvm_object_utils(mast_eighth_seq)

	extern function new(string name="mast_eighth_seq");
	extern task body();
endclass

function mast_eighth_seq :: new(string name="mast_eighth_seq");
	super.new(name);
endfunction

task mast_eighth_seq :: body();
	repeat(1)
		begin
			req = axi_xtn :: type_id :: create("req");
			start_item(req);
			assert(req.randomize() with { write_slave == 3; read_slave == 3;  });
			finish_item(req);
			
		end
endtask

// *************************************************//

class mast_ninth_seq extends mast_seqs;
	`uvm_object_utils(mast_ninth_seq)

	extern function new(string name="mast_ninth_seq");
	extern task body();
endclass

function mast_ninth_seq :: new(string name="mast_ninth_seq");
	super.new(name);
endfunction

task mast_ninth_seq :: body();
	repeat(1)
		begin
			req = axi_xtn :: type_id :: create("req");
			start_item(req);
			assert(req.randomize() with { write_slave == 0; read_slave == 0;  });
			finish_item(req);
			
		end
endtask

// *************************************************//

class mast_tenth_seq extends mast_seqs;
	`uvm_object_utils(mast_tenth_seq)

	extern function new(string name="mast_tenth_seq");
	extern task body();
endclass

function mast_tenth_seq :: new(string name="mast_tenth_seq");
	super.new(name);
endfunction

task mast_tenth_seq :: body();
	repeat(1)
		begin
			req = axi_xtn :: type_id :: create("req");
			start_item(req);
			assert(req.randomize() with {write_slave == 3; read_slave == 2;  });
			finish_item(req);
			
		end
endtask

// *************************************************//

class mast_eleventh_seq extends mast_seqs;
	`uvm_object_utils(mast_eleventh_seq)

	extern function new(string name="mast_eleventh_seq");
	extern task body();
endclass

function mast_eleventh_seq :: new(string name="mast_eleventh_seq");
	super.new(name);
endfunction

task mast_eleventh_seq :: body();
	repeat(1)
		begin
			req = axi_xtn :: type_id :: create("req");
			start_item(req);
			assert(req.randomize() with { write_slave == 0; read_slave == 1;  });
			finish_item(req);
			
		end
endtask


// *************************************************//

class mast_twelveth_seq extends mast_seqs;
	`uvm_object_utils(mast_twelveth_seq)

	bit[1:0] read_addr;
	bit[1:0] write_addr;


	extern function new(string name="mast_twelveth_seq");
	extern task body();
endclass

function mast_twelveth_seq :: new(string name="mast_twelveth_seq");
	super.new(name);
endfunction

task mast_twelveth_seq :: body();
	repeat(1)
		begin
			if(!uvm_config_db #(bit[1:0])::get(null, get_full_name(), "read_slave", read_addr))
				`uvm_fatal(get_type_name(), "Cannot get read_addr from uvm_config_db")

			if(!uvm_config_db #(bit[1:0])::get(null, get_full_name(), "write_slave", write_addr))
				`uvm_fatal(get_type_name(), "Cannot get write_addr from uvm_config_db")

			req = axi_xtn :: type_id :: create("req");
			start_item(req);
	         	assert(req.randomize() with {write_slave == write_addr; read_slave == read_addr; });
			finish_item(req);
			
		end
endtask

// *************************************************//

class mast_thirteenth_seq extends mast_seqs;
	`uvm_object_utils(mast_thirteenth_seq)

	extern function new(string name="mast_thirteenth_seq");
	extern task body();
endclass

function mast_thirteenth_seq :: new(string name="mast_thirteenth_seq");
	super.new(name);
endfunction

task mast_thirteenth_seq :: body();
	repeat(1)
		begin
			req = axi_xtn :: type_id :: create("req");
			start_item(req);
			assert(req.randomize() with { write_slave==3; read_slave==2; AWVALID ==0; ARVALID ==1; });
			finish_item(req);
			
		end
endtask


