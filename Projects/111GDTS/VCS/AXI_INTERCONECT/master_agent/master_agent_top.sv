class axi_mast_agt_top extends uvm_env;
	`uvm_component_utils(axi_mast_agt_top)

	// properties
	master_agent agnth[];
	axi_env_config m_cfg;

	//Methods
	extern function new(string name ="axi_mast_agt_top", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
endclass

function axi_mast_agt_top :: new(string name="axi_mast_agt_top", uvm_component parent);
	super.new(name, parent);
endfunction

function void axi_mast_agt_top :: build_phase(uvm_phase phase);
	super.build_phase(phase);	

	if(!uvm_config_db #(axi_env_config)::get(this, "", "axi_env_config", m_cfg))
		`uvm_fatal("Master_Agent_Top", "Cannot get m_cfg from uvm_config_db. Have you set it?")

	agnth = new[m_cfg.no_of_mast_agt];
	
	foreach(agnth[i])
		begin
			uvm_config_db #(axi_mast_agt_cfg) :: set(this, $sformatf("*agnth[%0d]*", i), "axi_mast_agt_cfg", m_cfg.mast_cfg[i]);
			agnth[i] = master_agent :: type_id :: create($sformatf("agnth[%0d]", i), this);

		end
endfunction
