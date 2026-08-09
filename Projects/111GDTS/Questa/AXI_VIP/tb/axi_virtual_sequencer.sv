class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);

     master_sequencer mst_seqr_h[];
     slave_sequencer slv_seqr_h[];

     axi_env_config env_cfg_h;

     extern function new(string name="virtual_sequencer",uvm_component parent);
     extern function void build_phase(uvm_phase phase);
     `uvm_component_utils(virtual_sequencer)
endclass

    function virtual_sequencer::new(string name="virtual_sequencer",uvm_component parent);
          super.new(name,parent);
    endfunction


    function void virtual_sequencer::build_phase(uvm_phase phase);
        super.build_phase(phase);
      if(!uvm_config_db#(axi_env_config)::get(this,"","axi_env_config",env_cfg_h))
              `uvm_fatal("router_virtual_sequencer","unable to get router_env_config, have you set it?")
      super.build_phase(phase);
      mst_seqr_h=new[env_cfg_h.no_of_master];
      slv_seqr_h=new[env_cfg_h.no_of_slave];
    endfunction

