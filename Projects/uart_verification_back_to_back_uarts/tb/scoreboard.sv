class scoreboard extends uvm_scoreboard;
	 `uvm_component_utils(scoreboard)
	 
	 uvm_tlm_analysis_fifo #(trans) fifoh;
        
    	function new(string name="scoreboard",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
	  	super.build_phase(phase);
	  	
	  	fifoh = new("fifoh", this);
	endfunction
endclass
