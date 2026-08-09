class uart_monitor extends uvm_monitor;
	`uvm_component_utils(uart_monitor)

	uart_config uart_cfg;
	bit [7:0] lcr;
	bit [7:0] q_thr[$];
      	bit [7:0] q_rbr[$];
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

		if(! uvm_config_db #(int)::get(this,"","lcr",lcr))
			`uvm_fatal(get_type_name(),"Have you set the LCR correctly?");
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		vif = uart_cfg.vif;
	endfunction

	task delay;
		repeat(16) 
		@(posedge vif.baud_o);
	endtask
	
	task collect_uart_tx_temp (ref bit line, ref bit [7:0]data, ref bit parity);
		
			//wait(line == 1'b1)
			//@(posedge vif.baud_o);
			
			wait(line == 1'b0);
			$display($time, " m start ",line);
			
			repeat(8) 
				@(posedge vif.baud_o);
			delay;
			
			$display($time, " m 1 ",line);
			data[0] = line;
			delay;
			
			$display($time, " m 2 ",line);
			data[1] = line;
			delay;

			$display($time, " m 3 ",line);
			data[2] = line;
			delay;
			
			$display($time, " m 4 ",line);
			data[3] = line;
			delay;

			case(lcr[1:0])
				2'b00: 	begin
						data[4] = line;
						delay;
					end

				2'b01: 	begin
						data[4] = line;
						delay;

						data[5] = line;
						delay;
					end

				2'b10: 	begin
						data[4] = line;
						delay;

						data[5] = line;
						delay;
						
						data[6] = line;
						delay;
					end

				2'b11: 	begin
						$display($time, " m 5 ",line);
						data[4] = line;
						delay;

						$display($time, " m 6 ",line);
						data[5] = line;
						delay;

						$display($time, " m 7 ",line);
						data[6] = line;
						delay;

						$display($time, " m 8 ",line);
						data[7] = line;
						delay;
							
					end
			endcase	

			if(lcr[3] == 1)
				begin
					$display($time," m parity ", line);
					parity = line;
					delay;
				end

			if(lcr[2] == 0)
				begin
					$display($time, " m 1stop ", line);
					repeat(8)
					@(posedge vif.baud_o);
				end
			else
				begin
					$display($time, " m 1stop ", line);
					repeat(8)
					@(posedge vif.baud_o);
					$display($time, " m 2stop ", line);
					delay;
				end
				
	endtask

	task collect_uart_rx_temp (ref bit line, ref bit [7:0]data, ref bit parity);
		
			wait(line == 1'b1)
			//@(posedge vif.baud_o);
			
			wait(line == 1'b0);
			$display($time, " m start ",line);
			
			repeat(8) 
				@(posedge vif.baud_o);
			delay;
			
			$display($time, " m 1 ",line);
			data[0] = line;
			delay;
			
			$display($time, " m 2 ",line);
			data[1] = line;
			delay;

			$display($time, " m 3 ",line);
			data[2] = line;
			delay;
			
			$display($time, " m 4 ",line);
			data[3] = line;
			delay;

			case(lcr[1:0])
				2'b00: 	begin
						data[4] = line;
						delay;
					end

				2'b01: 	begin
						data[4] = line;
						delay;

						data[5] = line;
						delay;
					end

				2'b10: 	begin
						data[4] = line;
						delay;

						data[5] = line;
						delay;
						
						data[6] = line;
						delay;
					end

				2'b11: 	begin
						$display($time, " m 5 ",line);
						data[4] = line;
						delay;

						$display($time, " m 6 ",line);
						data[5] = line;
						delay;

						$display($time, " m 7 ",line);
						data[6] = line;
						delay;

						$display($time, " m 8 ",line);
						data[7] = line;
						delay;
							
					end
			endcase	

			if(lcr[3] == 1)
				begin
					$display($time," m parity ", line);
					parity = line;
					delay;
				end

			if(lcr[2] == 0)
				begin
					$display($time, " m 1stop ", line);
					repeat(8)
					@(posedge vif.baud_o);
				end
			else
				begin
					$display($time, " m 1stop ", line);
					repeat(8)
					@(posedge vif.baud_o);
					$display($time, " m 2stop ", line);
					delay;
				end
				
	endtask
	
	task collect_uart_tx (ref bit line, ref bit [7:0]data, ref bit parity);
	begin
			//wait(line == 1'b1)
			//@(posedge vif.baud_o);

			wait(line == 1'b0);
			
			repeat(8) 
				@(posedge vif.baud_o);
			delay;
			
			data[0] = line;
			delay;
			
			data[1] = line;
			delay;

			data[2] = line;
			delay;
			
			data[3] = line;
			delay;

			case(lcr[1:0])
				2'b00: 	begin
						data[4] = line;
						delay;
					end

				2'b01: 	begin
						data[4] = line;
						delay;

						data[5] = line;
						delay;
					end

				2'b10: 	begin
						data[4] = line;
						delay;

						data[5] = line;
						delay;
						
						data[6] = line;
						delay;
					end

				2'b11: 	begin
						data[4] = line;
						delay;

						data[5] = line;
						delay;

						data[6] = line;
						delay;

						data[7] = line;
						delay;
							
					end
			endcase	

			if(lcr[3] == 1)
				begin
					parity = line;
					delay;
				end

			if(lcr[2] == 0)
				begin
					repeat(8)
					@(posedge vif.baud_o);
				end
			else
				begin
					repeat(8)
					@(posedge vif.baud_o);
					delay;
				end
		
		/*q_thr.push_back(t_xtn.tx);
		monitor_port.write(t_xtn);
		$display("----------This is the TX line data :%d, Parity=%b", t_xtn.tx, t_xtn.parity);*/
	end
	endtask
	
	task collect_uart_rx (ref bit line, ref bit [7:0]data, ref bit parity);
	begin
			wait(line == 1'b1)
			//@(posedge vif.baud_o);

			wait(line == 1'b0);
			
			repeat(8) 
				@(posedge vif.baud_o);
			delay;
			
			data[0] = line;
			delay;
			
			data[1] = line;
			delay;

			data[2] = line;
			delay;
			
			data[3] = line;
			delay;

			case(lcr[1:0])
				2'b00: 	begin
						data[4] = line;
						delay;
					end

				2'b01: 	begin
						data[4] = line;
						delay;

						data[5] = line;
						delay;
					end

				2'b10: 	begin
						data[4] = line;
						delay;

						data[5] = line;
						delay;
						
						data[6] = line;
						delay;
					end

				2'b11: 	begin
						data[4] = line;
						delay;

						data[5] = line;
						delay;

						data[6] = line;
						delay;

						data[7] = line;
						delay;
							
					end
			endcase	

			if(lcr[3] == 1)
				begin
					parity = line;
					delay;
				end

			if(lcr[2] == 0)
				begin
					repeat(8)
					@(posedge vif.baud_o);
				end
			else
				begin
					repeat(8)
					@(posedge vif.baud_o);
					delay;
				end
		
		/*q_thr.push_back(t_xtn.tx);
		monitor_port.write(t_xtn);
		$display("----------This is the TX line data :%d, Parity=%b", t_xtn.tx, t_xtn.parity);*/
	end
	endtask

	task run_phase(uvm_phase phase);
		bit tx_busy, rx_busy;

		forever
			fork
				begin
					if(tx_busy == 1'b0)
					begin
						tx_busy = 1'b1;
			      			t_xtn = uart_trans::type_id::create("t_xtn");
						collect_uart_tx(vif.TX, t_xtn.tx, t_xtn.parity);
						//collect_uart_tx_temp(vif.TX, t_xtn.tx, t_xtn.parity);
						
						q_thr.push_back(t_xtn.tx);
                                              	t_xtn.THR.push_back(t_xtn.tx);
						monitor_port.write(t_xtn);
						$display("----------This is the TX line data : %0d, Parity=%b", t_xtn.tx, t_xtn.parity);
						
						tx_busy = 1'b0;
					end

					else
						@(posedge vif.baud_o);
				end

				begin
					if(rx_busy == 1'b0)
					begin
						rx_busy = 1'b1;
			      			r_xtn = uart_trans::type_id::create("r_xtn");
						collect_uart_rx(vif.RX, r_xtn.rx, r_xtn.parity);
						//collect_uart_rx_temp(vif.RX, r_xtn.rx, r_xtn.parity);
						
						q_rbr.push_back(r_xtn.rx);
                                              	r_xtn.RBR.push_back(r_xtn.rx);
						monitor_port.write(r_xtn);
						$display("----------This is the RX line data : %0d, Parity=%b", r_xtn.rx, r_xtn.parity);
						
						rx_busy = 1'b0;
					end

					else
						@(posedge vif.baud_o);
				end

			join_any
	endtask

	function void extract_phase(uvm_phase phase);
	super.extract_phase(phase);
		//`uvm_info(get_type_name(),"Printing from UART agent monitor",UVM_LOW)
		//t_xtn.print();

		//`uvm_info(get_type_name(),"Printing from UART agent monitor",UVM_LOW)
		//r_xtn.print();
		$display("\nuart q_thr = %p", q_thr);
		$display("uart q_rbr = %p\nextract phase end\n\n", q_rbr);
	endfunction
endclass
