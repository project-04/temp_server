class uart_driver extends uvm_driver #(uart_trans);
	`uvm_component_utils(uart_driver)

	uart_config uart_cfg;
	bit [7:0] lcr;
	virtual uart_if vif;

	function new(string name="uart_driver", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		if(! uvm_config_db #(uart_config)::get(this,"","uart_config",uart_cfg))
			`uvm_fatal(get_type_name(),"Have you set the config correctly?");

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

	task send_to_dut(uart_trans xtn);

		@(posedge vif.baud_o);
		vif.TX = 1'b0;
		delay;
		
		if(lcr[6]==1)
		begin
			vif.TX = 1'b0;
			repeat(4) delay;
		end
		else
		begin
			vif.TX = xtn.tx[0];
			delay;
			
			vif.TX = xtn.tx[1];
			delay;
			
			vif.TX = xtn.tx[2];
			delay;
			
			vif.TX = xtn.tx[3];
			delay;
		end

		case(lcr[1:0])
			2'b00:  begin
					if(lcr[6]==1)
					begin
						vif.TX = 1'b0;
						repeat(1) delay;
					end
					else
					begin
						vif.TX = xtn.tx[4];
						delay;
					end
				end

			2'b01:  begin
					if(lcr[6]==1)
					begin
						vif.TX = 1'b0;
						repeat(2) delay;
					end
					else
					begin
					 	vif.TX = xtn.tx[4];
						delay;
						
						vif.TX = xtn.tx[5];
						delay;
					end
				end

			2'b10:  begin
					if(lcr[6]==1)
					begin
						vif.TX = 1'b0;
						repeat(3) delay;
					end
					else
					begin
					 	vif.TX = xtn.tx[4];
						delay;

						vif.TX = xtn.tx[5];
						delay;

						vif.TX = xtn.tx[6];
						delay;
					end
				end

			2'b11:  begin
					if(lcr[6]==1)
					begin
						vif.TX = 1'b0;
						repeat(4) delay;
					end
					else
					begin
					 	vif.TX = xtn.tx[4];
						delay;
					 	
						vif.TX = xtn.tx[5];
						delay;

						vif.TX = xtn.tx[6];
						delay;

						vif.TX = xtn.tx[7];
						delay;
					end
				end
		endcase

		//parity bit
		if(lcr[3] == 1'b1)
			begin
				if(lcr[6]==1)
				begin
					vif.TX = 1'b0;
					repeat(1) delay;
				end
				else if(lcr[4] == 1'b1 && lcr[5] == 1'b0) 
				begin
					vif.TX = ^xtn.tx;
					delay;
				end
				
				else if(lcr[4] == 1'b0 && lcr[5] == 1'b0) 
				begin
					vif.TX = ~^xtn.tx;
					delay;
				end
				
				else if(lcr[5] == 1'b1) 
				begin
					vif.TX = ~lcr[4];
					delay;
				end
			end

		//stop bit
		if(lcr[2] == 0)
			begin
				if(lcr[6]==1)
				begin
					vif.TX = 1'b0;
					repeat(1) delay;
				end
				else
				begin
					vif.TX = 1'b1;
					delay;
				end
			end
		if(lcr[2] == 1)
			begin	
				if(lcr[6]==1)
				begin
					vif.TX = 1'b0;
					repeat(1) delay;
				end
				else
				begin
					vif.TX = 1'b1;
					delay;
					delay;
				end
			end
	endtask
	
	task send_to_dut_temp(uart_trans xtn);

		@(posedge vif.baud_o);
		vif.TX = 1'b0;
		$display($time, " d start ", vif.TX);
		delay;
		
		if(lcr[6]==1)
		begin
			vif.TX = 1'b0;
			$display($time, " d break ", vif.TX);
			repeat(4) delay;
		end
		else
		begin
			vif.TX = xtn.tx[0];
			$display($time, " d 0 ", vif.TX);
			delay;
			
			vif.TX = xtn.tx[1];
			$display($time, " d 1 ", vif.TX);
			delay;
			
			vif.TX = xtn.tx[2];
			$display($time, " d 2 ", vif.TX);
			delay;
			
			vif.TX = xtn.tx[3];
			$display($time, " d 3 ", vif.TX);
			delay;
		end

		case(lcr[1:0])
			2'b00:  begin
					if(lcr[6]==1)
					begin
						vif.TX = 1'b0;
						$display($time, " d break ", vif.TX);
						repeat(1) delay;
					end
					else
					begin
						vif.TX = xtn.tx[4];
						$display($time, " d 4 ", vif.TX);
						delay;
					end
				end

			2'b01:  begin
					if(lcr[6]==1)
					begin
						vif.TX = 1'b0;
						$display($time, " d break ", vif.TX);
						repeat(2) delay;
					end
					else
					begin
					 	vif.TX = xtn.tx[4];
						$display($time, " d 4 ", vif.TX);
						delay;
						
						vif.TX = xtn.tx[5];
						$display($time, " d 5 ", vif.TX);
						delay;
					end
				end

			2'b10:  begin
					if(lcr[6]==1)
					begin
						vif.TX = 1'b0;
						$display($time, " d break ", vif.TX);
						repeat(3) delay;
					end
					else
					begin
					 	vif.TX = xtn.tx[4];
						$display($time, " d 4 ", vif.TX);
						delay;

						vif.TX = xtn.tx[5];
						$display($time, " d 5 ", vif.TX);
						delay;

						vif.TX = xtn.tx[6];
						$display($time, " d 6 ", vif.TX);
						delay;
					end
				end

			2'b11:  begin
					if(lcr[6]==1)
					begin
						vif.TX = 1'b0;
						$display($time, " d break ", vif.TX);
						repeat(4) delay;
					end
					else
					begin
					 	vif.TX = xtn.tx[4];
						$display($time, " d 4 ", vif.TX);
						delay;
					 	
						vif.TX = xtn.tx[5];
						$display($time, " d 5 ", vif.TX);
						delay;

						vif.TX = xtn.tx[6];
						$display($time, " d 6 ", vif.TX);
						delay;

						vif.TX = xtn.tx[7];
						$display($time, " d 7 ", vif.TX);
						delay;
					end
				end
		endcase

		//parity bit
		if(lcr[3] == 1'b1)
			begin
				if(lcr[6]==1)
				begin
					vif.TX = 1'b0;
					$display($time, " d break ", vif.TX);
					repeat(1) delay;
				end
				else if(lcr[4] == 1'b1 && lcr[5] == 1'b0) 
				begin
					vif.TX = ^xtn.tx;
					$display($time, " d parity ", vif.TX);
					delay;
				end
				
				else if(lcr[4] == 1'b0 && lcr[5] == 1'b0) 
				begin
					vif.TX = ~^xtn.tx;
					$display($time, " d parity ", vif.TX);
					delay;
				end
				
				else if(lcr[5] == 1'b1) 
				begin
					vif.TX = ~lcr[4];
					$display($time, " d parity ", vif.TX);
					delay;
				end
			end

		//stop bit
		if(lcr[2] == 0)
			begin
				if(lcr[6]==1)
				begin
					vif.TX = 1'b0;
					$display($time, " d break ", vif.TX);
					repeat(1) delay;
				end
				else
				begin
					vif.TX = 1'b1;
					$display($time, " d 1stop ", vif.TX);
					delay;
				end
			end
		if(lcr[2] == 1)
			begin	
				if(lcr[6]==1)
				begin
					vif.TX = 1'b0;
					$display($time, " d break ", vif.TX);
					repeat(2) delay;
				end
				else
				begin
					vif.TX = 1'b1;
					$display($time, " d 1stop ", vif.TX);
					delay;
					$display($time, " d 2stop ", vif.TX);
					delay;
				end
			end
	endtask
	
	task run_phase(uvm_phase phase);
		vif.TX = 1'b1;

		forever begin
			seq_item_port.get_next_item(req);

			//`uvm_info("UART DRIVER","Printing from the UART agent Driver", UVM_LOW)
			//req.print();

			//send_to_dut_temp(req);
			send_to_dut(req);
			seq_item_port.item_done();
			
		end
	endtask
endclass

