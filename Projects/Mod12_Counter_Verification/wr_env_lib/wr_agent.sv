class wr_agent extends uvm_agent;
	`uvm_component_utils(wr_agent)
	
	wr_monitor wr_monh;
	wr_sequencer wr_seqrh;
	wr_driver wr_drvh;
	wr_agent_config wr_agent_configh;
		
	function new(string name = "wr_agent", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(wr_agent_config)::get(this, "", "wr_agent_config", wr_agent_configh))
		begin
			`uvm_fatal("wr_agent", "cannot get the wr_agent_configh form wr_agent_config");
		end
		
		wr_monh = wr_monitor::type_id::create("wr_monh", this);
		
		if(agent_configh.is_active == UVM_ACTIVE)
		begin
			wr_seqrh = wr_sequencer::type_id::create("wr_seqrh", this); 
			wr_drvh  = wr_driver::type_id::create("wr_drvh", this);
		end
	endfunction
  
	function void connect_phase(uvm_phase phase);
		if(agent_configh.is_active==UVM_ACTIVE)
   		wr_monh.vif = wr_agent_config.vif;
		begin
			wr_drvh.seq_item_port.connect(wr_seqrh.seq_item_export);
   		wr_drvh.vif = wr_agent_config.vif;
	  	end
	endfunction
endclass
