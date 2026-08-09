class base_test extends uvm_test;
	`uvm_component_utils(base_test)
    		
	env envh;
	env_config env_configh;
	     
	wr_agent_config wr_agent_configh[];
	rd_agent_config rd_agent_configh[];
 
	
 	virtual counter_if vif0;

    	int no_of_agents = 1;
    	
	sequence_xtns_vseq seq_xtns_vseq;
		
	function new(string name = "base_test" , uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
	    	super.build_phase(phase);
         
         	if(!uvm_config_db #(virtual counter_if)::get(this, "", "counter_if0", vif0))
        		`uvm_fatal("base_test", "cannot get the vif0 form counter_if0");
           	
      		envh = env::type_id::create("envh", this);
      		env_configh = env_config::type_id::create("env_configh", this);
      		env_configh.no_of_agents = no_of_agents;
      		uvm_config_db #(env_config)::set(this,"envh*","env_config",env_configh);
      		
      		wr_agent_configh = new[no_of_agents];
         	rd_agent_configh = new[no_of_agents];
      		
      		foreach(wr_agent_configh[i])
		begin
      			wr_agent_configh[i] = wr_agent_config::type_id::create($sformatf("wr_agent_configh[%d]",i), this);
      			wr_agent_configh[i].vif = vif0;
       			wr_agent_configh[i].is_active = UVM_ACTIVE;
		 	uvm_config_db #(wr_agent_config)::set(this,$sformatf("envh.wr_agent_toph.wr_agenth[%0d]",i),"wr_agent_config",wr_agent_configh[i]);
        	end
         
         	foreach(rd_agent_configh[i])
		begin
      			rd_agent_configh[i] = rd_agent_config::type_id::create($sformatf("rd_agent_configh[%d]",i), this);
      			rd_agent_configh[i].vif = vif0;
       			rd_agent_configh[i].is_active = UVM_PASSIVE;
		 	uvm_config_db #(rd_agent_config)::set(this,$sformatf("envh.rd_agent_toph.rd_agenth[%0d]",i),"rd_agent_config",rd_agent_configh[i]);
        	end
	endfunction: build_phase
    	
	function void end_of_elaboration_phase(uvm_phase phase);
     		super.end_of_elaboration_phase(phase);
     		
		uvm_top.print_topology;
	endfunction
endclass

class sequence_test extends base_test;
	`uvm_component_utils(sequence_test)
	
	//sequence_xtns_vseq seq_xtns_vseq;

 	function new(string name = "sequence_test", uvm_component parent);
		super.new(name, parent);
  	endfunction
 
  	task run_phase(uvm_phase phase);
    		super.run_phase(phase);

         	phase.raise_objection(this);
          	seq_xtns_vseq = sequence_xtns_vseq::type_id::create("seq_xtns_vseq");
          	seq_xtns_vseq.start(envh.v_sequencer);
          	//seq_xtns_vseq.start(envh.wr_agent_toph.wr_agenth[0].wr_seqrh);
          	//#40;
         	phase.drop_objection(this);
          
          $display("\n\n\n------------------------------------------------Mod 12 Counter------------------------------------------------\n\n\n");
  	endtask
endclass

