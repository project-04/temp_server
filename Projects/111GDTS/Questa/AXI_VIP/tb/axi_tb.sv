class axi_env extends uvm_env;

    axi_env_config env_cfg_h;
    master_agent_top mst_agt_top;  
    slave_agent_top slv_agt_top;
    virtual_sequencer vseqr_h;
    scoreboard sb;

    extern function new(string name="axi_env",uvm_component parent);
 extern function void build_phase(uvm_phase phase); 
extern function void connect_phase(uvm_phase phase);
	
    `uvm_component_utils(axi_env) endclass

    function axi_env::new(string name="axi_env",uvm_component parent);
super.new(name,parent); endfunction

    function void axi_env::build_phase(uvm_phase phase);
if(!uvm_config_db#(axi_env_config)::get(this,"","axi_env_config",env_cfg_h))
`uvm_fatal("AXI Env","Unable to get axi env config, have you set it in test?")
    
	if(env_cfg_h.has_master_agent) begin
                uvm_config_db#(master_config)::set(this,"mst_agt_top*","master_config",env_cfg_h.mst_cfg_h);
                mst_agt_top=master_agent_top::type_id::create("mst_agt_top",this);
	    end

        if(env_cfg_h.has_slave_agent)
            begin
                uvm_config_db#(slave_config)::set(this,"slv_agt_top*","slave_config",env_cfg_h.slv_cfg_h);
                slv_agt_top=slave_agent_top::type_id::create("slv_agt_top",this);
            end

        if(env_cfg_h.has_virtual_sequencer)
            begin
            vseqr_h=virtual_sequencer::type_id::create("vseqr_h",this);
            end
        if(env_cfg_h.has_scoreboard)
            sb=scoreboard::type_id::create("sb",this);

        super.build_phase(phase);

    endfunction

    function void axi_env::connect_phase(uvm_phase phase);
        
	if(env_cfg_h.has_virtual_sequencer)
            begin
                if(env_cfg_h.has_master_agent)
                    begin
                        foreach(mst_agt_top.mst_agt_h[i])
                            vseqr_h.mst_seqr_h[i]=mst_agt_top.mst_agt_h[i].mst_seqr_h;
                    end

                if(env_cfg_h.has_slave_agent)
                    begin
                        foreach(slv_agt_top.slv_agt_h[i])
                            vseqr_h.slv_seqr_h[i]=slv_agt_top.slv_agt_h[i].slv_seqr_h;
                    end				   					
            end
			
        if(env_cfg_h.has_scoreboard)
            begin
                foreach(mst_agt_top.mst_agt_h[i])
                    mst_agt_top.mst_agt_h[i].mst_mon_h.mst_mon_port.connect(sb.mst_fifo_h[i].analysis_export);
                foreach(slv_agt_top.slv_agt_h[i])
                    slv_agt_top.slv_agt_h[i].slv_mon_h.slv_mon_port.connect(sb.slv_fifo_h[i].analysis_export);
            end   
     endfunction

