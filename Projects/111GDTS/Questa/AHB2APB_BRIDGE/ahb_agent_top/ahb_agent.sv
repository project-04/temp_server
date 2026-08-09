class ahb_agent extends uvm_agent;

`uvm_component_utils(ahb_agent)

ahb_drv  hdrv;
ahb_mon  hmon;
ahb_seqr hseqr;

ahb_agent_config hcfg;
env_config m_cfg;

extern function new(string name="ahb_agent",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);

endclass

function ahb_agent::new(string name ="ahb_agent",uvm_component parent);
  super.new(name,parent);
endfunction

function void ahb_agent::build_phase(uvm_phase phase);
      if(!uvm_config_db #(ahb_agent_config)::get(this,"","ahb_agent_top",hcfg))
      `uvm_fatal("CONFIG","cannot get hcfg from uvm_config_db")
      super.build_phase(phase);
       hmon = ahb_mon::type_id::create("hmon",this);
    if(hcfg.is_active==UVM_ACTIVE)
       begin
              hdrv=ahb_drv::type_id::create("hdrv",this);
              hseqr = ahb_seqr::type_id::create("hseqr",this);
       end
endfunction
 
function void ahb_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  hdrv.seq_item_port.connect(hseqr.seq_item_export);
endfunction

function void ahb_agent::end_of_elaboration_phase(uvm_phase phase);
  uvm_top.print_topology;
endfunction



