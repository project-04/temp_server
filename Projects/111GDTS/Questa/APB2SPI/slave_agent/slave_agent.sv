class spi_agent extends uvm_agent;
   `uvm_component_utils(spi_agent)

   // Properties
   spi_agent_config spi_cfg;
   spi_driver drvh;
   spi_monitor monh;
   spi_sequencer seqrh;

   //Methods
   extern function new(string name="spi_agent", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
 endclass

 function spi_agent :: new(string name="spi_agent", uvm_component parent);
   super.new(name, parent);
 endfunction

 function void spi_agent :: build_phase(uvm_phase phase);
   super.build_phase(phase);

   if(!uvm_config_db #(spi_agent_config)::get(this, "", "spi_agent_config", spi_cfg))
     `uvm_fatal(get_type_name(), "Cannot get spi_cfg from uvm_config_db. Have you set it?")

   monh = spi_monitor :: type_id :: create("monh", this);
   if(spi_cfg.is_active == UVM_ACTIVE)
     begin
       drvh = spi_driver :: type_id :: create("drvh", this);
       seqrh = spi_sequencer ::type_id :: create("seqrh", this);
     end
 endfunction

 function void spi_agent :: connect_phase(uvm_phase phase);
   if(spi_cfg.is_active == UVM_ACTIVE)
     drvh.seq_item_port.connect(seqrh.seq_item_export);
 endfunction

