 class router_env extends uvm_env;
	`uvm_component_utils(router_env)

	src_agt_top src_agt_top_h[];
	dest_agt_top dest_agt_top_h[];

	scoreboard sb_h;
	v_sequencer v_seqr;
	
	env_config env_cfg;
	
	function new(string name = "router_env",uvm_component parent = null);
		super.new(name,parent);
	endfunction
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);	
		if(!uvm_config_db #(env_config)::get(this,"","env_cfg",env_cfg))
			`uvm_fatal("ENV","not able to get")

		src_agt_top_h = new[env_cfg.no_of_src_agt_top];
		dest_agt_top_h= new[env_cfg.no_of_dest_agt_top];
		

		foreach(src_agt_top_h[i])
			begin 

				src_agt_top_h[i] = src_agt_top::type_id::create($sformatf("src_agt_top_h[%0d]",i),this);
			end

		foreach(dest_agt_top_h[i])
			begin
				dest_agt_top_h[i] = dest_agt_top::type_id::create($sformatf("dest_agt_top_h[%0d]",i),this);
			end
		v_seqr         = v_sequencer::type_id::create("v_sequencer",this);
		v_seqr.dest_seqrh = new[env_cfg.no_of_dest_agt];
		
		sb_h	       = scoreboard::type_id::create("scoreboard",this);

	endfunction

	virtual function void connect_phase(uvm_phase phase);
		v_seqr.src_seqrh = src_agt_top_h[0].src_agth[0].m_sequencer;
		
		for(int i = 0;i<env_cfg.no_of_dest_agt;i++)
			begin
				v_seqr.dest_seqrh[i] = dest_agt_top_h[0].dest_agth[i].m_sequencer;			
			end
			
		src_agt_top_h[0].src_agth[0].src_monh.src_mon_ap.connect(sb_h.src_fifo.analysis_export);
		dest_agt_top_h[0].dest_agth[0].dest_monh.dest_mon_ap.connect(sb_h.dest_fifo_0.analysis_export);
		dest_agt_top_h[0].dest_agth[1].dest_monh.dest_mon_ap.connect(sb_h.dest_fifo_1.analysis_export);	
		dest_agt_top_h[0].dest_agth[2].dest_monh.dest_mon_ap.connect(sb_h.dest_fifo_2.analysis_export);  
						
	endfunction
		
		
endclass

