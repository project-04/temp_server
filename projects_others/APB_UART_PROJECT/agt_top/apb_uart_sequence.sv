
class apb_uart_base_sequence extends uvm_sequence#(apb_uart_trans);

	`uvm_object_utils(apb_uart_base_sequence)

	function new (string name = "base_sequence");
		super.new(name);
	endfunction 

endclass

//-----------------------------------------------------------------------------------------------------------------------------------------

// 								FULL DUPLEXXXXX 
 
//-----------------------------------------------------------------------------------------------------------------------------------------



class fd_seq1 extends apb_uart_base_sequence;		// UART 1

	`uvm_object_utils(fd_seq1)

	function new (string name = "fd_seq1");
		super.new(name);
	endfunction 
	
	task body();
		begin 

			//DIV 1 MSB	
			req = apb_uart_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h20; Pwdata==0;} )
		//	req.print();
			finish_item(req);


			//DIV 1 LSB
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h1C; Pwdata==54;} )
		//	req.print();
			finish_item(req);


			//LCR line control reg
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'hC; Pwdata==8'b00000011;} )
		//	req.print();
			finish_item(req);


			//FCR fifo control reg
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h8; Pwdata==8'b00000110;} )
		//	req.print();
			finish_item(req);


			//IER interrupt enable reg
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h4; Pwdata==8'b00000101;} )
		//	req.print();
			finish_item(req);	


			//THR transmitter holding reg
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h0; Pwdata==23;} )
		//	req.print();
			finish_item(req);


			//IIR intrpt ident reg
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h8;} )
		//	req.print();
			finish_item(req);
			get_response(req);


			//RBR rec buf reg
			if(req.IIR[3:0] == 4)
				begin 
					start_item(req);
					assert(req.randomize() with {Pwrite==0; Paddr==32'h00;} )
				//	req.print();	
					finish_item(req);
				end

			//LSR	line status reg
			if(req.IIR[3:1] == 6)
				begin 
					start_item(req);
					assert(req.randomize() with {Pwrite==0; Paddr==32'h14;} )
			//		req.print();
					finish_item(req);	
				end
		
		
		end 
	endtask

endclass




class fd_seq2 extends apb_uart_base_sequence; 			// UART 2 

	`uvm_object_utils(fd_seq2)

	function new (string name = "fd_seq2");
		super.new(name);
	endfunction 
	
	task body();
		begin 
		
			//DIV 2 MSB
			req = apb_uart_trans::type_id::create("req");	
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h20; Pwdata==0;} )
		//	req.print();
			finish_item(req);


			//DIV 2 LSB
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h1C; Pwdata==27;} )
		//	req.print();
			finish_item(req);

			//LCR line control reg
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'hC; Pwdata==8'b00000011;} )
		//	req.print();
			finish_item(req);


			//FCR fifo control reg
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h8; Pwdata==8'b00000110;} )
		//	req.print();
			finish_item(req);


			//IER interrupt enable reg
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h4; Pwdata==8'b00000101;} )
		//	req.print();
			finish_item(req);
	

			//THR transmitter holding reg
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h0; Pwdata==221;} )
		//	req.print();
			finish_item(req);

			//IIR 
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h8;} )
		//	req.print();
			finish_item(req);
			get_response(req);
		
			//RBR  rece buff reg
			if(req.IIR[3:0] == 4)
				begin 
					start_item(req);
					assert(req.randomize() with {Pwrite==0; Paddr==32'h0;} )
			//		req.print();
					finish_item(req);
				end

			//LSR line status reg
			if(req.IIR[3:1] == 6)
				begin 
					start_item(req);
					assert(req.randomize() with {Pwrite==0; Paddr==32'h14;} )
			//		req.print();
					finish_item(req);
				end
		
	
		end 
	endtask

endclass



//-----------------------------------------------------------------------------------------------------------------------------------------

// 							HALF DUPLEXXXXX 
 
//-----------------------------------------------------------------------------------------------------------------------------------------

class hd_seq1 extends apb_uart_base_sequence;		 //FOR UART 1		
	`uvm_object_utils(hd_seq1)

	function new (string name = "hd_seq1");
		super.new(name);
	endfunction 
	
	task body();
		begin 

			//DIV 1 MSB	
			req = apb_uart_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h20; Pwdata==0;} )
		//	req.print();
			finish_item(req);


			//DIV 1 LSB
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h1C; Pwdata==54;} )
		//	req.print();
			finish_item(req);


			//LCR line control reg
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'hC; Pwdata==8'b00000011;} )
		//	req.print();
			finish_item(req);


			//FCR fifo control reg
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h8; Pwdata==8'b00000110;} )
		//	req.print();
			finish_item(req);


			//IER interrupt enable reg
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h4; Pwdata==8'b00000101;} )
		//	req.print();
			finish_item(req);	

			//IIR 
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h8;} )
		//	req.print();
			finish_item(req);
			get_response(req);
		
			//RBR  rece buff reg

			if(req.IIR[3:0] == 4)
				begin 
					start_item(req);
					assert(req.randomize() with {Pwrite==0; Paddr==32'h00;} )
			//		req.print();
					finish_item(req);
				end

			//LSR line status reg
	
			if(req.IIR[3:1] == 6)
				begin 
					start_item(req);
					assert(req.randomize() with {Pwrite==0; Paddr==32'h14;} )
			//		req.print();
					finish_item(req);
				end

		
		end 
	endtask

endclass




class hd_seq2 extends apb_uart_base_sequence;			 //	UART 2	

	`uvm_object_utils(hd_seq2)

	function new (string name = "hd_seq2");
		super.new(name);
	endfunction 
	
	task body();
		begin 
		
			//DIV 2 MSB
	
			req = apb_uart_trans::type_id::create("req");	
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h20; Pwdata==0;} )
		//	req.print();
			finish_item(req);


			//DIV 2 LSB
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h1C; Pwdata ==27;} )
		//	req.print();
			finish_item(req);

			//LCR line control reg
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'hC; Pwdata==8'b00000011;} )
		//	req.print();
			finish_item(req);


			//FCR fifo control reg
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h8; Pwdata==8'b00000110;} )
		//	req.print();
			finish_item(req);


			//IER interrupt enable reg
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h4; Pwdata==8'b00000111;} )
		//	req.print();
			finish_item(req);

			//THR transmitter holding reg
			start_item(req);
			assert(req.randomize() with {Pwrite== 1; Paddr==32'h0; Pwdata==101;} )
		//	req.print();
			finish_item(req);

	
		end 
	endtask

endclass


//-----------------------------------------------------------------------------------------------------------------------------------------

// 								LOOP BACK MODE 
 
//-----------------------------------------------------------------------------------------------------------------------------------------



class lb_seq1 extends apb_uart_base_sequence; //FOR UART 1

	`uvm_object_utils(lb_seq1)

	function new (string name = "lb_seq1");
		super.new(name);
	endfunction 
	
	task body();
		begin 
			req = apb_uart_trans::type_id::create("req");

			//DIV 1 MSB		
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h20; Pwdata==0;} )
			finish_item(req);

			//DIV 1 LSB
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h1C; Pwdata==27;} )
			finish_item(req);

			//LCR line control register
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'hC; Pwdata==8'b00000011;} )
			finish_item(req);

			//FCR fifo control register
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h8; Pwdata==8'b00000110;} )
			finish_item(req);

			//IER interrupt enable register
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h4; Pwdata==8'b00000101;} )
			finish_item(req);

			//MCR modem control register
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h10; Pwdata==8'b00010000;} )
			finish_item(req);		

			//THR transmitter holding register
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h0; Pwdata==250;} )
			finish_item(req);

			//IIR 	
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h8;} )
			finish_item(req);
			get_response(req);

			// RBR receiver buffer register
			if(req.IIR[3:0] == 4) 
				begin
					start_item(req);
					assert(req.randomize() with {Pwrite==0; Paddr==32'h00;} )
					finish_item(req);
				end
		
			// LSR line status register
			if(req.IIR[3:0] == 6)
				 begin
					start_item(req);
					assert(req.randomize() with {Pwrite==0; Paddr==32'h14;} );
					finish_item(req);
				end
					
		end 
	endtask

endclass  



class lb_seq2 extends apb_uart_base_sequence; 				// UART 2

	`uvm_object_utils(lb_seq2)

	function new (string name = "lb_seq2");
		super.new(name);
	endfunction 
	
	task body();
		begin 
			req = apb_uart_trans::type_id::create("req");

			//DIV 2 MSB		
			start_item(req);
			assert(req.randomize() with {Pwrite==1 ;Paddr==32'h20; Pwdata==0;} )
			finish_item(req);

			//DIV 2 LSB
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h1C; Pwdata==54;} )
			finish_item(req);

			//LCR line control register
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'hC; Pwdata==8'b00000011;} )
			finish_item(req);

			//FCR fifo control register
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h8; Pwdata==8'b00000110;} )
			finish_item(req);

			//IER interrupt enable register
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h4; Pwdata==8'b00000101;} )
			finish_item(req);

			//MCR modem control register
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h10; Pwdata==8'b00010000;} )
			finish_item(req);		

			//THR transmitter holding register
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h0; Pwdata==200;} )
			finish_item(req);

			//IIR
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h8;} )
			finish_item(req);
			get_response(req);

			//RBR
			if(req.IIR[3:0] == 4)
				begin
					start_item(req);
					assert(req.randomize() with {Pwrite==0; Paddr==32'h00;} )
					finish_item(req);
				end
			
			//LSR
			if(req.IIR[3:0] == 6)
				 begin
					start_item(req);
					assert(req.randomize() with {Pwrite==0; Paddr==32'h14;} )
					finish_item(req);
				end

		end 
	endtask

endclass 


//--------------------------------------------------------------------------------------------------------------------------------------------------------------------

//									ERRORRRRRRRRRRR

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
		
	
//								PARITY ERROR 	- pe
//								FRAMING ERROR	- fe
//								BREAK ERROR 	- be
//								OVERRUN ERROR 	- oe
//								TIMEOUT ERROR 	- te
//								THR EMPTY ERROR - thr_e



//--------------------------------------------------------------------------------------------------------------------------------------------------------------------


//									PARITY ERROR

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------




class pe_seq1 extends apb_uart_base_sequence;		// ENABLE THE PARITY BIT [ LCR 3RD BIT ] && AND FOR ONE SEQ ODD PARITY FOR OTHE EVEN PARITY

	`uvm_object_utils(pe_seq1)

	function new (string name = "pe_seq1");
		super.new(name);
	endfunction 
	
	task body();
		begin 

			//DIV 1 MSB	
			req = apb_uart_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h20; Pwdata==0;} )
		//	req.print();
			finish_item(req);


			//DIV 1 LSB
			start_item(req);
			assert(req.randomize() with {Pwrite==1;Paddr==32'h1C;Pwdata==54;} )
		//	req.print();
			finish_item(req);


			//LCR line control reg
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'hC; Pwdata==8'b00001011;} )
		//	req.print();
			finish_item(req);



			//FCR fifo control reg
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h8; Pwdata==8'b00000110;} )
		//	req.print();
			finish_item(req);


			//IER interrupt enable reg
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h4; Pwdata==8'b00000101;} )
		//	req.print();
			finish_item(req);	


			//THR transmitter holding reg
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h0; Pwdata==23;} )
		//	req.print();
			finish_item(req);


			//IIR intrpt ident reg
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h8;} )
		//	req.print();
			finish_item(req);
			get_response(req);


			//RBR rec buf reg
			if(req.IIR[3:0] == 4)
				begin 
					start_item(req);
					assert(req.randomize() with {Pwrite==0; Paddr==32'h0;} )
				//	req.print();	
					finish_item(req);
				end

			//LSR	line status reg
			if(req.IIR[3:0] == 6)
				begin 
					start_item(req);
					assert(req.randomize() with {Pwrite==0; Paddr==32'h14;} )
			//		req.print();
					finish_item(req);	
				end
		
		
		end 
	endtask

endclass




class pe_seq2 extends apb_uart_base_sequence; 			// UART 2 

	`uvm_object_utils(pe_seq2)

	function new (string name = "pe_seq2");
		super.new(name);
	endfunction 
	
	task body();
		begin 
		
			//DIV 2 MSB
			req = apb_uart_trans::type_id::create("req");	
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h20; Pwdata==0;} )
		//	req.print();
			finish_item(req);


			//DIV 2 LSB
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h1C; Pwdata==27;} )
		//	req.print();
			finish_item(req);

			//LCR line control reg
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'hC; Pwdata==8'b00011111;} )
		//	req.print();
			finish_item(req);


			//FCR fifo control reg
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h8; Pwdata==8'b00000110;} )
		//	req.print();
			finish_item(req);


			//IER interrupt enable reg
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h4; Pwdata==8'b00000101;} )
		//	req.print();
			finish_item(req);
	

			//THR transmitter holding reg
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h0; Pwdata==221;} )
		//	req.print();
			finish_item(req);

			//IIR 
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h8;} )
		//	req.print();
			finish_item(req);
			get_response(req);
		
			//RBR  rece buff reg
			if(req.IIR[3:0] == 4)
				begin 
					start_item(req);
					assert(req.randomize() with {Pwrite==0; Paddr==32'h0;} )
			//		req.print();
					finish_item(req);
				end

			//LSR line status reg
			if(req.IIR[3:0] == 6)
				begin 
					start_item(req);
					assert(req.randomize() with {Pwrite==0; Paddr==32'h14;} )
			//		req.print();
					finish_item(req);
				end
		
	
		end 
	endtask

endclass


//--------------------------------------------------------------------------------------------------------------------------------------------------------------------


//									FRAMING ERROR

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------



class fe_seq1 extends apb_uart_base_sequence;

	`uvm_object_utils(fe_seq1)

	function new(string name="fe_seq1");
		super.new(name);
	endfunction

	apb_uart_env_config config_h;

	task body();

		
		req = apb_uart_trans::type_id::create("req");

		//DIV 1 MSB
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h20; Pwdata==0;} )
		finish_item(req);

		//DIV 1 LSB
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h1C; Pwdata==54;} )
		finish_item(req);

		//LCR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'hC; Pwdata==8'b00000011;} )
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h8; Pwdata==8'b00000110;} )
		finish_item(req);

		//IIR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h4; Pwdata==8'b00000101;} )
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h0; Pwdata==100;} )
		req.print();
		finish_item(req);

	endtask

