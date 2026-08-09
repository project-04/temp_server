 class axi_rst_agent extends uvm_agent;
   `uvm_component_utils(axi_rst_agent)

   axi_rst_driver drvh;
   axi_rst_monitor monh;
   axi_rst_sequencer seqrh;
   axi_rst_agent_config rst_cfg;

   extern function new(string name="axi_rst_agent",uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);	
 endclass
 //---------------------------------- new ---------------------------------
 function axi_rst_agent::new(string name="axi_rst_agent",uvm_component parent);
   super.new(name,parent);
 endfunction
 //------------------------------- build phase ---------------------------
 function void axi_rst_agent::build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db#(axi_rst_agent_config)::get(this,"","axi_rst_agent_config",rst_cfg))
     `uvm_fatal(get_type_name(),"configuration is not getting properly in axi agent")
   monh=axi_rst_monitor::type_id::create("monh",this);
   if(rst_cfg.is_active==UVM_ACTIVE)
     begin
       drvh=axi_rst_driver::type_id::create("drvh",this);
       seqrh=axi_rst_sequencer::type_id::create("seqrh",this);
     end
   `uvm_info(get_type_name(),"axi rst agent  build_phase",UVM_HIGH)
 endfunction
 //------------------------------ connect phase -----------------------------
 function void axi_rst_agent::connect_phase(uvm_phase phase);
   super.connect_phase(phase);	
   if(rst_cfg.is_active==UVM_ACTIVE)
     drvh.seq_item_port.connect(seqrh.seq_item_export);
   `uvm_info(get_type_name(),"axi rst agent connnect_phase",UVM_HIGH)
 endfunction
