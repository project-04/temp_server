class spi_env_config extends uvm_object;

//FACTORY
	`uvm_object_utils(spi_env_config)


//DATA MEMBERS
bit has_master_agent =1;
bit has_slave_agent =1;
bit has_virtual_seq =1;
bit has_scoreboard =1;


master_agent_config  master_cfg;
slave_agent_config   slave_cfg;


//METHODS
	extern function new(string name = "spi_env_config");

endclass

function spi_env_config::new(string name = "spi_env_config");
	super.new(name);
endfunction

