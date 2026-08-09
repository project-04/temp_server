//*****************************************************//Base Master Sequence.
class master_sequence extends uvm_sequence #(axi_xtn);
	`uvm_object_utils(master_sequence)

  	function new(string name = "master_sequence" );
           	super.new(name);
  	endfunction
  	
endclass

//*****************************************************//Fixed Burst Sequence.
class fixed_burst_seq extends master_sequence;
	`uvm_object_utils(fixed_burst_seq)

  	function new(string name = "fixed_burst_seq" );
           	super.new(name);
  	endfunction
  	
  	task body();
  	repeat(15)
  		begin
  		     req = axi_xtn::type_id::create("req");
  		
  		     start_item(req);
  		     //assert(req.randomize() with {AWADDR == 'd2313; AWBURST == 0; AWLEN == 3; AWSIZE == 2;
  		     	//			  ARADDR == 32'h20; ARBURST == 0; ARLEN == 3; ARSIZE == 2;});
  		     	
  		     //assert(req.randomize() with {AWADDR == 32'd0; AWBURST == 0; AWLEN == 3; AWSIZE == 2;
  		     	//			  ARADDR == 32'h20; ARBURST == 0; ARLEN == 3; ARSIZE == 1;});
  		     	
		     assert(req.randomize() with {AWBURST == 2'b00; ARBURST == 2'b00;});
  		     finish_item(req);
  		end
  		
  	endtask
endclass

//*****************************************************//INCR Burst Sequence(Aligned).
class incr_aligned_burst_seq extends master_sequence;
	`uvm_object_utils(incr_aligned_burst_seq)

  	function new(string name = "incr_aligned_burst_seq" );
           	super.new(name);
  	endfunction
  	
  	task body();
  	repeat(15)
  		begin
  		     req = axi_xtn::type_id::create("req");
  		
  		     start_item(req);
  		     //assert(req.randomize() with {AWADDR == 32'h0; AWBURST == 1; AWLEN == 3; AWSIZE == 2;
  		     	//			  ARADDR == 32'h20; ARBURST == 1; ARLEN == 3; ARSIZE == 2;});
  		     	
		     assert(req.randomize() with {AWBURST == 2'b01; ARBURST == 2'b01;});
  		     finish_item(req);
  		end
  		
  	endtask
endclass

//*****************************************************//INCR Burst Sequence(Unaligned).
class incr_unaligned_burst_seq extends master_sequence;
	`uvm_object_utils(incr_unaligned_burst_seq)

  	function new(string name = "incr_unaligned_burst_seq" );
           	super.new(name);
  	endfunction
  	
  	task body();
  	repeat(15)
  		begin
  		     req = axi_xtn::type_id::create("req");
  		
  		     start_item(req);
  		     //assert(req.randomize() with {AWADDR == 32'h2; AWBURST == 1; AWLEN == 3; AWSIZE == 2;
  		     	//			  ARADDR == 32'h21; ARBURST == 1; ARLEN == 3; ARSIZE == 2;});
  		     				  
		     assert(req.randomize() with {AWBURST == 2'b01; ARBURST == 2'b01;});
		     
  		     finish_item(req);
  		end
  		
  	endtask
endclass

//*****************************************************//WRAP Burst Sequence.
class wrap_burst_seq extends master_sequence;
	`uvm_object_utils(wrap_burst_seq)

  	function new(string name = "wrap_burst_seq" );
           	super.new(name);
  	endfunction
  	
  	task body();
  	repeat(15)
  		begin
  		     req = axi_xtn::type_id::create("req");
  		
  		     start_item(req);
  		     //assert(req.randomize() with {AWADDR == 32'd24; AWBURST == 2; AWLEN == 3; AWSIZE == 2;
  		     	//			  ARADDR == 32'd24; ARBURST == 2; ARLEN == 3; ARSIZE == 2;});
  		     				  
		     assert(req.randomize() with {AWBURST == 2'b10; ARBURST == 2'b10;});
		     
  		     finish_item(req);
  		end
  		
  	endtask
endclass

//*****************************************************//Multiple-outstanding.














