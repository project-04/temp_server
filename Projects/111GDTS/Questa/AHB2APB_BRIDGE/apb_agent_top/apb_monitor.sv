class apb_monitor extends uvm_monitor;

 `uvm_component_utils(apb_monitor)

	apb_agent_config cfg_h1;
	apb_xtn xtn;
	uvm_analysis_port#(apb_xtn) monitor_port;
	virtual bridge_if.SMON_MP vif1;

	extern function new(string name = "apb_monitor", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_data();
//      extern function void report_phase(uvm_phase phase);
endclass


function apb_monitor::new(string name = "apb_monitor", uvm_component parent);
    super.new(name,parent);
    monitor_port =new("monitor_port",this);
endfunction

function void apb_monitor::build_phase(uvm_phase phase);
//Get configuration object from AHB agent
	if(!uvm_config_db#(apb_agent_config)::get(this,"","apb_agent_config",cfg_h1))
	`uvm_fatal("APB_MONITOR","cannot get vif1 from APB agent")
	super.build_phase(phase);
endfunction

function void apb_monitor::connect_phase(uvm_phase phase);
	vif1=cfg_h1.vif1;
endfunction

task apb_monitor::run_phase(uvm_phase phase);
          `uvm_info("APB_MONITOR","THIS IS APB MONITOR IN RUN",UVM_LOW)
          
        forever
        collect_data();
endtask

task apb_monitor::collect_data();

	apb_xtn xtn;
	xtn = apb_xtn::type_id::create("xtn");

	@(vif1.smon_cb);	
	wait(vif1.smon_cb.Penable);
	xtn.Penable = vif1.smon_cb.Penable;
	xtn.Paddr  = vif1.smon_cb.Paddr;
	xtn.Pselx = vif1.smon_cb.Pselx;
	xtn.Pwrite = vif1.smon_cb.Pwrite;
	
	if(vif1.smon_cb.Pwrite)
		xtn.Pwdata = vif1.smon_cb.Pwdata;
		
	else
		xtn.Prdata = vif1.smon_cb.Prdata;
	
//	apb__cfg.mon_data_count++;
  	`uvm_info("APB_MONITOR",$sformatf("Printing from apb_monitor /n %p",xtn.sprint()),UVM_LOW)
	monitor_port.write(xtn);

	@(vif1.smon_cb);
	
	
endtask

	
/*function void apb_monitor::report_phase(uvm_phase phase);

	`uvm_info(get_type_name(),$sformatf("Report:Monitor collected %0d transaction"apb_cfg.mon_data_count),UVM_LOW)

endfunction */