endclass

class fe_seq2 extends apb_uart_base_sequence;

	`uvm_object_utils(fe_seq2)

	function new(string name="fe_seq2");
		super.new(name);
	endfunction

	apb_uart_env_config config_h;

	task body();
		
		req = apb_uart_trans::type_id::create("req");			
	
		//DIV 2 MSB
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h20; Pwdata==0;} )
		finish_item(req);

		//DIV 2 LSB 
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h1C; Pwdata==27;} )
		finish_item(req);

		//LCR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'hC; Pwdata==8'b0100010;} )
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h8; Pwdata==8'b00000110;} )
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h4; Pwdata==8'b00000101;} )
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize() with {Pwrite==1;Paddr==32'h0;Pwdata==200;} )
		req.print();
		finish_item(req);

		//IIR 
		start_item(req);
		assert(req.randomize() with {Pwrite==0; Paddr==32'h8;} )
		finish_item(req);
		get_response(req);

		//RBR
		if(req.IIR[3:0] == 4)
		begin
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h0;} )
			finish_item(req);
		end

		//LSR
		if(req.IIR[3:0] == 6)
		begin
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h14;} )
			finish_item(req);
		end

	endtask

endclass

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------


//									BREAKING ERROR

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------



class be_seq1 extends apb_uart_base_sequence;

	`uvm_object_utils(be_seq1)

	function new(string name="be_seq1");
		super.new(name);
	endfunction

	apb_uart_env_config config_h;

	task body();

		
		req = apb_uart_trans::type_id::create("req");

		//DIV 1 MSB
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h20; Pwdata==0;} )
		finish_item(req);

		//DIV 1 LSB
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h1C; Pwdata==54;} )
		finish_item(req);

		//LCR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'hC; Pwdata==8'b01000011;} )
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h8; Pwdata==8'b00000110;} )
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h4; Pwdata==8'b00000101;} )
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h0; Pwdata==100;} )
		req.print();
		finish_item(req);

		//IIR
		start_item(req);
		assert(req.randomize() with {Pwrite==0; Paddr==32'h8;} )
		finish_item(req);
		get_response(req);		

		//RBR
		if(req.IIR[3:0] == 4)
		begin
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h0;} )
			finish_item(req);
		end

		//LSR
		if(req.IIR[3:0] == 6)
		begin
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h14;} )
			finish_item(req);
		end

	endtask

