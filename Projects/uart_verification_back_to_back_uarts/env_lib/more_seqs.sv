//------------------------------------UART0___TX-RX___FULL DUPLEX MULTIPLE_DATA_TRANSFER WITH PARITY
class FD_P_0_sequence_xtns extends seqs;
	`uvm_object_utils(FD_P_0_sequence_xtns)

	function new(string name = "FD_P_0_sequence_xtns");
		super.new(name);
	endfunction
	
	task body();
      	repeat(1)
		begin
			req=trans::type_id::create("req");
	   		
	   		//--------------------------------DIV1 - Divisor LSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h1c; PWRITE==1'b1; PWDATA=='d27;});
	   		finish_item(req);
			
			//--------------------------------DIV2 - Divisor MSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h20; PWRITE==1'b1; PWDATA=='d0;});
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==8'b0000_1011;});
	   		finish_item(req);
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==8'b0000_0110;});
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==8'b0000_0101;});
	   		finish_item(req);
	   		
	   		//--------------------------------Transimtter Holding Register
	   		//repeat(14) 
	   		begin
		   		start_item(req);
		   		assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b1; PWDATA inside{[1:255]};});
		   		finish_item(req);
	   		end
	   		
	   		//--------------------------------Interrupt Identification Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b0;});
	   		finish_item(req);
	   		get_response(req);
	   		
	   		//--------------------------------Receiver Buffer Register
	   		if(req.iir[3:0] == 'h4)
	   		//repeat(14)
	   		begin
	   			start_item(req);
	   			assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b0;});
	   			finish_item(req);
	   		end
      
	   		//--------------------------------Line Status Register
	   		if(req.iir[3:0] == 'h6)
	   		begin
	   			start_item(req);
	   			assert(req.randomize() with {PADDR==32'h14; PWRITE==1'b0;});
	   			finish_item(req);
	   		end
      		end
  	endtask
endclass

//------------------------------------UART1___TX-RX___FULL DUPLEX MULTIPLE_DATA_TRANSFER WITH PARITY
class FD_P_1_sequence_xtns extends seqs;
	`uvm_object_utils(FD_P_1_sequence_xtns)

	function new(string name = "FD_P_1_sequence_xtns");
		super.new(name);
	endfunction
	
	task body();
      	repeat(1)
		begin
			req=trans::type_id::create("req");
	   		
	   		//--------------------------------DIV1 - Divisor LSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h1c; PWRITE==1'b1; PWDATA=='d54;});
	   		finish_item(req);
	   		
			//--------------------------------DIV2 - Divisor MSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h20; PWRITE==1'b1; PWDATA=='d0;});
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==8'b0000_1011;});
	   		finish_item(req);
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==8'b0000_0110;});
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==8'b0000_0101;});
	   		finish_item(req);
	   		
	   		//--------------------------------Transimtter Holding Register
	   		//repeat(14) 
	   		begin
		   		start_item(req);
		   		assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b1; PWDATA inside{[1:255]};});
		   		finish_item(req);
	   		end
	   		
	   		//--------------------------------Interrupt Identification Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b0;});
	   		finish_item(req);
	   		get_response(req);
	   		
	   		//--------------------------------Receiver Buffer Register
	   		if(req.iir[3:0] == 'h4)
	   		//repeat(14)
	   		begin
	   			start_item(req);
	   			assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b0;});
	   			finish_item(req);
	   		end
      
	   		//--------------------------------Line Status Register
	   		if(req.iir[3:0] == 'h6)
	   		begin
	   			start_item(req);
	   			assert(req.randomize() with {PADDR==32'h14; PWRITE==1'b0;});
	   			finish_item(req);
	   		end        
      		end      
    	endtask
endclass

//------------------------------------UART0___TX-RX___FULL DUPLEX MULTIPLE_DATA_TRANSFER WITH BREAK ERROR
class FD_BE_0_sequence_xtns extends seqs;
	`uvm_object_utils(FD_BE_0_sequence_xtns)

	function new(string name = "FD_BE_0_sequence_xtns");
		super.new(name);
	endfunction
	
	task body();
      	repeat(1)
		begin
			req=trans::type_id::create("req");
	   		
	   		//--------------------------------DIV1 - Divisor LSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h1c; PWRITE==1'b1; PWDATA=='d27;});
	   		finish_item(req);
			
			//--------------------------------DIV2 - Divisor MSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h20; PWRITE==1'b1; PWDATA=='d0;});
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==8'b0100_0011;});
	   		finish_item(req);
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==8'b0000_0110;});
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==8'b0000_0101;});
	   		finish_item(req);
	   		
	   		//--------------------------------Transimtter Holding Register
	   		//repeat(14) 
	   		begin
		   		start_item(req);
		   		assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b1; PWDATA inside{[1:255]};});
		   		finish_item(req);
	   		end
	   		
	   		//--------------------------------Interrupt Identification Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b0;});
	   		finish_item(req);
	   		get_response(req);
	   		
	   		//--------------------------------Receiver Buffer Register
	   		if(req.iir[3:0] == 'h4)
	   		//repeat(14)
	   		begin
	   			start_item(req);
	   			assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b0;});
	   			finish_item(req);
	   		end
      
	   		//--------------------------------Line Status Register
	   		if(req.iir[3:0] == 'h6)
	   		begin
	   			start_item(req);
	   			assert(req.randomize() with {PADDR==32'h14; PWRITE==1'b0;});
	   			finish_item(req);
	   		end
      		end
  	endtask
endclass

//------------------------------------UART1___TX-RX___FULL DUPLEX MULTIPLE_DATA_TRANSFER WITH BREAK ERROR
class FD_BE_1_sequence_xtns extends seqs;
	`uvm_object_utils(FD_BE_1_sequence_xtns)

	function new(string name = "FD_BE_1_sequence_xtns");
		super.new(name);
	endfunction
	
	task body();
      	repeat(1)
		begin
			req=trans::type_id::create("req");
	   		
	   		//--------------------------------DIV1 - Divisor LSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h1c; PWRITE==1'b1; PWDATA=='d54;});
	   		finish_item(req);
	   		
			//--------------------------------DIV2 - Divisor MSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h20; PWRITE==1'b1; PWDATA=='d0;});
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==8'b0100_0011;});
	   		finish_item(req);
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==8'b0000_0110;});
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==8'b0000_0101;});
	   		finish_item(req);
	   		
	   		//--------------------------------Transimtter Holding Register
	   		//repeat(14) 
	   		begin
		   		start_item(req);
		   		assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b1; PWDATA inside{[1:255]};});
		   		finish_item(req);
	   		end
	   		
	   		//--------------------------------Interrupt Identification Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b0;});
	   		finish_item(req);
	   		get_response(req);
	   		
	   		//--------------------------------Receiver Buffer Register
	   		if(req.iir[3:0] == 'h4)
	   		//repeat(14)
	   		begin
	   			start_item(req);
	   			assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b0;});
	   			finish_item(req);
	   		end
      
	   		//--------------------------------Line Status Register
	   		if(req.iir[3:0] == 'h6)
	   		begin
	   			start_item(req);
	   			assert(req.randomize() with {PADDR==32'h14; PWRITE==1'b0;});
	   			finish_item(req);
	   		end        
      		end      
    	endtask
endclass

//------------------------------------UART0___TX-RX___FULL DUPLEX MULTIPLE_DATA_TRANSFER WITH OVERRUN ERROR
class FD_ORE_0_sequence_xtns extends seqs;
	`uvm_object_utils(FD_ORE_0_sequence_xtns)

	function new(string name = "FD_ORE_0_sequence_xtns");
		super.new(name);
	endfunction
	
	task body();
      	repeat(1)
		begin
			req=trans::type_id::create("req");
	   		
	   		//--------------------------------DIV1 - Divisor LSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h1c; PWRITE==1'b1; PWDATA=='d27;});
	   		finish_item(req);
			
			//--------------------------------DIV2 - Divisor MSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h20; PWRITE==1'b1; PWDATA=='d0;});
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==8'b0000_0011;});
	   		finish_item(req);
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==8'b1100_0110;});
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==8'b0000_0100;});
	   		finish_item(req);
	   		
	   		//--------------------------------Transimtter Holding Register
	   		repeat(17) 
	   		begin
		   		start_item(req);
		   		assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b1; PWDATA inside{[1:255]};});
		   		finish_item(req);
	   		end
	   		
	   		//--------------------------------Interrupt Identification Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b0;});
	   		finish_item(req);
	   		get_response(req);
	   		
	   		//--------------------------------Receiver Buffer Register
	   		if(req.iir[3:0] == 'h4)
	   		repeat(17)
	   		begin
	   			start_item(req);
	   			assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b0;});
	   			finish_item(req);
	   		end
      
	   		//--------------------------------Line Status Register
	   		if(req.iir[3:0] == 'h6)
	   		begin
	   			start_item(req);
	   			assert(req.randomize() with {PADDR==32'h14; PWRITE==1'b0;});
	   			finish_item(req);
	   		end
      		end
  	endtask
endclass

//------------------------------------UART1___TX-RX___FULL DUPLEX MULTIPLE_DATA_TRANSFER WITH OVERRUN ERROR
class FD_ORE_1_sequence_xtns extends seqs;
	`uvm_object_utils(FD_ORE_1_sequence_xtns)

	function new(string name = "FD_ORE_1_sequence_xtns");
		super.new(name);
	endfunction
	
	task body();
      	repeat(1)
		begin
			req=trans::type_id::create("req");
	   		
	   		//--------------------------------DIV1 - Divisor LSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h1c; PWRITE==1'b1; PWDATA=='d54;});
	   		finish_item(req);
	   		
			//--------------------------------DIV2 - Divisor MSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h20; PWRITE==1'b1; PWDATA=='d0;});
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==8'b0000_0011;});
	   		finish_item(req);
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==8'b1100_0110;});
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==8'b0000_0100;});
	   		finish_item(req);
	   		
	   		//--------------------------------Transimtter Holding Register
	   		repeat(17) 
	   		begin
		   		start_item(req);
		   		assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b1; PWDATA inside{[1:255]};});
		   		finish_item(req);
	   		end
	   		
	   		//--------------------------------Interrupt Identification Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b0;});
	   		finish_item(req);
	   		get_response(req);
	   		
	   		//--------------------------------Receiver Buffer Register
	   		if(req.iir[3:0] == 'h4)
	   		repeat(17)
	   		begin
	   			start_item(req);
	   			assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b0;});
	   			finish_item(req);
	   		end
      
	   		//--------------------------------Line Status Register
	   		if(req.iir[3:0] == 'h6)
	   		begin
	   			start_item(req);
	   			assert(req.randomize() with {PADDR==32'h14; PWRITE==1'b0;});
	   			finish_item(req);
	   		end
      		end      
    	endtask
endclass

//------------------------------------UART0___TX-RX___FULL DUPLEX MULTIPLE_DATA_TRANSFER WITH FRAMING ERROR
class FD_FE_0_sequence_xtns extends seqs;
	`uvm_object_utils(FD_FE_0_sequence_xtns)

	function new(string name = "FD_FE_0_sequence_xtns");
		super.new(name);
	endfunction
	
	task body();
      	repeat(1)
		begin
			req=trans::type_id::create("req");
	   		
	   		//--------------------------------DIV1 - Divisor LSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h1c; PWRITE==1'b1; PWDATA==32'h46;});
	   		finish_item(req);
			
			//--------------------------------DIV2 - Divisor MSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h20; PWRITE==1'b1; PWDATA==32'h1;});
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==8'b0100_0011;});
	   		finish_item(req);
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==8'b0000_0110;});
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==8'b0000_0100;});
	   		finish_item(req);
	   		
	   		//--------------------------------Transimtter Holding Register
	   		//repeat(14) 
	   		begin
		   		start_item(req);
		   		assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b1; PWDATA inside{[1:255]};});
		   		finish_item(req);
	   		end
	   		
	   		/*//--------------------------------Interrupt Identification Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b0;});
	   		finish_item(req);
	   		get_response(req);
	   		
	   		//--------------------------------Receiver Buffer Register
	   		if(req.iir[3:0] == 'h4)
	   		//repeat(14)
	   		begin
	   			start_item(req);
	   			assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b0;});
	   			finish_item(req);
	   		end
      
	   		//--------------------------------Line Status Register
	   		if(req.iir[3:0] == 'h6)
	   		begin
	   			start_item(req);
	   			assert(req.randomize() with {PADDR==32'h14; PWRITE==1'b0;});
	   			finish_item(req);
	   		end*/
      		end
  	endtask
endclass

//------------------------------------UART1___TX-RX___FULL DUPLEX MULTIPLE_DATA_TRANSFER WITH FRAMING ERROR
class FD_FE_1_sequence_xtns extends seqs;
	`uvm_object_utils(FD_FE_1_sequence_xtns)

	function new(string name = "FD_FE_1_sequence_xtns");
		super.new(name);
	endfunction
	
	task body();
      	repeat(1)
		begin
			req=trans::type_id::create("req");
	   		
	   		//--------------------------------DIV1 - Divisor LSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h1c; PWRITE==1'b1; PWDATA==32'h8c;});
	   		finish_item(req);
	   		
			//--------------------------------DIV2 - Divisor MSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h20; PWRITE==1'b1; PWDATA==32'h2;});
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==8'b0000_0000;});
	   		finish_item(req);
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==8'b0000_0110;});
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==8'b0000_0100;});
	   		finish_item(req);
	   		
	   		//--------------------------------Transimtter Holding Register
	   		//repeat(14) 
	   		/*begin
		   		start_item(req);
		   		assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b1; PWDATA inside{[1:255]};});
		   		finish_item(req);
	   		end*/
	   		
	   		//--------------------------------Interrupt Identification Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b0;});
	   		finish_item(req);
	   		get_response(req);
	   		
	   		//--------------------------------Receiver Buffer Register
	   		if(req.iir[3:0] == 'h4)
	   		//repeat(14)
	   		begin
	   			start_item(req);
	   			assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b0;});
	   			finish_item(req);
	   		end
      
	   		//--------------------------------Line Status Register
	   		if(req.iir[3:0] == 'h6)
	   		begin
	   			start_item(req);
	   			assert(req.randomize() with {PADDR==32'h14; PWRITE==1'b0;});
	   			finish_item(req);
	   		end        
      		end      
    	endtask
endclass

//------------------------------------UART0___TX-RX___FULL DUPLEX MULTIPLE_DATA_TRANSFER WITH TIME OUT ERROR
class FD_TOE_0_sequence_xtns extends seqs;
	`uvm_object_utils(FD_TOE_0_sequence_xtns)

	function new(string name = "FD_TOE_0_sequence_xtns");
		super.new(name);
	endfunction
	
	task body();
      	repeat(1)
		begin
			req=trans::type_id::create("req");
	   		
	   		//--------------------------------DIV1 - Divisor LSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h1c; PWRITE==1'b1; PWDATA=='d27;});
	   		finish_item(req);
			
			//--------------------------------DIV2 - Divisor MSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h20; PWRITE==1'b1; PWDATA=='d0;});
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==8'b0000_1011;});
	   		finish_item(req);
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==8'b1000_0110;});
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==8'b0000_0000;});
	   		finish_item(req);
	   		
	   		//--------------------------------Transimtter Holding Register
	   		repeat(17) 
	   		begin
		   		start_item(req);
		   		assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b1; PWDATA inside{[1:255]};});
		   		finish_item(req);
	   		end
	   		
	   		//--------------------------------Interrupt Identification Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b0;});
	   		finish_item(req);
	   		get_response(req);
	   		
	   		//--------------------------------Receiver Buffer Register
	   		if(req.iir[3:0] == 'h4)
	   		repeat(17)
	   		begin
	   			start_item(req);
	   			assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b0;});
	   			finish_item(req);
	   		end
      
	   		//--------------------------------Line Status Register
	   		if(req.iir[3:0] == 'h6)
	   		begin
	   			start_item(req);
	   			assert(req.randomize() with {PADDR==32'h14; PWRITE==1'b0;});
	   			finish_item(req);
	   		end
      		end
  	endtask
endclass

//------------------------------------UART1___TX-RX___FULL DUPLEX MULTIPLE_DATA_TRANSFER WITH OVERRUN ERROR
class FD_TOE_1_sequence_xtns extends seqs;
	`uvm_object_utils(FD_TOE_1_sequence_xtns)

	function new(string name = "FD_TOE_1_sequence_xtns");
		super.new(name);
	endfunction
	
	task body();
      	repeat(1)
		begin
			req=trans::type_id::create("req");
	   		
	   		//--------------------------------DIV1 - Divisor LSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h1c; PWRITE==1'b1; PWDATA=='d54;});
	   		finish_item(req);
	   		
			//--------------------------------DIV2 - Divisor MSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h20; PWRITE==1'b1; PWDATA=='d0;});
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==8'b0000_1011;});
	   		finish_item(req);
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==8'b1100_0110;});
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==8'b0000_0000;});
	   		finish_item(req);
	   		
	   		//--------------------------------Transimtter Holding Register
	   		repeat(17) 
	   		begin
		   		start_item(req);
		   		assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b1; PWDATA inside{[1:255]};});
		   		finish_item(req);
	   		end
	   		
	   		//--------------------------------Interrupt Identification Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b0;});
	   		finish_item(req);
	   		get_response(req);
	   		
	   		//--------------------------------Receiver Buffer Register
	   		if(req.iir[3:0] == 'h4)
	   		repeat(17)
	   		begin
	   			start_item(req);
	   			assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b0;});
	   			finish_item(req);
	   		end
      
	   		//--------------------------------Line Status Register
	   		if(req.iir[3:0] == 'h6)
	   		begin
	   			start_item(req);
	   			assert(req.randomize() with {PADDR==32'h14; PWRITE==1'b0;});
	   			finish_item(req);
	   		end
      		end      
    	endtask
endclass


