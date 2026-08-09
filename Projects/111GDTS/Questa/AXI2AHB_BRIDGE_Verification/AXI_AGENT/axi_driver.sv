 class axi_driver extends uvm_driver#(axi_trans);
   `uvm_component_utils(axi_driver)

   axi_trans axi_xtn;
   axi_trans q1[$],q2[$],q3[$],q4[$],q5[$];
   //write channels semaphore
   semaphore sem1=new(); //created semaphore with zero key
   semaphore sem2=new();
   semaphore sem3=new(1);	//created semaphore with one key
   semaphore sem4=new(1);
   semaphore sem5=new(1);
   //read channels seamphore
   semaphore sem6=new();
   semaphore sem7=new(1);
   semaphore sem8=new(1);

   axi_agent_config axi_cfg;
   axi_rst_agent_config axi_rst_cfg;

   virtual axi_if.AXI_DRV_MP vif;
   virtual axi_rst_if.AXI_RST_MON_MP r_vif;

   extern function new(string name="axi_driver",uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
   extern task send_to_dut(axi_trans xtn);
 
   extern task write_address_channel(axi_trans xtn);
   extern task write_data_channel(axi_trans xtn);
   extern task write_response_channel(axi_trans xtn);

   extern task read_address_channel(axi_trans xtn);
   extern task read_data_channel(axi_trans xtn);
 endclass
 //------------------------- new ------------------------
 function axi_driver::new(string name="axi_driver",uvm_component parent);
   super.new(name,parent);
 endfunction
 //------------------------ build phase ------------------
 function void axi_driver::build_phase(uvm_phase phase);	
   super.build_phase(phase);
   if(!uvm_config_db#(axi_agent_config)::get(this,"","axi_agent_config",axi_cfg))
     `uvm_fatal(get_type_name(),"configuration is not get properly in axi driver")
 
  if(!uvm_config_db#(axi_rst_agent_config)::get(this,"","axi_rst_agent_config",axi_rst_cfg))
     `uvm_fatal(get_type_name(),"configuration is not get properly in axi driver")
 endfunction
 //----------------------- connect phase ------------------
 function void axi_driver::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   vif = axi_cfg.vif;
   r_vif=axi_rst_cfg.vif;
 endfunction
 //----------------------- run phase --------------------
 task axi_driver::run_phase(uvm_phase phase);
   forever  
     begin
       seq_item_port.get_next_item(req);
       send_to_dut(req);
       `uvm_info(get_type_name(),$sformatf("axi_trans :\n %p",req.sprint()),UVM_LOW)
       seq_item_port.item_done();
     end
   `uvm_info(get_type_name(),"axi driver run_phase",UVM_HIGH)
 endtask
 //---------------------- send to dut -------------------
 task axi_driver::send_to_dut(axi_trans xtn);	
   q1.push_back(xtn);
   q2.push_back(xtn);
   q3.push_back(xtn);
   q4.push_back(xtn);
   q5.push_back(xtn);	
   fork 
     begin
       sem3.get(1);
       write_address_channel(q1.pop_front());
       sem1.put(1);	
       sem3.put(1);
     end
     begin
       sem4.get(1);
       sem1.get(1);
       write_data_channel(q2.pop_front());
       sem2.put(1);	
       sem4.put(1);
     end
     begin
       sem5.get(1);
       sem2.get(1);
       write_response_channel(q3.pop_front());
       sem5.put(1);
           end
     begin
       sem7.get(1);
       read_address_channel(q4.pop_front());
       sem6.put(1);	
       sem7.put(1);
     end
     begin
       sem8.get(1);
       sem6.get(1);
       read_data_channel(q5.pop_front());		
       sem8.put(1);
     end
   join_any	
 endtask	
 //------------------- write address channel ----------------------
 task axi_driver::write_address_channel(axi_trans xtn);
   @(vif.axi_drv_cb);
   begin	
     vif.axi_drv_cb.awvalid<=xtn.AWVALID;		
//    vif.axi_drv_cb.aresetn<=xtn.aresetn;
     vif.axi_drv_cb.awid<=xtn.AWID;
     vif.axi_drv_cb.awaddr<=xtn.AWADDR;
     vif.axi_drv_cb.awlen<=xtn.AWLEN;
     vif.axi_drv_cb.awsize<=xtn.AWSIZE;
     vif.axi_drv_cb.awburst<=xtn.AWBURST;	
     wait(vif.axi_drv_cb.awready)
     @(vif.axi_drv_cb);
     vif.axi_drv_cb.awvalid<=1'b0;
     repeat(xtn.delay_cycles) 
       @(vif.axi_drv_cb);
   end
 endtask
 //---------------- write data channel ----------------------
 task axi_driver::write_data_channel(axi_trans xtn);
   begin		
     foreach(xtn.WDATA[i])
       begin
	 vif.axi_drv_cb.wvalid<=xtn.WVALID;
	 vif.axi_drv_cb.wid<=xtn.WID;	
	 vif.axi_drv_cb.wdata<=xtn.WDATA[i];
	 vif.axi_drv_cb.wstrb<=xtn.WSTRB[i];			
	 if(i==(xtn.AWLEN))
	   vif.axi_drv_cb.wlast<=1'b1;
	 else
	   vif.axi_drv_cb.wlast<=1'b0;
	 wait(vif.axi_drv_cb.wready)
	 @(vif.axi_drv_cb);		
	 vif.axi_drv_cb.wvalid<=1'b0;
	 vif.axi_drv_cb.wlast<=1'b0;
	 @(vif.axi_drv_cb);
	 repeat(xtn.delay_cycles)
	   @(vif.axi_drv_cb);
       end
   end
 endtask
 //----------------------- write response channel ----------------------
 task axi_driver::write_response_channel(axi_trans xtn);
   vif.axi_drv_cb.bready<=1'b1;	
   wait(vif.axi_drv_cb.bvalid)
   @(vif.axi_drv_cb);		
   vif.axi_drv_cb.bready<=1'b0;
   repeat(xtn.delay_cycles)
     @(vif.axi_drv_cb);
 endtask
 //------------------------- read address channel ---------------------
 task axi_driver::read_address_channel(axi_trans xtn);
   begin
     @(vif.axi_drv_cb);
     vif.axi_drv_cb.arvalid<=xtn.arvalid;		
     vif.axi_drv_cb.aresetn<=xtn.aresetn;
     vif.axi_drv_cb.arid<=xtn.arid;
     vif.axi_drv_cb.araddr<=xtn.araddr;
     vif.axi_drv_cb.arlen<=xtn.arlen;
     vif.axi_drv_cb.arsize<=xtn.arsize;
     vif.axi_drv_cb.arburst<=xtn.arburst;		
     wait(vif.axi_drv_cb.arready)
     @(vif.axi_drv_cb);				
     vif.axi_drv_cb.arvalid<=1'b0;
     repeat(xtn.delay_cycles)
       @(vif.axi_drv_cb);
   end
 endtask
 //------------------------ read data channel -----------------------
 task axi_driver::read_data_channel(axi_trans xtn);
   repeat(vif.axi_drv_cb.arlen +1'b1)
     begin
       @(vif.axi_drv_cb);
       vif.axi_drv_cb.rready<=1'b1;
       wait(vif.axi_drv_cb.rvalid)
       @(vif.axi_drv_cb);
       vif.axi_drv_cb.rready<=1'b0;
       repeat(xtn.delay_cycles)
	 @(vif.axi_drv_cb);
     end
 endtask
