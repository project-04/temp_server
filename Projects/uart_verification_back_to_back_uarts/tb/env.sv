class env extends uvm_env;
	`uvm_component_utils(env)
	
	env_config env_configh;
	//agent_config agent_configh[];
	apb_agent apb_agenth[];
	virtual_sequencer v_sequencer;
	scoreboard sb;
	
	function new(string name="env",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);	
		super.build_phase(phase);

		if(!uvm_config_db #(env_config)::get(this, "", "env_config", env_configh))
			`uvm_fatal("env", "cannot get the env_configh form env_config");
        
        	//agent_configh = new[env_configh.no_of_agents];
     		apb_agenth = new[env_configh.no_of_agents];
            	
		foreach(apb_agenth[i])
		begin
			apb_agenth[i] = apb_agent::type_id::create($sformatf("apb_agenth[%0d]",i), this);
		end

      		v_sequencer = virtual_sequencer::type_id::create("v_sequencer", this);
   		sb = scoreboard::type_id::create("sb",this);
	endfunction: build_phase
 
 	function void connect_phase(uvm_phase phase);
  		super.connect_phase(phase);
  		
        	foreach(apb_agenth[i])
        	begin
			v_sequencer.seqrh[i] = apb_agenth[i].seqrh;
			apb_agenth[i].monh.monitor_port.connect(sb.fifoh.analysis_export);
		end
  	endfunction: connect_phase
endclass
