
class io_agent extends uvm_agent;

io_driver driver;
io_monitor monitor;
io_sequencer seqr;

io_cfg m_cfg;

    `uvm_component_utils(io_agent)	
	extern function new(string name = "io_agent",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
endclass


function io_agent::new(string name = "io_agent",uvm_component parent);
	super.new(name,parent);
endfunction

function void io_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);


if(!uvm_config_db #(io_cfg)::get(this,"","io_cfg",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")


monitor=io_monitor::type_id::create("monitor",this);	
	if(m_cfg.is_active==UVM_ACTIVE)
		begin
			driver=io_driver::type_id::create("drvh",this);
			seqr=io_sequencer::type_id::create("seqrh",this);
		end


endfunction
 
function void io_agent::connect_phase(uvm_phase phase);
	super.connect_phase(phase);

			driver.seq_item_port.connect(seqr.seq_item_export);

endfunction


//-----------------



