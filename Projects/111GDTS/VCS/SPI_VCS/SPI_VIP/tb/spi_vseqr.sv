class spi_vseqr extends uvm_sequencer#(uvm_sequence_item);

//FACTORY
	`uvm_component_utils(spi_vseqr)

//MEMBERS
	master_sequencer m_seqr;
	slave_sequencer  s_seqr;

//METHODS
		extern function new(string name = "spi_vseqr",uvm_component parent);
endclass

//CONSTRUCTOR
	function spi_vseqr::new(string name = "spi_vseqr",uvm_component parent);
		super.new(name,parent);
	endfunction

