module top;
  import uvm_pkg::*; 
  `include "uvm_macros.svh"
  
  import uart_test_pkg::*;

  logic clk0 = 0;
  logic clk1 = 0;

  always #10 clk0 = ~clk0;    // 50 MHz
  always #5  clk1 = ~clk1;    // 100 MHz


  uart_if vif0(clk0);
  uart_if vif1(clk1);

  wire TXD, RXD;
  uart_16550 uart0(
      .PCLK     (clk0),
      .PRESETn  (vif0.PRESETn),
      .PADDR    (vif0.PADDR),
      .PWDATA   (vif0.PWDATA),
      .PRDATA   (vif0.PRDATA),
      .PWRITE   (vif0.PWRITE),
      .PENABLE  (vif0.PENABLE),
      .PSEL     (vif0.PSEL),
      .PREADY   (vif0.PREADY),
      .PSLVERR  (vif0.PSLVERR),

      .IRQ      (vif0.IRQ),

      //.TXD      (vif0.TXD),
      //.RXD      (vif1.TXD),
      .TXD      (TXD),
      .RXD      (RXD),

      .baud_o   (vif0.baud_o)
  );

  uart_16550 uart1(
      .PCLK     (clk1),
      .PRESETn  (vif1.PRESETn),
      .PADDR    (vif1.PADDR),
      .PWDATA   (vif1.PWDATA),
      .PRDATA   (vif1.PRDATA),
      .PWRITE   (vif1.PWRITE),
      .PENABLE  (vif1.PENABLE),
      .PSEL     (vif1.PSEL),
      .PREADY   (vif1.PREADY),
      .PSLVERR  (vif1.PSLVERR),

      .IRQ      (vif1.IRQ),

      //.TXD      (vif1.TXD),
      //.RXD      (vif0.TXD),
      .TXD      (RXD),
      .RXD      (TXD),
      
      .baud_o   (vif1.baud_o)
  );

  initial begin
  
	`ifdef VCS
		$fsdbDumpvars(0, top);
        `endif
        		
	uvm_config_db#(virtual uart_if)::set(null, "*", "uart_if0", vif0);
	uvm_config_db#(virtual uart_if)::set(null, "*", "uart_if1", vif1);

	uvm_top.set_report_verbosity_level(UVM_NONE);
	//uvm_top.set_report_verbosity_level(UVM_MEDIUM);
      
      run_test();
  end

endmodule
