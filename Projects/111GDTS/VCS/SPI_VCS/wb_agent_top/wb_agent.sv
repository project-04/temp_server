class wb_agent extends uvm_agent;

	`uvm_component_utils(wb_agent)

wb_driver drvh;
wb_monitor monh;
wb_sequencer seqrh;
		wb_agent_config wb_cfg;

extern function new(string name ="wb_agent" ,uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass

function wb_agent::new(string name ="wb_agent", uvm_component parent);
	super.new(name,parent);
endfunction

function void wb_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);

monh=wb_monitor::type_id::create("monh",this);

uvm_config_db#(wb_agent_config)::get(this,"","wb_agent_config",wb_cfg);

if(wb_cfg.is_active==UVM_ACTIVE)
begin
drvh=wb_driver::type_id::create("drvh",this);
seqrh=wb_sequencer::type_id::create("seqrh",this);
end
`uvm_info("wb_agent","This is in WB_AGENT",UVM_LOW)
endfunction

function void wb_agent::connect_phase(uvm_phase phase);

if(wb_cfg.is_active == UVM_ACTIVE)
		begin
		drvh.seq_item_port.connect(seqrh.seq_item_export);
		end
		
endfunction


