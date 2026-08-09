class base_virtual_seqs extends uvm_sequence #(uvm_sequence_item);

	`uvm_object_utils(base_virtual_seqs)
	
	virtual_sequencer v_seqrh;
	master_seqr mst_seqrh[];
	slave_seqr slv_seqrh[];
	env_config e_cfg;

    bit[31:0] Paddr;	
	extern function new(string name = "base_virtual_seqs");
	extern task body;
	
endclass

function base_virtual_seqs::new(string name = "base_virtual_seqs");
	super.new(name);
endfunction

task base_virtual_seqs::body;

	 if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
        `uvm_fatal("VIRTUAL_SEQUENCE","cannot get() from the config database. Have you set it?")

	 if(!uvm_config_db #(bit[31:0])::get(null,get_full_name(),"Paddr",Paddr))
        `uvm_fatal("VIRTUAL_SEQUENCE","cannot get() from the Paddr. Have you set it?")

        mst_seqrh = new[e_cfg.no_of_master_agent];
        slv_seqrh = new[e_cfg.no_of_slave_agent];
        
        assert($cast(v_seqrh, m_sequencer))
        else `uvm_error("BODY","ERROR IN $CAST OF VIRTUAL_SEQUENCER")

        foreach(mst_seqrh[i])
                mst_seqrh[i] = v_seqrh.mst_seqrh[i];

        foreach(slv_seqrh[i])
                slv_seqrh[i] = v_seqrh.slv_seqrh[i];
endtask

/*************************    V_Sequence-1   ***********************/

class vseq1 extends base_virtual_seqs;

    `uvm_object_utils(vseq1);
    
    mseq1 ms1;
    sseq1 ss1;

function new(string name = "vseq1");
    super.new(name);
endfunction

task body();

    super.body();

    ms1 = mseq1::type_id::create("ms1");
    ss1 = sseq1::type_id::create("ss1");

    fork
        begin
            ms1.start(mst_seqrh[0]);
        end
        begin
            if(Paddr[11:10]==2'b00)
                ss1.start(slv_seqrh[0]);
            if(Paddr[11:10]==2'b01)
               ss1.start(slv_seqrh[1]);
            if(Paddr[11:10]==2'b10)
               ss1.start(slv_seqrh[2]);
            if(Paddr[11:10]==2'b11)
                ss1.start(slv_seqrh[3]);
        end
    join

endtask
endclass 
