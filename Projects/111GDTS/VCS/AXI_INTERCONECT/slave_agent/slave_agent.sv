class slave_agent extends uvm_agent;
	`uvm_component_utils(slave_agent)

	// Properties
	axi_slv_agt_cfg m_slv_cfg;

	slave_driver drvh;
	slave_monitor monh;
	axi_slv_sequencer seqrh;

	//methods
	extern function new(string name="slave_agent", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

endclass

function slave_agent :: new(string name="slave_agent", uvm_component parent);
	super.new(name, parent);
endfunction

function void slave_agent :: build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db #(axi_slv_agt_cfg)::get(this, "", "axi_slv_agt_cfg", m_slv_cfg))
		`uvm_fatal("AXI_SLAVE_AGENT", "Cannot m_slv_cfg from uvm_config_db. Have you set it?")

	monh = slave_monitor::type_id::create("monh", this);
	if(m_slv_cfg.is_active == UVM_ACTIVE)
		begin
                      seqrh = axi_slv_sequencer::type_id::create("seqrh", this);
			drvh = slave_driver :: type_id :: create("drvh", this);
		end
endfunction

function void slave_agent ::connect_phase(uvm_phase phase);
	if(m_slv_cfg.is_active == UVM_ACTIVE)
		drvh.seq_item_port.connect(seqrh.seq_item_export);
endfunction
