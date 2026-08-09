class apb_agent extends uvm_agent;

apb_driver driver;
apb_monitor monitor;
apb_sequencer seqr;

apb_cfg m_cfg;

    `uvm_component_utils(apb_agent)	
	extern function new(string name = "apb_agent",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
endclass


function apb_agent::new(string name = "apb_agent",uvm_component parent);
	super.new(name,parent);
endfunction

function void apb_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);


if(!uvm_config_db #(apb_cfg)::get(this,"","apb_cfg",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")


monitor=apb_monitor::type_id::create("monitor",this);	
	if(m_cfg.is_active==UVM_ACTIVE)
		begin
			driver=apb_driver::type_id::create("drvh",this);
			seqr=apb_sequencer::type_id::create("seqrh",this);
		end


endfunction
 
function void apb_agent::connect_phase(uvm_phase phase);
	super.connect_phase(phase);

			driver.seq_item_port.connect(seqr.seq_item_export);

endfunction

