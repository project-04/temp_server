

class base_test extends uvm_test;

	`uvm_component_utils(base_test);

	function new (string name = "base_test",uvm_component parent);
		super.new(name,parent);
	endfunction 

	environment env;
	
	env_config env_cfg;
	apb_config apb_cfg[];
	ahb_config ahb_cfg[];
	
	int no_of_apb_agents = 1;
	int no_of_ahb_agents = 1;
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		env_cfg = env_config::type_id::create("env_cfg");

		apb_cfg = new[this.no_of_apb_agents];
		ahb_cfg = new[this.no_of_ahb_agents];

		env_cfg.ahb_cfg = new[this.no_of_ahb_agents];
		env_cfg.apb_cfg = new[this.no_of_apb_agents];

		env_cfg.no_of_apb_agents = no_of_apb_agents;
		env_cfg.no_of_ahb_agents = no_of_ahb_agents;
			

		foreach(apb_cfg[i])
			begin 
			
				apb_cfg[i] = apb_config::type_id::create($sformatf("apb_cfg[%0d]",i));

				if(!uvm_config_db#(virtual apb_if)::get(this,"","apb_if",apb_cfg[i].apb_f))
					`uvm_fatal("TEST","failed to get apb interface");

				if(i == 0)
					begin
						apb_cfg[i].is_active = UVM_ACTIVE;
						uvm_config_db#(apb_config)::set(this,$sformatf("*apb_agt[%0d]*",i),"apb_config",apb_cfg[i]);
					end

				else
					begin 
						apb_cfg[i].is_active = UVM_PASSIVE;
						uvm_config_db#(apb_config)::set(this,$sformatf("*apb_agt[%0d]*",i),"apb_config",apb_cfg[i]);
					end
				
				env_cfg.apb_cfg[i] = apb_cfg[i];

			end


		foreach(ahb_cfg[i])
			begin 
				
				ahb_cfg[i] = ahb_config::type_id::create($sformatf("ahb_cfg[%0d]",i));
			
				if(!uvm_config_db#(virtual ahb_if)::get(this,"","ahb_if",ahb_cfg[i].ahb_f))
					`uvm_fatal("TEST","failed to get the ahb interface");

				if(i == 0)
					begin 
						ahb_cfg[i].is_active = UVM_ACTIVE;
						uvm_config_db#(ahb_config)::set(this,$sformatf("*ahb_agt[%0d]*",i),"ahb_config",ahb_cfg[i]);
					end

				else
					begin 
						ahb_cfg[i].is_active = UVM_PASSIVE;
						uvm_config_db#(ahb_config)::set(this,$sformatf("*ahb_agt[%0d]*",i),"ahb_config",ahb_cfg[i]);
					end
					
				env_cfg.ahb_cfg[i] = ahb_cfg[i];
				
			end

			uvm_config_db#(env_config)::set(this,"*","env_config",env_cfg);

			env = environment::type_id::create("env",this);

		endfunction 


	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		
			uvm_top.print_topology();

	endfunction 

endclass
		
							

		 
class single_sequence_test extends base_test;

	`uvm_component_utils(single_sequence_test)
	
	function new (string name = "single_sequence_test",uvm_component parent);
		super.new(name,parent);
	endfunction 

	single_sequence ss_handle;
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		ss_handle = single_sequence::type_id::create("ss_handle");
		
	endfunction 

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		ss_handle.start(env.ahb_agt_top.ahb_agt[0].ahb_seqr);
		phase.drop_objection(this);
	endtask

endclass
	
	
	
	
	
	
class inc_undefined_test extends base_test;

	`uvm_component_utils(inc_undefined_test)
		
	function new (string name = "inc_undefined_test",uvm_component parent);
		super.new(name,parent);
	endfunction 	
	
	inc_undefined_sequence inc_handle;
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		inc_handle = inc_undefined_sequence::type_id::create("inc_handle");
		
	endfunction 	
	
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		inc_handle.start(env.ahb_agt_top.ahb_agt[0].ahb_seqr);
		phase.drop_objection(this);
	endtask

endclass	








class inc_by_4_test extends base_test;

	`uvm_component_utils(inc_by_4_test)

	function new(string name = "inc_by_4_test",uvm_component parent);
		super.new(name,parent);
	endfunction 

	inc_by_4_sequence inc4_handle;
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		inc4_handle = inc_by_4_sequence::type_id::create("inc4_handle");
		
	endfunction 	

	
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		inc4_handle.start(env.ahb_agt_top.ahb_agt[0].ahb_seqr);
		phase.drop_objection(this);
	endtask	

endclass





class inc_by_8_test extends base_test;

	`uvm_component_utils(inc_by_8_test)

	function new (string name = "inc_by_8_test",uvm_component parent);
		super.new(name,parent);
	endfunction 

	inc_by_8_sequence inc8_handle;

	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		inc8_handle = inc_by_8_sequence::type_id::create("inc8_handle");
		
	endfunction 	

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		inc8_handle.start(env.ahb_agt_top.ahb_agt[0].ahb_seqr);
		phase.drop_objection(this);
	endtask


endclass





class inc_by_16_test extends base_test;

	`uvm_component_utils(inc_by_16_test)

	function new (string name = "inc_by_16_test",uvm_component parent);
		super.new(name,parent);
	endfunction 

	inc_by_16_sequence inc16_handle;

	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		inc16_handle = inc_by_16_sequence::type_id::create("inc16_handle");
		
	endfunction 	

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		inc16_handle.start(env.ahb_agt_top.ahb_agt[0].ahb_seqr);
		phase.drop_objection(this);
	endtask


endclass






class wrap_4_test extends base_test;

	`uvm_component_utils(wrap_4_test)

	function new (string name = "wrap_4_test",uvm_component parent);
		super.new(name,parent);
	endfunction 

	wrap_4_sequence wrap4_handle;

	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		wrap4_handle = wrap_4_sequence::type_id::create("wrap4_handle");
		
	endfunction 	

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		wrap4_handle.start(env.ahb_agt_top.ahb_agt[0].ahb_seqr);
		phase.drop_objection(this);
	endtask


endclass




class wrap_8_test extends base_test;

	`uvm_component_utils(wrap_8_test)

	function new (string name = "wrap_8_test",uvm_component parent);
		super.new(name,parent);
	endfunction 

	wrap_8_sequence wrap8_handle;

	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		wrap8_handle = wrap_8_sequence::type_id::create("wrap8_handle");
		
	endfunction 	

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		wrap8_handle.start(env.ahb_agt_top.ahb_agt[0].ahb_seqr);
		phase.drop_objection(this);
	endtask


endclass





class wrap_16_test extends base_test;

	`uvm_component_utils(wrap_16_test)

	function new (string name = "wrap_16_test",uvm_component parent);
		super.new(name,parent);
	endfunction 

	wrap_16_sequence wrap16_handle;

	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		wrap16_handle = wrap_16_sequence::type_id::create("wrap16_handle");
		
	endfunction 	

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		wrap16_handle.start(env.ahb_agt_top.ahb_agt[0].ahb_seqr);
		phase.drop_objection(this);
	endtask


endclass

