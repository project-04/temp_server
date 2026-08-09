class scoreboard extends uvm_scoreboard;

	`uvm_component_utils(scoreboard)
	
	uvm_tlm_analysis_fifo#(io_xtn) io_f;
	uvm_tlm_analysis_fifo#(apb_xtn) apb_f;
	uvm_tlm_analysis_fifo#(aux_xtn) aux_f;

	function new(string name="scoreboard",uvm_component parent);
		super.new(name,parent);
		io_f = new("io_f",this);
		apb_f = new("apb_f",this);
		aux_f = new("aux_f",this);	
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
endclass
