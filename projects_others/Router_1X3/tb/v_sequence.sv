
class v_sequence extends uvm_sequence #(uvm_sequence_item);
	`uvm_object_utils(v_sequence)
	
	env_config env_cfg;
	v_sequencer v_seqr; //virtal sequencer handle 
	
	src_seqr src_seqrh; //physical source sequencer handle
	dest_seqr dest_seqrh[]; //physical destination sequencer handle
	
	small_sequence seqr1; // physical src sequence1 handle
	mid_sequence   seqr2; // physical src sequence2 handle
	large_sequence seqr3; // physical src sequence3 handle
	
	read_sequence rd_seq1,rd_seq2,rd_seq3; // physical read sequences handles
	
	function new(string name = "v_sequence");
		super.new(name);
	endfunction 
endclass

class base_sequence extends v_sequence;
    `uvm_object_utils(base_sequence)
        
    function new(string name = "base_sequence");
        super.new(name);
    endfunction
    
    task body();
        if(!$cast(v_seqr,m_sequencer))
            begin 
                `uvm_error(get_full_name(),"casting failed");
            end
                
        src_seqrh = v_seqr.src_seqrh;
        dest_seqrh = new[v_seqr.dest_seqrh.size()];  // Allocate based on v_seqr's array size
        foreach(dest_seqrh[i])
            begin
                dest_seqrh[i] = v_seqr.dest_seqrh[i];
            end
    endtask
endclass

class small_vsequence extends base_sequence;
	`uvm_object_utils(small_vsequence)
	bit[1:0] addr;
	function new(string name = "small_vsequence");
		super.new(name);
	endfunction
	
	task body();
		super.body();
		seqr1   = small_sequence::type_id::create("seqr1");
		rd_seq1 = read_sequence::type_id::create("rd_seq1");
		if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit1",addr))
			`uvm_fatal("small_vsequence","not able to get")
		repeat(5)
			begin
				fork
					seqr1.start(src_seqrh);
					rd_seq1.start(dest_seqrh[addr]);
				join
			end
		
	endtask
endclass
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class mid_vsequence extends base_sequence;
	`uvm_object_utils(mid_vsequence)
	bit[1:0] addr;
	function new(string name = "mid_vsequence");
		super.new(name);
	endfunction
	
	task body();
		super.body();
		seqr2 = mid_sequence::type_id::create("seqr2");
		rd_seq2 = read_sequence::type_id::create("rd_seq2");
		if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit2",addr))
			`uvm_fatal("mid_vsequence","not able to get")
		repeat(5)
			begin
				fork
					seqr2.start(src_seqrh);
					rd_seq2.start(dest_seqrh[addr]);
				join
			end
	endtask
endclass

class large_vsequence extends base_sequence;
	`uvm_object_utils(large_vsequence)
	bit[1:0] addr;
	function new(string name = "large_vsequence");
		super.new(name);
	endfunction
	
	task body();
		super.body();
		seqr3 = large_sequence::type_id::create("seqr3");
		rd_seq3 = read_sequence::type_id::create("rd_seq3");
		if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit3",addr))
			`uvm_fatal("large_vsequence","not able to get")
		repeat(5)
			begin
				fork
					seqr3.start(src_seqrh);
					rd_seq3.start(dest_seqrh[addr]);
				join
			end
	endtask
endclass
