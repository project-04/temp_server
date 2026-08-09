class apb_agent extends uvm_agent;
	`uvm_component_utils(apb_agent)
	
	monitor monh;
	sequencer seqrh;
	driver drvh;
	agent_config agent_configh;
		
	function new(string name = "apb_agent", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(agent_config)::get(this, "", "agent_config", agent_configh))
		begin
			`uvm_fatal("apb_agent", "cannot get the agent_configh form agent_config");
		end
		
		monh = monitor::type_id::create("monh", this);
		
		if(agent_configh.is_active == UVM_ACTIVE)
		begin
			seqrh = sequencer::type_id::create("seqrh", this); 
			drvh  = driver::type_id::create("drvh", this);
		end
	endfunction
  
	function void connect_phase(uvm_phase phase);
		if(agent_configh.is_active==UVM_ACTIVE)
		begin
			drvh.seq_item_port.connect(seqrh.seq_item_export);
	  	end
	endfunction
endclass
