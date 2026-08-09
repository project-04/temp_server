 class ahb_monitor extends uvm_monitor;
   `uvm_component_utils(ahb_monitor)

   ahb_agent_config ahb_cfg;
   virtual ahb_if.AHB_MON_MP vif;
   ahb_trans ahb_xtn;

   uvm_analysis_port#(ahb_trans) monitor_port;
 
   extern function new(string name = "ahb_monitor",uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
   extern task collect();
 endclass
 //--------------------------  new ------------------------------
 function ahb_monitor::new(string name = "ahb_monitor",uvm_component parent);
   super.new(name,parent);
   monitor_port=new("monitor_port",this);
 endfunction
 //------------------------ Build phase ---------------------------
 function void ahb_monitor::build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db #(ahb_agent_config)::get(this," ","ahb_agent_config",ahb_cfg))
     `uvm_fatal(get_type_name(),"configuration is not set properly for ahb monitor")

 endfunction
 //------------------------- connect phase -------------------------
 function void ahb_monitor::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   vif=ahb_cfg.vif;
 endfunction
 //--------------------------- Run phase --------------------------
 task ahb_monitor::run_phase(uvm_phase phase);
   forever
     collect();

   `uvm_info(get_type_name(),"ahb monitor run_phase",UVM_HIGH)
 endtask
 //-------------------------- collect ---------------------------
 task ahb_monitor::collect();
   ahb_xtn=ahb_trans::type_id::create("ahb_xtn",this);
   begin
     wait((vif.ahb_mon_cb.hready==1'b1) && (vif.ahb_mon_cb.htrans==2'b10) );
     ahb_xtn.haddr  = vif.ahb_mon_cb.haddr;
     ahb_xtn.htrans = vif.ahb_mon_cb.htrans;
     ahb_xtn.hburst = vif.ahb_mon_cb.hburst;
     ahb_xtn.hsize  = vif.ahb_mon_cb.hsize;  
     ahb_xtn.hwrite = vif.ahb_mon_cb.hwrite;
     ahb_xtn.hready = vif.ahb_mon_cb.hready;
     ahb_xtn.hresp  = vif.ahb_mon_cb.hresp;
     $display("hwrite =%b time=%t ",ahb_xtn.hwrite ,$time);
     if(vif.ahb_mon_cb.hwrite == 1'b1)        
       begin   
	 @(vif.ahb_mon_cb);   
         ahb_xtn.hwdata = vif.ahb_mon_cb.hwdata;
	 monitor_port.write(ahb_xtn);
       end
     else
       begin
	 @(vif.ahb_mon_cb);
	 $display(" hrdata time = %t",$time);
	 ahb_xtn.hrdata = vif.ahb_mon_cb.hrdata;
	 monitor_port.write(ahb_xtn);
	end
   end		
   `uvm_info(get_type_name(),$sformatf("ahb_trans: \n %p",ahb_xtn.sprint()),UVM_LOW)
 endtask
