class apb_monitor extends uvm_monitor;
   `uvm_component_utils(apb_monitor)

   uvm_analysis_port #(apb_xtn) monitor_port;
   apb_agent_config apb_cfg;
   virtual apb_intf.APB_MON_MP apb_if;

   extern function new(string name="apb_monitor", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
   extern task collect_data();
   extern function void report_phase(uvm_phase phase);
 endclass

 function apb_monitor :: new(string name="apb_monitor", uvm_component parent);
   super.new(name, parent);
   monitor_port = new("monitor_port", this);
 endfunction

 function void apb_monitor :: build_phase(uvm_phase phase);
   super.build_phase(phase);
	
   if(!uvm_config_db #(apb_agent_config)::get(this, " ", "apb_agent_config", apb_cfg))
     `uvm_fatal(get_type_name(), "Cannot get apb_cfg from uvm_config_db. Have you set it?")
 endfunction

 function void apb_monitor:: connect_phase(uvm_phase phase);
   apb_if = apb_cfg.apb_if;
 endfunction

 task apb_monitor :: run_phase(uvm_phase phase);
   forever 
     begin
       collect_data();
     end
 endtask

 task apb_monitor :: collect_data();
 
   apb_xtn xtn;
   xtn = apb_xtn :: type_id :: create("xtn");
   
   wait(apb_if.apb_mon_cb.PENABLE && apb_if.apb_mon_cb.PREADY)
   
   xtn.PRESETn = apb_if.apb_mon_cb.PRESETn;
   xtn.PADDR = apb_if.apb_mon_cb.PADDR;
   xtn.PWRITE = apb_if.apb_mon_cb.PWRITE;
   xtn.PSEL = apb_if.apb_mon_cb.PSEL;
   xtn.PENABLE = apb_if.apb_mon_cb.PENABLE;

   if(apb_if.apb_mon_cb.PWRITE)
     xtn.PWDATA = apb_if.apb_mon_cb.PWDATA;
   else
     xtn.PRDATA = apb_if.apb_mon_cb.PRDATA;

   xtn.PREADY = apb_if.apb_mon_cb.PREADY;
   xtn.PSLVERR = apb_if.apb_mon_cb.PSLVERR;


   `uvm_info(get_type_name(), $sformatf("The Data Collected from APB Monitor is \n %s", xtn.sprint()), UVM_LOW)
 
  monitor_port.write(xtn);

   apb_cfg.apb_mon_rcvd_xtn_cnt++;

   @(apb_if.apb_mon_cb);


 endtask

 function void apb_monitor :: report_phase(uvm_phase phase);

   `uvm_info(get_type_name(), $sformatf("APB Monitor:Collected in the APB Monitor is : %0d", apb_cfg.apb_mon_rcvd_xtn_cnt), UVM_LOW)

 endfunction

