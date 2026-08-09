class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);

        `uvm_component_utils(virtual_sequencer)

        master_seqr mst_seqrh[];
        slave_seqr slv_seqrh[];
        env_config e_cfg;

        extern function new(string name="virtual_sequencer",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
endclass

function virtual_sequencer::new(string name="virtual_sequencer",uvm_component parent);
        super.new(name,parent);
endfunction

function void virtual_sequencer::build_phase(uvm_phase phase);

        if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
        `uvm_fatal("VIRTUAL_SEQUENCER","cannot get config data. Have you set it?")

        mst_seqrh=new[e_cfg.no_of_master_agent];
        slv_seqrh=new[e_cfg.no_of_slave_agent];

endfunction




