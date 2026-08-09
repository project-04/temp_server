
class io_monitor extends uvm_monitor;

virtual io_pad_if.IO_PAD_MON_MP vif;
io_cfg m_cfg;
uvm_analysis_port#(io_xtn) monitor_port;

     `uvm_component_utils(io_monitor)	
	extern function new(string name = "io_monitor",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function io_monitor::new(string name = "io_monitor",uvm_component parent);
	super.new(name,parent);
	monitor_port=new("monitor_port",this);

endfunction
function void io_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);

if(!uvm_config_db #(io_cfg)::get(this,"","io_cfg",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")



endfunction
  
function void io_monitor::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
vif=m_cfg.vif;
endfunction


task io_monitor::run_phase(uvm_phase phase);
super.run_phase(phase);
endtask


