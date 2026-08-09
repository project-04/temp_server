//*****************************************************//Base Master Sequence.
class master_sequence extends uvm_sequence #(axi_xtn);
	`uvm_object_utils(master_sequence)

	env_config env_cfg;
	
  	function new(string name = "master_sequence" );
           	super.new(name);
  	endfunction
  	
	task body();
  	
		if(!uvm_config_db #(env_config)::get(null, get_full_name(), "env_config", env_cfg))
			`uvm_fatal(get_type_name,"Have you set the config?")
	endtask
endclass

//*****************************************************//Fixed Burst Sequence.
class fixed_burst_seq extends master_sequence;
	`uvm_object_utils(fixed_burst_seq)
	
  	function new(string name = "fixed_burst_seq" );
           	super.new(name);
  	endfunction
  	
  	task body();
		super.body();
  		
  		repeat(env_cfg.no_of_transations)
  		begin
  		     req = axi_xtn::type_id::create("req");
  		
  		     start_item(req);
  		     //assert(req.randomize() with {AWADDR == 'd2838428683; AWBURST == 0; AWLEN == 3; AWSIZE == 0;
  		     	//			  ARADDR == 32'h20; ARBURST == 0; ARLEN == 3; ARSIZE == 1;});
  		     	
  		    // assert(req.randomize() with {AWADDR == 32'd8; AWBURST == 0; AWLEN == 10; AWSIZE == 2;
  		     //				  ARADDR == 32'h20; ARBURST == 0; ARLEN == 1; ARSIZE == 0;});
  		     	
		     assert(req.randomize() with {AWLEN == 1; AWSIZE == 0; AWBURST == 2'b00; ARBURST == 2'b00;});
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
		super.body();
  		
  		repeat(env_cfg.no_of_transations)
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
		super.body();
  		
  		repeat(env_cfg.no_of_transations)
  		begin
  		     req = axi_xtn::type_id::create("req");
  		
  		     start_item(req);
  		     //assert(req.randomize() with {AWADDR == 32'h2; AWBURST == 1; AWLEN == 3; AWSIZE == 2;
  		     	//			  ARADDR == 32'h21; ARBURST == 1; ARLEN == 3; ARSIZE == 2;});
  		     				  
		  //   assert(req.randomize() with { AWBURST == 2'b01; ARBURST == 2'b01;});
		     assert(req.randomize() with {AWADDR == 32'd5; AWBURST == 2'b01; ARBURST == 2'b01;}); 
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
		super.body();
  		
  		repeat(env_cfg.no_of_transations)
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














