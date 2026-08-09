class base_virtual_seqs extends uvm_sequence #(uvm_sequence_item);

	`uvm_object_utils(base_virtual_seqs)
	
	virtual_sequencer v_seqrh;
	ahb_seqr ahb_seqrh[];
	env_config e_cfg;
	
	extern function new(string name = "base_virtual_seqs");
	extern task body;
	
endclass

function base_virtual_seqs::new(string name = "base_virtual_seqs");
	super.new(name);
endfunction

task base_virtual_seqs::body;
	 if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
        `uvm_fatal("VIRTUAL_SEQUENCE","cannot get() from the config database. Have you set it?")

        ahb_seqrh = new[e_cfg.no_of_ahb_agent];
        
        assert($cast(v_seqrh, m_sequencer))
        else `uvm_error("BODY","ERROR IN $CAST OF VIRTUAL_SEQUENCER")

        foreach(ahb_seqrh[i])
                ahb_seqrh[i] = v_seqrh.ahb_seqrh[i];
endtask


//----------------------- AHB INCR VIRTUAL SEQUENCE ------------------------//

class ahb_incr_vseq extends base_virtual_seqs;

	`uvm_object_utils(ahb_incr_vseq)
	
	ahb_incr_wr_seq incr_seq;
	
	extern function new(string name = "ahb_incr_vseq");
	extern task body;
	
endclass

function ahb_incr_vseq::new(string name = "ahb_incr_vseq");
	super.new(name);
endfunction

task ahb_incr_vseq::body;
	 super.body();
     
        if(e_cfg.has_ahb_agent)  
incr_seq = ahb_incr_wr_seq::type_id::create("incr_seq");

        incr_seq.start(ahb_seqrh[0]);
endtask


