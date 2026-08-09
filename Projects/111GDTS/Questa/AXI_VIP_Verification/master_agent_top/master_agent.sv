class master_agent extends uvm_agent;
    
	`uvm_component_utils(master_agent)

    extern function new(string name="master_agent",uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);

    master_driver mst_drv_h;
    master_monitor mst_mon_h;
    master_sequencer mst_seqr_h;
    master_config mst_cfg_h;
 endclass



     function master_agent::new(string name ="master_agent", uvm_component parent);
         super.new(name,parent);
     endfunction


     function void master_agent::build_phase(uvm_phase phase);
	 
         if(!uvm_config_db #(master_config)::get(this," ","master_config",mst_cfg_h))
             `uvm_fatal("master_agent","no response from config, have you set it in env")

         mst_mon_h=master_monitor::type_id::create("mst_mon_h",this);
        
		 if(mst_cfg_h.is_active==UVM_ACTIVE)
             begin
                 mst_drv_h=master_driver::type_id::create("mst_drv_h",this);
                 mst_seqr_h=master_sequencer::type_id::create("mst_seqr_h",this);
             end
			 
         super.build_phase(phase);
    endfunction

    function void master_agent::connect_phase(uvm_phase phase);
        if(mst_cfg_h.is_active==UVM_ACTIVE)
            begin
                mst_drv_h.seq_item_port.connect(mst_seqr_h.seq_item_export);
            end
        super.connect_phase(phase);
    endfunction

