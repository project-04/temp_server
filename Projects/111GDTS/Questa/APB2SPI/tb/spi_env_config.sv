class spi_env_config extends uvm_object;
   `uvm_object_utils(spi_env_config)

   //Properties
   bit has_functional_coverage =0;
   bit has_virtual_sequencer =1;
   bit has_scoreboard =1;
	
   bit has_apb_agt;
   bit has_spi_agt;

   int no_of_apb_agent;
   int no_of_spi_agent;
	
   apb_agent_config apb_cfg[];
   spi_agent_config spi_cfg[];

   spi_reg_block spi_rg_blk;
   //Methods
   extern function new(string name ="spi_env_config");
 endclass

 function spi_env_config :: new(string name="spi_env_config");
   super.new(name);
 endfunction
