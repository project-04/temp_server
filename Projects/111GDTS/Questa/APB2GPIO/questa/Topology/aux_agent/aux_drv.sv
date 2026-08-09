
class aux_driver extends uvm_driver#(aux_xtn);
virtual aux_input_if.AUX_INPUT_DRV_MP vif;
aux_cfg m_cfg;

     `uvm_component_utils(aux_driver)	
	extern function new(string name = "aux_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass
function aux_driver::new(string name = "aux_driver",uvm_component parent);
	super.new(name,parent);
endfunction
function void aux_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);

if(!uvm_config_db #(aux_cfg)::get(this,"","aux_cfg",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")


endfunction
 
function void aux_driver::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
vif=m_cfg.vif;
endfunction

task aux_driver::run_phase(uvm_phase phase);
super.run_phase(phase);
endtask

