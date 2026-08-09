class seqs extends uvm_sequence #(trans);
	`uvm_object_utils(seqs)

	function new(string name="seqs");
		super.new(name);
	endfunction
endclass

//------------------------------------UART0___TX___HALF DUPLEX ---------50Mhz
class HD_0_sequence_xtns extends seqs;
	`uvm_object_utils(HD_0_sequence_xtns)

	function new(string name = "HD_0_sequence_xtns");
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
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==8'b0000_0110;});
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==8'b0000_0011;});
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==8'b0000_0101;});
	   		finish_item(req);
	   		
	   		//--------------------------------Transimtter Holding Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b1; PWDATA inside{[15:15]};});
	   		finish_item(req);
      		end
  	endtask
endclass

//------------------------------------UART1___RX___HALF DUPLEX ---------100Mhz
class HD_1_sequence_xtns extends seqs;
	`uvm_object_utils(HD_1_sequence_xtns)

	function new(string name = "HD_1_sequence_xtns");
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
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==32'h06;}); //'b0000_0110
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==32'h03;}); //'b0000_0011
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==32'h01;}); //'b0000_0001
	   		finish_item(req);

        		//--------------------------------Interrupt Identification Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b0;});
	   		finish_item(req);
	   		get_response(req);
	   		
	   		//--------------------------------Receiver Buffer Register
	   		if(req.iir[3:0] == 'h4)
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


//------------------------------------UART0___TX___HALF DUPLEX__MULTIPLE_DATA_TRANSFER
class HDM_0_sequence_xtns extends seqs;
	`uvm_object_utils(HDM_0_sequence_xtns)

	function new(string name = "HDM_0_sequence_xtns");
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
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==8'b1100_0100;});
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==8'b0000_0011;});
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==8'b0000_0101;});
	   		finish_item(req);
	   		
	   		//--------------------------------Transimtter Holding Register
	   		repeat(14) 
	   		begin
		   		start_item(req);
		   		assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b1; PWDATA inside{[1:255]};});
		   		finish_item(req);
	   		end
      		end
  	endtask
endclass

