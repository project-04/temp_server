/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       ahb_rst_driver.sv   

module Name             :       ahb_rst_driver

Description             :       ahb reset driver for axi2ahb bridge verification

Author Name             :       Aishwarya,Naveen.

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.0
*********************************************************************************************/
 class ahb_rst_driver extends uvm_driver#(ahb_rst_trans);
   `uvm_component_utils(ahb_rst_driver)

   ahb_rst_trans ahb_rst_xtn;
   ahb_rst_agent_config rst_cfg;
   ahb_agent_config ahb_cfg;

   virtual ahb_rst_if.AHB_RST_DRV_MP vif;
   virtual ahb_if.AHB_DRV_MP a_vif;

   extern function new(string name="ahb_rst_driver",uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
   extern task send_to_dut(ahb_rst_trans xtn);
 endclass
 //---------------------------------- new --------------------------------
 function ahb_rst_driver::new(string name="ahb_rst_driver", uvm_component parent);
   super.new(name,parent);
 endfunction
 //------------------------------ build phase -----------------------------
 function void ahb_rst_driver::build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db#(ahb_rst_agent_config)::get(this,"","ahb_rst_agent_config",rst_cfg))
     `uvm_fatal(get_type_name(),"configuration is not set properly")
   if(!uvm_config_db#(ahb_agent_config)::get(this,"","ahb_agent_config",ahb_cfg))
     `uvm_fatal(get_type_name(),"configuration is not set properly")

   `uvm_info(get_type_name(),"ahb rst driver build_phase",UVM_HIGH)
 endfunction
 //---------------------------- connect phase ----------------------------
 function void ahb_rst_driver::connect_phase(uvm_phase phase);
   super.connect_phase(phase);	
   vif=rst_cfg.vif;
   a_vif=ahb_cfg.vif;
   `uvm_info(get_type_name(),"ahb rst driver connect_phase",UVM_HIGH)
 endfunction
 //--------------------------- run phase ----------------------------------
 task ahb_rst_driver::run_phase(uvm_phase phase);
   forever
     begin
       seq_item_port.get_next_item(req);
       send_to_dut(req);
       seq_item_port.item_done();
     end
   `uvm_info(get_type_name(),"ahb rst driver run _phase",UVM_HIGH)
 endtask
 //------------------------------ send to dut ---------------------------
 task ahb_rst_driver::send_to_dut(ahb_rst_trans xtn);
   @(vif.ahb_rst_drv_cb)
   vif.ahb_rst_drv_cb.hresetn<=xtn.hresetn;
   a_vif.ahb_drv_cb.hready<=1'b1;
   @(vif.ahb_rst_drv_cb);
   @(vif.ahb_rst_drv_cb);
   vif.ahb_rst_drv_cb.hresetn<=1'b1;
   a_vif.ahb_drv_cb.hready<=1'b0;
   @(vif.ahb_rst_drv_cb);
   @(vif.ahb_rst_drv_cb);
 endtask
