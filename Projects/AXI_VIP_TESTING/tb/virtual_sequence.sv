//***************************************************************//Base virtual sequence
class virtual_seq extends uvm_sequence #(uvm_sequence_item);
 	`uvm_object_utils(virtual_seq)

	master_seqr master_seqrh[];
	slave_seqr  slave_seqrh[];
	virtual_seqr virtual_seqrh;

	env_config env_cfg;

	function new(string name ="virtual_seq");
		super.new(name);
	endfunction
        
        task body();
                if(!$cast(virtual_seqrh,m_sequencer))
          		`uvm_error("BODY", "Error in $cast of virtual sequencer")

                if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",env_cfg))
			`uvm_fatal("CONFIG","cannot get() env_cfg from uvm_config_db. Have you set() it?")

                master_seqrh = new[env_cfg.no_of_master_agents];
		slave_seqrh  = new[env_cfg.no_of_slave_agents];

		foreach(master_seqrh[i])
                	master_seqrh[i] = virtual_seqrh.master_seqrh[i];

		foreach(slave_seqrh[i])
                	slave_seqrh[i] = virtual_seqrh.slave_seqrh[i];
        endtask
endclass
