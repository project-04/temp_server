class master_agent extends uvm_agent;

`uvm_component_utils(master_agent)

	master_driver  drv;
	master_monitor  mon;
	master_seqr seqr;

	master_config cfg;

extern function new(string name="master_agent",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);

endclass

function master_agent::new(string name ="master_agent",uvm_component parent);
  super.new(name,parent);
endfunction

function void master_agent::build_phase(uvm_phase phase);

      if(!uvm_config_db #(master_config)::get(this,"","master_config",cfg))
          `uvm_fatal("CONFIG","cannot get cfg from uvm_config_db")
   
   super.build_phase(phase);

       mon = master_monitor::type_id::create("mon",this);

    if(cfg.is_active==UVM_ACTIVE)
       begin
              drv=master_driver::type_id::create("drv",this);
              seqr = master_seqr::type_id::create("seqr",this);
       end
endfunction
 
function void master_agent::connect_phase(uvm_phase phase);
  drv.seq_item_port.connect(seqr.seq_item_export);
endfunction

function void master_agent::end_of_elaboration_phase(uvm_phase phase);
  uvm_top.print_topology;
endfunction




