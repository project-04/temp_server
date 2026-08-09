class master_agent extends uvm_agent;
	`uvm_component_utils(master_agent)

	// Properties
	axi_mast_agt_cfg m_mast_cfg;

	master_driver drvh;
	master_monitor monh;
	axi_mast_sequencer seqrh;

	//methods
	extern function new(string name="master_agent", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

endclass

function master_agent :: new(string name="master_agent", uvm_component parent);
	super.new(name, parent);
endfunction

function void master_agent :: build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db #(axi_mast_agt_cfg)::get(this, "", "axi_mast_agt_cfg", m_mast_cfg))
		`uvm_fatal("AXI_MASTER_AGENT", "Cannot m_mast_cfg from uvm_config_db. Have you set it?")

	monh = master_monitor::type_id::create("monh", this);
	if(m_mast_cfg.is_active == UVM_ACTIVE)
		begin
                  	seqrh = axi_mast_sequencer::type_id::create("seqrh", this);
			drvh = master_driver :: type_id :: create("drvh", this);
		end
endfunction

function void master_agent ::connect_phase(uvm_phase phase);
	if(m_mast_cfg.is_active == UVM_ACTIVE)
		drvh.seq_item_port.connect(seqrh.seq_item_export);
endfunction
