 class spi_virt_sequencer extends uvm_sequencer #(uvm_sequence_item);
   `uvm_component_utils(spi_virt_sequencer)
	
   // Properties
   spi_env_config m_cfg;
	
   apb_sequencer apb_seqrh[];
   spi_sequencer spi_seqrh[];

   //Methods
   extern function new(string name="spi_virt_sequencer", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
 endclass

 function spi_virt_sequencer :: new(string name="spi_virt_sequencer", uvm_component parent);
   super.new(name, parent);
 endfunction


 function void spi_virt_sequencer :: build_phase(uvm_phase phase);
   if(!uvm_config_db #(spi_env_config)::get(this, "", "spi_env_config", m_cfg))
     `uvm_fatal(get_type_name(), "Cannot get m_cfg from uvm_config_db. Have you set it?")

   apb_seqrh = new[m_cfg.no_of_apb_agent];
   spi_seqrh = new[m_cfg.no_of_spi_agent];
 endfunction

