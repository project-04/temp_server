class seqs extends uvm_sequence #(trans);
	`uvm_object_utils(seqs)

	function new(string name="seqs");
		super.new(name);
	endfunction
endclass

class sequence_xtns extends seqs;
	`uvm_object_utils(sequence_xtns)

	function new(string name = "sequence_xtns");
		super.new(name);
	endfunction
	
	task body();
      //	repeat(50)
		begin
			req=trans::type_id::create("req");
	   		
	   		start_item(req);
	   		assert(req.randomize());
	   		finish_item(req);	
      		end
      //  repeat(3)
		begin
      	req=trans::type_id::create("req");
     	start_item(req);
	   	assert(req.randomize() with {load==1; data_in==9;});
	 		finish_item(req);	
    end
  	endtask
endclass
