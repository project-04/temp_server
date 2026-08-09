/********************************************************************************************
Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       test.sv   

module Name             :       test

Description             :       test cases for axi2ahb bridge verification

Author Name             :       Aishwarya,Naveen.

Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version                 :       1.0
*********************************************************************************************/

 class base_test extends uvm_test;

   `uvm_component_utils(base_test)

   environment envh;
   environment_config env_cfg;
 
   axi_agent_config axi_cfg[];
   ahb_agent_config ahb_cfg[];

   axi_rst_agent_config axi_rst_cfg[];
   ahb_rst_agent_config ahb_rst_cfg[];

   bit has_axi_agent=1'b1;
   bit has_ahb_agent=1'b1;
   bit has_scoreboard=1'b1;
   bit has_virtual_sequencer=1'b1;
 
   int no_of_axi_agent=1;
   int no_of_ahb_agent=1;

   bit has_axi_rst_agent=1'b1;
   bit has_ahb_rst_agent=1'b1;

   int no_of_axi_rst_agent=1;
   int no_of_ahb_rst_agent=1;

   rand int length[];
   int no_of_transactions;
   //constraints
   constraint length_c{foreach(length[i])
			 length[i] inside {[1:15]};
		      }
   extern function new(string name="base_test",uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void end_of_elaboration_phase(uvm_phase phase);
   //extern function void start_of_simulation_phase(uvm_phase phase);
   extern function void config_axi2ahb();
 endclass
 //--------------------------- new ---------------------------
 function base_test::new(string name="base_test",uvm_component parent);
   super.new(name,parent);
 endfunction
 //--------------------------- build phase -------------------------
 function void base_test::build_phase(uvm_phase phase);
   super.build_phase(phase);
   env_cfg=environment_config::type_id::create("env_cfg");
   config_axi2ahb();
   uvm_config_db#(environment_config)::set(this,"*","environment_config",env_cfg);
   envh=environment::type_id::create("envh",this);
   `uvm_info(get_type_name(),"test build_phase",UVM_HIGH)
 endfunction
 //--------------------------- config axi2ahb ----------------------------
 function void base_test::config_axi2ahb();
   env_cfg.has_axi_agent=has_axi_agent;
   env_cfg.has_ahb_agent=has_ahb_agent;
   env_cfg.has_virtual_sequencer=has_virtual_sequencer;
   env_cfg.has_scoreboard=has_scoreboard;

   env_cfg.has_axi_rst_agent=has_axi_rst_agent;
   env_cfg.has_ahb_rst_agent=has_ahb_rst_agent;

   env_cfg.no_of_axi_agent=no_of_axi_agent;
   env_cfg.no_of_ahb_agent=no_of_ahb_agent;

   env_cfg.no_of_axi_rst_agent=no_of_axi_rst_agent;
   env_cfg.no_of_ahb_rst_agent=no_of_ahb_rst_agent;

   if(has_axi_agent)
     begin
       axi_cfg=new[no_of_axi_agent];
       env_cfg.axi_cfg=new[no_of_axi_agent];
       foreach(axi_cfg[i])
	 begin
	   axi_cfg[i]=axi_agent_config::type_id::create($sformatf("axi_cfg[%0d]",i));
           if(!uvm_config_db#(virtual axi_if)::get(this,"","axi_if",axi_cfg[i].vif))
	     `uvm_fatal(get_type_name(),"configuration is not getting properly in test")
           axi_cfg[i].is_active=UVM_ACTIVE;
	   env_cfg.axi_cfg[i]=axi_cfg[i];
         end
     end
   if(has_axi_rst_agent)
     begin
       axi_rst_cfg=new[no_of_axi_rst_agent];
       env_cfg.axi_rst_cfg=new[no_of_axi_rst_agent];
       foreach(axi_rst_cfg[i])
         begin
           axi_rst_cfg[i]=axi_rst_agent_config::type_id::create($sformatf("axi_rst_cfg[%0d]",i));
           if(!uvm_config_db#(virtual axi_rst_if)::get(this,"","axi_rst_if",axi_rst_cfg[i].vif))
             `uvm_fatal(get_type_name(),"configuration is not getting properly in test")
           axi_rst_cfg[i].is_active=UVM_ACTIVE;
           env_cfg.axi_rst_cfg[i]=axi_rst_cfg[i];
         end
     end
   if(has_ahb_agent)
     begin
       ahb_cfg=new[no_of_ahb_agent];
       env_cfg.ahb_cfg=new[no_of_ahb_agent];
       foreach(ahb_cfg[i])
	 begin
	   ahb_cfg[i]=ahb_agent_config::type_id::create($sformatf("ahb_cfg[%0d]",i));
           if(!uvm_config_db#(virtual ahb_if)::get(this,"","ahb_if",ahb_cfg[i].vif))
             `uvm_fatal(get_type_name(),"configuration is not getting properly in test")
           ahb_cfg[i].is_active=UVM_ACTIVE;
	   env_cfg.ahb_cfg[i]=ahb_cfg[i];
         end
     end
   if(has_ahb_rst_agent)
     begin
       ahb_rst_cfg=new[no_of_ahb_rst_agent];
       env_cfg.ahb_rst_cfg=new[no_of_ahb_rst_agent];
       foreach(ahb_rst_cfg[i])
         begin
           ahb_rst_cfg[i]=ahb_rst_agent_config::type_id::create($sformatf("ahb_rst_cfg[%0d]",i));
           if(!uvm_config_db#(virtual ahb_rst_if)::get(this,"","ahb_rst_if",ahb_rst_cfg[i].vif))
             `uvm_fatal(get_type_name(),"configuration is not getting properly in test")
           ahb_rst_cfg[i].is_active=UVM_ACTIVE;
           env_cfg.ahb_rst_cfg[i]=ahb_rst_cfg[i];
         end
     end	
   if(!(this.randomize() with {length.size==no_of_transactions;}))
     `uvm_fatal(get_type_name(),"randomization of length failed in test")	
   foreach(length[i])
     begin
       $display(" lengths : %0d",length[i]);
       env_cfg.axi_length.push_back(length[i]);
       env_cfg.ahb_length.push_back(length[i]);
     end
 endfunction
 //------------------------------------------ end of elaboration ----------------------
 function void base_test::end_of_elaboration_phase(uvm_phase phase); 
   `uvm_info(get_type_name(),"test end of elaboration__phase",UVM_HIGH)
   super.end_of_elaboration_phase(phase);
   uvm_top.print_topology();
 endfunction
 //----------------------------------- start of simulation ----------------------------
 /*
 function void base_test::start_of_simulation_phase(uvm_phase phase); 
   super.start_of_simulation_phase(phase);
   uvm_top.set_timeout(12000000,1);
 endfunction
 */
 //========================================================================================
 //reset test
 class reset_test extends base_test;
   `uvm_component_utils(reset_test) 
   axi_rst_vseq axi_rst_vseqh;
   ahb_rst_vseq ahb_rst_vseqh;
   extern function new(string name="reset_test",uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
 endclass
 //--------------------------------------- new ------------------------------------
 function reset_test::new(string name="reset_test",uvm_component parent);
   super.new(name,parent);
 endfunction
 //--------------------------------- build_phase -------------------------------
 function void reset_test::build_phase(uvm_phase phase);
   super.build_phase(phase);
 endfunction 
 //---------------------------- run phase ------------------------------
 task reset_test::run_phase(uvm_phase phase);
   begin
     phase.raise_objection(this);
     `uvm_info(get_type_name(),"reset_test run phase",UVM_LOW)
     axi_rst_vseqh=axi_rst_vseq::type_id::create("axi_rst_vseqh");
     ahb_rst_vseqh=ahb_rst_vseq::type_id::create("ahb_rst_vseqh");
     fork
       begin
         axi_rst_vseqh.start(envh.vseqrh);
       end
       begin
	 ahb_rst_vseqh.start(envh.vseqrh);
       end
     join
     phase.drop_objection(this);
   end
 endtask
 //========================================================================================
 //axi test
 class axi_test extends base_test;
   `uvm_component_utils(axi_test)
   axi_vseq axi_vseqh;
   ahb_vseq ahb_vseqh;

   axi_rst_vseq axi_rst_vseqh;
   ahb_rst_vseq ahb_rst_vseqh;
   extern function new(string name="axi_test",uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
 endclass
 //--------------------------------------- new ------------------------------------
 function axi_test::new(string name="axi_test",uvm_component parent);
   super.new(name,parent);
 endfunction
 //--------------------------------- build_phase -------------------------------
 function void axi_test::build_phase(uvm_phase phase);
   super.no_of_transactions=1;
   super.build_phase(phase);
 endfunction
 //---------------------------- run phase ------------------------------
 task axi_test::run_phase(uvm_phase phase);
   begin
     phase.raise_objection(this);
     repeat(no_of_transactions)
       begin
         `uvm_info(get_type_name(),"reset_test run phase",UVM_LOW)
         axi_vseqh=axi_vseq::type_id::create("axi_vseqh");
         ahb_vseqh=ahb_vseq::type_id::create("ahb_vseqh");
         axi_rst_vseqh=axi_rst_vseq::type_id::create("axi_rst_vseqh");
         ahb_rst_vseqh=ahb_rst_vseq::type_id::create("ahb_rst_vseqh");
         begin
           axi_rst_vseqh.start(envh.vseqrh);
           ahb_rst_vseqh.start(envh.vseqrh);
	   #20;
           fork
             begin
               axi_vseqh.start(envh.vseqrh);
             end
             begin
               ahb_vseqh.start(envh.vseqrh);
             end
           join
           #1000;
         end
       end    
     phase.drop_objection(this);
   end
 endtask
 //========================================================================
 //axi test
 class axi_test_write_burst extends base_test;
   `uvm_component_utils(axi_test_write_burst)
   axi_burst_vseq axi_burst_vseqh;
   ahb_vseq ahb_vseqh;

   axi_rst_vseq axi_rst_vseqh;
   ahb_rst_vseq ahb_rst_vseqh;

   constraint length_c{foreach(length[i])
                         length[i] inside {3,7,15};
                      }
   extern function new(string name="axi_test_write_burst",uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
 endclass
 //--------------------------------------- new ------------------------------------
 function axi_test_write_burst::new(string name="axi_test_write_burst",uvm_component parent);
   super.new(name,parent);
 endfunction
 //--------------------------------- build_phase -------------------------------
 function void axi_test_write_burst::build_phase(uvm_phase phase);
   super.no_of_transactions=1;
   super.build_phase(phase);
 endfunction
 //---------------------------- run phase ------------------------------
 task axi_test_write_burst::run_phase(uvm_phase phase);
   begin
     phase.raise_objection(this);
     repeat(no_of_transactions)
       begin
         `uvm_info(get_type_name(),"reset_test run phase",UVM_LOW)
         axi_burst_vseqh=axi_burst_vseq::type_id::create("axi_vseqh");
         ahb_vseqh=ahb_vseq::type_id::create("ahb_vseqh");
         axi_rst_vseqh=axi_rst_vseq::type_id::create("axi_rst_vseqh");
         ahb_rst_vseqh=ahb_rst_vseq::type_id::create("ahb_rst_vseqh");
         begin
           axi_rst_vseqh.start(envh.vseqrh);
           ahb_rst_vseqh.start(envh.vseqrh);
           #20;
           fork
             begin
               axi_burst_vseqh.start(envh.vseqrh);
             end
             begin
               ahb_vseqh.start(envh.vseqrh);
             end
           join
           #1000;
         end
       end
     phase.drop_objection(this);
   end
 endtask
 //========================================================================================
 //axi read test
 class axi_read_test extends base_test;
   `uvm_component_utils(axi_read_test)

   axi_read_vseq axi_read_vseqh;
   ahb_read_vseq ahb_read_vseqh;

   axi_rst_vseq axi_rst_vseqh;
   ahb_rst_vseq ahb_rst_vseqh;
   constraint length_c{foreach(length[i])
                         length[i] inside {[3:15]};
                       }
   extern function new(string name="axi_read_test",uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
 endclass
 //--------------------------------------- new ------------------------------------
 function axi_read_test::new(string name="axi_read_test",uvm_component parent);
   super.new(name,parent);
 endfunction
 //--------------------------------- build_phase -------------------------------
 function void axi_read_test::build_phase(uvm_phase phase);
   super.no_of_transactions=1;
   super.build_phase(phase);
 endfunction
 //---------------------------- run phase ------------------------------
 task axi_read_test::run_phase(uvm_phase phase);
   begin 
     phase.raise_objection(this);
     repeat(no_of_transactions)
       begin
         `uvm_info(get_type_name(),"reset_test run phase",UVM_LOW)
         axi_read_vseqh=axi_read_vseq::type_id::create("axi_read_vseqh");
         ahb_read_vseqh=ahb_read_vseq::type_id::create("ahb_vseqh");
         axi_rst_vseqh=axi_rst_vseq::type_id::create("axi_rst_vseqh");
         ahb_rst_vseqh=ahb_rst_vseq::type_id::create("ahb_rst_vseqh");
         begin
           axi_rst_vseqh.start(envh.vseqrh);
           ahb_rst_vseqh.start(envh.vseqrh);
           //    #20;
           fork
             begin
               axi_read_vseqh.start(envh.vseqrh);
             end
             begin
               ahb_read_vseqh.start(envh.vseqrh);
             end
           join
           #1000;
         end
       end
     phase.drop_objection(this);
   end
 endtask


