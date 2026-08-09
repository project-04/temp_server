class virtual_seqs extends uvm_sequence #(uvm_sequence_item);
	`uvm_object_utils(virtual_seqs)
  
  	env_config env_configh;
  	sequencer seqrh[]; //sequencer seqrh[0], seqrh[1]; 
  	virtual_sequencer vsqrh;
      
      	HD_0_sequence_xtns HD_0_xtns;
    	HD_1_sequence_xtns HD_1_xtns;
    	
  	HDM_0_sequence_xtns HDM_0_xtns;
    	HDM_1_sequence_xtns HDM_1_xtns;
     
      	FD_0_sequence_xtns FD_0_xtns;
    	FD_1_sequence_xtns FD_1_xtns;
    	
    	FDM_0_sequence_xtns FDM_0_xtns;
    	FDM_1_sequence_xtns FDM_1_xtns;
    	
	FDLB_0_sequence_xtns FDLB_0_xtns;
	FDLB_1_sequence_xtns FDLB_1_xtns;
	
	FDLBM_0_sequence_xtns FDLBM_0_xtns;
	FDLBM_1_sequence_xtns FDLBM_1_xtns;
	
	FDM_0_thr_empty_sequence_xtns FDM_0_thr_empty_xtns;
    	FDM_1_thr_empty_sequence_xtns FDM_1_thr_empty_xtns;
     
    	FDM_EP_0_sequence_xtns FDM_EP_0_xtns;
    	FDM_EP_1_sequence_xtns FDM_EP_1_xtns;
  
 	function new(string name="virtual_seqs");
		super.new(name);
	endfunction
  
  	task body();
   	if (!$cast(vsqrh,m_sequencer)) //check with m_sequencer becauses we have so maney seqences, m_sequencer is default sequncer for all seqencers.
		begin
			`uvm_error("vir_seq", "Error in $cast of virtual sequencer")
		end
   
   
    		//if(!uvm_config_db #(env_config)::get(null, "","env_config",env_configh)) //working
	 	if(!uvm_config_db #(env_config)::get(null, get_full_name(),"env_config",env_configh)) //working
	 	begin
			`uvm_fatal("virtual_sequencer","cannot get() env_configh from uvm_config_db. Have you set() it?")
   		end

   		//seqrh = new[env_configh.no_of_agents];
   		seqrh = new[vsqrh.seqrh.size()];
      
		foreach(seqrh[i])
		begin
			seqrh[i] = vsqrh.seqrh[i];
		end

   
   //seqrh = vsqrh.seqrh;

  	endtask
endclass

class HD_0_and_HD_1_sequence_xtns_vseq extends virtual_seqs;
	`uvm_object_utils(HD_0_and_HD_1_sequence_xtns_vseq)
	
    //  HD_0_sequence_xtns HD_0_xtns;
    //	HD_1_sequence_xtns HD_1_xtns;
        
	function new(string name = "HD_0_and_HD_1_sequence_xtns_vseq");
		super.new(name);
  	endfunction
	
  	task body();
    		super.body();
    		
    		`uvm_info("HD_0_and_HD_1_sequence_xtns_vseq", $sformatf("get_full_name() = %s",get_full_name()), UVM_LOW)
    		HD_0_xtns = HD_0_sequence_xtns::type_id::create("HD_0_xtns");
    		HD_1_xtns = HD_1_sequence_xtns::type_id::create("HD_1_xtns");
    		fork
    			HD_0_xtns.start(seqrh[0]);
    			HD_1_xtns.start(seqrh[1]);
    		join
  	endtask
endclass

class HDM_0_and_HDM_1_sequence_xtns_vseq extends virtual_seqs;
	`uvm_object_utils(HDM_0_and_HDM_1_sequence_xtns_vseq)
	
    //  HDM_0_sequence_xtns HDM_0_xtns;
    //	HDM_1_sequence_xtns HDM_1_xtns;
        
	function new(string name = "HDM_0_and_HDM_1_sequence_xtns_vseq");
		super.new(name);
  	endfunction
	
  	task body();
    		super.body();
    		
    		`uvm_info("HDM_0_and_HDM_1_sequence_xtns_vseq", $sformatf("get_full_name() = %s",get_full_name()), UVM_LOW)
    		HDM_0_xtns = HDM_0_sequence_xtns::type_id::create("HDM_0_xtns");
    		HDM_1_xtns = HDM_1_sequence_xtns::type_id::create("HDM_1_xtns");
	    	fork
	    		HDM_0_xtns.start(seqrh[0]);
	    		HDM_1_xtns.start(seqrh[1]);
	  	join
  	endtask
endclass

class FD_0_and_FD_1_sequence_xtns_vseq extends virtual_seqs;
	`uvm_object_utils(FD_0_and_FD_1_sequence_xtns_vseq)
	
    //  FD_0_sequence_xtns FD_0_xtns;
    //	FD_1_sequence_xtns FD_1_xtns;
        
	function new(string name = "FD_0_and_FD_1_sequence_xtns_vseq");
		super.new(name);
  	endfunction
	
  	task body();
    		super.body();
    		
    		`uvm_info("FD_0_and_FD_1_sequence_xtns_vseq", $sformatf("get_full_name() = %s",get_full_name()), UVM_LOW)
    		FD_0_xtns = FD_0_sequence_xtns::type_id::create("FD_0_xtns");
    		FD_1_xtns = FD_1_sequence_xtns::type_id::create("FD_1_xtns");
        
		fork
	    		FD_0_xtns.start(seqrh[0]);
	    		FD_1_xtns.start(seqrh[1]);
		join
  	endtask
endclass


class FDM_0_and_FDM_1_sequence_xtns_vseq extends virtual_seqs;
	`uvm_object_utils(FDM_0_and_FDM_1_sequence_xtns_vseq)
	
    //  FDM_0_sequence_xtns FDM_0_xtns;
    //	FDM_1_sequence_xtns FDM_1_xtns;
        
	function new(string name = "FDM_0_and_FDM_1_sequence_xtns_vseq");
		super.new(name);
  	endfunction
	
  	task body();
    		super.body();
    		
    		`uvm_info("FDM_0_and_FDM_1_sequence_xtns_vseq", $sformatf("get_full_name() = %s",get_full_name()), UVM_LOW)
    		FDM_0_xtns = FDM_0_sequence_xtns::type_id::create("FDM_0_xtns");
    		FDM_1_xtns = FDM_1_sequence_xtns::type_id::create("FDM_1_xtns");
	    	fork
	    		FDM_0_xtns.start(seqrh[0]);
	    		FDM_1_xtns.start(seqrh[1]);
	  	join
  	endtask
endclass

class FDLB_0_and_FDLB_1_sequence_xtns_vseq extends virtual_seqs;
	`uvm_object_utils(FDLB_0_and_FDLB_1_sequence_xtns_vseq)
	
    	//FDLB_0_sequence_xtns FDLB_0_xtns;
    	//FDLB_1_sequence_xtns FDLB_1_xtns;
        
	function new(string name = "FDLB_0_and_FDLB_1_sequence_xtns_vseq");
		super.new(name);
  	endfunction
	
  	task body();
    		super.body();
    		
    		`uvm_info("FDLB_0_and_FDLB_1_sequence_xtns_vseq", $sformatf("get_full_name() = %s",get_full_name()), UVM_LOW)
    		FDLB_0_xtns = FDLB_0_sequence_xtns::type_id::create("FDLB_0_xtns");
    		FDLB_1_xtns = FDLB_1_sequence_xtns::type_id::create("FDLB_1_xtns");
        
		fork
	    		FDLB_0_xtns.start(seqrh[0]);
	    		FDLB_1_xtns.start(seqrh[1]);
		join
  	endtask
endclass

class FDLBM_0_and_FDLBM_1_sequence_xtns_vseq extends virtual_seqs;
	`uvm_object_utils(FDLBM_0_and_FDLBM_1_sequence_xtns_vseq)
	
	//FDLBM_0_sequence_xtns FDLBM_0_xtns;
	//FDLBM_1_sequence_xtns FDLBM_1_xtns;
        
	function new(string name = "FDLBM_0_and_FDLBM_1_sequence_xtns_vseq");
		super.new(name);
  	endfunction
	
  	task body();
    		super.body();
    		
    		`uvm_info("FDLBM_0_and_FDLBM_1_sequence_xtns_vseq", $sformatf("get_full_name() = %s",get_full_name()), UVM_LOW)
    		FDLBM_0_xtns = FDLBM_0_sequence_xtns::type_id::create("FDLBM_0_xtns");
    		FDLBM_1_xtns = FDLBM_1_sequence_xtns::type_id::create("FDLBM_1_xtns");
        
		fork
	    		FDLBM_0_xtns.start(seqrh[0]);
	    		FDLBM_1_xtns.start(seqrh[1]);
		join
  	endtask
endclass

class FDM_0_thr_empty_and_FDM_1_thr_empty_sequence_xtns_vseq extends virtual_seqs;
	`uvm_object_utils(FDM_0_thr_empty_and_FDM_1_thr_empty_sequence_xtns_vseq)
	
    //  FDM_0_thr_empty_sequence_xtns FDM_0_thr_empty_xtns;
    //	FDM_1_thr_empty_sequence_xtns FDM_1_thr_empty_xtns;
        
	function new(string name = "FDM_0_thr_empty_and_FDM_1_thr_empty_sequence_xtns_vseq");
		super.new(name);
  	endfunction
	
  	task body();
    		super.body();
    		
    		`uvm_info("FDM_0_thr_empty_and_FDM_1_thr_empty_sequence_xtns_vseq", $sformatf("get_full_name() = %s",get_full_name()), UVM_LOW)
    		FDM_0_thr_empty_xtns = FDM_0_thr_empty_sequence_xtns::type_id::create("FDM_0_thr_empty_xtns");
    		FDM_1_thr_empty_xtns = FDM_1_thr_empty_sequence_xtns::type_id::create("FDM_1_thr_empty_xtns");
	    	fork
	    		FDM_0_thr_empty_xtns.start(seqrh[0]);
	    		FDM_1_thr_empty_xtns.start(seqrh[1]);
	  	join
  	endtask
endclass

class FDM_EP_0_and_FDM_EP_1_sequence_xtns_vseq extends virtual_seqs;
	`uvm_object_utils(FDM_EP_0_and_FDM_EP_1_sequence_xtns_vseq)
	
    //  FDM_EP_0_sequence_xtns FDM_EP_0_xtns;
    //	FDM_EP_1_sequence_xtns FDM_EP_1_xtns;
        
	function new(string name = "FDM_EP_0_and_FDM_EP_1_sequence_xtns_vseq");
		super.new(name);
  	endfunction
	
  	task body();
    		super.body();
    		
    		`uvm_info("FDM_EP_0_and_FDM_EP_1_sequence_xtns_vseq", $sformatf("get_full_name() = %s",get_full_name()), UVM_LOW)
    		FDM_EP_0_xtns = FDM_EP_0_sequence_xtns::type_id::create("FDM_EP_0_xtns");
    		FDM_EP_1_xtns = FDM_EP_1_sequence_xtns::type_id::create("FDM_EP_1_xtns");
	    	fork
	    		FDM_EP_0_xtns.start(seqrh[0]);
	    		FDM_EP_1_xtns.start(seqrh[1]);
	  	join
  	endtask
endclass


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class FD_P_sequence_vseq extends virtual_seqs;
	`uvm_object_utils(FD_P_sequence_vseq)
	
      	FD_P_0_sequence_xtns FD_P_0_xtns;
    	FD_P_1_sequence_xtns FD_P_1_xtns;
        
	function new(string name = "FD_P_sequence_vseq");
		super.new(name);
  	endfunction
	
  	task body();
    		super.body();
    		
    		FD_P_0_xtns = FD_P_0_sequence_xtns::type_id::create("FD_P_0_xtns");
    		FD_P_1_xtns = FD_P_1_sequence_xtns::type_id::create("FD_P_1_xtns");
        
		fork
	    		FD_P_0_xtns.start(seqrh[0]);
	    		FD_P_1_xtns.start(seqrh[1]);
		join
  	endtask
endclass

class FD_BE_sequence_vseq extends virtual_seqs;
	`uvm_object_utils(FD_BE_sequence_vseq)
	
      	FD_BE_0_sequence_xtns FD_BE_0_xtns;
    	FD_BE_1_sequence_xtns FD_BE_1_xtns;
        
	function new(string name = "FD_BE_sequence_vseq");
		super.new(name);
  	endfunction
	
  	task body();
    		super.body();
    		
    		FD_BE_0_xtns = FD_BE_0_sequence_xtns::type_id::create("FD_BE_0_xtns");
    		FD_BE_1_xtns = FD_BE_1_sequence_xtns::type_id::create("FD_BE_1_xtns");
        
		fork
	    		FD_BE_0_xtns.start(seqrh[0]);
	    		FD_BE_1_xtns.start(seqrh[1]);
		join
  	endtask
endclass

class FD_ORE_sequence_vseq extends virtual_seqs;
	`uvm_object_utils(FD_ORE_sequence_vseq)
	
      	FD_ORE_0_sequence_xtns FD_ORE_0_xtns;
    	FD_ORE_1_sequence_xtns FD_ORE_1_xtns;
        
	function new(string name = "FD_ORE_sequence_vseq");
		super.new(name);
  	endfunction
	
  	task body();
    		super.body();
    		
    		FD_ORE_0_xtns = FD_ORE_0_sequence_xtns::type_id::create("FD_ORE_0_xtns");
    		FD_ORE_1_xtns = FD_ORE_1_sequence_xtns::type_id::create("FD_ORE_1_xtns");
        
		fork
	    		FD_ORE_0_xtns.start(seqrh[0]);
	    		FD_ORE_1_xtns.start(seqrh[1]);
		join
  	endtask
endclass

class FD_FE_sequence_vseq extends virtual_seqs;
	`uvm_object_utils(FD_FE_sequence_vseq)
	
      	FD_FE_0_sequence_xtns FD_FE_0_xtns;
    	FD_FE_1_sequence_xtns FD_FE_1_xtns;
        
	function new(string name = "FD_FE_sequence_vseq");
		super.new(name);
  	endfunction
	
  	task body();
    		super.body();
    		
    		FD_FE_0_xtns = FD_FE_0_sequence_xtns::type_id::create("FD_FE_0_xtns");
    		FD_FE_1_xtns = FD_FE_1_sequence_xtns::type_id::create("FD_FE_1_xtns");
        
		fork
	    		FD_FE_0_xtns.start(seqrh[0]);
	    		FD_FE_1_xtns.start(seqrh[1]);
		join
  	endtask
endclass

class FD_TOE_sequence_vseq extends virtual_seqs;
	`uvm_object_utils(FD_TOE_sequence_vseq)
	
      	FD_TOE_0_sequence_xtns FD_TOE_0_xtns;
    	FD_TOE_1_sequence_xtns FD_TOE_1_xtns;
        
	function new(string name = "FD_TOE_sequence_vseq");
		super.new(name);
  	endfunction
	
  	task body();
    		super.body();
    		
    		FD_TOE_0_xtns = FD_TOE_0_sequence_xtns::type_id::create("FD_TOE_0_xtns");
    		FD_TOE_1_xtns = FD_TOE_1_sequence_xtns::type_id::create("FD_TOE_1_xtns");
        
		fork
	    		FD_TOE_0_xtns.start(seqrh[0]);
	    		FD_TOE_1_xtns.start(seqrh[1]);
		join
  	endtask
endclass
