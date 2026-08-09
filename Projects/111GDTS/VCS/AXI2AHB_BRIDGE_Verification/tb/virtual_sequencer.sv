/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       virtual_sequencer.sv   

module Name             :       virtual_sequencer

Description             :       virtual sequencer for axi2ahb bridge verification

Author Name             :       Aishwarya,Naveen.

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.0
*********************************************************************************************/

 class virtual_sequencer extends uvm_sequencer#(uvm_sequence_item);
   `uvm_component_utils(virtual_sequencer)
   axi_sequencer axi_seqrh[];
   ahb_sequencer ahb_seqrh[];

   axi_rst_sequencer axi_rst_seqrh[];
   ahb_rst_sequencer ahb_rst_seqrh[];

   environment_config env_cfg;
   extern function new(string name="virtual_sequencer",uvm_component parent);
   extern function void build_phase(uvm_phase phase);
 endclass
 //---------------------------- new ------------------------
 function virtual_sequencer::new(string name="virtual_sequencer",uvm_component parent);
   super.new(name,parent);
 endfunction
 //-------------------------- build phase ---------------------
 function void virtual_sequencer::build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db#(environment_config)::get(this,"","environment_config",env_cfg))
     `uvm_fatal(get_type_name(),"configuration is not set properly")

   axi_seqrh=new[env_cfg.no_of_axi_agent];
   ahb_seqrh=new[env_cfg.no_of_ahb_agent];
   axi_rst_seqrh=new[env_cfg.no_of_axi_rst_agent];
   ahb_rst_seqrh=new[env_cfg.no_of_ahb_rst_agent];
 endfunction
