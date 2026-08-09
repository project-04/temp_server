class v_sequencer extends uvm_sequencer;
	`uvm_component_utils(v_sequencer)

		src_seqr src_seqrh;
		dest_seqr dest_seqrh[];
		env_config env_cfg;

	function new(string name = "v_sequencer",uvm_component parent = null);
		super.new(name,parent);
	endfunction 
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env_cfg = env_config::type_id::create("env_cfg");
		if(!uvm_config_db #(env_config)::get(this,"","env_cfg",env_cfg))
				`uvm_info("V_sequencer","not able to get",UVM_LOW)
		
		dest_seqrh = new[env_cfg.no_of_dest_agt]; // dynamic array allocation for every seqencer is created
		
			
		
	endfunction
	
endclass
