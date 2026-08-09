class ahb_mon extends uvm_monitor;

 `uvm_component_utils(ahb_mon)

 virtual bridge_if.MMON_MP vif;
 ahb_agent_config hcfg;
 uvm_analysis_port#(ahb_xtn) monitor_port;

extern function new(string name = "ahb_mon", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase  phase);
extern task run_phase(uvm_phase phase);
extern task collect();
//extern function void report_phase(uvm_phase phase);
endclass

function ahb_mon::new(string name="ahb_mon",uvm_component parent);
super.new(name,parent);
monitor_port = new("monitor_port", this);
endfunction

function void ahb_mon::build_phase(uvm_phase phase);
super.build_phase(phase); 
if(!uvm_config_db #(ahb_agent_config)::get(this,"","ahb_agent_top",hcfg))
`uvm_fatal("ahb_mon", "cannot get config data")
endfunction

function void ahb_mon::connect_phase(uvm_phase phase);

vif= hcfg.vif;
endfunction

task ahb_mon::run_phase(uvm_phase phase);
forever
  collect();
 endtask

task ahb_mon::collect();

	ahb_xtn  xtn;
//	int mem[int];
	begin
	xtn = ahb_xtn::type_id::create("xtn");

	wait(vif.mmon_cb.Hreadyout && (vif.mmon_cb.Htrans==2 | vif.mmon_cb.Htrans==3 | vif.mmon_cb.Htrans==0))
		begin
			xtn.Haddr  = vif.mmon_cb.Haddr;
			xtn.Htrans = vif.mmon_cb.Htrans;
			xtn.Hburst = vif.mmon_cb.Hburst;
			xtn.Hsize  = vif.mmon_cb.Hsize;
			xtn.Hwrite = vif.mmon_cb.Hwrite;
			xtn.length = vif.mmon_cb.length;
			xtn.Hready_in = vif.mmon_cb.Hreadyin;
			xtn.Hready_out = vif.mmon_cb.Hreadyout;
			xtn.Hresp = vif.mmon_cb.Hresp;
			xtn.Hsel = vif.mmon_cb.Hsel;

			@(vif.mmon_cb);
			wait(vif.mmon_cb.Hreadyout)
				if(vif.mmon_cb.Hwrite)
					xtn.Hwdata = vif.mmon_cb.Hwdata;
			//	else
				   begin
			        	for(int i=0;i<xtn.length;i++)
					    begin	
							xtn.mem[xtn.Haddr[i]] = vif.mmon_cb.Hrdata;
//							$display("mem -----  %p",mem[xtn.Haddr[i]]);	
					     end
			           end

			monitor_port.write(xtn);
			`uvm_info(get_type_name(),$sformatf("Printing from ahb_mon %s",xtn.sprint),UVM_LOW)	

	end

	end
endtask

  


