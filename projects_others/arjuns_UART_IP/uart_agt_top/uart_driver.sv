class uart_driver extends uvm_driver #(uart_trans);
	`uvm_component_utils(uart_driver)

	uart_config uart_cfg;
	bit [7:0]lcr;
	virtual uart_if vif;

	function new(string name="uart_driver", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		if(! uvm_config_db #(uart_config)::get(this,"","uart_config",uart_cfg))
			`uvm_fatal(get_type_name(),"Have you set the config correctly?");

		if(! uvm_config_db #(bit [7:0])::get(this,"","lcr",lcr))
			`uvm_fatal(get_type_name(),"Have you set the LCR correctly?");
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		vif = uart_cfg.vif;
	endfunction

	task send_to_dut(uart_trans xtn);

		@(posedge vif.baud_o);
		vif.TX = 1'b0;

		repeat(16) 
		@(posedge vif.baud_o);
		vif.TX = xtn.tx[0];

		repeat(16)
		@(posedge vif.baud_o);
		vif.TX = xtn.tx[1];

		repeat(16)
		@(posedge vif.baud_o);
		vif.TX = xtn.tx[2];

		repeat(16)
		@(posedge vif.baud_o);
		vif.TX = xtn.tx[3];

		repeat(16)
		@(posedge vif.baud_o);
		
		case(lcr[1:0])
			2'b00:  begin
				 	vif.TX = xtn.tx[4];

					repeat(16)
					@(posedge vif.baud_o);
				end

			2'b01:  begin
				 	vif.TX = xtn.tx[4];

					repeat(16)
					@(posedge vif.baud_o);
					
					vif.TX = xtn.tx[5];

					repeat(16)
					@(posedge vif.baud_o);
				end

			2'b10:  begin
				 	vif.TX = xtn.tx[4];

					repeat(16)
					@(posedge vif.baud_o);
					
					vif.TX = xtn.tx[5];

					repeat(16)
					@(posedge vif.baud_o);
					
					vif.TX = xtn.tx[6];

					repeat(16)
					@(posedge vif.baud_o);
				end

			2'b11:  begin
				 	vif.TX = xtn.tx[4];

					repeat(16)
					@(posedge vif.baud_o);
					
					vif.TX = xtn.tx[5];

					repeat(16)
					@(posedge vif.baud_o);
					
					vif.TX = xtn.tx[6];

					repeat(16)
					@(posedge vif.baud_o);
					
					vif.TX = xtn.tx[7];

					repeat(16)
					@(posedge vif.baud_o);
				end
		endcase

		if(lcr[3] == 1'b1)
			begin
				if(lcr[4] == 1'b1 && lcr[5] == 1'b0) 
					vif.TX = ^xtn.tx;
				else if(lcr[4] == 1'b0 && lcr[5] == 1'b0) 
					vif.TX = ~^xtn.tx;
				else if(lcr[5] == 1'b1)
					vif.TX = ~lcr[4];

				repeat(16)
				@(posedge vif.baud_o);
			end

		vif.TX = 1'b1;

		repeat(16)
		@(posedge vif.baud_o);
					
	endtask
	
	task run_phase(uvm_phase phase);
		vif.TX = 1'b1;

		forever begin
			seq_item_port.get_next_item(req);

			`uvm_info("UART DRIVER","Printing from the UART agent Driver", UVM_LOW)
			req.print();

			send_to_dut(req);
			seq_item_port.item_done();
			
		end
	endtask
endclass
