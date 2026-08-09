class env_cfg extends uvm_object;

	`uvm_object_utils(env_cfg)
apb_cfg apb_cfgh;
aux_cfg aux_cfgh;
io_cfg io_cfgh;

	bit has_apb_agt_top = 1;
	bit has_aux_agt_top = 1;
	bit has_io_agt_top = 1;
	bit has_scoreboard  = 1;


	extern function new(string name = "env_cfg");

endclass

function env_cfg::new(string name = "env_cfg");
  super.new(name);
endfunction