endclass

class be_seq2 extends apb_uart_base_sequence;

	`uvm_object_utils(be_seq2)

	function new(string name="be_seq2");
		super.new(name);
	endfunction

	apb_uart_env_config config_h;

	task body();
		
		req = apb_uart_trans::type_id::create("req");			
	
		//DIV 2 MSB
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h20; Pwdata==0;} )
		finish_item(req);

		//DIV 2 LSB 
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h1C; Pwdata==27;} )
		finish_item(req);

		//LCR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'hC; Pwdata==8'b01000011;} )
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h8; Pwdata==8'b00000110;} )
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h4; Pwdata==8'b00000101;} )
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h0; Pwdata==200;} )
		req.print();
		finish_item(req);

		//IIR 
		start_item(req);
		assert(req.randomize() with {Pwrite==0; Paddr==32'h8;} )
		finish_item(req);
		get_response(req);

		//RBR
		if(req.IIR[3:0] == 4)
		begin
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h0;} )
			finish_item(req);
		end

		//LSR
		if(req.IIR[3:0] == 6)
		begin
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h14;} )
			finish_item(req);
		end

	endtask

endclass


//--------------------------------------------------------------------------------------------------------------------------------------------------------------------


//									OVERRUN ERROR

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------



class oe_seq1 extends apb_uart_base_sequence;

	`uvm_object_utils(oe_seq1)

	function new(string name="oe_seq1");
		super.new(name);
	endfunction

	apb_uart_env_config config_h;

	task body();
		req = apb_uart_trans::type_id::create("req");

		//DIV 1 MSB
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h20; Pwdata==0;} )
		finish_item(req);

		//DIV 1 LSB
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h1C; Pwdata==54;} )
		finish_item(req);

		//LCR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'hC; Pwdata==8'b00000011;} )
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h8; Pwdata==8'b11000110;} )
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h4; Pwdata==8'b00000100;} )
		finish_item(req);

		//THR
		repeat(17)
		begin
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h0; Pwdata==100;} )
			finish_item(req);
		end

		//IER
		start_item(req);
		assert(req.randomize() with {Pwrite==0; Paddr==32'h8;} )
		finish_item(req);
		get_response(req);		

		//RBR
		if(req.IIR[3:0] == 4)
		begin
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h0;} )
			finish_item(req);
		end

		//LSR
		if(req.IIR[3:0] == 6)
		begin
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h14;} )
			finish_item(req);
		end


 	endtask

