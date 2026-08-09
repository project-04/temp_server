class uart_monitor extends uvm_monitor;
	`uvm_component_utils(uart_monitor)

	uart_config uart_cfg;
	bit [7:0]lcr;
	virtual uart_if vif;
	uart_trans t_xtn, r_xtn;
	
	uvm_analysis_port #(uart_trans) monitor_port;

	function new(string name="uart_driver", uvm_component parent);
		super.new(name,parent);
		monitor_port = new("monitor_port", this);
	endfunction

	function void build_phase(uvm_phase phase);
		if(! uvm_config_db #(uart_config)::get(this,"","uart_config",uart_cfg))
			`uvm_fatal(get_type_name(),"Have you set the config correctly?");

		t_xtn = uart_trans::type_id::create("t_xtn");
		r_xtn = uart_trans::type_id::create("r_xtn");

		if(! uvm_config_db #(bit [7:0])::get(this,"","lcr",lcr))
			`uvm_fatal(get_type_name(),"Have you set the LCR correctly?");
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		vif = uart_cfg.vif;
	endfunction

	task collect_uart(	ref bit line,
				ref bit [7:0]data,
				ref bit parity);
		
			wait(line == 1'b1)
			@(posedge vif.baud_o);

			wait(line == 1'b0)

			repeat(24)
			@(posedge vif.baud_o);

				data[0] = line;
			
			repeat(16)
			@(posedge vif.baud_o);

				data[1] = line;

			repeat(16)
			@(posedge vif.baud_o);

				data[2] = line;

			repeat(16)
			@(posedge vif.baud_o);

				data[3] = line;

			case(lcr[1:0])
				2'b00: 	begin
						repeat(16)
						@(posedge vif.baud_o);

							data[4] = line;
					end

				2'b01: 	begin
						repeat(16)
						@(posedge vif.baud_o);

							data[4] = line;

						repeat(16)
						@(posedge vif.baud_o);

							data[5] = line;
					end

				2'b10: 	begin
						repeat(16)
						@(posedge vif.baud_o);

							data[4] = line;

						repeat(16)
						@(posedge vif.baud_o);

							data[5] = line;

						repeat(16)
						@(posedge vif.baud_o);

							data[6] = line;
					end

				2'b11: 	begin
						repeat(16)
						@(posedge vif.baud_o);

							data[4] = line;

						repeat(16)
						@(posedge vif.baud_o);

							data[5] = line;

						repeat(16)
						@(posedge vif.baud_o);

							data[6] = line;

						repeat(16)
						@(posedge vif.baud_o);

							data[7] = line;
							
					end
			endcase	

			if(lcr[3] == 1)
					begin
						repeat(16)
						@(posedge vif.baud_o);

							parity = line;
					end

			repeat(16)
			@(posedge vif.baud_o);

	endtask

	task run_phase(uvm_phase phase);
		bit tx_busy, rx_busy;

		forever
			fork
				begin
					if(tx_busy == 1'b0)begin
						tx_busy = 1'b1;
			
						collect_uart(vif.TX, t_xtn.tx, t_xtn.parity);
						$display("***********************************This is the TX line data :%h, Parity=%b",t_xtn.tx,t_xtn.parity);
						
						monitor_port.write(t_xtn);
						tx_busy = 1'b0;

					end

					else
						@(posedge vif.baud_o);
				end

				begin
					if(rx_busy == 1'b0)begin
						rx_busy = 1'b1;
			
						collect_uart(vif.RX, r_xtn.rx, r_xtn.parity);
						$display("***********************************This is the RX line data :%h, Parity=%b",r_xtn.rx,r_xtn.parity);
						
						monitor_port.write(r_xtn);
						rx_busy = 1'b0;

					end

					else
						@(posedge vif.baud_o);
				end

			join_any

	endtask

	function void check_phase(uvm_phase phase);
		`uvm_info(get_type_name(),"Printing from UART agent monitor",UVM_LOW)
		t_xtn.print();

		`uvm_info(get_type_name(),"Printing from UART agent monitor",UVM_LOW)
		r_xtn.print();
	endfunction
endclass
