class ahb_seqs extends uvm_sequence#(ahb_xtn);

	`uvm_object_utils(ahb_seqs)
	// ahb_Sxtn req;
int ctrl;
	extern function new(string name="ahb_seqs");
endclass

function ahb_seqs:: new(string name="ahb_seqs");
	super.new(name);
endfunction



class slv_seqs extends ahb_seqs;

	`uvm_object_utils(slv_seqs)
	// ahb_Sxtn req;
int ctrl;
	extern function new(string name="slv_seqs");
	extern task body();
endclass

function slv_seqs:: new(string name="slv_seqs");
	super.new(name);
endfunction

task slv_seqs::body();
		req=ahb_xtn::type_id::create("req");

repeat(10)
	begin
		start_item(req);
		assert(req.randomize());
		finish_item(req);	
		
	end
endtask

