      class axi_env extends uvm_env;
	`uvm_component_utils(axi_env)

	// Properties
	axi_mast_agt_top mast_agt_top;
	axi_slv_agt_top slv_agt_top;
	axi_virtual_sequencer v_seqrh;
	axi_scoreboard sb_h;
	axi_env_config m_cfg;

	// Methods
	extern function new(string name="axi_env", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
  
endclass

function axi_env :: new(string name ="axi_env", uvm_component parent);
	super.new(name, parent);
endfunction

function void axi_env :: build_phase(uvm_phase phase);
	if(!uvm_config_db #(axi_env_config) :: get(this, "", "axi_env_config", m_cfg))
		`uvm_fatal("AXI_ENVIRONMENT", "Cannot get m_cfg from uvm_config_db. Have you set it?")

	if(m_cfg.has_mast_agt)
		mast_agt_top = axi_mast_agt_top :: type_id :: create("mast_agt_top", this);

		
	if(m_cfg.has_slv_agt)
		slv_agt_top = axi_slv_agt_top :: type_id :: create("slv_agt_top", this);

	if(m_cfg.has_virtual_sequencer)
		v_seqrh = axi_virtual_sequencer :: type_id :: create("v_seqrh", this);

	if(m_cfg.has_scoreboard)
		sb_h = axi_scoreboard :: type_id :: create("sb_h", this);

	super.build_phase(phase);

endfunction 

function void axi_env :: connect_phase(uvm_phase phase);
	if(m_cfg.has_virtual_sequencer)
		begin
			if(m_cfg.has_mast_agt)
				for(int i=0; i<m_cfg.no_of_mast_agt; i++)
					v_seqrh.mast_seqrh[i]=mast_agt_top.agnth[i].seqrh;

			if(m_cfg.has_slv_agt)
				for(int i=0; i<m_cfg.no_of_slv_agt; i++)
					v_seqrh.slv_seqrh[i]=slv_agt_top.agnth[i].seqrh;
		end

	if(m_cfg.has_scoreboard)
		begin
			for(int i=0; i<m_cfg.no_of_mast_agt; i++)
				mast_agt_top.agnth[i].monh.monitor_port.connect(sb_h.fifo_mast[i].analysis_export);

		
			for(int i=0; i<m_cfg.no_of_slv_agt; i++)
				slv_agt_top.agnth[i].monh.monitor_port.connect(sb_h.fifo_slv[i].analysis_export);


		
		end
endfunction
 
