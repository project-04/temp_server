//**************************************//Base_test
class base_test extends uvm_test;
	`uvm_component_utils(base_test)

	env 		env_h;
	
    	env_config 	env_cfg;
	master_config 	master_cfg[];
	slave_config 	slave_cfg[];
	
	int no_of_transations 	= 20;
	int no_of_master_agents = 1;
	int no_of_slave_agents  = 1;

	function new(string name="base_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void config_test();

		master_cfg 	= new[no_of_master_agents];
		slave_cfg 	= new[no_of_slave_agents];

		foreach(master_cfg[i])
		  	begin
		            master_cfg[i] 		= master_config::type_id::create($sformatf("master_cfg[%0d]",i));

			    if(! uvm_config_db #(virtual axi_if)::get(this,"","axi_if",master_cfg[i].mif))
				`uvm_fatal(get_type_name(),"Have you set the config correctly?");

			    master_cfg[i].is_active 	= UVM_ACTIVE;
		  	end

		foreach(slave_cfg[i])
			begin
			    slave_cfg[i] 		= slave_config::type_id::create($sformatf("slave_cfg[%0d]",i));

			    if(! uvm_config_db #(virtual axi_if)::get(this,"","axi_if",slave_cfg[i].sif))
				`uvm_fatal(get_type_name(),"Have you set the config correctly?");

			    slave_cfg[i].is_active 	= UVM_ACTIVE;
			end

		env_cfg.master_cfg 		= master_cfg;
		env_cfg.slave_cfg 		= slave_cfg;
		env_cfg.no_of_transations 	= no_of_transations;
		env_cfg.no_of_master_agents 	= no_of_master_agents;
		env_cfg.no_of_slave_agents 	= no_of_slave_agents;

	endfunction

	function void build_phase(uvm_phase phase);
	
		super.build_phase(phase);

		env_cfg = env_config::type_id::create("env_cfg");
		config_test();

		//uvm_config_db #(env_config)::set(null,"","env_config",env_cfg);
		uvm_config_db #(env_config)::set(this,"*","env_config",env_cfg);
		env_h = env::type_id::create("env_h",this);
		
	endfunction 

	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
		$display("\n\n\n################################################ BASE TEST ################################################\n\n\n");
	endfunction

endclass

//****************************************//Fixed Burst Test
class fixed_burst_test extends base_test;
	`uvm_component_utils(fixed_burst_test)
	
	fixed_burst_seq		fixed_burst_seqh;
	
	function new(string name="fixed_burst_test", uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
         	super.build_phase(phase);
        endfunction

	task run_phase(uvm_phase phase);
		
		phase.raise_objection(this);
		
		fixed_burst_seqh = fixed_burst_seq::type_id::create("fixed_burst_seqh");
		
		foreach(env_h.master_agt_top.master_agt[i])
			fixed_burst_seqh.start(env_h.master_agt_top.master_agt[i].master_seqrh);
		
		wait(no_of_transations == total_no_of_xtns) phase.drop_objection(this);
		
		$display("\n\n\n################################################ FIXED BURST TEST ################################################\n\n\n");
	endtask
	
endclass

//****************************************//INCR Burst Test(Aligned)
class incr_aligned_burst_test extends base_test;
	`uvm_component_utils(incr_aligned_burst_test)
	
	incr_aligned_burst_seq		incr_aligned_burst_seqh;
	
	function new(string name="incr_aligned_burst_test", uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
         	super.build_phase(phase);
        endfunction

	task run_phase(uvm_phase phase);
		
		phase.raise_objection(this);
		
		incr_aligned_burst_seqh = incr_aligned_burst_seq::type_id::create("incr_aligned_burst_seqh");
		
		foreach(env_h.master_agt_top.master_agt[i])
			incr_aligned_burst_seqh.start(env_h.master_agt_top.master_agt[i].master_seqrh);
		
		wait(no_of_transations == total_no_of_xtns) phase.drop_objection(this);
		
		$display("\n\n\n################################################ INCE ALIGNED BURST TEST ################################################\n\n\n");
	endtask
	
endclass

//****************************************//INCR Burst Test(Unaligned)
class incr_unaligned_burst_test extends base_test;
	`uvm_component_utils(incr_unaligned_burst_test)
	
	incr_unaligned_burst_seq	incr_unaligned_burst_seqh;
	
	function new(string name="incr_unaligned_burst_test", uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
         	super.build_phase(phase);
        endfunction

	task run_phase(uvm_phase phase);
		
		phase.raise_objection(this);
		
		incr_unaligned_burst_seqh = incr_unaligned_burst_seq::type_id::create("incr_unaligned_burst_seqh");
		
		foreach(env_h.master_agt_top.master_agt[i])
			incr_unaligned_burst_seqh.start(env_h.master_agt_top.master_agt[i].master_seqrh);

		wait(no_of_transations == total_no_of_xtns) phase.drop_objection(this);
		
		$display("\n\n\n################################################ INCE UNALIGNED BURST TEST ################################################\n\n\n");
	endtask
	
endclass
//****************************************//WRAP Burst Test
class wrap_burst_test extends base_test;
	`uvm_component_utils(wrap_burst_test)
	
	wrap_burst_seq		wrap_burst_seqh;
	
	function new(string name="wrap_burst_test", uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
         	super.build_phase(phase);
        endfunction

	task run_phase(uvm_phase phase);
		
		phase.raise_objection(this);
		
		wrap_burst_seqh = wrap_burst_seq::type_id::create("wrap_burst_seqh");
		
		foreach(env_h.master_agt_top.master_agt[i])
			wrap_burst_seqh.start(env_h.master_agt_top.master_agt[i].master_seqrh);

		wait(no_of_transations == total_no_of_xtns) phase.drop_objection(this);
		
		$display("\n\n\n################################################ WRAP BURST TEST ################################################\n\n\n");
	endtask
	
endclass























