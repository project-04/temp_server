class spi_scoreboard extends uvm_scoreboard;

    `uvm_component_utils (spi_scoreboard)

    wb_xtn m_xtn;
    sl_xtn s_xtn;
	wb_xtn wb_cov_data;
	sl_xtn sl_cov_data;
    uvm_tlm_analysis_fifo #(wb_xtn) m_fifo;
    uvm_tlm_analysis_fifo #(sl_xtn) s_fifo;
    int ctrl;
    bit [127:0] TX_Reg,RX_Reg;    
    int i;
    extern function new(string name = "Scoreboard",  uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern task run_phase (uvm_phase phase);
    extern function void check_phase(uvm_phase phase);

/*covergroup ADDRESS;
		option.auto_bin_max=1;
   // option.per_instance=1;
           ADDR : coverpoint wb_cov_data.wb_adr_i { bins DR={0,4,8,12};
                                      bins CTRL={'h10};
                                      bins DIVIDER={'h14};
                                      bins SS = {'h18};}
 endgroup           

covergroup DAT;
   // option.per_instance=1;
		option.auto_bin_max=1;

       control : coverpoint wb_cov_data.CTRL[6:0] {bins CH1 ={[0:127]};}
                                         //bins CH2 ={[63:65]};
                                         //bins CH3 ={[95:97]};
                                        // bins CH4={126};                                                
                                         //bins CH5={[98:127]};                                         
                                         //bins CH6={0};                                         
                                        // bins CH7={[1:30]};
                                        // bins CH8={[34:62]};
                                       //  bins CH9={[66:94]};} 
      
go_busy : coverpoint wb_cov_data.CTRL[8] {bins gb = {1};}
                      //bins gb1= {1};}
              
txrx_neg : coverpoint wb_cov_data.CTRL[10:9]  {bins tx={2'b01};
                        bins rx={2'b01};}                 

lsb1 : coverpoint wb_cov_data.CTRL[11] {bins msb ={1};}
                 //  bins lsb ={1};}

ie0 : coverpoint wb_cov_data.CTRL[13:12] {bins ie_ass={2'b11};}
          //        bins ie1={1};}

//ass0: coverpoint wb_cov_data.CTRL[13]{ bins ass={0} ;
  //                 bins ass1={1};}
  
CHAR_LENxTxRx_NEG :cross control,txrx_neg;
CHAR_LENxLSBxASS :cross control,lsb1;           
endgroup                              

covergroup DR;
          
  // option.per_instance=1;
		option.auto_bin_max=1;
           coverpoint wb_cov_data.DIVIDER[31:0] {bins div={[31:0]};}
                               //bins b2={[16383:1024]};
                               //bins b3={[65535:16384]};}
endgroup

covergroup SSR;

   //option.per_instance=1;
		option.auto_bin_max=1;
           coverpoint wb_cov_data.SS[7:0] {bins ssr0 = {[1:128]};}
                                bins ssr1 = {2};
                                bins ssr2 = {4};
                                bins ssr3 = {8};
                                bins ssr4 = {16};
                                bins ssr5 = {32};
                                bins ssr6 = {64};
                                bins ssr7 = {128};}
endgroup*/


covergroup SPI;
//option.auto_bin_max=1;
	option.per_instance=1;
WB_ADDR :coverpoint wb_cov_data.wb_adr_i {
					   bins REG ={['h00:'h18]};}
					 // bins REG1 ={['h0c:'h18]};}
						//bins REG2 ={[13:20]};}

CTRL : coverpoint wb_cov_data.CTRL[6:0] {
					bins CTrl ={0};
				   	bins CTrl1 ={[2:15]};}
DIV : coverpoint wb_cov_data.DIVIDER {
					bins Div ={[0:5]};
					bins Div1 ={[6:31]};
				     }
S2 : coverpoint wb_cov_data.SS {
					bins s1 ={[0:31]};
					}
endgroup

endclass

    /////////////////////////////////////////////////////////////////////////////////////

    function spi_scoreboard::new(string name = "Scoreboard",  uvm_component parent);
        super.new(name, parent);        
        m_fifo = new("m_fifo",this);
        s_fifo = new("s_fifo",this);
SPI = new();
//DAT =new();
//DR = new();
//SSR=new();

    endfunction: new
    
    /////////////////////////////////////////////////////////////////////////////////////
    
    function void spi_scoreboard::build_phase(uvm_phase phase);
               if (!uvm_config_db #(int)::get(this,"","int",ctrl))
            `uvm_fatal("CONFIG","Getting config database failed")

             super.build_phase(phase); 
    endfunction

    /////////////////////////////////////////////////////////////////////////////////////

    task spi_scoreboard::run_phase(uvm_phase phase);
        forever
            fork 
                begin
                    m_fifo.get(m_xtn);
                end 
                begin
                    s_fifo.get(s_xtn);
                end
            join_any
    endtask

    /////////////////////////////////////////////////////////////////////////////////////

    function void spi_scoreboard::check_phase(uvm_phase phase);

        this.TX_Reg = {m_xtn.TX3, m_xtn.TX2, m_xtn.TX1, m_xtn.TX0};
        this.RX_Reg = {m_xtn.RX3, m_xtn.RX2, m_xtn.RX1, m_xtn.RX0};
                   if (ctrl[6:0] == 0)
			 begin
                                 for (i = 0; i <= 127; i++) 
			begin
                       		 if (TX_Reg[i] == s_xtn.mosi_pad_o[i])
					  $display("=========A Data Match for TX Registers===========");
                       		 else 
                        		   $display("############ Data Not matched in TX Register ################  at %d bit.",i);

                               if(RX_Reg[i] == s_xtn.miso_pad_i[i])
				            	 $display("========A Data Match for RX Register=========");
                       	    else 
                       				 $display("############ Data Not match RX Register ############ at %d bit.",i);
                    	end
            		end
              else 
			begin
            	                    			for (i = 0; i < ctrl[6:0]; i++) 
						begin
                  				      if (TX_Reg[i] == s_xtn.mosi_pad_o[i])
								  $display("=========A Data Match for TX Registers===========");
                       				     else 
                        		   			$display("######## Data Not matched in TX Register #  at %d bit.",i);

                            			    if(RX_Reg[i] == s_xtn.miso_pad_i[i])
				                           	 $display("========A Data Match for RX Register=========");
                       				      else 
                       				 		$display("######## Data Not match RX Register ####### at %d bit.",i);
                    				end
               		  end
		wb_cov_data = m_xtn;
  		SPI.sample();

    endfunction

