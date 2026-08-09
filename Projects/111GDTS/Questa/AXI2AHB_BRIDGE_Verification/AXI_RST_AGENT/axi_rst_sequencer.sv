 class axi_rst_sequencer extends uvm_sequencer#(axi_rst_trans);
   `uvm_component_utils(axi_rst_sequencer)

   extern function new(string name="axi_rst_sequencer", uvm_component parent);
 endclass
 //--------------------------- new --------------------
 function axi_rst_sequencer::new(string name="axi_rst_sequencer", uvm_component parent);
   super.new(name,parent);
 endfunction

