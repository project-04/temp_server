

class apb_sequence extends uvm_sequence#(apb_trans);

	`uvm_object_utils(apb_sequence)

	function new (string name = "apb_sequence");
		super.new(name);
	endfunction 

	task body();
		begin 

		end
	endtask	
		

endclass

class half_duplex_seq extends apb_sequence;

	`uvm_object_utils(half_duplex_seq)
	
	function new(string name = "half_duplex_seq");
		super.new(name);
	endfunction 
	
	bit [7:0] LCR;

	task body();
		begin 
		
			if(!uvm_config_db#(bit[7:0])::get(null,get_full_name(),"LCR",LCR))
				`uvm_fatal(get_type_name(),"FAILED TO GET LCR")
			
			req = apb_trans::type_id::create("req");

			start_item(req);
			assert(req.randomize() with  {Paddr == 32'h20; Pwrite == 1; Pwdata == 0;});
			finish_item(req);

			start_item(req);
			assert(req.randomize() with {Paddr == 32'h1C; Pwrite == 1; Pwdata == 54;});
			finish_item(req);

			start_item(req);
			assert(req.randomize() with {Paddr == 32'hC; Pwrite == 1; Pwdata == LCR;});
			finish_item(req);

			start_item(req);
			assert(req.randomize() with {Paddr == 32'h08; Pwrite == 1; Pwdata == 6;});
			finish_item(req);
				
			start_item(req);
			assert(req.randomize() with {Paddr == 32'h04; Pwrite == 1; Pwdata == 1;});
			finish_item(req);
			
			start_item(req);
			assert(req.randomize() with {Paddr == 32'h00; Pwrite == 1; Pwdata == 121;});
			finish_item(req);

		end
	endtask

endclass	
