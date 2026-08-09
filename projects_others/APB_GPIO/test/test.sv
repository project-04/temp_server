class test extends uvm_test;

	`uvm_component_utils(test)

	function new(string name = "test",uvm_component parent);
		super.new(name,parent);
	endfunction

	environment env_h;
	env_config env_cfg;
	apb_config apb_cfg[];
	aux_config aux_cfg[];
	io_config  io_cfg[];

	int no_of_apb_agt = 1;
	int no_of_aux_agt = 1;
	int no_of_io_agt = 1;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

	env_cfg = env_config::type_id::create("env_cfg");
	
	apb_cfg = new[this.no_of_apb_agt];
	aux_cfg = new[this.no_of_aux_agt];	
	io_cfg = new[this.no_of_io_agt];

	env_cfg.apb_cfg = new[no_of_apb_agt];
	env_cfg.aux_cfg = new[no_of_aux_agt];
	env_cfg.io_cfg = new[no_of_io_agt];

	foreach(apb_cfg[i])
		begin
			apb_cfg[i] = apb_config::type_id::create($sformatf("apb_cfg[%0d]",i),this);
			if(!uvm_config_db#(apb_config)::get(this,"","apb_if",apb_cfg[i].vif))
				`uvm_fatal("get_type_name","failed to get config")	
			apb_cfg[i].is_active=UVM_ACTIVE;
			env_cfg.apb_cfg[i]=apb_cfg[i];
		end

	foreach(aux_cfg[i])
		begin
			aux_cfg[i] = aux_config::type_id::create($sformatf("aux_cfg[%0d]",i),this);
			aux_cfg[i].is_active=UVM_ACTIVE;
			env_cfg.aux_cfg[i]=aux_cfg[i];
		end

	foreach(io_cfg[i])
		begin
			io_cfg[i] = io_config::type_id::create($sformatf("io_cfg[%0d]",i),this);
			io_cfg[i].is_active=UVM_ACTIVE;
			env_cfg.io_cfg[i]=io_cfg[i];
		end

	env_cfg.no_of_apb_agt = no_of_apb_agt;
	env_cfg.no_of_aux_agt = no_of_aux_agt;
	env_cfg.no_of_io_agt = no_of_io_agt;

	uvm_config_db#(env_config)::set(this,"*","env_config",env_cfg);
	
	env_h = environment::type_id::create("env_h",this);
	
    endfunction
	
	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
		factory.print();	
	endfunction
	
endclass
