/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       virtual_sequence.sv   

module Name             :       virtual_sequence

Description             :       virtual sequence for axi2ahb bridge verification

Author Name             :       Aishwarya,Naveen.

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.0
*********************************************************************************************/
 class virtual_sequence_base extends uvm_sequence#(uvm_sequence_item);
   `uvm_object_utils(virtual_sequence_base)
   virtual_sequencer vseqrh;
   axi_sequencer axi_seqrh[];
   ahb_sequencer ahb_seqrh[];
   axi_rst_sequencer axi_rst_seqrh[]; 
   ahb_rst_sequencer ahb_rst_seqrh[];
   environment_config env_cfg;
   extern function new(string name="virtual_sequence_base");
   extern task body();
 endclass
 //-------------------------------- new -------------------------------
 function virtual_sequence_base::new(string name="virtual_sequence_base");
   super.new(name);
 endfunction
 //------------------------------ body ------------------------------
 task virtual_sequence_base::body();
   if(!uvm_config_db#(environment_config)::get(null,get_full_name(),"environment_config",env_cfg))
     `uvm_fatal(get_type_name(),"configuration is not getting properly")
   axi_seqrh=new[env_cfg.no_of_axi_agent];
   ahb_seqrh=new[env_cfg.no_of_ahb_agent];
   axi_rst_seqrh=new[env_cfg.no_of_axi_rst_agent];
   ahb_rst_seqrh=new[env_cfg.no_of_ahb_rst_agent];
   assert($cast(vseqrh,m_sequencer))
   else
     `uvm_error(get_type_name(),"Error in $cast of virtual sequencer")
   foreach(axi_seqrh[i])
     axi_seqrh[i]=vseqrh.axi_seqrh[i];
   foreach(ahb_seqrh[i])	
     ahb_seqrh[i]=vseqrh.ahb_seqrh[i];
   foreach(axi_rst_seqrh[i])
     axi_rst_seqrh[i]=vseqrh.axi_rst_seqrh[i];
   foreach(ahb_rst_seqrh[i])
     ahb_rst_seqrh[i]=vseqrh.ahb_rst_seqrh[i];
   `uvm_info(get_type_name(),"virtual seq base body",UVM_HIGH)
 endtask
 //===============================================================================
 // reset sequence
 class axi_rst_vseq extends virtual_sequence_base;
   `uvm_object_utils(axi_rst_vseq)
   //properties
   axi_rst_seq axi_rst_vseqh;
   //methods 
   extern function new(string name="axi_rst_vseq");
   extern task body();
 endclass
 //------------------------------ new ------------------------------
 function axi_rst_vseq::new(string name="axi_rst_vseq");
   super.new(name);
 endfunction
 //----------------------------- body ---------------------------------
 task axi_rst_vseq::body();
   super.body();
   if(env_cfg.has_axi_rst_agent)
     begin
       `uvm_info(get_type_name(),$sformatf("has_axi_rst_agent=%d",env_cfg.has_axi_rst_agent),UVM_LOW)
       axi_rst_vseqh=axi_rst_seq::type_id::create("axi_rst_vseqh");
     end
   fork
     begin
       axi_rst_vseqh.start(axi_rst_seqrh[0]);//
     end
   join
 endtask
 //====================================================================
 //ahb reset seq
 class ahb_rst_vseq extends virtual_sequence_base;
   `uvm_object_utils(ahb_rst_vseq)
   //properties
   ahb_rst_seq ahb_rst_vseqh;
   //methods 
   extern function new(string name="ahb_rst_vseq");
   extern task body();
 endclass
 //------------------------------ new ------------------------------
 function ahb_rst_vseq::new(string name="ahb_rst_vseq");
   super.new(name); 
 endfunction
 //----------------------------- body ---------------------------------
 task ahb_rst_vseq::body();
   super.body();
   if(env_cfg.has_ahb_rst_agent)
     begin
       `uvm_info(get_type_name(),$sformatf("has_ahb_rst_agent=%d",env_cfg.has_ahb_rst_agent),UVM_LOW)
       ahb_rst_vseqh=ahb_rst_seq::type_id::create("ahb_rst_vseqh");
     end
   fork
     begin
       ahb_rst_vseqh.start(ahb_rst_seqrh[0]);//
     end
   join
 endtask
 //=============================================================
 class axi_vseq extends virtual_sequence_base;
   `uvm_object_utils(axi_vseq)
   //properties
   axi_seq axi_vseqh;
   //methods 
   extern function new(string name="axi_vseq");
   extern task body();
 endclass
 //------------------------------ new ------------------------------
 function axi_vseq::new(string name="axi_vseq");
   super.new(name); 
 endfunction
 //----------------------------- body ---------------------------------
 task axi_vseq::body();
   super.body();
   if(env_cfg.has_axi_agent)
     begin
        `uvm_info(get_type_name(),$sformatf("has_axi_agent=%d",env_cfg.has_axi_agent),UVM_LOW)
       axi_vseqh=axi_seq::type_id::create("axi_vseqh");
     end
   fork
     begin
       axi_vseqh.start(axi_seqrh[0]);//
     end
   join
 endtask
 //=============================================================
 class ahb_vseq extends virtual_sequence_base;
   `uvm_object_utils(ahb_vseq)
   //properties
   ahb_seq ahb_vseqh;
   //methods 
   extern function new(string name="ahb_vseq");
   extern task body();
 endclass
 //------------------------------ new ------------------------------
 function ahb_vseq::new(string name="ahb_vseq");
   super.new(name);
 endfunction
 //----------------------------- body ---------------------------------
 task ahb_vseq::body();
   super.body();
   if(env_cfg.has_ahb_agent)
     begin
       `uvm_info(get_type_name(),$sformatf("has_ahb_agent=%d",env_cfg.has_ahb_agent),UVM_LOW)
       ahb_vseqh=ahb_seq::type_id::create("ahb_vseqh");
     end
   fork
     begin
       ahb_vseqh.start(ahb_seqrh[0]);//
     end
   join
 endtask
 //=============================================================
 class axi_burst_vseq extends virtual_sequence_base;
   `uvm_object_utils(axi_burst_vseq)
   //properties
   axi_burst_seq axi_burst_vseqh;
   //methods 
   extern function new(string name="axi_burst_vseq");
   extern task body();
 endclass
 //------------------------------ new ------------------------------
 function axi_burst_vseq::new(string name="axi_burst_vseq");
   super.new(name);
 endfunction
 //----------------------------- body ---------------------------------
 task axi_burst_vseq::body();
   super.body();
   if(env_cfg.has_axi_agent)
     begin
       `uvm_info(get_type_name(),$sformatf("has_axi_agent=%d",env_cfg.has_axi_agent),UVM_LOW)
       axi_burst_vseqh=axi_burst_seq::type_id::create("axi_burst_vseqh");
     end
   fork
     begin
       axi_burst_vseqh.start(axi_seqrh[0]);//
     end
   join
 endtask
 //=============================================================
 //axi read sequence
 class axi_read_vseq extends virtual_sequence_base;
   `uvm_object_utils(axi_read_vseq)
   //properties
   axi_read_seq axi_read_vseqh;
   //methods 
   extern function new(string name="axi_read_vseq");
   extern task body();
 endclass
 //------------------------------ new ------------------------------
 function axi_read_vseq::new(string name="axi_read_vseq");
   super.new(name); 
 endfunction
 //----------------------------- body ---------------------------------
 task axi_read_vseq::body();
   super.body();
   if(env_cfg.has_axi_agent)
     begin
       `uvm_info(get_type_name(),$sformatf("has_axi_agent=%d",env_cfg.has_axi_agent),UVM_LOW)
       axi_read_vseqh=axi_read_seq::type_id::create("axi_read_vseqh");
     end
   fork
     begin
       axi_read_vseqh.start(axi_seqrh[0]);//
     end
   join
 endtask
 //=============================================================
 class ahb_read_vseq extends virtual_sequence_base;
   `uvm_object_utils(ahb_read_vseq)
   //properties
   ahb_read_seq ahb_read_vseqh;
   //methods 
   extern function new(string name="ahb_read_vseq");
   extern task body();
 endclass
 //------------------------------ new ------------------------------
 function ahb_read_vseq::new(string name="ahb_read_vseq");
   super.new(name);
 endfunction
 //----------------------------- body ---------------------------------
 task ahb_read_vseq::body();
   super.body();
   if(env_cfg.has_ahb_agent)
     begin
       `uvm_info(get_type_name(),$sformatf("has_ahb_agent=%d",env_cfg.has_ahb_agent),UVM_LOW)
       ahb_read_vseqh=ahb_read_seq::type_id::create("ahb_read_vseqh");
     end
   fork
     begin
       ahb_read_vseqh.start(ahb_seqrh[0]);//
     end
   join
 endtask
