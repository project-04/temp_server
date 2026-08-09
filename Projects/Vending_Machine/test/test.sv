class test extends uvm_test;
	`uvm_component_utils(test)
	
	int no_of_wr_agents = 1;
	int no_of_rd_agents = 1;
	env envh;
	env_cfg env_cfg_h;
	virtual ven_if vif;
	
	wr_agt_cfg wr_agt_cfg_h[];
	rd_agt_cfg rd_agt_cfg_h[];
	
	
	function new(string name = "test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(virtual ven_if)::get(this, "", "ven_if", vif))
			`uvm_fatal("test", "can't get ven_if")
		
		envh = env::type_id::create("envh", this);
		env_cfg_h = env_cfg::type_id::create("env_cfg_h", this);
		env_cfg_h.no_of_wr_agents = no_of_wr_agents;
		env_cfg_h.no_of_rd_agents = no_of_rd_agents;
		uvm_config_db #(env_cfg)::set(this, "*", "env_cfg", env_cfg_h);
			
		wr_agt_cfg_h = new[no_of_wr_agents];
		foreach(wr_agt_cfg_h[i])
		begin
			wr_agt_cfg_h[i] = wr_agt_cfg::type_id::create($sformatf("wr_agt_cfg_h[%0d]", i));
			wr_agt_cfg_h[i].is_active = UVM_ACTIVE;
			wr_agt_cfg_h[i].vif = vif;
		uvm_config_db #(wr_agt_cfg)::set(this, $sformatf("envh.wr_agent[%0d]", i), "wr_agt_cfg", wr_agt_cfg_h[i]);
		end
		
		rd_agt_cfg_h = new[no_of_rd_agents];
		foreach(rd_agt_cfg_h[i])
		begin
			rd_agt_cfg_h[i] = rd_agt_cfg::type_id::create($sformatf("rd_agt_cfg_h[%0d]", i));
			rd_agt_cfg_h[i].is_active = UVM_PASSIVE;
			rd_agt_cfg_h[i].vif = vif;
		uvm_config_db #(rd_agt_cfg)::set(this, $sformatf("envh.rd_agent[%0d]", i), "rd_agt_cfg", rd_agt_cfg_h[i]);
		end
	endfunction
	
	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();
	endfunction
endclass


class test1 extends test;
	`uvm_component_utils(test1)
	
	wr_seq1 seq1_h;
	
	
	function new(string name = "test1", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		
		phase.raise_objection(this);
		seq1_h = wr_seq1::type_id::create("seq1_h");
		seq1_h.start(envh.wr_agent[0].seqr);
		#10;
		phase.drop_objection(this);
	endtask
endclass