endclass

class oe_seq2 extends apb_uart_base_sequence;

	`uvm_object_utils(oe_seq2)

	function new(string name="oe_seq2");
		super.new(name);
	endfunction

	apb_uart_env_config config_h;

	task body();
		
		begin
		req = apb_uart_trans::type_id::create("req");			
	
		//DIV MSB 2
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h20; Pwdata==0;} )
		finish_item(req);

		//DIV LSB 2
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h1C ;Pwdata==27;} )
		finish_item(req);

		//LCR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'hC; Pwdata==8'b00000011;} )
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h8; Pwdata==8'b11000110;} )
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h4; Pwdata==8'b00000100;} )
		finish_item(req);

		//THR
		repeat(17)
		begin
			start_item(req);
			assert(req.randomize() with {Pwrite==1; Paddr==32'h0; Pwdata==200;} )
			finish_item(req);
		end

		//IIR
		start_item(req);
		assert(req.randomize() with {Pwrite==0; Paddr==32'h8;} )
		finish_item(req);
		get_response(req);

		//RBR
		if(req.IIR[3:0] == 4)
		begin
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h0;} )
			finish_item(req);
		end

		//LSR
		if(req.IIR[3:0] == 6)
		begin
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h14;} )
			finish_item(req);
		end

	end




	endtask

endclass

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------


//									THR EMPTY ERROR

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------



class thr_e_seq1 extends apb_uart_base_sequence;

	`uvm_object_utils(thr_e_seq1)

	function new(string name="thr_e_seq1");
		super.new(name);
	endfunction

	apb_uart_env_config config_h;

	task body();

			
		req = apb_uart_trans::type_id::create("req");

		//DIV 1 MSB
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h20; Pwdata==0;} )
		finish_item(req);

		//DIV 1 LSB
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h1C; Pwdata==54;} )
		finish_item(req);

		//LCR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'hC; Pwdata==8'b00000011;} )
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h8; Pwdata==8'b00000110;} )
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h4; Pwdata==8'b00000010;} )
		finish_item(req);


		//IIR 
		start_item(req);
		assert(req.randomize() with {Pwrite==0; Paddr==32'h8;} )
		finish_item(req);
		get_response(req);		

		//RBR
		if(req.IIR[3:0] == 4)
		begin
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h0;} )
			finish_item(req);
		end

		//LSR
		if(req.IIR[3:0] == 6)
		begin
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h14;} )
			finish_item(req);
		end



	endtask

