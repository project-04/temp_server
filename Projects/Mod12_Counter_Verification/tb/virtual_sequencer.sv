class virtual_sequencer extends uvm_sequencer#(uvm_sequence_item) ;
	`uvm_component_utils(virtual_sequencer)
   	
   	env_config env_configh;
   	wr_sequencer seqrh[]; //sequencer seqrh[0], seqrh[1];

	function new(string name="virtual_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction
 
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	  	if(!uvm_config_db #(env_config)::get(this,"","env_config",env_configh))
			`uvm_fatal("virtual_sequencer","cannot get() env_configh from uvm_config_db. Have you set() it?")
   
		seqrh = new[env_configh.no_of_agents]; //sequencer seqrh[0], seqrh[1];
	endfunction
endclass
