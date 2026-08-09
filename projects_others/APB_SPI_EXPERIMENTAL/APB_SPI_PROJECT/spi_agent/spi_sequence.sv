

class spi_base_sequence extends uvm_sequence#(spi_trans);
	
	`uvm_object_utils(spi_base_sequence)

	function new (string name = "spi_base_sequence");
		super.new(name);
	endfunction 

	
endclass

class cpol_cphase_00_spi extends spi_base_sequence;

	`uvm_object_utils(cpol_cphase_00_spi);

	function new (string name = "cpol_cphase_00_spi");
		super.new(name);
	endfunction 

	task body();
		begin

			req = spi_trans::type_id::create("req");

			start_item(req);
			assert(req.randomize() with { miso == 8'b1111_0000; });	
			finish_item(req);
			
		end
	endtask

endclass

