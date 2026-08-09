class axi_virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);
	`uvm_component_utils(axi_virtual_sequencer)

	// Properties
	axi_env_config m_cfg;
	
	axi_mast_sequencer mast_seqrh[];
	axi_slv_sequencer slv_seqrh[];

	// Methods
	extern function new(string name="axi_virtual_sequencer", uvm_component parent);
	extern function void build_phase(uvm_phase phase);

endclass

function axi_virtual_sequencer :: new(string name ="axi_virtual_sequencer", uvm_component parent);
	super.new(name, parent);
endfunction

function void axi_virtual_sequencer :: build_phase(uvm_phase phase);
	if(!uvm_config_db #(axi_env_config) :: get(this, "", "axi_env_config", m_cfg))
		`uvm_fatal("AXI_VIRTUAL_SEQUENCER", "Cannot get m_cfg from uvm_config_db. Have you set it?")

	mast_seqrh=new[m_cfg.no_of_mast_agt];
	slv_seqrh = new[m_cfg.no_of_slv_agt];

endfunction
