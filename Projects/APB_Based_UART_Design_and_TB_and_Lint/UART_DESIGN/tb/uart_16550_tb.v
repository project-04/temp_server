//`timescale 1ns / 1ns
module uart_16550_tb(); 
	
	reg pclk;
	reg presetn;
	reg [31:0] paddr;
	reg [31:0] pwdata;
	reg pwrite;
	reg penable;
	reg psel;
	reg rxd;
	
	wire [31:0] prdata;
	wire pready;
	wire pslverr;
	wire irq;
	wire txd;
	
	wire baud_o;
	
	reg pclk1;
	reg presetn1;
	reg [31:0] paddr1;
	reg [31:0] pwdata1;
	reg pwrite1;
	reg penable1;
	reg psel1;
	reg rxd1;
	
	wire [31:0] prdata1;
	wire pready1;
	wire pslverr1;
	wire irq1;
	wire txd1;
	
	wire baud_o1;



  
  	uart_16550 DUT(	.PCLK(pclk),
			.PRESETn(presetn),
			.PADDR(paddr),
			.PWDATA(pwdata),
			.PRDATA(prdata),
			.PWRITE(pwrite),
			.PENABLE(penable),
			.PSEL(psel),
			.PREADY(pready),
			.PSLVERR(pslverr),
			.IRQ(irq),
			.TXD(txd),
			.RXD(rxd),
			.baud_o(baud_o)
		);


	uart_16550 DUT1(	.PCLK(pclk1),
			.PRESETn(presetn1),
			.PADDR(paddr1),
			.PWDATA(pwdata1),
			.PRDATA(prdata1),
			.PWRITE(pwrite1),
			.PENABLE(penable1),
			.PSEL(psel1),
			.PREADY(pready1),
			.PSLVERR(pslverr1),
			.IRQ(irq1),
			.TXD(txd1),
			.RXD(rxd1),
			.baud_o(baud_o1)
		);
	
	initial begin
		pclk=1'b0;
		pclk1=1'b0;
		
		presetn = 1'b0;
		presetn1 = 1'b0;
		
		#100 presetn = 1'b1;
		#100 presetn1 = 1'b1;
	end
		
	always #10 pclk = ~pclk;    // 50 MHz //27
	always #5  pclk1 = ~pclk1;    // 100 MHz //54

	
	
	task reset();
	begin
	       @(posedge pclk);      
	       presetn<=1'b0;
	       
	       @(posedge pclk1);      
	       presetn1<=1'b0;
	       
	       @(posedge pclk);      
	       presetn<=1'b1;
	       
	       @(posedge pclk1);      
	       presetn1<=1'b1;
	       
	       rxd <= 1'b1;
	       
	       #100;
	end
	endtask
	
	task transfer_data(input reg [7:0] pa, input reg pw, input reg [7:0] pwd);
	begin
		@(posedge pclk); 
		psel<=1'b1;
		penable<=1'b0;
		
		//data to transfer
		paddr = pa; pwrite = pw; pwdata = pwd;
		
		@(posedge pclk); 
		psel<=1'b1;
		penable<=1'b1;
		
		wait(pready);
		//wait(irq);
		
		@(posedge pclk); 
		psel<=1'b0;
		penable<=1'b0;
		
		#1_00_000; //if the div == 27 then #1_00_000 delay to complet transfer;
		
		#1000;
	end
	endtask
	
	task transfer_data1(input reg [7:0] pa, input reg pw, input reg [7:0] pwd);
	begin
		@(posedge pclk1); 
		psel1<=1'b1;
		penable1<=1'b0;
		
		//data to transfer
		paddr1 = pa; pwrite1 = pw; pwdata1 = pwd;
		
		@(posedge pclk1); 
		psel1<=1'b1;
		penable1<=1'b1;
		
		wait(pready1);
		//wait(irq);
		
		@(posedge pclk1); 
		psel1<=1'b0;
		penable1<=1'b0;
		
		#1_00_000; //if the div == 27 then #1_00_000 delay to complet transfer;
		
		#1000;
	end
	endtask
	
	task set_all_registers_data();
	begin
		@(posedge pclk); 
		psel<=1'b1;
		penable<=1'b0;
		
		//div2 msb
		paddr = 8'h20; pwrite = 1; pwdata = 'd0;
		
		@(posedge pclk); 
		psel<=1'b1;
		penable<=1'b1;
		
		#100;

		@(posedge pclk); 
		psel<=1'b1;
		penable<=1'b0;
		
		//div1 lsb
		paddr = 8'h1c; pwrite = 1; pwdata = 'd27;
		
		@(posedge pclk); 
		psel<=1'b1;
		penable<=1'b1;
		
		#100;
		
		@(posedge pclk); 
		psel<=1'b1;
		penable<=1'b0;
		
		//lcr
		paddr = 8'hc; pwrite = 1; pwdata = 8'b0000_1011;
		
		@(posedge pclk); 
		psel<=1'b1;
		penable<=1'b1;
		
		#100;
		
		@(posedge pclk); 
		psel<=1'b1;
		penable<=1'b0;
		
		//fcr
		paddr = 8'h8; pwrite = 1; pwdata = 8'b0000_0110;
		
		@(posedge pclk); 
		psel<=1'b1;
		penable<=1'b1;
		
		#100;
		
		@(posedge pclk); 
		psel<=1'b1;
		penable<=1'b0;
		
		//ier
		paddr = 8'h4; pwrite = 1; pwdata = 8'b0000_0001;
		
		@(posedge pclk); 
		psel<=1'b1;
		penable<=1'b1;
		
		wait(pready);
		
		@(posedge pclk); 
		psel<=1'b0;
		penable<=1'b0;
		
		#100;
	end
	endtask
	
	
	task set_all_registers_data1();
	begin
		@(posedge pclk1); 
		psel1<=1'b1;
		penable1<=1'b0;
		
		//div2 msb
		paddr1 = 8'h20; pwrite1 = 1; pwdata1 = 'd0;
		
		@(posedge pclk1); 
		psel1<=1'b1;
		penable1<=1'b1;
		
		#100;

		@(posedge pclk1); 
		psel1<=1'b1;
		penable1<=1'b0;
		
		//div1 lsb
		paddr1 = 8'h1c; pwrite1 = 1; pwdata1 = 'd54;
		
		@(posedge pclk1); 
		psel1<=1'b1;
		penable1<=1'b1;
		
		#100;

		@(posedge pclk1); 
		psel1<=1'b1;
		penable1<=1'b0;
		
		//lcr
		paddr1 = 8'hc; pwrite1 = 1; pwdata1 = 8'b0100_1011;
		
		@(posedge pclk1); 
		psel1<=1'b1;
		penable1<=1'b1;
		
		#100;

		@(posedge pclk1); 
		psel1<=1'b1;
		penable1<=1'b0;
		
		//fcr
		paddr1 = 8'h8; pwrite1 = 1; pwdata1 = 8'b0000_0110;
		
		@(posedge pclk1); 
		psel1<=1'b1;
		penable1<=1'b1;
		
		#100;

		@(posedge pclk1); 
		psel1<=1'b1;
		penable1<=1'b0;
		
		//ier
		paddr1 = 8'h4; pwrite1 = 1; pwdata1 = 8'b0000_0001;
		
		@(posedge pclk1); 
		psel1<=1'b1;
		penable1<=1'b1;
		
		wait(pready1);
		
		@(posedge pclk1); 
		psel1<=1'b0;
		penable1<=1'b0;
		
		#100;
	end
	endtask
	
	task rx_data(input [7:0] data, input inserted_parity_error, input inserted_framing_error);
	
	reg [7:0] LCR;
	integer no_of_bits, i;
  begin
  	LCR = 8'b0000_1011; // config (odd parity, 8-bit, 1 stop)
      // idle line is high
      rxd = 1'b1; @(posedge baud_o);
       
      // start bit
      rxd = 1'b0; repeat(16) @(posedge baud_o);
      
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
          rxd = data[i];
          repeat(16) @(posedge baud_o);
      end
      
      
      // parity bit
      if(LCR[3] == 1'b1)
      begin
	      if(inserted_parity_error)
	      begin
		case({LCR[5:4]})
		  2'b00 : rxd <= (^data); //odd parity generator
		  2'b01 : rxd <= ~(^data); //even parity generator 
		  2'b10 : rxd <= 1'b0; //odd parity but LCR[4] inverse
		  2'b11 : rxd <= 1'b1; //even parity but LCR[4] inverse
		  //default  rxd <= 1'b0;
		endcase
	      	repeat(16) @(posedge baud_o);
	      end
	      else
	      begin
		case({LCR[5:4]})
		  2'b00 : rxd <= ~(^data); //odd parity generator
		  2'b01 : rxd <=  (^data); //even parity generator 
		  2'b10 : rxd <= 1'b1; //odd parity but LCR[4] inverse
		  2'b11 : rxd <= 1'b0; //even parity but LCR[4] inverse
		  //default  rxd <= 1'b0;
		endcase
	      	repeat(16) @(posedge baud_o);
	      end
     end
      
      // stop bit
      if(inserted_framing_error)
      begin
      	rxd = 1'b0;
      	repeat(16) @(posedge baud_o);
      end
      else
      begin
      	rxd = 1'b1;
      	repeat(16) @(posedge baud_o);
      end
      
      // 2nd stop bit
      if(LCR[2] == 1'b1)
      begin
      	rxd = 1'b1; // second stop (if LCR config wants)
      	repeat(16) @(posedge baud_o);
      end
    end
  endtask
  
  task read_rbr();
  begin
        wait(irq);
      
      //#1_000;
      
      		@(posedge pclk); 
		psel<=1'b1;
		penable<=1'b0;
		
		paddr = 8'h08; pwrite = 1'b0; pwdata = 8'h00;
		
		@(posedge pclk); 
		psel<=1'b1;
		penable<=1'b1;
		
		wait(pready);
		
		@(posedge pclk); 
		psel<=1'b0;
		penable<=1'b0;
		
		#1000;
		
	//#2_000;
	
  		if(prdata[3:0] == 4)
		  begin
		    	@(posedge pclk); 
			psel<=1'b1;
			penable<=1'b0;
			
			paddr = 8'h00; pwrite = 1'b0; pwdata = 8'h00;
			
			@(posedge pclk); 
			psel<=1'b1;
			penable<=1'b1;
			
			wait(pready);
			
			@(posedge pclk); 
			psel<=1'b0;
			penable<=1'b0;
		  end

	#1000;
   end
   endtask
   
     task read_rbr1();
  begin
        wait(irq1);
      
      //#1_000;
      
      		@(posedge pclk1); 
		psel1<=1'b1;
		penable1<=1'b0;
		
		paddr1 = 8'h08; pwrite1 = 1'b0; pwdata1 = 8'h00; //iir
		
		@(posedge pclk1); 
		psel1<=1'b1;
		penable1<=1'b1;
		
		wait(pready1);
		
		@(posedge pclk1); 
		psel1<=1'b0;
		penable1<=1'b0;
		
		#1000;
		
	//#2_000;
	
  		if(prdata1[3:0] == 4) //if my iir is last 4bits is 4 then read the rbr
		  begin
		    	@(posedge pclk1); 
			psel1<=1'b1;
			penable<=1'b0;
			
			paddr1 = 8'h00; pwrite1 = 1'b0; pwdata1 = 8'h00; //RBR
			
			@(posedge pclk1); 
			psel1<=1'b1;
			penable1<=1'b1;
			
			wait(pready1);
			
			@(posedge pclk1); 
			psel1<=1'b0;
			penable1<=1'b0;
		  end

	#1000;
   end
   endtask
   
   always@(*)
   begin
   	rxd = txd1;
   	rxd1 = txd;
   end
  
	initial begin
		//$fsdbDumpfile("wave.fsdb");
  		//$fsdbDumpvars(0, uart_16550_tb);
		$display("start");
		#100;
		reset();
		
		set_all_registers_data(); // not having 1 at LCR 6 postion
		set_all_registers_data1(); // having 1 at LCR 6 postion , first we have to set lcr 6 bit 1 before reciver recives the data

		
		//thr uart0
		transfer_data('b0, 1, 8'b0000_1010);
   		#10_000;
   		//rbr uart2
   		read_rbr1();
   		#10_000;
   		//thr uart0
		transfer_data('b0, 1, 8'b0000_1011);
		#10_000;
		//rbr uart2
		read_rbr1();
		#10_000;
   
  		#20_000;
  
	/*	//thr uart1
		transfer_data1('b0, 1, 8'b0000_1100);
		#10_000;
		read_rbr();
		#10_000;
		transfer_data1('b0, 1, 8'b0000_1101);
		#10_000;
		read_rbr();
		#10_000;
   
		//uart0
		/*
    rx_data(8'b0000_1111, 1'b0, 1'b0); //0f // odd parity occurs
		read_rbr();
		rx_data(8'b0000_1111, 1'b1, 1'b0); //0f // odd parity error occurs
		read_rbr();
		rx_data(8'b0000_1111, 1'b0, 1'b1); //0f // framing occurs
		read_rbr();
		
		rx_data(8'b0000_1111, 1'b0, 1'b0); //0f // timeout error occurs
		#4_00_000; // don't read rbr for 4characters to get time out error
    */
	//	#3_00_000;
		$display("end");
		$finish;
	end
endmodule
