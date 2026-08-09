
class apb_monitor extends uvm_monitor;

virtual apb_if.APB_MON_MP vif;
apb_cfg m_cfg;
uvm_analysis_port#(apb_xtn) monitor_port;

     `uvm_component_utils(apb_monitor)	
	extern function new(string name = "apb_monitor",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function apb_monitor::new(string name = "apb_monitor",uvm_component parent);
	super.new(name,parent);
	monitor_port=new("monitor_port",this);

endfunction
function void apb_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);

if(!uvm_config_db #(apb_cfg)::get(this,"","apb_cfg",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")



endfunction
  
function void apb_monitor::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
vif=m_cfg.vif;
endfunction


task apb_monitor::run_phase(uvm_phase phase);
super.run_phase(phase);
endtask