//------------------------------------UART1___RX___HALF DUPLEX__MULTIPLE_DATA_TRANSFER
class HDM_1_sequence_xtns extends seqs;
	`uvm_object_utils(HDM_1_sequence_xtns)

	function new(string name = "HDM_1_sequence_xtns");
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
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==8'b1100_0100;});
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==8'b0000_0011;});
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==8'b0000_0001;});
	   		finish_item(req);

        		//--------------------------------Interrupt Identification Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b0;});
	   		finish_item(req);
	   		get_response(req);
	   		
	   		//--------------------------------Receiver Buffer Register
	   		if(req.iir[3:0] == 'h4)
	   		repeat(14)
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


//------------------------------------UART0___TX-RX___FULL DUPLEX
class FD_0_sequence_xtns extends seqs;
	`uvm_object_utils(FD_0_sequence_xtns)

	function new(string name = "FD_0_sequence_xtns");
		super.new(name);
	endfunction
 
   	task body();
	repeat(1)
		begin
		  	req=trans::type_id::create("req");
			
			  //--------------------------------DIV2 - Divisor MSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h20; PWRITE==1'b1; PWDATA=='d0;});
	   		finish_item(req);
	   		
	   		//--------------------------------DIV1 - Divisor LSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h1c; PWRITE==1'b1; PWDATA=='d27;});
	   		finish_item(req);
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==32'h06;});
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==32'h03;});
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==32'h01;});
	   		finish_item(req);
	   		
        		//--------------------------------Transimtter Holding Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b1; PWDATA inside{[1:99]};});
	   		finish_item(req);
                            
        		//--------------------------------Interrupt Identification Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b0;});
	   		finish_item(req);
	   		get_response(req);
	   		
	   		//--------------------------------Receiver Buffer Register
	   		if(req.iir[3:0] == 'h4)
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

//------------------------------------UART1___TX-RX___FULL DUPLEX
class FD_1_sequence_xtns extends seqs;
	`uvm_object_utils(FD_1_sequence_xtns)

	function new(string name = "FD_1_sequence_xtns");
		super.new(name);
	endfunction

   	task body();
	repeat(1)
		begin
       			trans req1;
   
		  	req1=trans::type_id::create("req1");
			
			//--------------------------------DIV2 - Divisor MSB
	   		start_item(req1);
	   		assert(req1.randomize() with {PADDR==32'h20; PWRITE==1'b1; PWDATA=='d0;});
	   		finish_item(req1);
	   		
	   		//--------------------------------DIV1 - Divisor LSB
	   		start_item(req1);
	   		assert(req1.randomize() with {PADDR==32'h1c; PWRITE==1'b1; PWDATA=='d54;});
	   		finish_item(req1);
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req1);
	   		assert(req1.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==32'h06;});
	   		finish_item(req1);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req1);
	   		assert(req1.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==32'h03;});
	   		finish_item(req1);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req1);
	   		assert(req1.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==32'h01;});
	   		finish_item(req1);
	   		
        		//--------------------------------Transimtter Holding Register
	   		start_item(req1);
	   		assert(req1.randomize() with {PADDR==32'h00; PWRITE==1'b1; PWDATA inside{[100:199]};});
	   		finish_item(req1);
                        
        		//--------------------------------Interrupt Identification Register
	   		start_item(req1);
	   		assert(req1.randomize() with {PADDR==32'h8; PWRITE==1'b0;});
	   		finish_item(req1);
	   		get_response(req1);
	   		
	   		//--------------------------------Receiver Buffer Register
	   		if(req1.iir[3:0] == 'h4)
	   		begin
	   			start_item(req1);
	   			assert(req1.randomize() with {PADDR==32'h00; PWRITE==1'b0;});
	   			finish_item(req1);
	   		end
      
	   		//--------------------------------Line Status Register
	   		if(req1.iir[3:0] == 'h6)
	   		begin
	   			start_item(req1);
	   			assert(req1.randomize() with {PADDR==32'h14; PWRITE==1'b0;});
	   			finish_item(req1);
	   		end         
	   	end
    	endtask
endclass

//------------------------------------UART0___TX-RX___FULL DUPLEX MULTIPLE_DATA_TRANSFER
class FDM_0_sequence_xtns extends seqs;
	`uvm_object_utils(FDM_0_sequence_xtns)

	function new(string name = "FDM_0_sequence_xtns");
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
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==8'b1100_0100;});
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==8'b0000_0011;});
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==8'b0000_0101;});
	   		finish_item(req);
	   		
	   		//--------------------------------Transimtter Holding Register
	   		repeat(14) 
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
	   		repeat(14)
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

//------------------------------------UART1___TX-RX___FULL DUPLEX MULTIPLE_DATA_TRANSFER
class FDM_1_sequence_xtns extends seqs;
	`uvm_object_utils(FDM_1_sequence_xtns)

	function new(string name = "FDM_1_sequence_xtns");
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
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==8'b1100_0100;});
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==8'b0000_0011;});
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==8'b0000_0001;});
	   		finish_item(req);
	   		
	   		//--------------------------------Transimtter Holding Register
	   		repeat(14) 
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
	   		repeat(14)
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


//------------------------------------UART0___TX-RX___FULL DUPLEX_LOOPBACK
class FDLB_0_sequence_xtns extends seqs;
	`uvm_object_utils(FDLB_0_sequence_xtns)

	function new(string name = "FDLB_0_sequence_xtns");
		super.new(name);
	endfunction
 
   	task body();
	repeat(1)
		begin
		  	req=trans::type_id::create("req");
			
			//--------------------------------DIV2 - Divisor MSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h20; PWRITE==1'b1; PWDATA=='d0;});
	   		finish_item(req);
	   		
	   		//--------------------------------DIV1 - Divisor LSB
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h1c; PWRITE==1'b1; PWDATA=='d27;});
	   		finish_item(req);
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==32'h06;});
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==32'h03;});
	   		finish_item(req);
	   		
	   		//--------------------------------Modem Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h10; PWRITE==1'b1; PWDATA==8'b0001_0110;}); //h'16
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==32'h01;});
	   		finish_item(req);
	   		
        		//--------------------------------Transimtter Holding Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h00; PWRITE==1'b1; PWDATA inside{[1:99]};});
	   		finish_item(req);
                           
        		//--------------------------------Interrupt Identification Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b0;});
	   		finish_item(req);
	   		get_response(req);
	   		
	   		//--------------------------------Receiver Buffer Register
	   		if(req.iir[3:0] == 'h4)
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

//------------------------------------UART1___TX-RX___FULL DUPLEX_LOOPBACK
class FDLB_1_sequence_xtns extends seqs;
	`uvm_object_utils(FDLB_1_sequence_xtns)

	function new(string name = "FDLB_1_sequence_xtns");
		super.new(name);
	endfunction

   	task body();
	repeat(1)
		begin
       			trans req1;
   
		  	req1=trans::type_id::create("req1");
			
			//--------------------------------DIV2 - Divisor MSB
	   		start_item(req1);
	   		assert(req1.randomize() with {PADDR==32'h20; PWRITE==1'b1; PWDATA=='d0;});
	   		finish_item(req1);
	   		
	   		//--------------------------------DIV1 - Divisor LSB
	   		start_item(req1);
	   		assert(req1.randomize() with {PADDR==32'h1c; PWRITE==1'b1; PWDATA=='d54;});
	   		finish_item(req1);
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req1);
	   		assert(req1.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==32'h06;});
	   		finish_item(req1);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req1);
	   		assert(req1.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==32'h03;});
	   		finish_item(req1);
	   		
	   		//--------------------------------Modem Control Register
	   		start_item(req1);
	   		assert(req1.randomize() with {PADDR==32'h10; PWRITE==1'b1; PWDATA==8'b0001_0110;}); //h'16
	   		finish_item(req1);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req1);
	   		assert(req1.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==32'h01;});
	   		finish_item(req1);
	   		
        		//--------------------------------Transimtter Holding Register
	   		start_item(req1);
	   		assert(req1.randomize() with {PADDR==32'h00; PWRITE==1'b1; PWDATA inside{[100:199]};});
	   		finish_item(req1);
                        
        		//--------------------------------Interrupt Identification Register
	   		start_item(req1);
	   		assert(req1.randomize() with {PADDR==32'h8; PWRITE==1'b0;});
	   		finish_item(req1);
	   		get_response(req1);
	   		
	   		//--------------------------------Receiver Buffer Register
	   		if(req1.iir[3:0] == 'h4)
	   		begin
	   			start_item(req1);
	   			assert(req1.randomize() with {PADDR==32'h00; PWRITE==1'b0;});
	   			finish_item(req1);
	   		end
      
	   		//--------------------------------Line Status Register
	   		if(req1.iir[3:0] == 'h6)
	   		begin
	   			start_item(req1);
	   			assert(req1.randomize() with {PADDR==32'h14; PWRITE==1'b0;});
	   			finish_item(req1);
	   		end         
	   	end
    	endtask
endclass

//------------------------------------UART0___TX-RX___FULL DUPLEX_LOOPBACK MULTIPLE_DATA_TRANSFER
class FDLBM_0_sequence_xtns extends seqs;
	`uvm_object_utils(FDLBM_0_sequence_xtns)

	function new(string name = "FDLBM_0_sequence_xtns");
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
	   		
	   		//--------------------------------Modem Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h10; PWRITE==1'b1; PWDATA==8'b0001_0110;}); //h'16
	   		finish_item(req);
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==8'b1100_0100;});
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==8'b0000_0011;});
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==8'b0000_0101;});
	   		finish_item(req);
	   		
	   		//--------------------------------Transimtter Holding Register
	   		repeat(14) 
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
	   		repeat(14)
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

//------------------------------------UART1___TX-RX___FULL DUPLEX_LOOPBACK MULTIPLE_DATA_TRANSFER
class FDLBM_1_sequence_xtns extends seqs;
	`uvm_object_utils(FDLBM_1_sequence_xtns)

	function new(string name = "FDLBM_1_sequence_xtns");
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
	   		
			//--------------------------------Modem Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h10; PWRITE==1'b1; PWDATA==8'b0001_0110;}); //h'16
	   		finish_item(req);
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==8'b1100_0100;});
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==8'b0000_0011;});
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==8'b0000_0101;});
	   		finish_item(req);
	   		
	   		//--------------------------------Transimtter Holding Register
	   		repeat(14) 
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
	   		repeat(14)
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


//------------------------------------UART0___TX-RX___FULL DUPLEX MULTIPLE_DATA_TRANSFER_THR_EMPTY
class FDM_0_thr_empty_sequence_xtns extends seqs;
	`uvm_object_utils(FDM_0_thr_empty_sequence_xtns)

	function new(string name = "FDM_0_thr_empty_sequence_xtns");
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
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==8'b1100_0100;});
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==8'b0000_0011;});
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==8'b0000_0010;});
	   		finish_item(req);
	   		
	   		//--------------------------------Transimtter Holding Register
	   		repeat(14) 
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
	   		repeat(14)
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

//------------------------------------UART1___TX-RX___FULL DUPLEX MULTIPLE_DATA_TRANSFER_THR_EMPTY
class FDM_1_thr_empty_sequence_xtns extends seqs;
	`uvm_object_utils(FDM_1_thr_empty_sequence_xtns)

	function new(string name = "FDM_1_thr_empty_sequence_xtns");
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
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==8'b1100_0100;});
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==8'b0000_0011;});
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==8'b0000_0010;});
	   		finish_item(req);
	   		
	   		//--------------------------------Transimtter Holding Register
	   		repeat(14) 
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
	   		repeat(14)
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


//------------------------------------UART0___TX-RX___FULL DUPLEX MULTIPLE_DATA_TRANSFER WITH EVEN PARITY
class FDM_EP_0_sequence_xtns extends seqs;
	`uvm_object_utils(FDM_EP_0_sequence_xtns)

	function new(string name = "FDM_EP_0_sequence_xtns");
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
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==8'b1100_0100;});
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==8'b0001_1011;});
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==8'b0000_0101;});
	   		finish_item(req);
	   		
	   		//--------------------------------Transimtter Holding Register
	   		repeat(14) 
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
	   		repeat(14)
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

//------------------------------------UART1___TX-RX___FULL DUPLEX MULTIPLE_DATA_TRANSFER WITH EVEN PARITY
class FDM_EP_1_sequence_xtns extends seqs;
	`uvm_object_utils(FDM_EP_1_sequence_xtns)

	function new(string name = "FDM_EP_1_sequence_xtns");
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
	   		
	   		//--------------------------------FIFO Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h8; PWRITE==1'b1; PWDATA==8'b1100_0100;});
	   		finish_item(req);
	   		
	   		//--------------------------------Line Control Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'hc; PWRITE==1'b1; PWDATA==8'b0001_1011;});
	   		finish_item(req);
	   		
	   		//--------------------------------Interrupt Enable Register
	   		start_item(req);
	   		assert(req.randomize() with {PADDR==32'h4; PWRITE==1'b1; PWDATA==8'b0000_0001;});
	   		finish_item(req);
	   		
	   		//--------------------------------Transimtter Holding Register
	   		repeat(14) 
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
	   		repeat(14)
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
