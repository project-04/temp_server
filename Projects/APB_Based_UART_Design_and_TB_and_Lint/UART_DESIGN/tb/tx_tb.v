`timescale 1ns / 1ns
module uart_tx_tb();  
  reg pclk, presetn;
  reg [7:0] pw_data;
  reg tx_fifo_push, enable;
  reg [7:0] LCR;
  wire [4:0] tx_fifo_count;
  wire busy, tx_fifo_empty, tx_fifo_full, TXD;
  
  uart_tx DUT(
  .PCLK(pclk), 
  .PRESETn(presetn), 
  .PWDATA(pw_data), 
  .tx_fifo_push(tx_fifo_push), 
  .enable(enable), 
  .LCR(LCR), 
  .tx_fifo_count(tx_fifo_count), 
  .busy(busy), 
  .tx_fifo_empty(tx_fifo_empty), 
  .tx_fifo_full(tx_fifo_full), 
  .TXD(TXD)
  );
  
  
  initial {pclk, pw_data, tx_fifo_push, enable, LCR}=0;
  initial {presetn}=1;
  
  always #10 pclk = ~pclk; //50MHz
  
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
  
  
  //reset
  task res();
  begin
    @(negedge pclk) presetn <= 1'b0;
    @(negedge pclk) presetn <= 1'b1;
    end
  endtask
    
  // Write
  task wri(input pu, input [7:0] d_i);
    begin
      @(negedge pclk)
      tx_fifo_push = pu;
      pw_data = d_i;
    end
  endtask
  
  
  initial begin
  	$display("---run started");
    $dumpfile("dump.vcd");
    $dumpvars(0, uart_tx_tb);
    res();
    

    //LCR = 8'b0_0_011_1_11; // even parity
    LCR = 8'b0_0_001_0_11; // odd parity
    wri(1'b1,8'b00001111); // 0f it having even number of bits so parity is 1, then it is in odd parity
    wri(1'b1,8'b00001110); // 0e it having odd number of bits so parity is 0, it is already in odd parity
    wri(1'b1,8'b00111100); // 3c parity is 1
    wri(1'b0,8'd0);
    
    #14000;
    wri(1'b1,8'b00111011); //3b
    // parity is 0
    wri(1'b0,8'd0);
    
    //#1500 enable = 1'b0;
    
    #1000;
    
    $display("---run ended");
  	
    #500000 $finish;
  end
endmodule
