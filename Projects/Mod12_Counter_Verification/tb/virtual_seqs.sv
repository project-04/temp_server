class virtual_seqs extends uvm_sequence #(uvm_sequence_item);
	`uvm_object_utils(virtual_seqs)
  
  	//env_config env_configh;
  	wr_sequencer seqrh[]; //sequencer seqrh[0], seqrh[1]; 
  	virtual_sequencer vsqrh;
      
      	sequence_xtns xtns;
  
 	function new(string name="virtual_seqs");
		super.new(name);
	endfunction
  
  	task body();
   	if (!$cast(vsqrh,m_sequencer)) //check with m_sequencer becauses we have so maney seqences, m_sequencer is default sequncer for all seqencers.
		begin
			`uvm_error("vir_seq", "Error in $cast of virtual sequencer")
		end
   
   
    		//if(!uvm_config_db #(env_config)::get(null, "","env_config",env_configh)) //working
	/* 	if(!uvm_config_db #(env_config)::get(null, get_full_name(),"env_config",env_configh)) //working
	 	begin
			`uvm_fatal("virtual_sequencer","cannot get() env_configh from uvm_config_db. Have you set() it?")
   		end
   */   
      seqrh = new[vsqrh.seqrh.size()];      
   		//seqrh = new[env_configh.no_of_agents];
      
		foreach(seqrh[i])
		begin
			seqrh[i] = vsqrh.seqrh[i];
		end
   
   
   //seqrh = vsqrh.seqrh;

  	endtask
endclass

class sequence_xtns_vseq extends virtual_seqs;
	`uvm_object_utils(sequence_xtns_vseq)
	
      	//sequence_xtns xtns;
        
	function new(string name = "sequence_xtns_vseq");
		super.new(name);
  	endfunction
	
  	task body();
    		super.body();
    		
    		`uvm_info("sequence_xtns_vseq", $sformatf("get_full_name() = %s",get_full_name()), UVM_LOW)
    		xtns = sequence_xtns::type_id::create("xtns");
    
    		xtns.start(seqrh[0]);
  	endtask
endclass
