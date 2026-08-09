
class apb_driver extends uvm_driver#(apb_xtn);
virtual apb_if.APB_DRV_MP vif;
apb_cfg m_cfg;

     `uvm_component_utils(apb_driver)	
	extern function new(string name = "apb_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass
function apb_driver::new(string name = "apb_driver",uvm_component parent);
	super.new(name,parent);
endfunction
function void apb_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);

if(!uvm_config_db #(apb_cfg)::get(this,"","apb_cfg",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")


endfunction
 
function void apb_driver::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
vif=m_cfg.vif;
endfunction

task apb_driver::run_phase(uvm_phase phase);
super.run_phase(phase);
endtask

