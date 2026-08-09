 class spi_reg_access_wrapper extends uvm_object;
   `uvm_object_utils(spi_reg_access_wrapper)

   covergroup register_cov(string name) with function sample(uvm_reg_data_t data1, uvm_reg_data_t data2, uvm_reg_data_t data3);
     option.per_instance = 1;
     option.name = name;
	
     LSBFE 	: coverpoint data1[0]{bins lsbfe[] ={0,1};}// LSB-First Enable
     SSOE	: coverpoint data1[1]{bins ssoe[]={0,1};}//Slave Select Output Enable
     CPHA	: coverpoint data1[2]{bins cpha[]={0,1};}// Clock Phase
     CPOL	: coverpoint data1[3]{bins cpol[]={0,1};}//Clock Polarity
     MSTR	: coverpoint data1[4]{bins mstr[]={0,1};}//Master/slave
     SPTIE	: coverpoint data1[5]{bins sptie[]={0,1};}//SPI Transmit Interrupt Enable
     SPE	: coverpoint data1[6]{bins spe[]={0,1};}//SPI System Enable 
     SPIE	: coverpoint data1[7]{bins spie[]={0,1};}//SPI Interrupt Enable
     SPC0	: coverpoint data2[0]{bins spc0[]={0,1};}//Serial Pin Control Bit 0
     SPISWAI	: coverpoint data2[1]{bins spiswai[]={0,1};}//SPI Stop in Wait Mode
     BIDIROE	: coverpoint data2[3]{bins bidiroe[]={0,1};}//Bidirectional Mode Output Enable
     MODFEN	: coverpoint data2[4]{bins modfen[]={0,1};}//Mode Fault Enable Bit 
     SPR	: coverpoint data3[2:0]{bins spr[]={[0:7]};}//SPI Baud Rate Selection Bits
     SPPR	: coverpoint data3[6:4]{bins sppr[]={[0:7]};}//SPI Baud Rate Preselection Bits

     BAUD_RATE  : cross SPR, SPPR;// Baud Rate Register
     SPI_MODE   : cross CPHA, CPOL;// 4 modes will be available based on cphase and cpolx
     SPI_M_MODE : cross CPHA, CPOL, LSBFE;
     LOW_MODE   : cross SPE, SPISWAI;
   endgroup

   function new(string name="spi_reg_access_wrapper");
     register_cov = new(name);
   endfunction

   function void sample(uvm_reg_data_t data1, uvm_reg_data_t data2, uvm_reg_data_t data3);
     register_cov.sample(data1, data2, data3);
   endfunction
 endclass
