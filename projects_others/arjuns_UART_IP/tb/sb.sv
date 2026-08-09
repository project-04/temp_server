class sb extends uvm_scoreboard;	
   	`uvm_component_utils(sb)

   	uvm_tlm_analysis_fifo #(apb_trans) fifo_apb[];
   	uvm_tlm_analysis_fifo #(uart_trans) fifo_uart[];

	env_config env_cfg;

	function new(string name="sb", uvm_component parent);
      		super.new(name,parent);
   	endfunction

	function void build_phase(uvm_phase phase);
    		if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
        		`uvm_fatal(get_type_name(),"Did you get the config?")

   

    		fifo_apb=new[env_cfg.no_of_apb_agents];
		fifo_uart=new[env_cfg.no_of_uart_agents];

    		foreach(fifo_apb[i])
 			begin
	   			fifo_apb[i]=new($sformatf("fifo_apb[%0d]",i),this);
			end

   		foreach(fifo_uart[i])
 			begin
	   			fifo_uart[i]=new($sformatf("fifo_uart[%0d]",i),this);
			end

   	endfunction

endclass




