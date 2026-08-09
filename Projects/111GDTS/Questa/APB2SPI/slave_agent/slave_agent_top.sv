class spi_agent_top extends uvm_env;
   `uvm_component_utils(spi_agent_top)

   spi_agent agnth[];
   spi_env_config m_cfg;

   //Methods
   extern function new(string name="spi_agent_top", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
 endclass

 function spi_agent_top :: new(string name="spi_agent_top", uvm_component parent);
   super.new(name, parent);
 endfunction

 function void spi_agent_top :: build_phase(uvm_phase phase);
   super.build_phase(phase);

   if(!uvm_config_db #(spi_env_config)::get(this, "", "spi_env_config", m_cfg))
     `uvm_fatal(get_type_name(), "Cannot get m_cfg from uvm_config_db. Have you set it?")

   agnth = new[m_cfg.no_of_spi_agent];

   foreach(agnth[i])
     begin
       uvm_config_db #(spi_agent_config)::set(this, $sformatf("*agnth[%0d]*", i), "spi_agent_config", m_cfg.spi_cfg[i]);
       agnth[i]= spi_agent :: type_id :: create($sformatf("agnth[%0d]", i),this);
     end
 endfunction
