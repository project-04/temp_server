class sl_agent extends uvm_agent;

	`uvm_component_utils(sl_agent)

sl_driver drvh;
sl_monitor monh;
sl_sequencer seqrh;
sl_agent_config sl_cfg;
extern function new(string name ="sl_agent" ,uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass

function sl_agent::new(string name ="sl_agent", uvm_component parent);
	super.new(name,parent);
endfunction

function void sl_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	uvm_config_db#(sl_agent_config)::get(this,"","sl_agent_config",sl_cfg);


	monh=sl_monitor::type_id::create("monh",this);
if(sl_cfg.is_active==UVM_ACTIVE)
	begin
		drvh=sl_driver::type_id::create("drvh",this);
		seqrh=sl_sequencer::type_id::create("seqrh",this);
	end
`uvm_info("sl_agent","This is in Sl_Agent",UVM_LOW)
endfunction

function void sl_agent::connect_phase(uvm_phase phase);

//if(wb_agt_cfg.is_active == UVM_ACTIVE)
		begin
		drvh.seq_item_port.connect(seqrh.seq_item_export);
		end
		
endfunction


