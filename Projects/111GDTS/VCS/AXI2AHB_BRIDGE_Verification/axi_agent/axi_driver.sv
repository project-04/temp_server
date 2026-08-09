/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       axi_driver.sv   

module Name             :       axi_driver

Description             :       axi driver for axi2ahb bridge verification

Author Name             :       Aishwarya,Naveen.

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.1
*********************************************************************************************/

 class axi_driver extends uvm_driver#(axi_trans);
   `uvm_component_utils(axi_driver)

   axi_trans axi_xtn;
   axi_trans q1[$],q2[$],q3[$],q4[$],q5[$];
   //write channels semaphore
   semaphore sem_write_address_data=new(); //created semaphore with zero key
   semaphore sem_write_data_response=new();
   semaphore sem_write_address=new(1);	//created semaphore with one key
   semaphore sem_write_data=new(1);
   semaphore sem_write_response=new(1);
   //read channels seamphore
   semaphore sem_read_address_data=new();
   semaphore sem_read_address=new(1);
   semaphore sem_read_data=new(1);

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
   `uvm_info(get_type_name(),"axi driver build_phase",UVM_HIGH)
 endfunction
 //----------------------- connect phase ------------------
 function void axi_driver::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   vif = axi_cfg.vif;
   r_vif=axi_rst_cfg.vif;
   `uvm_info(get_type_name(),"axi driver connect_phase",UVM_HIGH)
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
       sem_write_address.get(1);
       write_address_channel(q1.pop_front());
       sem_write_address_data.put(1);	//to synchronize address and data channel
       sem_write_address.put(1);
     end
     begin
       sem_write_data.get(1);
       sem_write_address_data.get(1);
       write_data_channel(q2.pop_front());
       sem_write_data_response.put(1);	//to synchronize data and response channel
       sem_write_data.put(1);
     end
     begin
       sem_write_response.get(1);
       sem_write_data_response.get(1);
       write_response_channel(q3.pop_front());
       sem_write_response.put(1);
       //sem_write_read.put(1);	//changed in 26/2/24
     end
     begin
       sem_read_address.get(1);
       //     sem_write_read.get(1);	//changed in 26/2/24
       read_address_channel(q4.pop_front());
       sem_read_address_data.put(1);	//to synchronize address and data channel
       sem_read_address.put(1);
     end
     begin
       sem_read_data.get(1);
       sem_read_address_data.get(1);
       read_data_channel(q5.pop_front());		
       sem_read_data.put(1);
     end
   join_any	
 endtask	
 //------------------- write address channel ----------------------
 task axi_driver::write_address_channel(axi_trans xtn);
   @(vif.axi_drv_cb);
   begin	
     vif.axi_drv_cb.awvalid<=xtn.awvalid;		
     vif.axi_drv_cb.aresetn<=xtn.aresetn;
     vif.axi_drv_cb.awid<=xtn.awid;
     vif.axi_drv_cb.awaddr<=xtn.awaddr;
     vif.axi_drv_cb.awlen<=xtn.awlen;
     vif.axi_drv_cb.awsize<=xtn.awsize;
     vif.axi_drv_cb.awburst<=xtn.awburst;	
     wait(vif.axi_drv_cb.awready)
     @(vif.axi_drv_cb);
     vif.axi_drv_cb.awvalid<=1'b0;
     repeat(xtn.delay_cycles) //check whether you have included delay cyles in axi_trans
       @(vif.axi_drv_cb);
   end
 endtask
 //---------------- write data channel ----------------------
 task axi_driver::write_data_channel(axi_trans xtn);
   begin		
     foreach(xtn.wdata[i])
       begin
	 vif.axi_drv_cb.wvalid<=xtn.wvalid;
	 vif.axi_drv_cb.wid<=xtn.wid;	
	 vif.axi_drv_cb.wdata<=xtn.wdata[i];
	 vif.axi_drv_cb.wstrb<=xtn.wstrb[i];			
	 if(i==(xtn.awlen))
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
