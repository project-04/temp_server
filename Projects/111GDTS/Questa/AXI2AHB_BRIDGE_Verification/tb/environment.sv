 class environment extends uvm_env;
   `uvm_component_utils(environment)

   axi_agent axi_agth[];
   ahb_agent ahb_agth[];
   axi_rst_agent axi_rst_agth[];
   ahb_rst_agent ahb_rst_agth[];	
   axi_agent_config axi_cfg[];
   ahb_agent_config ahb_cfg[];
   axi_rst_agent_config axi_rst_cfg[];
   ahb_rst_agent_config ahb_rst_cfg[];
   scoreboard scoreboardh;
   virtual_sequencer vseqrh;
   environment_config env_cfg;

   extern function new(string name="environment",uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
 endclass
 //---------------------------- new ----------------------------
 function environment::new(string name="environment",uvm_component parent);
   super.new(name,parent);
 endfunction
 //---------------------------- build phase -----------------------
 function void environment::build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db#(environment_config)::get(this,"","environment_config",env_cfg))
     `uvm_fatal(get_type_name(),"configuration is not getting properly in environment ")
   if(env_cfg.has_axi_agent)
     begin
       axi_agth=new[env_cfg.no_of_axi_agent];
       foreach(axi_agth[i])
	 begin
	   axi_agth[i]=axi_agent::type_id::create($sformatf("axi_agth[%0d]",i),this);
	   uvm_config_db#(axi_agent_config)::set(this,"*","axi_agent_config",env_cfg.axi_cfg[i]);
	 end
     end
   if(env_cfg.has_axi_rst_agent)
     begin
       axi_rst_agth=new[env_cfg.no_of_axi_rst_agent];
       foreach(axi_rst_agth[i])
         begin
           axi_rst_agth[i]=axi_rst_agent::type_id::create($sformatf("axi_rst_agth[%0d]",i),this);
           uvm_config_db#(axi_rst_agent_config)::set(this,"*","axi_rst_agent_config",env_cfg.axi_rst_cfg[i]);
         end
     end
   if(env_cfg.has_ahb_agent)
     begin
       ahb_agth=new[env_cfg.no_of_ahb_agent];
       foreach(ahb_agth[i])
	 begin
	   ahb_agth[i]=ahb_agent::type_id::create($sformatf("ahb_agth[%0d]",i),this);
	   uvm_config_db#(ahb_agent_config)::set(this,"*","ahb_agent_config",env_cfg.ahb_cfg[i]);
         end	
     end
   if(env_cfg.has_ahb_rst_agent)
     begin
       ahb_rst_agth=new[env_cfg.no_of_ahb_rst_agent];
       foreach(ahb_rst_agth[i])
         begin
           ahb_rst_agth[i]=ahb_rst_agent::type_id::create($sformatf("ahb_rst_agth[%0d]",i),this);
           uvm_config_db#(ahb_rst_agent_config)::set(this,"*","ahb_rst_agent_config",env_cfg.ahb_rst_cfg[i]);
         end
     end
   if(env_cfg.has_virtual_sequencer)
     vseqrh=virtual_sequencer::type_id::create("vseqrh",this);
   if(env_cfg.has_scoreboard)
     scoreboardh=scoreboard::type_id::create("scoreboardh",this);
 endfunction
 //------------------------- connect phase ----------------------
 function void environment::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   if(env_cfg.has_virtual_sequencer)
     begin
       if(env_cfg.has_axi_agent)
	 begin
	   for(int i=0;i<env_cfg.no_of_axi_agent;i++)
	     vseqrh.axi_seqrh[i]=axi_agth[i].seqrh;
	 end
       if(env_cfg.has_axi_rst_agent)
         begin
           for(int i=0;i<env_cfg.no_of_axi_rst_agent;i++)
             vseqrh.axi_rst_seqrh[i]=axi_rst_agth[i].seqrh;
         end
       if(env_cfg.has_ahb_agent)
         begin
           for(int i=0;i<env_cfg.no_of_ahb_agent;i++)
             vseqrh.ahb_seqrh[i]=ahb_agth[i].seqrh;
         end
       if(env_cfg.has_ahb_rst_agent)
         begin
           for(int i=0;i<env_cfg.no_of_ahb_rst_agent;i++)
             vseqrh.ahb_rst_seqrh[i]=ahb_rst_agth[i].seqrh;
         end
     end
   if(env_cfg.has_scoreboard)
     begin
       if(env_cfg.has_axi_rst_agent)
	 begin
	   for(int i=0;i<env_cfg.no_of_axi_rst_agent;i++)
              begin
	        axi_rst_agth[i].monh.rst_monitor_port.connect(scoreboardh.fifo_axi_rst_h[i].analysis_export);
 	      end
	 end
       if(env_cfg.has_ahb_rst_agent)
         begin
           for(int i=0;i<env_cfg.no_of_ahb_rst_agent;i++)
             begin
	       ahb_rst_agth[i].monh.rst_monitor_port.connect(scoreboardh.fifo_ahb_rst_h[i].analysis_export);
             end
         end
       if(env_cfg.has_axi_agent)
         begin
           for(int i=0;i<env_cfg.no_of_axi_agent;i++)
             begin
               axi_agth[i].monh.axi_monitor_port.connect(scoreboardh.fifo_axi_h[i].analysis_export);
	       axi_agth[i].monh.axi_write_data_monitor_port.connect(scoreboardh.fifo_axi_wdata_h[i].analysis_export);
	       axi_agth[i].monh.axi_read_data_monitor_port.connect(scoreboardh.fifo_axi_rdata_h[i].analysis_export);
             end
         end
       if(env_cfg.has_ahb_agent)
         begin
           for(int i=0;i<env_cfg.no_of_ahb_agent;i++)
             begin
               ahb_agth[i].monh.monitor_port.connect(scoreboardh.fifo_ahb_h[i].analysis_export);
             end
         end

     end
 endfunction
