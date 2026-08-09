
class base_test extends uvm_test;

	`uvm_component_utils(base_test)

	function new(string name = "base_test",uvm_component parent);
		super.new(name,parent);
	endfunction 

	environment env;

	env_config env_cfg;
	apb_config apb_cfg[];
	uart_config uart_cfg[];

	int no_of_uart_agents = 1;
	int no_of_apb_agents = 1;
	

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		env_cfg = env_config::type_id::create("env_cfg");

		apb_cfg = new[this.no_of_apb_agents];
		uart_cfg = new[this.no_of_uart_agents];
	
		env_cfg.apb_cfg = new[this.no_of_apb_agents];
		env_cfg.uart_cfg = new[this.no_of_uart_agents];	
		
		env_cfg.no_of_apb_agents = this.no_of_apb_agents;
		env_cfg.no_of_uart_agents = this.no_of_uart_agents;

		foreach(apb_cfg[i])
			begin 
				apb_cfg[i] = apb_config::type_id::create($sformatf("apb_cfg[%0d]",i));
				
				if(!uvm_config_db#(virtual apb_if)::get(this,"","apb_if",apb_cfg[i].apbf))
					`uvm_fatal(get_type_name(),"failed getting apb interface");
								
				if(i == 0)
					begin
						apb_cfg[i].is_active = UVM_ACTIVE;
						uvm_config_db#(apb_config)::set(this,$sformatf("*apb_agt[%0d]*",i),"apb_config",apb_cfg[i]);
					end
				else
					begin 
						apb_cfg[i].is_active = UVM_PASSIVE;
						uvm_config_db#(apb_config)::set(this,$sformatf("*apb_cfg[%0d]*",i),"apb_config",apb_cfg[i]);
					end

				env_cfg.apb_cfg[i] = apb_cfg[i];				
			end
		
		
		foreach(uart_cfg[i])
			begin 
			
				uart_cfg[i] = uart_config::type_id::create($sformatf("uart_cfg[%0d]",i));
				
				if(!uvm_config_db#(virtual uart_if)::get(this,"","uart_if",uart_cfg[i].uartf))
					`uvm_fatal(get_type_name(),"failed to get uart interface")
	
				if(i == 0)
					begin 
						uart_cfg[i].is_active = UVM_ACTIVE;
						uvm_config_db#(uart_config)::set(this,$sformatf("*uart_agt[%0d]*",i),"uart_config",uart_cfg[i]);
					end
				else
					begin 
						uart_cfg[i].is_active = UVM_PASSIVE;
						uvm_config_db#(uart_config)::set(this,$sformatf("*uart_agt[%0d]*",i),"uart_config",uart_cfg[i]);
					end

				env_cfg.uart_cfg[i] = uart_cfg[i];

			end

			uvm_config_db#(env_config)::set(this,"*","env_config",env_cfg);

			env = environment::type_id::create("env",this);

	endfunction 

	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
			
		uvm_top.print_topology();
		
	endfunction 

endclass		



class half_duplex_test extends base_test;

	`uvm_component_utils(half_duplex_test)
	
	function new (string name = "half_duplex_test",uvm_component parent);
		super.new(name,parent);
	endfunction 
	
	bit [7:0] LCR;

	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
			
			LCR = 3;		// [0:1] is 11 soo 8 bit data 
			uvm_config_db#(bit[7:0])::set(this,"*","LCR",LCR);
			
	endfunction 
	
	task run_phase(uvm_phase phase);
		super.run_phase(phase);

	endtask

endclass

		
			

		
		
		
		
	 		

			

		
	
