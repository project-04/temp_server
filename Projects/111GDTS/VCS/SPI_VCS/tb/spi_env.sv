class spi_env extends uvm_env;

        `uvm_component_utils(spi_env)
wb_agent_top wb_agt_h;
sl_agent_top sl_agt_h;
spi_scoreboard sb;
	extern function new(string name = "spi_env",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
	 extern function void connect_phase(uvm_phase phase);

endclass

function spi_env::new(string name = "spi_env",uvm_component parent);
		super.new(name,parent);
endfunction

function void spi_env::build_phase(uvm_phase phase);
	super.build_phase(phase);
wb_agt_h=wb_agent_top::type_id::create("wb_agt_h",this);
sl_agt_h=sl_agent_top::type_id::create("sl_agt_h",this);
sb = spi_scoreboard::type_id::create("sb",this);
`uvm_info("spi_env","This is in ENV",UVM_LOW)

endfunction

function void spi_env::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
            wb_agt_h.wbagth.monh.monitor_port.connect(sb.m_fifo.analysis_export);
            sl_agt_h.slagth.monh.monitor_port.connect(sb.s_fifo.analysis_export);

endfunction

