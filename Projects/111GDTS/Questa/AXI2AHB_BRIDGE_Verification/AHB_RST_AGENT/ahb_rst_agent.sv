 class ahb_rst_agent extends uvm_agent;
   `uvm_component_utils(ahb_rst_agent)

   ahb_rst_driver drvh;
   ahb_rst_monitor monh;
   ahb_rst_sequencer seqrh;

   ahb_rst_agent_config rst_cfg;

   extern function new(string name="ahb_rst_agent",uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);	
 endclass
 //---------------------------------- new ---------------------------------
 function ahb_rst_agent::new(string name="ahb_rst_agent",uvm_component parent);
   super.new(name,parent);
 endfunction
 //------------------------------- build phase ---------------------------
 function void ahb_rst_agent::build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db#(ahb_rst_agent_config)::get(this,"","ahb_rst_agent_config",rst_cfg))
     `uvm_fatal(get_type_name(),"configuration is not getting properly in ahb agent")

   monh=ahb_rst_monitor::type_id::create("monh",this);

   if(rst_cfg.is_active==UVM_ACTIVE)
     begin
       drvh=ahb_rst_driver::type_id::create("drvh",this);
       seqrh=ahb_rst_sequencer::type_id::create("seqrh",this);
     end
   `uvm_info(get_type_name(),"ahb rst agent  build_phase",UVM_HIGH)
 endfunction
 //------------------------------ connect phase -----------------------------
 function void ahb_rst_agent::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   if(rst_cfg.is_active==UVM_ACTIVE)
     drvh.seq_item_port.connect(seqrh.seq_item_export);
   `uvm_info(get_type_name(),"ahb rst agent connect_phase",UVM_HIGH)
 endfunction