endclass

class thr_e_seq2 extends apb_uart_base_sequence;

	`uvm_object_utils(thr_e_seq2)

	function new(string name="thr_e_seq2");
		super.new(name);
	endfunction

	apb_uart_env_config config_h;

	task body();
		
	
		req = apb_uart_trans::type_id::create("req");			
	
		//DIV 2 MSB
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h20; Pwdata==0;} )
		finish_item(req);

		//DIV 2 LSB
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h1C; Pwdata==27;} )
		finish_item(req);

		//LCR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'hC; Pwdata==8'b00000011;} )
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h8; Pwdata==8'b00000110;} )
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h4; Pwdata==8'b00000010;} )
		finish_item(req);


		//IIR 
		start_item(req);
		assert(req.randomize() with {Pwrite==0; Paddr==32'h8;} )
		finish_item(req);
		get_response(req);

		//RBR
		if(req.IIR[3:0] == 4)
		begin
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h0;} )
			finish_item(req);
		end

		//LSR
		if(req.IIR[3:0] == 6)
		begin
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h14;} )
			finish_item(req);
		end


	endtask

endclass



//--------------------------------------------------------------------------------------------------------------------------------------------------------------------


//									TIMEE OUTTT ERROR

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------



class te_seq1 extends apb_uart_base_sequence;

	`uvm_object_utils(te_seq1)

	function new(string name="te_seq1");
		super.new(name);
	endfunction

	apb_uart_env_config config_h;

	task body();

			
		req = apb_uart_trans::type_id::create("req");

		//DIV 1 MSB
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h20; Pwdata==0;} )
		finish_item(req);

		//DIV 1 LSB
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h1C; Pwdata==54;} )
		finish_item(req);

		//LCR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'hC; Pwdata==8'b00000111;} )
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h8; Pwdata==8'b00000110;} )
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h4; Pwdata==8'b00000000;} )
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h0; Pwdata==200;} )
		finish_item(req);
	

		//IIR 
		start_item(req);
		assert(req.randomize() with {Pwrite==0; Paddr==32'h8;} )
		finish_item(req);
		get_response(req);		

		//RBR
		if(req.IIR[3:0] == 4)
		begin
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h0;} )
			finish_item(req);
		end

		//LSR
		if(req.IIR[3:0] == 6)
		begin
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h14;} )
			finish_item(req);
		end



	endtask

