/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       ahb_sequence.sv   

module Name             :       ahb_sequence

Description             :       ahb sequence for axi2ahb bridge verification

Author Name             :       Aishwarya,Naveen.

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.0
*********************************************************************************************/
 class ahb_sequence_base extends uvm_sequence#(ahb_trans);
   `uvm_object_utils(ahb_sequence_base)

   environment_config env_cfg;

   extern function new(string name="ahb_sequence_base");
 endclass
 //---------------------- new ---------------------
 function ahb_sequence_base::new(string name="ahb_sequence_base");
   super.new(name);
 endfunction
 //====================================================
 //ahb_sequence
 class ahb_seq extends ahb_sequence_base;
   `uvm_object_utils(ahb_seq);
        
   extern function new (string name="ahb_seq");
   extern task body();
 endclass
 //---------------------- new ---------------------------
 function ahb_seq::new(string name="ahb_seq");
   super.new(name);
 endfunction
 //-------------------------- body -----------------------
 task ahb_seq::body();
   req=ahb_trans::type_id::create("req");
   if(!(uvm_config_db#(environment_config)::get(null,get_full_name(),"environment_config",env_cfg)))
     `uvm_fatal(get_type_name(),"configuration fail in ahb_sequence")
   $display("ahb_length :%p",env_cfg.ahb_length);	
   repeat((2*(env_cfg.ahb_length.pop_front()))+2)
     begin
       start_item(req);
       assert(req.randomize() with {delay_cycles==2;});
       finish_item(req);
     end
 endtask
 //====================================================
 //ahb_read_sequence
 class ahb_read_seq extends ahb_sequence_base;
   `uvm_object_utils(ahb_read_seq);
        
   extern function new (string name="ahb_read_seq");
   extern task body();
 endclass
 //---------------------- new ---------------------------
 function ahb_read_seq::new(string name="ahb_read_seq");
   super.new(name);
 endfunction
 //-------------------------- body -----------------------
 task ahb_read_seq::body();
   req=ahb_trans::type_id::create("req");
   if(!(uvm_config_db#(environment_config)::get(null,get_full_name(),"environment_config",env_cfg)))
     `uvm_fatal(get_type_name(),"configuration fail in ahb_sequence")
   $display("ahb_length :%p",env_cfg.ahb_length);	
   repeat((2*(env_cfg.ahb_length.pop_front()))+2)
     begin
       start_item(req);
       assert(req.randomize() with {delay_cycles==2;resp==0;});
       finish_item(req);
     end
 endtask
