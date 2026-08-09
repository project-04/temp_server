
class aux_agent extends uvm_agent;

aux_driver driver;
aux_monitor monitor;
aux_sequencer seqr;

aux_cfg m_cfg;

    `uvm_component_utils(aux_agent)	
	extern function new(string name = "aux_agent",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
endclass


function aux_agent::new(string name = "aux_agent",uvm_component parent);
	super.new(name,parent);
endfunction

function void aux_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);


if(!uvm_config_db #(aux_cfg)::get(this,"","aux_cfg",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")


monitor=aux_monitor::type_id::create("monitor",this);	
	if(m_cfg.is_active==UVM_ACTIVE)
		begin
			driver=aux_driver::type_id::create("drvh",this);
			seqr=aux_sequencer::type_id::create("seqrh",this);
		end


endfunction
 
function void aux_agent::connect_phase(uvm_phase phase);
	super.connect_phase(phase);

			driver.seq_item_port.connect(seqr.seq_item_export);

endfunction


