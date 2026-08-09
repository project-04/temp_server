
class ahb_agt extends uvm_agent;

ahb_drv driver;
ahb_mon monitor;
ahb_seqr seqr;

ahb_cfg m_cfg;

    `uvm_component_utils(ahb_agt)	
	extern function new(string name = "ahb_agt",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
//	extern task run_phase(uvm_phase phase);
endclass


function ahb_agt::new(string name = "ahb_agt",uvm_component parent);
	super.new(name,parent);
endfunction

function void ahb_agt::build_phase(uvm_phase phase);
	super.build_phase(phase);


if(!uvm_config_db #(ahb_cfg)::get(this,"","ahb_cfg",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")


monitor=ahb_mon::type_id::create("monitor",this);	
	if(m_cfg.is_active==UVM_ACTIVE)
		begin
			driver=ahb_drv::type_id::create("drvh",this);
			seqr=ahb_seqr::type_id::create("seqrh",this);
		end


endfunction
 
function void ahb_agt::connect_phase(uvm_phase phase);
	super.connect_phase(phase);

			driver.seq_item_port.connect(seqr.seq_item_export);

endfunction


