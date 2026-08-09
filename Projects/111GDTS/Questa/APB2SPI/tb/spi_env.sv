class spi_env extends uvm_env;
   `uvm_component_utils(spi_env)

   //Properties
   apb_agent_top apb_top;
   spi_agent_top spi_top;
   spi_virt_sequencer v_seqrh;
   spi_scoreboard sb_h;
   spi_env_config m_cfg;

   spi_adapter spi_adpt;

   uvm_reg_predictor #(apb_xtn) apb2reg_predictor;

   //Methods
   extern function new(string name="spi_env", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
 endclass

 function spi_env :: new(string name ="spi_env", uvm_component parent);
   super.new(name, parent);
 endfunction
	
 function void spi_env :: build_phase(uvm_phase phase);
   if(!uvm_config_db #(spi_env_config)::get(this, "", "spi_env_config", m_cfg))
     `uvm_fatal(get_type_name(), "Cannot get m_cfg from uvm_config_db.Have you set it?")

   if(m_cfg.has_apb_agt)
     apb_top = apb_agent_top :: type_id ::create("apb_top", this);

   if(m_cfg.has_spi_agt)
     spi_top = spi_agent_top :: type_id :: create("spi_top", this);

   if(m_cfg.has_virtual_sequencer)
     v_seqrh = spi_virt_sequencer :: type_id :: create("v_seqrh", this);

   if(m_cfg.has_scoreboard)
     sb_h = spi_scoreboard :: type_id :: create("sb_h", this);

   apb2reg_predictor = uvm_reg_predictor#(apb_xtn) :: type_id :: create("apb2reg_predictor", this);
   spi_adpt = spi_adapter :: type_id :: create("spi_adpt");

   super.build_phase(phase);
 endfunction

 function void spi_env :: connect_phase(uvm_phase phase);
   if(m_cfg.has_virtual_sequencer)
     begin
       if(m_cfg.has_apb_agt)
	 for(int i=0; i<m_cfg.no_of_apb_agent;i++)
	   v_seqrh.apb_seqrh[i]=apb_top.agnth[i].seqrh;

       if(m_cfg.has_spi_agt)
	 for(int i=0; i<m_cfg.no_of_spi_agent; i++)
	   v_seqrh.spi_seqrh[i]=spi_top.agnth[i].seqrh;
     end

   if(m_cfg.has_scoreboard)
     begin
       for(int i=0; i<m_cfg.no_of_apb_agent; i++)
	 apb_top.agnth[i].monh.monitor_port.connect(sb_h.fifo_apb[i].analysis_export);

       for(int i=0; i<m_cfg.no_of_spi_agent; i++)
	 spi_top.agnth[i].monh.monitor_port.connect(sb_h.fifo_spi[i].analysis_export);	
     end

   uvm_resource_db #(apb_sequencer)::set("*", "APB", apb_top.agnth[0].seqrh);
   if(m_cfg.spi_rg_blk.get_parent()==null)
     begin
       m_cfg.spi_rg_blk.spi_reg_map.set_sequencer(apb_top.agnth[0].seqrh, spi_adpt);
     end

   apb2reg_predictor.map = m_cfg.spi_rg_blk.spi_reg_map;
   apb2reg_predictor.adapter= spi_adpt;
   m_cfg.spi_rg_blk.spi_reg_map.set_auto_predict(0);
   apb_top.agnth[0].monh.monitor_port.connect(apb2reg_predictor.bus_in);
 endfunction
