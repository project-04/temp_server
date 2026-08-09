 `timescale 1ns / 1ps
 module top();
   bit clock;
	
   import spi_pkg::*;
   import uvm_pkg::*;

       always
	 #5 clock = ~clock;
	

   apb_intf apb_if(clock);
   spi_intf spi_if(clock);

   spi_core CORE(.PCLK(clock),
		.PRESETn(apb_if.PRESETn),
		.PADDR(apb_if.PADDR),
		.PWRITE(apb_if.PWRITE),
		.PSEL(apb_if.PSEL),
		.PENABLE(apb_if.PENABLE),
		.PWDATA(apb_if.PWDATA),
		.PRDATA(apb_if.PRDATA),
		.PREADY(apb_if.PREADY),
		.PSLVERR(apb_if.PSLVERR),
		.miso(spi_if.miso),
		.ss(spi_if.ss),
		.sclk(spi_if.sclk),
		.spi_interrupt_request(spi_if.spi_inpt_req),
		.mosi(spi_if.mosi));
	
   initial
     begin
      
	 `ifdef VCS 
	        $fsdbDumpvars(0, top);
         `endif
		
       uvm_config_db #(virtual apb_intf)::set(null, "*", "apb_intf", apb_if);
       uvm_config_db #(virtual spi_intf)::set(null, "*", "spi_intf", spi_if);

       run_test();
     end
 endmodule