endclass

class te_seq2 extends apb_uart_base_sequence;

	`uvm_object_utils(te_seq2)

	function new(string name="te_seq2");
		super.new(name);
	endfunction

	apb_uart_env_config config_h;

	task body();
		
	
		req = apb_uart_trans::type_id::create("req");			
	
		//DIV 2 MSB
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h20; Pwdata==0;} )
		finish_item(req);

		//DIV 2 LSB
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h1C; Pwdata==27;} )
		finish_item(req);

		//LCR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'hC; Pwdata==8'b00000111;} )
		finish_item(req);

		//FCR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h8; Pwdata==8'b00000110;} )
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h4; Pwdata==8'b00000000;} )
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize() with {Pwrite==1; Paddr==32'h0; Pwdata==200;} )
		finish_item(req);
	
		//IIR 
		start_item(req);
		assert(req.randomize() with {Pwrite==0; Paddr==32'h8;} )
		finish_item(req);
		get_response(req);

		//RBR
		if(req.IIR[3:0] == 4)
		begin
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h0;} )
			finish_item(req);
		end

		//LSR
		if(req.IIR[3:0] == 6)
		begin
			start_item(req);
			assert(req.randomize() with {Pwrite==0; Paddr==32'h14;} )
			finish_item(req);
		end


	endtask

endclass
