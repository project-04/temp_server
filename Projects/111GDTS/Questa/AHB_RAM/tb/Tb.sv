class Tb extends uvm_env;

	`uvm_component_utils(Tb)

	ahb_agent_top ahb_top;
	virtual_sequencer v_sequencer;
	scoreboard sb;
	env_config m_cfg;
	
	extern function new(string name = "Tb",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
//	extern function void end_of_elaboration_phase(uvm_phase phase);
endclass

	function Tb::new(string name = "Tb",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void Tb::build_phase(uvm_phase phase);
		if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
			`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
		if (m_cfg.has_ahb_agent)
		begin
			ahb_top = ahb_agent_top::type_id::create("ahb_top",this); 	
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

	function void Tb::connect_phase(uvm_phase phase);
		if(m_cfg.has_ahb_agent) begin
			foreach(v_sequencer.ahb_seqrh[i]) begin
				v_sequencer.ahb_seqrh[i] = ahb_top.hagnt[i].hseqr;
			end
		end

		if(m_cfg.has_scoreboard) begin
			foreach(sb.fifo_ahb_h[i]) begin
				ahb_top.hagnt[i].hmon.monitor_port.connect(sb.fifo_ahb_h[i].analysis_export);
			end
		end 
	endfunction

/*	function void Tb::end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology;
	endfunction*/


