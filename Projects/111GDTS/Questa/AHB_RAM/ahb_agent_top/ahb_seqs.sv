
//-------------------- AHB BASE SEQUENCE ----------------------//
class ahb_base_seqs extends uvm_sequence #(ahb_xtn);

	`uvm_object_utils(ahb_base_seqs)
	
	extern function new(string name ="ahb_base_seqs");
endclass

//-----------------  constructor new method  -------------------//
function ahb_base_seqs::new(string name ="ahb_base_seqs");
        super.new(name);
endfunction

//------------------ AHB INCREMENT SEQUENCE ---------------------//

class ahb_incr_wr_seq extends ahb_base_seqs;

	`uvm_object_utils(ahb_incr_wr_seq)

        extern function new(string name ="ahb_incr_wr_seq");
        extern task body();
endclass

function ahb_incr_wr_seq::new(string name ="ahb_incr_wr_seq");
	super.new(name);
endfunction

task ahb_incr_wr_seq::body();
	bit [31:0] addr;
	bit [1:0] size1;
	bit [2:0] burst;
       	bit [2:0] temp_b;
        bit Write;

	req = ahb_xtn::type_id::create("req");
begin	
//NON-SEQUENTIAL
	start_item(req);
	assert(req.randomize with {req.Htrans == 2'b10; ((req.Hburst==3'd7)||(req.Hburst==3'd5)||(req.Hburst==3'd3)||(req.Hburst==3'd0));/*req.Hwrite==0; req.Haddr == 32'h8000_0000;*/});
	finish_item(req);

        Write = req.Hwrite;
	burst = req.Hburst;
	size1 = req.Hsize;
	addr = req.Haddr;
       	temp_b = req.length;

//SEQUENTIAL
//	if((req.Hburst == 3'd7) | (req.Hburst == 3'd5) | (req.Hburst == 3'd3) | (req.Hburst ==3'd0))
        begin
		for (int i=1; i < temp_b; i++) 
		begin
                       	start_item(req);
			assert(req.randomize with {req.Haddr == addr+(2**size1); req.Htrans == 2'b11; req.Hsize == size1; req.Hburst == burst; req.Hwrite == Write;}) ;

			burst = req.Hburst;
			size1 = req.Hsize;
			addr = req.Haddr;
	       		Write = req.Hwrite;

                       	finish_item(req);

		end
        end

//IDLE TRANSFER
/*
	start_item(req);
	assert(req.randomize with {req.Haddr == addr; req.Htrans == 2'b00; req.Hsize == size1; req.Hburst == burst; req.Hwrite == Write;}) ;
//	`uvm_info("INCREMENT",$sformatf("Printing from seqs /n %s",req.sprint()),UVM_LOW)
	finish_item(req);
*/
end
endtask
