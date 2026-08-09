
class ahb_mon extends uvm_monitor;

virtual ahb_if.SMON_MP vif;
ahb_cfg m_cfg;
uvm_analysis_port#(ahb_xtn) monitor_port;

     `uvm_component_utils(ahb_mon)	
	extern function new(string name = "ahb_mon",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function ahb_mon::new(string name = "ahb_mon",uvm_component parent);
	super.new(name,parent);
monitor_port=new("monitor_port",this);

endfunction
function void ahb_mon::build_phase(uvm_phase phase);
	super.build_phase(phase);

if(!uvm_config_db #(ahb_cfg)::get(this,"","ahb_cfg",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")



endfunction
  
function void ahb_mon::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
vif=m_cfg.vif;
endfunction


task ahb_mon::run_phase(uvm_phase phase);
super.run_phase(phase);
endtask


