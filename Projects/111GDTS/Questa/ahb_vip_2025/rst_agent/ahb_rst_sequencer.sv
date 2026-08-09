 class ahb_rst_sequencer extends uvm_sequencer#(ahb_rst_trans);
   `uvm_component_utils(ahb_rst_sequencer)
   extern function new(string name="ahb_rst_sequencer", uvm_component parent);
 endclass
 //--------------------------- new --------------------
 function ahb_rst_sequencer::new(string name="ahb_rst_sequencer", uvm_component parent);
   super.new(name,parent);
 endfunction
