class scoreboard extends uvm_scoreboard;

    `uvm_component_utils (scoreboard)

       	uvm_tlm_analysis_fifo #(apb_xtn) apb_fifo;
    	uvm_tlm_analysis_fifo #(aux_xtn) aux_fifo;
    	uvm_tlm_analysis_fifo #(io_xtn) io_fifo;
    
    extern function new(string name = "Scoreboard",  uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern task run_phase (uvm_phase phase);
    extern function void check_phase(uvm_phase phase);
endclass


  function scoreboard::new(string name = "Scoreboard",  uvm_component parent);
        super.new(name, parent);        
        apb_fifo = new("apb_fifo",this);
        aux_fifo = new("aux_fifo",this);
        io_fifo = new("io_fifo",this);
    endfunction: new
    
    /////////////////////////////////////////////////////////////////////////////////////
    
    function void scoreboard::build_phase(uvm_phase phase);

             super.build_phase(phase); 
    endfunction

    /////////////////////////////////////////////////////////////////////////////////////

    task scoreboard::run_phase(uvm_phase phase);
    /*    forever
            fork 
                begin
                    m_fifo.get(m_xtn);
                end 
                begin
                    s_fifo.get(s_xtn);
                end
            join_any */
    endtask

    /////////////////////////////////////////////////////////////////////////////////////

    function void scoreboard::check_phase(uvm_phase phase);
endfunction
