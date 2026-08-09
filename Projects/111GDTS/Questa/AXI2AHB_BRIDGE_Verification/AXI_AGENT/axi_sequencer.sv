 class axi_sequencer extends uvm_sequencer#(axi_trans);
   `uvm_component_utils(axi_sequencer)
   extern function new(string name="axi_sequencer", uvm_component parent);
 endclass
 //--------------------------- new --------------------
 function axi_sequencer::new(string name="axi_sequencer", uvm_component parent);
   super.new(name,parent);
 endfunction
