
class io_driver extends uvm_driver#(io_xtn);
virtual io_pad_if.IO_PAD_DRV_MP vif;
io_cfg m_cfg;

     `uvm_component_utils(io_driver)	
	extern function new(string name = "io_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass
function io_driver::new(string name = "io_driver",uvm_component parent);
	super.new(name,parent);
endfunction
function void io_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);

if(!uvm_config_db #(io_cfg)::get(this,"","io_cfg",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")


endfunction
 
function void io_driver::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
uvm_top.print_topology();
vif=m_cfg.vif;
endfunction

task io_driver::run_phase(uvm_phase phase);
super.run_phase(phase);
endtask


