 class ahb_rst_monitor extends uvm_monitor;
   `uvm_component_utils(ahb_rst_monitor)

   ahb_rst_trans ahb_rst_xtn;
   ahb_rst_agent_config rst_cfg;
   ahb_rst_agent_config ahb_cfg;

   virtual ahb_rst_if.AHB_RST_MON_MP vif;
	
   uvm_analysis_port #(ahb_rst_trans) rst_monitor_port;

   extern function new(string name="ahb_rst_monitor", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
   extern task collect();
 endclass
 //----------------------- new ------------------
 function ahb_rst_monitor:: new(string name="ahb_rst_monitor",uvm_component parent);	
   super.new(name,parent);
   rst_monitor_port=new("rst_monitor_port",this);
 endfunction
 //---------------------- build phase --------------
 function void ahb_rst_monitor::build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db#(ahb_rst_agent_config)::get(this,"","ahb_rst_agent_config",rst_cfg))
     `uvm_fatal(get_type_name(),"configuration is not get properly in ahb monitor")
 endfunction
 //-------------------------- connect phase ------------------
 function void ahb_rst_monitor::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   vif=rst_cfg.vif;
 endfunction
 //--------------------------- run phase ------------------------
 task ahb_rst_monitor::run_phase(uvm_phase phase);
   forever
     collect();
   `uvm_info(get_type_name(),"ahb rst monitor run_phase",UVM_HIGH)
 endtask
 //------------------------- collect ----------------------------
 task ahb_rst_monitor::collect();
   ahb_rst_xtn=ahb_rst_trans::type_id::create("ahb_rst_xtn",this);
  
   wait(!vif.ahb_rst_mon_cb.hresetn);      	
   @(vif.ahb_rst_mon_cb); 


   ahb_rst_xtn.hresetn=vif.ahb_rst_mon_cb.hresetn;


   rst_monitor_port.write(ahb_rst_xtn);

 endtask
