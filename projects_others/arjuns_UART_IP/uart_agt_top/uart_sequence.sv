//*******************************************************Base sequence
class base_seq extends uvm_sequence #(uart_trans);
	`uvm_object_utils(base_seq)

	bit [7:0]lcr;

	function new(string name="base_seq");
		super.new(name);
	endfunction
	
endclass

//*******************************************************UART agent(receiving) Half_duplex
class uart_HD0 extends base_seq;
	`uvm_object_utils(uart_HD0)

	function new(string name="uart_HD0");
		super.new(name);
	endfunction

	task body();
		req = uart_trans::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {tx == 8'hff;});
		finish_item(req);
	
		//`uvm_info("UART HALF_DUPLEX_0 SEQUENCE","This is UART Agent sequence:%s",UVM_LOW)
		//req.print();
	endtask
endclass 

//*******************************************************HD0_multiple
class uart_HD0_multiple extends base_seq;
	`uvm_object_utils(uart_HD0_multiple)

	function new(string name="uart_HD0_multiple");
		super.new(name);
	endfunction

	task body();

		repeat(8)
			begin
				req = uart_trans::type_id::create("req");

				start_item(req);
				assert(req.randomize() with {tx inside {[0:8]};});
				finish_item(req);
	
				//`uvm_info("UART HD0_Multiple SEQUENCE","This is UART Agent sequence:%s",UVM_LOW)
				//req.print();
			end
	endtask
endclass

//*******************************************************UART agent(sending) Half_duplex
class uart_HD1 extends base_seq;
	`uvm_object_utils(uart_HD1)

	function new(string name="uart_HD1");
		super.new(name);
	endfunction

	task body();
		req = uart_trans::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {tx == 8'b0101_0101;});
		finish_item(req);
	
		//`uvm_info("UART HALF_DUPLEX_1 SEQUENCE","This is UART Agent sequence:%s",UVM_LOW)
		//req.print();
	endtask
endclass

//*******************************************************HD1_multiple
class uart_HD1_multiple extends base_seq;
	`uvm_object_utils(uart_HD1_multiple)

	function new(string name="uart_HD1_multiple");
		super.new(name);
	endfunction

	task body();

		repeat(8)
			begin
				req = uart_trans::type_id::create("req");

				start_item(req);
				assert(req.randomize() with {tx inside {[0:8]};});
				finish_item(req);
	
				//`uvm_info("UART HD1_Multiple SEQUENCE","This is UART Agent sequence:%s",UVM_LOW)
				//req.print();
			end
	endtask
endclass

//*******************************************************Full_duplex
class uart_FD extends base_seq;
	`uvm_object_utils(uart_FD)

	function new(string name="uart_FD");
		super.new(name);
	endfunction

	task body();
		req = uart_trans::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {tx == 8'b0101_0101;});
		finish_item(req);
	
		//`uvm_info("UART FULL_DUPLEX SEQUENCE","This is UART Agent sequence:%s",UVM_LOW)
		//req.print();
	endtask
endclass

//*******************************************************Full_duplex_multiple
class uart_FD_multiple extends base_seq;
	`uvm_object_utils(uart_FD_multiple)

	function new(string name="uart_FD_multiple");
		super.new(name);
	endfunction

	task body();
		repeat(8)
			begin
				req = uart_trans::type_id::create("req");

				start_item(req);
				assert(req.randomize() with {tx inside {[0:8]};});
				finish_item(req);
	
				//`uvm_info("UART FD_Multiple SEQUENCE","This is UART Agent sequence:%s",UVM_LOW)
				//req.print();
			end
	endtask
endclass

//******************************************************* No need for UART sequence for loopback
//******************************************************* No need for UART sequence for THR empty

//*******************************************************HD0_parity
class uart_HD0_parity extends base_seq;
	`uvm_object_utils(uart_HD0_parity)

	function new(string name="uart_HD0_parity");
		super.new(name);
	endfunction

	task body();
		req = uart_trans::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {tx inside {[0:8]}; parity == 1'b1;});
		finish_item(req);

		//`uvm_info("UART FD_Multiple SEQUENCE","This is UART Agent sequence:%s",UVM_LOW)
		//req.print();
	endtask
endclass

//*******************************************************HD1_parity
class uart_HD1_parity extends base_seq;
	`uvm_object_utils(uart_HD1_parity)

	function new(string name="uart_HD1_parity");
		super.new(name);
	endfunction

	task body();
		req = uart_trans::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {tx inside {[0:8]}; parity == 1'b1;});
		finish_item(req);

		//`uvm_info("UART FD_Multiple SEQUENCE","This is UART Agent sequence:%s",UVM_LOW)
		//req.print();
	endtask
endclass

//*******************************************************FD_parity
class uart_FD_parity extends base_seq;
	`uvm_object_utils(uart_FD_parity)

	function new(string name="uart_FD_parity");
		super.new(name);
	endfunction

	task body();
		req = uart_trans::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {tx inside {[0:8]}; parity == 1'b1;});
		finish_item(req);

		//`uvm_info("UART FD_Multiple SEQUENCE","This is UART Agent sequence:%s",UVM_LOW)
		//req.print();
	endtask
endclass

//*******************************************************HD_break
class uart_HD_break extends base_seq;
	`uvm_object_utils(uart_HD_break)

	function new(string name="uart_HD_break");
		super.new(name);
	endfunction

	task body();
		req = uart_trans::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {tx inside {[0:8]};});
		finish_item(req);

		//`uvm_info("UART FD_Multiple SEQUENCE","This is UART Agent sequence:%s",UVM_LOW)
		//req.print();
	endtask
endclass

//*******************************************************HD_frame
class uart_HD_frame extends base_seq;
	`uvm_object_utils(uart_HD_frame)

	function new(string name="uart_HD_frame");
		super.new(name);
	endfunction

	task body();
		req = uart_trans::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {tx ==  8'b0000_1111;});
		finish_item(req);

		//`uvm_info("UART FD_Multiple SEQUENCE","This is UART Agent sequence:%s",UVM_LOW)
		//req.print();
	endtask
endclass

//*******************************************************FD_frame
class uart_FD_frame extends base_seq;
	`uvm_object_utils(uart_FD_frame)

	function new(string name="uart_FD_frame");
		super.new(name);
	endfunction

	task body();
		req = uart_trans::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {tx ==  8'b0000_1111; });
		finish_item(req);

		//`uvm_info("UART FD_Multiple SEQUENCE","This is UART Agent sequence:%s",UVM_LOW)
		//req.print();
	endtask
endclass

//*******************************************************HD1_overrun
class uart_HD1_overrun extends base_seq;
	`uvm_object_utils(uart_HD1_overrun)

	function new(string name="uart_HD1_overrun");
		super.new(name);
	endfunction

	task body();

		repeat(17)
			begin
				req = uart_trans::type_id::create("req");

				start_item(req);
				assert(req.randomize() with {tx inside {[0:8]};});
				finish_item(req);
	
				//`uvm_info("UART HD1_Multiple SEQUENCE","This is UART Agent sequence:%s",UVM_LOW)
				//req.print();
			end
	endtask
endclass

//*******************************************************HD1_timeout
class uart_HD1_timeout extends base_seq;
	`uvm_object_utils(uart_HD1_timeout)

	function new(string name="uart_HD1_timeout");
		super.new(name);
	endfunction

	task body();

		repeat(17)
			begin
				req = uart_trans::type_id::create("req");

				start_item(req);
				assert(req.randomize() with {tx inside {[0:8]};});
				finish_item(req);
	
				//`uvm_info("UART HD1_Multiple SEQUENCE","This is UART Agent sequence:%s",UVM_LOW)
				//req.print();
			end
	endtask
endclass
