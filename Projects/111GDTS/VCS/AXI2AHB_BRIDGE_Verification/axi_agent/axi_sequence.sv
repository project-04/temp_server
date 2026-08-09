/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       axi_sequence.sv   

module Name             :       axi_sequence

Description             :       axi sequence for axi2ahb bridge verification

Author Name             :       Aishwarya,Naveen.

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.0
*********************************************************************************************/
 class axi_sequence_base extends uvm_sequence#(axi_trans);	
   `uvm_object_utils(axi_sequence_base)	
	
   environment_config env_cfg;
   int temp;

   extern function new(string name="axi_sequence_base");
 endclass
 //----------------------- new -----------------------
 function axi_sequence_base::new(string name="axi_sequence_base");
   super.new(name);
 endfunction
 //--------------------------- axi sequene -------------------
 class axi_seq extends axi_sequence_base;
   `uvm_object_utils(axi_seq);
	
   extern function new (string name="axi_seq");
   extern task body();
 endclass
 //---------------------- new ---------------------------
 function axi_seq::new(string name="axi_seq");
   super.new(name);
 endfunction
 //-------------------------- body -----------------------
 task axi_seq::body();
   req=axi_trans::type_id::create("req");
   if(!(uvm_config_db#(environment_config)::get(null,get_full_name(),"environment_config",env_cfg)))
     `uvm_fatal(get_type_name(),"configuration failed in axi sequence")
   $display("axi_length : %p",env_cfg.axi_length);
   temp=env_cfg.axi_length.pop_front();
   $display("awlen$ : %d",temp);
   start_item(req);
   assert(req.randomize() with  {awlen==temp;arlen==temp;arvalid==0;awvalid==1;wvalid==1;awburst inside {[0:1]};});
   finish_item(req);
 endtask
 //--------------------------- axi sequene -------------------
 class axi_burst_seq extends axi_sequence_base;
   `uvm_object_utils(axi_burst_seq);	
   extern function new (string name="axi_burst_seq");
   extern task body();
 endclass
 //---------------------- new ---------------------------
 function axi_burst_seq::new(string name="axi_burst_seq");
   super.new(name);
 endfunction
 //-------------------------- body -----------------------
 task axi_burst_seq::body();
   req=axi_trans::type_id::create("req");
   if(!(uvm_config_db#(environment_config)::get(null,get_full_name(),"environment_config",env_cfg)))
     `uvm_fatal(get_type_name(),"configuration failed in axi sequence")
   $display("axi_length : %p",env_cfg.axi_length);
   temp=env_cfg.axi_length.pop_front();
   $display("awlen$ : %d",temp);
   start_item(req);
   assert(req.randomize() with  {awlen==temp;arlen==temp;arvalid==0;awvalid==1;wvalid==1;awburst==2;});
   finish_item(req);
 endtask
 //--------------------------- axi sequene -------------------
 class axi_read_seq extends axi_sequence_base;
   `uvm_object_utils(axi_read_seq);
   extern function new (string name="axi_read_seq");
   extern task body();
 endclass
 //---------------------- new ---------------------------
 function axi_read_seq::new(string name="axi_read_seq");
   super.new(name);
 endfunction
 //-------------------------- body -----------------------
 task axi_read_seq::body();
   req=axi_trans::type_id::create("req");
   if(!(uvm_config_db#(environment_config)::get(null,get_full_name(),"environment_config",env_cfg)))
     `uvm_fatal(get_type_name(),"configuration failed in axi sequence")
   $display("axi_length : %p",env_cfg.axi_length);
   temp=env_cfg.axi_length.pop_front();
   $display("awlen$ : %d",temp);
   start_item(req);
   assert(req.randomize() with  {awlen==temp;arlen==temp;awvalid==0;wvalid==0;arvalid==1;arburst inside {1,2};});
   finish_item(req);
 endtask
