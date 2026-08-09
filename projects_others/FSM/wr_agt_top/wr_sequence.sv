

class wr_sequence extends uvm_sequence#(trans);

	`uvm_object_utils(wr_sequence)
	
	function new (string name = "wr_sequence");
		super.new(name);
	endfunction 

	task body();
		repeat(1)	
			begin
				req = trans::type_id::create("req");
				start_item(req);
				assert(req.randomize() with {din == 1;})
				finish_item(req); 
				
				
				start_item(req);
				assert(req.randomize() with {din == 0;})
				finish_item(req);
				
				start_item(req);
				assert(req.randomize() with {din == 1;})
				finish_item(req);
				
				start_item(req);
				assert(req.randomize())
				finish_item(req);			

				start_item(req);
				assert(req.randomize())
				finish_item(req);
				
				start_item(req);
				assert(req.randomize())
				finish_item(req);
				
				
				
			end
	endtask

endclass	
