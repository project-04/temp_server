class master_monitor extends uvm_monitor;

 `uvm_component_utils(master_monitor)

	virtual apb_if.MMON_MP vif;
	master_config cfg;

	uvm_analysis_port#(master_xtn) monitor_port;

extern function new(string name = "master_monitor", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase  phase);
extern task run_phase(uvm_phase phase);
extern task collect();
//extern function void report_phase(uvm_phase phase);
endclass

function master_monitor::new(string name="master_monitor",uvm_component parent);
super.new(name,parent);
monitor_port = new("monitor_port", this);
endfunction

function void master_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase); 
	if(!uvm_config_db #(master_config)::get(this,"","master_config",cfg))
	    `uvm_fatal("master_monitor", "cannot get config data")
endfunction

function void master_monitor::connect_phase(uvm_phase phase);

vif= cfg.vif;
endfunction

task master_monitor::run_phase(uvm_phase phase);
forever
  collect();
endtask

task master_monitor::collect();

	master_xtn  xtn;
	
	begin
	xtn = master_xtn::type_id::create("xtn");
	wait(vif.mmon_cb.pready)
		begin
			xtn.Paddr  = vif.mmon_cb.Paddr;
			xtn.Pwrite = vif.mmon_cb.Pwrite;

			//@(vif.mmon_cb);

	//wait(vif.mmon_cb.pready)
				if(xtn.Pwrite)
					xtn.Pwdata = vif.mmon_cb.Pwdata;
				else
					xtn.Prdata = vif.mmon_cb.Prdata;
		//	wcfg.mon_data_count++;	
			monitor_port.write(xtn);
		`uvm_info(get_type_name(),$sformatf("Printing from master_monitor %s \n",xtn.sprint()),UVM_LOW)	

			@(vif.mmon_cb);
	end
	end
	
endtask

/*function void master_monitor::report_phase(uvm_phase phase);

	`uvm_info(get_type_name(),$sformatf("Report:Monitor collected %0d transactions",wcfg.mon_data_count),UVM_LOW)

endfunction*/
  



