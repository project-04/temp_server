`timescale 1ns / 1ns
module uart_rx_tb();
  
  reg pclk, presetn;
  reg RXD, pop_rx_fifo, enable;
  reg [7:0] LCR;
  wire rx_idle;
  wire [7:0] rx_fifo_out;
  wire [4:0] rx_fifo_count;
  wire push_rx_fifo, rx_fifo_empty, rx_fifo_full;
  wire rx_overrun, parity_error, framing_error, break_error, time_out;
  
  // Instantiate DUT
  uart_rx DUT (
    .PCLK(pclk), 
    .PRESETn(presetn),
    .RXD(RXD),
    .pop_rx_fifo(pop_rx_fifo),
    .enable(enable),
    .LCR(LCR),
    .rx_idle(rx_idle),
    .rx_fifo_out(rx_fifo_out),
    .rx_fifo_count(rx_fifo_count),
    .push_rx_fifo(push_rx_fifo),
    .rx_fifo_empty(rx_fifo_empty),
    .rx_fifo_full(rx_fifo_full),
    .rx_overrun(rx_overrun),
    .parity_error(parity_error),
    .framing_error(framing_error),
    .break_error(break_error),
    .time_out(time_out)
  );
  
  // Clock
  initial pclk = 0;
  always #10 pclk = ~pclk; // 50MHz clock
  
  localparam integer CLK_FREQ    = 50_000_000; //50MHz
  localparam integer BAUD        = 115200;
  localparam integer OVERSAMP    = 16;
  localparam integer baud_trigger = CLK_FREQ / (OVERSAMP * BAUD); //27

  integer cycle_count = 0;
  
  always@(posedge pclk)
  begin
  	if(baud_trigger == cycle_count)
  	begin
  		enable <= 1'b1;
  		cycle_count <= 0;
  	end
  	else 
  	begin
  		enable <= 1'b0;
  		cycle_count <= cycle_count+1;
  	end
  end
  
  // Reset task
  task reset();
  begin
	@(negedge pclk) presetn = 1'b0;
	@(negedge pclk) presetn = 1'b1;
  end
  endtask
  
  task pop_operation();
  begin
	@(negedge pclk) pop_rx_fifo = 1'b1;
     	@(negedge pclk) pop_rx_fifo = 1'b0;
  end
  endtask 

  // Send a byte serially (start bit + data bits + parity + stop bits)
  integer no_of_bits, i;
  task send_byte(input [7:0] data, input inserted_parity_error, input inserted_framing_error);
  begin
      // idle line is high
      RXD = 1'b1; @(posedge enable);
       
      // start bit
      RXD = 1'b0; repeat(16) @(posedge enable);
      
      // data bits (LSB first)
      case({LCR[1:0]})
		2'b00 : no_of_bits = 5;
		2'b01 : no_of_bits = 6; 
		2'b10 : no_of_bits = 7;
		2'b11 : no_of_bits = 8;
		default  no_of_bits = 5;
      endcase
      for (i = 0; i < no_of_bits; i = i + 1)
      begin
          RXD = data[i];
          repeat(16) @(posedge enable);
      end
      
      
      // parity bit
      if(LCR[3] == 1'b1)
      begin
	      if(inserted_parity_error)
	      begin
		case({LCR[5:4]})
		  2'b00 : RXD <= (^data); //odd parity generator
		  2'b01 : RXD <= ~(^data); //even parity generator 
		  2'b10 : RXD <= 1'b0; //odd parity but LCR[4] inverse
		  2'b11 : RXD <= 1'b1; //even parity but LCR[4] inverse
		  //default  RXD <= 1'b0;
		endcase
	      	repeat(16) @(posedge enable);
	      end
	      else
	      begin
		case({LCR[5:4]})
		  2'b00 : RXD <= ~(^data); //odd parity generator
		  2'b01 : RXD <=  (^data); //even parity generator 
		  2'b10 : RXD <= 1'b1; //odd parity but LCR[4] inverse
		  2'b11 : RXD <= 1'b0; //even parity but LCR[4] inverse
		  //default  RXD <= 1'b0;
		endcase
	      	repeat(16) @(posedge enable);
	      end
     end
      
      // stop bit
      if(inserted_framing_error)
      begin
      	RXD = 1'b0;
      	repeat(16) @(posedge enable);
      end
      else
      begin
      	RXD = 1'b1;
      	repeat(16) @(posedge enable);
      end
      
      // 2nd stop bit
      if(LCR[2] == 1'b1)
      begin
      	RXD = 1'b1; // second stop (if LCR config wants)
      	repeat(16) @(posedge enable);
      end
      
      repeat(5) @(posedge pclk);
    end
  endtask
  
    task parity_error_task();
    begin
    repeat (1)
    begin
	// no error
	LCR = 8'b0_0_001_0_11; // config (odd parity, 8-bit, 1 stop)
	send_byte(8'b0000_1111, 1'b0, 1'b0); //0f // odd parity occurs
	pop_operation();

	LCR = 8'b0_0_011_0_11; // config (even parity, 8-bit, 1 stop)
	send_byte(8'b0000_1111, 1'b0, 1'b0); //1f // even parity occurs
	pop_operation();

	LCR = 8'b0_0_101_0_11; // config (stick 1, 8-bit, 1 stop)
	send_byte(8'b0000_1111, 1'b0, 1'b0); //2f // stick 1 occurs
	pop_operation();

	LCR = 8'b0_0_111_0_11; // config (stick 0, 8-bit, 1 stop)
	send_byte(8'b0000_1111, 1'b0, 1'b0); //3f // stick 0 occurs
	pop_operation();
    
    	// error
	LCR = 8'b0_0_001_0_11; // config (odd parity, 8-bit, 1 stop)
	send_byte(8'b0000_1111, 1'b1, 1'b0); //0f // odd parity error occurs
	pop_operation();

	LCR = 8'b0_0_011_0_11; // config (even parity, 8-bit, 1 stop)
	send_byte(8'b0000_1111, 1'b1, 1'b0); //1f // even parity error occurs
	pop_operation();

	LCR = 8'b0_0_101_0_11; // config (stick 1, 8-bit, 1 stop)
	send_byte(8'b0000_1111, 1'b1, 1'b0); //2f // stick 1 error occurs
	pop_operation();

	LCR = 8'b0_0_111_0_11; // config (stick 0, 8-bit, 1 stop)
	send_byte(8'b0000_1111, 1'b1, 1'b0); //3f // stick 0 error occurs
	pop_operation();
    end
    end
    endtask


    //reset();
    task framing_error_task();
    begin
    repeat (1) // frame error
    begin   
	LCR = 8'b0_0_001_0_11; // config (odd parity, 8-bit, 1 stop)
	send_byte(8'b0011_1100, 1'b0, 1'b1); //3c // frame error occurss
	pop_operation();
    end
    end
    endtask
    
    //reset();
    
    task overrun_error_task();
    begin
    repeat (1) // overrun eror
    begin
	repeat (17)
    	begin
    		LCR = 8'b0_0_001_0_11; // config (odd parity, 8-bit, 1 stop)
    		send_byte(8'b0000_1111, 1'b1, 1'b0); //0f
    	end
    end
    end
    endtask
    
    //reset();
    
    task timeout_error_task();
    begin
    repeat (1) // timeout error
    begin
	LCR = 8'b0_0_001_0_11; // config (odd parity, 8-bit, 1 stop)
	send_byte(8'b0011_1100, 1'b1, 1'b0); //3c
    
        repeat (4) // wait for 4 charaters 
        begin
		repeat (11) // 1 start + 8 bits + 1 partiy + 1 stop = 11
		begin
			repeat(16) @(negedge enable); // 16 buad's
		end
        end
    end
    end
    endtask
    

    task break_error_task();
    begin
    repeat(1) // break error
    begin
    	LCR = 8'b0_0_000_0_00; // config (odd parity, 8-bit, 1 stop)
    	repeat(11) // one charater frame all 0's, // 1 start + 8 bits + 1 partiy + 1 stop = 11
    	begin
    		RXD = 1'b0; 
    		repeat(16) @(negedge enable); 
    	end
    end
    end
    endtask

    
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, uart_rx_tb);
    $display("start");
    // init
    {RXD, pop_rx_fifo, enable, LCR} = 0;
    presetn = 1;
    
    //reset
    reset();
    
    parity_error_task();
    $display("end");
    #100_000 $finish;
  end
endmodule

