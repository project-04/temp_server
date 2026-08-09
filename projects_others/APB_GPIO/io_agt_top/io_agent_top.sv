class io_agent_top extends uvm_env;

	`uvm_component_utils(io_agent_top)

	env_config env_cfg;
	io_agent  io_agt[];

	function new(string name="io_agent_top",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(env_config)::get(this,"","env_config",env_cfg))
			`uvm_fatal(get_full_name(),"have you set it or not?")

		io_agt=new[env_cfg.no_of_io_agt];
		foreach(io_agt[i])
			begin
			     uvm_config_db#(io_config)::set(this,$sformatf("io_agt[%0d]*",i),"io_config",env_cfg.io_cfg[i]);
			     io_agt[i]=io_agent::type_id::create($sformatf("io_agt[%0d]",i),this);
			end
	endfunction

endclass

