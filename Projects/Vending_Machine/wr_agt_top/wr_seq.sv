class wr_seq extends uvm_sequence #(wr_trans);
	`uvm_object_utils(wr_seq)
	
	function new(string name = "wr_seq");
		super.new(name);
	endfunction
endclass

class wr_seq1 extends wr_seq;
	`uvm_object_utils(wr_seq1)
	
	function new(string name = "wr_seq1");
		super.new(name);
	endfunction
	
	task body();
		req = wr_trans::type_id::create("req");
		repeat(4)
		begin
			start_item(req);
			assert(req.randomize() with {coin_in==2'b00;});
			finish_item(req);
		end
		
		/*
		repeat(2)
		begin
			start_item(req);
			assert(req.randomize() with {coin_in==2'b01;});
			finish_item(req);
		end
		
		repeat(1)
		begin
			start_item(req);
			assert(req.randomize() with {coin_in==2'b01;});
			finish_item(req);
		
			start_item(req);
			assert(req.randomize() with {coin_in==2'b11;});
			finish_item(req);
		end
		
		repeat(20)
		begin
			start_item(req);
			assert(req.randomize());
			finish_item(req);
		end
		
		repeat(0)
		begin
			start_item(req);
			assert(req.randomize());
			finish_item(req);
		end
		*/
	endtask
endclass
