class virtual_seqr extends uvm_sequencer #(uvm_sequence_item) ;
   
    // Factory Registration
	`uvm_component_utils(virtual_seqr)

    // Declare handles for sequencers
	uart_seqr uart_seqrh[];
	apb_seqr apb_seqrh[];
        
	env_config env_cfg;

    // Define Constructor new() function
	function new(string name="virtual_seqr",uvm_component parent);
	         super.new(name,parent);
	endfunction

        function void build_phase(uvm_phase phase);
                      	if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg)) //Here we are getting to find the no of agents. 
		      		`uvm_fatal("CONFIG","cannot get() env_cfg from uvm_config_db. Have you set() it?")

                      	apb_seqrh=new[env_cfg.no_of_apb_agents];
			uart_seqrh=new[env_cfg.no_of_uart_agents];
	endfunction
          
endclass


