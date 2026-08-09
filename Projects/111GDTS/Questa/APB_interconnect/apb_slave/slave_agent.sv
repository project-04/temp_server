class slave_agent extends uvm_agent;

`uvm_component_utils(slave_agent)

	slave_driver  drv;
	slave_monitor  mon;
	slave_seqr seqr;

	slave_config cfg;

extern function new(string name="slave_agent",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);

endclass

function slave_agent::new(string name ="slave_agent",uvm_component parent);
  super.new(name,parent);
endfunction

function void slave_agent::build_phase(uvm_phase phase);

      if(!uvm_config_db #(slave_config)::get(this,"","slave_config",cfg))
          `uvm_fatal("CONFIG","cannot get cfg from uvm_config_db")
   
   super.build_phase(phase);

       mon = slave_monitor::type_id::create("mon",this);

    if(cfg.is_active==UVM_ACTIVE)
       begin
              drv=slave_driver::type_id::create("drv",this);
              seqr = slave_seqr::type_id::create("seqr",this);
       end
endfunction
 
function void slave_agent::connect_phase(uvm_phase phase);
  drv.seq_item_port.connect(seqr.seq_item_export);
endfunction

function void slave_agent::end_of_elaboration_phase(uvm_phase phase);
endfunction




