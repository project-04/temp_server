class env extends uvm_env;
	`uvm_component_utils(env)
	
	env_config env_configh;
 
	wr_agent_top wr_agent_toph;
	rd_agent_top rd_agent_toph;
 
	virtual_sequencer v_sequencer;
	scoreboard sb;
	
	function new(string name="env",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);	
		super.build_phase(phase);

		if(!uvm_config_db #(env_config)::get(this, "", "env_config", env_configh))
			`uvm_fatal("env", "cannot get the env_configh form env_config");

			wr_agent_toph =  wr_agent_top::type_id::create("wr_agent_toph", this);

			rd_agent_toph =  rd_agent_top::type_id::create("rd_agent_toph", this);

   		
      			v_sequencer = virtual_sequencer::type_id::create("v_sequencer", this);
   		
      			sb = scoreboard::type_id::create("sb",this);	
	endfunction: build_phase
 
 	function void connect_phase(uvm_phase phase);
  		super.connect_phase(phase);
  		
  		for(int i=0; i<env_configh.no_of_agents; i++)
  		begin
				v_sequencer.seqrh[i] = wr_agent_toph.wr_agenth[i].wr_seqrh;
  		end
  

		for(int i=0; i<env_configh.no_of_agents; i++)
		begin
  	      			wr_agent_toph.wr_agenth[i].wr_monh.monitor_port.connect(sb.wr_fifo.analysis_export);
  	      			rd_agent_toph.rd_agenth[i].rd_monh.monitor_port.connect(sb.rd_fifo.analysis_export);
  		end   
  	endfunction: connect_phase
endclass
