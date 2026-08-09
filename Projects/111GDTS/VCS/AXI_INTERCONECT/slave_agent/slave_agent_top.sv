class axi_slv_agt_top extends uvm_env;
	`uvm_component_utils(axi_slv_agt_top)

	// properties
	slave_agent agnth[];
	axi_env_config m_cfg;

	//Methods
	extern function new(string name ="axi_slv_agt_top", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void end_of_elaboration_phase(uvm_phase phase);
endclass

function axi_slv_agt_top :: new(string name="axi_slv_agt_top", uvm_component parent);
	super.new(name, parent);
endfunction

function void axi_slv_agt_top :: build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db #(axi_env_config)::get(this, "", "axi_env_config", m_cfg))
		`uvm_fatal("Slave_Agent_Top", "Cannot get m_cfg from uvm_config_db. Have you set it")

	agnth=new[m_cfg.no_of_slv_agt];
	foreach(agnth[i])
		begin
			uvm_config_db #(axi_slv_agt_cfg)::set(this, $sformatf("*agnth[%0d]*",i), "axi_slv_agt_cfg", m_cfg.slv_cfg[i]);
			agnth[i] = slave_agent :: type_id :: create($sformatf("agnth[%0d]", i), this);
		end	

endfunction

function void axi_slv_agt_top :: end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology();
endfunction
