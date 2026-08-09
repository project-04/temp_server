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


   temp=env_cfg.axi_length.pop_front();
   $display("\n AWLEN  : %d \n axi_length = %p",temp,env_cfg.axi_length);


// Just a write operation so read valid is 0 and burst = 0,1
   start_item(req);
   assert(req.randomize() with  {AWLEN==temp;arlen==temp;arvalid==1;AWVALID==1;WVALID==1;AWBURST inside {[0:1]};});
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


   temp=env_cfg.axi_length.pop_front();
   $display("\n AWLEN  : %d \n axi_length = %p",temp,env_cfg.axi_length);


// Just a write operation so read valid is 0 and burst = wrap

   start_item(req);
   assert(req.randomize() with  {AWLEN==temp;arlen==temp;arvalid==0;AWVALID==1;WVALID==1;AWBURST==2;});
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


   temp=env_cfg.axi_length.pop_front();
   $display("\n AWLEN  : %d \n axi_length = %p",temp,env_cfg.axi_length);

// read operation so write valid is 0 and burst = inr or wrap 
   start_item(req);
   assert(req.randomize() with  {AWLEN==temp;arlen==temp;AWVALID==0;WVALID==0;arvalid==1;arsize inside {0,1,2,3};arburst inside {0,1,2};});
   finish_item(req);

 endtask

//================================================================


//--------------------------- axi sequene -------------------
 class axi_burst_seq1 extends axi_sequence_base;
   `uvm_object_utils(axi_burst_seq1);	
   extern function new (string name="axi_burst_seq1");
   extern task body();
 endclass
 //---------------------- new ---------------------------
 function axi_burst_seq1::new(string name="axi_burst_seq1");
   super.new(name);
 endfunction
 //-------------------------- body -----------------------
 task axi_burst_seq1::body();
   req=axi_trans::type_id::create("req");
   if(!(uvm_config_db#(environment_config)::get(null,get_full_name(),"environment_config",env_cfg)))
     `uvm_fatal(get_type_name(),"configuration failed in axi sequence")


   temp=env_cfg.axi_length.pop_front();
   $display("\n AWLEN  : %d \n axi_length = %p",temp,env_cfg.axi_length);


// Just a write operation so read valid is 0 and burst = wrap

   start_item(req);
   assert(req.randomize() with  {AWLEN==temp;arlen==temp;arvalid==0;AWVALID==1;WVALID==1;AWSIZE==2;AWBURST==2;AWADDR inside{[32'hcccc_cccd:32'hffff_ffff]};});
   finish_item(req);

 endtask

