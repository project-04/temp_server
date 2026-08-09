 class ahb_driver extends uvm_driver#(ahb_trans);
   `uvm_component_utils(ahb_driver)
	
   ahb_trans ahb_xtn;
   ahb_agent_config ahb_cfg;
   ahb_rst_agent_config ahb_rst_cfg;
   environment_config env_cfg;

   virtual ahb_if.AHB_DRV_MP vif;
   virtual ahb_rst_if.AHB_RST_MON_MP r_vif;

   extern function new(string name = "ahb_driver",uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
   extern task send_to_dut(ahb_trans xtn); 
 endclass
 //-------------------------------new----------------------------------- 
 function ahb_driver::new(string name = "ahb_driver",uvm_component parent);
   super.new(name,parent);
 endfunction
 //------------------------------Build phase-----------------------------
 function void ahb_driver :: build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db #(ahb_agent_config)::get(this," ","ahb_agent_config",ahb_cfg))
     `uvm_fatal(get_type_name(),"configuration is not set properly for ahb driver")

   if(!uvm_config_db #(ahb_rst_agent_config)::get(this," ","ahb_rst_agent_config",ahb_rst_cfg))
     `uvm_fatal(get_type_name(),"configuration is not set properly for ahb driver")

   if(!uvm_config_db #(environment_config)::get(this," ","environment_config",env_cfg))
     `uvm_fatal(get_type_name(),"configuration is not set properly for ahb driver")

 endfunction
 //---------------------------connect phase------------------------------
 function void ahb_driver::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   vif=ahb_cfg.vif;
   r_vif=ahb_rst_cfg.vif;
 endfunction
 //----------------------------Run phase--------------------------------------
 task ahb_driver::run_phase(uvm_phase phase);
   forever
     begin
       seq_item_port.get_next_item(req);
       `uvm_info(get_type_name(),$sformatf("in ahb driver %d",req.resp),UVM_HIGH) 
       send_to_dut(req);
       seq_item_port.item_done();			
     end
 endtask
 //----------------------------- send to dut ---------------------------------
 task ahb_driver::send_to_dut(ahb_trans xtn);
   
vif.ahb_drv_cb.hmaster<=4'b0;
   if(xtn.resp==0)
     begin
       if(vif.ahb_drv_cb.hwrite==1'b1)
	 begin
	   vif.ahb_drv_cb.hready<=1'b1;
	   vif.ahb_drv_cb.hresp<=2'b0;
	   @(vif.ahb_drv_cb);
	 end
       else if(vif.ahb_drv_cb.hwrite==1'b0)
	 begin
	   vif.ahb_drv_cb.hready<=1'b1;
	   vif.ahb_drv_cb.hresp<=2'b0;
	   vif.ahb_drv_cb.hrdata<=xtn.hrdata;
	   @(vif.ahb_drv_cb);
	 end
     end
   else if(xtn.resp==1)
     begin
       if(vif.ahb_drv_cb.hwrite==1'b1)
         begin
	   vif.ahb_drv_cb.hready<=1'b0;
	   repeat(xtn.delay_cycles)
	     @(vif.ahb_drv_cb);
	   @(vif.ahb_drv_cb);
           vif.ahb_drv_cb.hready<=1'b1;
           vif.ahb_drv_cb.hresp<=2'b0;
	   @(vif.ahb_drv_cb);
           @(vif.ahb_drv_cb);
	   vif.ahb_drv_cb.hready<=1'b0;
         end
       else if(vif.ahb_drv_cb.hwrite==1'b0)
         begin
           vif.ahb_drv_cb.hready<=1'b0;
	   repeat(xtn.delay_cycles)
	     @(vif.ahb_drv_cb);
           vif.ahb_drv_cb.hready<=1'b1;
           vif.ahb_drv_cb.hresp<=2'b0;
           vif.ahb_drv_cb.hrdata<=xtn.hrdata;
           @(vif.ahb_drv_cb);
	   @(vif.ahb_drv_cb);
           vif.ahb_drv_cb.hready<=1'b0;
         end
     end
   else if(xtn.resp==2)
     begin
       if(vif.ahb_drv_cb.hwrite==1'b1)
         begin
           @(vif.ahb_drv_cb);
	   if(vif.ahb_drv_cb.htrans==(2'b10))
             begin
               vif.ahb_drv_cb.hready<=1'b0;
               vif.ahb_drv_cb.hresp<=2'b01;
               @(vif.ahb_drv_cb);
               vif.ahb_drv_cb.hready<=1'b1;
               vif.ahb_drv_cb.hresp<=2'b01;
	       @(vif.ahb_drv_cb);
	       vif.ahb_drv_cb.hready<=1'b0;
             end
	   else
             begin
               @(vif.ahb_drv_cb);
	       @(vif.ahb_drv_cb);
               vif.ahb_drv_cb.hready<=1'b1;
               vif.ahb_drv_cb.hresp<=2'b0;
	       @(vif.ahb_drv_cb);
               vif.ahb_drv_cb.hready<=1'b0;
             end
	 end
       else if(vif.ahb_drv_cb.hwrite==1'b0)
         begin
           @(vif.ahb_drv_cb);
           if(vif.ahb_drv_cb.htrans==(2'b10))
             begin
               vif.ahb_drv_cb.hready<=1'b0;
               vif.ahb_drv_cb.hresp<=2'b01;
               @(vif.ahb_drv_cb);
               vif.ahb_drv_cb.hready<=1'b1;
               vif.ahb_drv_cb.hresp<=2'b01;
	       @(vif.ahb_drv_cb);
	       vif.ahb_drv_cb.hready<=1'b0;
             end
           else
             begin
               @(vif.ahb_drv_cb);
	       @(vif.ahb_drv_cb);
               vif.ahb_drv_cb.hready<=1'b1;
               vif.ahb_drv_cb.hresp<=2'b0;
               @(vif.ahb_drv_cb);
	       @(vif.ahb_drv_cb);
               vif.ahb_drv_cb.hready<=1'b0;
             end
         end
     end
 endtask
