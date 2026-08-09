class master_base_seqs extends uvm_sequence #(master_xtn);

	`uvm_object_utils(master_base_seqs)
	
    bit[31:0]paddr;

	extern function new(string name ="master_base_seqs");
    extern task body();
endclass

function master_base_seqs::new(string name ="master_base_seqs");
        super.new(name);
endfunction

task master_base_seqs::body();

    if(!uvm_config_db#(bit[31:0])::get(null,get_full_name(),"Paddr",paddr))
        `uvm_fatal("master_sequence"," cannot able to get the Paddr inside master sequencer class")


endtask


/************************   Sequence-1  ***********************/


class mseq1 extends master_base_seqs;

    `uvm_object_utils(mseq1)

function new(string name = "mseq1");
    super.new(name);
endfunction


task body();
int abc;
    super.body();

    req = master_xtn::type_id::create("req");

    start_item(req);
    assert(req.randomize() with { Pwrite ==1;});
    finish_item(req);
    abc = req.Paddr;
    //#30;

    start_item(req);
    assert(req.randomize() with { Pwrite ==0;Paddr==abc;});
    finish_item(req);


    $display("@@!!!!!!!!!!!!!!!!    %h  %b",req.Pwdata,req.Pwrite);
endtask
endclass
    

