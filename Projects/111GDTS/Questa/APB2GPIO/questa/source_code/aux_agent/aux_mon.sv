
class aux_monitor extends uvm_monitor;

virtual aux_input_if.AUX_INPUT_MON_MP vif;
aux_cfg m_cfg;
uvm_analysis_port#(aux_xtn) monitor_port;

     `uvm_component_utils(aux_monitor)	
	extern function new(string name = "aux_monitor",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_data();
endclass

function aux_monitor::new(string name = "aux_monitor",uvm_component parent);
	super.new(name,parent);
	monitor_port=new("monitor_port",this);

endfunction
function void aux_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);

if(!uvm_config_db #(aux_cfg)::get(this,"","aux_cfg",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")



endfunction
  
function void aux_monitor::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
vif=m_cfg.vif;
endfunction


task aux_monitor::run_phase(uvm_phase phase);
	
	forever
		collect_data();
endtask

task aux_monitor::collect_data();

     aux_xtn xtn;
     xtn = aux_xtn::type_id::create("xtn");

	@(vif.aux_input_mon_cb);
	xtn.aux_in = vif.aux_input_mon_cb.aux_in;

	if(xtn.aux_in!=0)
	monitor_port.write(xtn);
//	`uvm_info("aux_moniter",$sformatf("Printing from AUX_IN Monitor class %s \n",xtn.sprint),UVM_LOW)
	@(vif.aux_input_mon_cb);
endtask


