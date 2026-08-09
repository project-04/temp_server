class env extends uvm_env;

	`uvm_component_utils(env)

	master_agent magth[];
	slave_agent sagth[];
	virtual_sequencer v_sequencer;
	scoreboard sb;
	env_config m_cfg;
	
	extern function new(string name = "env",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
endclass

	function env::new(string name = "env",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void env::build_phase(uvm_phase phase);

		if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
			`uvm_fatal("Environment","cannot get() m_cfg from uvm_config_db. Have you set() it?") 

		magth = new[m_cfg.no_of_master_agent]; 
		sagth = new[m_cfg.no_of_slave_agent]; 

		if (m_cfg.has_master_agent)
		begin
		  foreach(magth[i])
		    begin
			magth[i] = master_agent::type_id::create($sformatf("magth[%0d]",i),this); 
		        uvm_config_db #(master_config)::set(this,$sformatf("magth[%0d]*",i),"master_config", m_cfg.mcfg[i]);
		    end
		end

		if (m_cfg.has_slave_agent)
		begin
		   foreach(sagth[i])
		     begin
			sagth[i] = slave_agent::type_id::create($sformatf("sagth[%0d]",i),this); 	
			uvm_config_db #(slave_config)::set(this,$sformatf("sagth[%0d]*",i),"slave_config", m_cfg.scfg[i]);
		     end
		end

		if (m_cfg.has_virtual_sequencer)
		begin
			v_sequencer = virtual_sequencer::type_id::create("v_sequencer",this); 	
		end

		if (m_cfg.has_scoreboard)
		begin
			sb = scoreboard::type_id::create("sb",this); 	
		end
	endfunction

	function void env::connect_phase(uvm_phase phase);
		if(m_cfg.has_master_agent)
			begin
			   foreach(v_sequencer.mst_seqrh[i]) 
			     begin
			        v_sequencer.mst_seqrh[i] = magth[i].seqr;
			     end
			end
		if(m_cfg.has_slave_agent)
		   begin
			foreach(v_sequencer.slv_seqrh[i])
			   begin
			     v_sequencer.slv_seqrh[i] = sagth[i].seqr;
			   end
		   end 
		if(m_cfg.has_scoreboard)
		    begin
		     foreach(sb.mst_fifo[i]) 
			begin
			   magth[i].mon.monitor_port.connect(sb.mst_fifo[i].analysis_export);
			end

		    foreach(sb.slv_fifo[i])
			begin
				sagth[i].mon.monitor_port.connect(sb.slv_fifo[i].analysis_export);
			end
		    end 
	endfunction




