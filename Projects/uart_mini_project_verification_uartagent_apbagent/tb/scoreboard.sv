class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard)

env_config m_cfg;

uvm_tlm_analysis_fifo#(apb_trans) fifo_apb;
uvm_tlm_analysis_fifo#(uart_trans) fifo_uart;

apb_trans uart1;
uart_trans uart2;
apb_trans cov_data1;
uart_trans cov_data2;

int thr1size, rbr1size;
int thr2size, rbr2size;


	covergroup apb_signals_cov;
		option.per_instance=1;

		ADDRESS: coverpoint cov_data1.PADDR { bins add = {[0:255]}; }

	//	DATA: coverpoint cov_data.addr_i[2:0] { bins addr_sign = {[0:7]}; }

		WR_ENB: coverpoint cov_data1.PWRITE { bins rd = {0};
						bins wr = {1}; }  
	//	ERROR: coverpoint cov_data.Pslverr {bins p1={0};
	//						bins p2 = {1};}
	endgroup

	covergroup apb_lcr_cov;
                option.per_instance=1;

                CHAR_SIZE: coverpoint cov_data1.LCR[1:0] { bins five = {2'b00};
                                                          bins eight = {2'b11}; }

                STOP_BIT: coverpoint cov_data1.LCR[2] { bins one = {1'b0};
                                                        bins more = {1'b1}; }

                PARITY: coverpoint cov_data1.LCR[3] { bins no_parity = {1'b0};
                                                       bins parity_en = {1'b1}; }
		
                EV_ODD_PARITY: coverpoint cov_data1.LCR[4] { bins odd_parity = {1'b0};
								bins even_parity = {1'b1};}
		
		
               // STICK_PARITY: coverpoint cov_data.lcr[5] { bins no_stick_parity = {1'b0};
                 //                                       bins stick_parity = {1'b1}; }

                //BREAK: coverpoint cov_data.lcr[6] { bins low = {1'b0};
                  //                                      bins high = {1'b1}; }

                //DIV_LCH: coverpoint cov_data.lcr[7] { bins low = {1'b0};
                                                //        bins high = {1'b1}; }

		//LCR_RST: coverpoint cov_data.lcr[7:0] { bins lcr_rst = {8'd3};}

                //CHAR_SIZE_X_STOP_BIT_X_EV_ODD_PARITY: cross CHAR_SIZE,STOP_BIT,EV_ODD_PARITY;
        endgroup

        covergroup apb_ier_cov;
                option.per_instance=1;

                RCVD_INT: coverpoint cov_data1.IER[0] { bins dis = {1'b0};
                                                        bins en = {1'b1}; }

                THRE_INT: coverpoint cov_data1.IER[1] { bins dis = {1'b0};
                                                        bins en = {1'b1}; }

                LSR_INT: coverpoint cov_data1.IER[2] { bins dis = {1'b0};
                                                        bins en = {1'b1}; }

		IER_RST: coverpoint cov_data1.IER[7:0] { bins ier_rst = {8'd0};}

        endgroup

        covergroup apb_fcr_cov;
                option.per_instance=1;

                RFIFO: coverpoint cov_data1.FCR[1] { bins dis = {1'b0};
                                                    bins clr = {1'b1}; }

                TFIFO: coverpoint cov_data1.FCR[2] { bins dis = {1'b0};
                                                    bins clr = {1'b1}; }

                TRG_LVL: coverpoint cov_data1.FCR[7:6] { bins one = {2'b00};
                                                       // bins four = {2'b01};
                                                        bins eight = {2'b10};
                                                        bins fourteen = {2'b11}; }
		
		//FCR_RST: coverpoint cov_data.fcr[7:0] { bins fcr_rst = {8'd192};}

        endgroup

        covergroup apb_mcr_cov;
                option.per_instance=1;

                LB: coverpoint cov_data1.MCR[4] {bins dis = {1'b0};
                                                bins en = {1'b1}; }
	
		MCR_RST: coverpoint cov_data1.MCR[7:0] { bins lcr_rst = {8'd0};}

        endgroup

        covergroup apb_iir_cov;
                option.per_instance=1;

                IIR: coverpoint cov_data1.IIR[3:1] {bins lsr = {3'b011};
                                                   bins rdf = {3'b010};
                                                   bins ti_o = {3'b110};
                                                    }
		
	//	IIR_RST: coverpoint cov_data.iir[3:0] { bins iir_rst = {4'h1};}

        endgroup

        covergroup apb_lsr_cov;
                option.per_instance=1;

                DATA_READY: coverpoint cov_data1.LSR[0] {bins fifoempty = {1'b0};
                                                        bins datarcvd = {1'b1}; }

                OVER_RUN: coverpoint cov_data1.LSR[1] {bins nooverrun = {1'b0};
                                                        bins overrun = {1'b1}; }

                PARITY_ERR: coverpoint cov_data1.LSR[2] {bins noparityerr = {1'b0};
                                                        bins parityerr = {1'b1} ;}

                FRAME_ERR: coverpoint cov_data1.LSR[3] {
                                                        bins frameerr = {1'b0}; }

                BREAK_INT: coverpoint cov_data1.LSR[4] {bins nobreakint = {1'b0};
                                                        bins breakint = {1'b1}; }

		b1: coverpoint cov_data1.LSR[5] {bins a1 = {1'b0};
						bins a2 = {1'b1}; }	
        endgroup

function new(string name = "scoreboard",uvm_component parent);
        super.new(name,parent);
	apb_signals_cov = new();
	apb_lcr_cov = new();
        apb_ier_cov = new();
        apb_fcr_cov = new();
        apb_mcr_cov = new();
        apb_iir_cov = new();
        apb_lsr_cov = new();
        fifo_apb = new("fifo_apb",this);
	fifo_uart = new("fifo_uart",this);
endfunction




function void build_phase(uvm_phase phase);
	super.build_phase(phase);
/*	if(!uvm_config_db#(env_config)::get(this,"","env_config",m_cfg))
	`uvm_fatal("CONFIG","Cannot get config")

 /*	fifo_h = new[1];
        foreach(fifo_h[i]) 
           fifo_apb = new("fifo_apb",this);
	fifo_uart = new("fifo_uart",this);*/
endfunction

task run_phase(uvm_phase phase);
	super.run_phase(phase);

forever
	fork 	
		begin
                        fifo_apb.get(uart1);
			//uart1.print;
			thr1size = uart1.THR.size;
			rbr1size = uart1.RBR.size;
      
 //   $display("@@@@@@@@@@@@@@ size of thr UART1 = %0d",thr1size);
   // $display("@@@@@@@@@@@@@@ size of rbr UART1 = %0d",rbr1size);
//	`uvm_info("SCOREBOARD",$sformatf("PRINTING FROM SCOREBOARD OF UART1 \n %s",uart1.sprint()),UVM_LOW)

			cov_data1=uart1;
			apb_signals_cov.sample();
	                apb_lcr_cov.sample();
        	        apb_ier_cov.sample();
                	apb_fcr_cov.sample();
	                apb_mcr_cov.sample();
        	        apb_iir_cov.sample();
                        apb_lsr_cov.sample();

		end

			begin
                    fifo_uart.get(uart2);
			//uart2.print;
		
			thr2size = uart2.THR.size;
			rbr2size = uart2.RBR.size;

//    $display("@@@@@@@@@@@@@@ size of thr UART2 = %0d",thr2size);
  //  $display("@@@@@@@@@@@@@@ size of rbr UART2 = %0d",rbr2size);
/*			cov_data2=uart2;
		//	apb_signals_cov.sample();
	             //   apb_lcr_cov.sample();
        	      //  apb_ier_cov.sample();
                //	apb_fcr_cov.sample();
	         //       apb_mcr_cov.sample();
        	  //      apb_iir_cov.sample();
               /// 	apb_lsr_cov.sample();

	//`uvm_info("SCOREBOARD",$sformatf("PRINTING FROM SCOREBOARD OF UART2 \n %s",uart2.sprint()),UVM_LOW)
*/
		end
	join_any
endtask

function void check_phase(uvm_phase phase);
	$display("size of thr UART1 = %p \n",thr1size);
	$display("size of thr UART2 = %p \n",thr2size);
	$display("size of rbr UART1 = %p \n",rbr1size);
	$display("size of rbr UART2 = %p \n",rbr2size);
	$display("values sent by UART1 = %p \n",uart1.THR);
	$display("values sent by UART2 = %p \n",uart2.THR);
	$display("values received by UART1 = %p \n",uart1.RBR);
	$display("values received by UART2 = %p \n",uart2.RBR);

if((uart1.IIR[3:1]==3'b010))
     begin  
       if((uart1.MCR[4]==0))
     begin
       if(uart1.THR.size()==0)
         begin
         
           if((uart1.THR==uart2.RBR)||(uart2.THR==uart1.RBR))
         `uvm_info(get_type_name(),"\n-------In scoreboard half duplex comparison passed",UVM_LOW)
           else
         `uvm_info(get_type_name(),"\n-------In scoreboard half duplex comparison failed",UVM_LOW)
         end
       else
         begin
           if((uart1.THR==uart2.RBR)&&(uart2.THR==uart1.RBR))
                 `uvm_info(get_type_name(),"\n-------In scoreboard full duplex comparison passed",UVM_LOW)
               else
                 `uvm_info(get_type_name(),"\n-------In scoreboard full duplex comparison failed",UVM_LOW)
             end
     end
       else
     begin
           if((uart1.THR==uart1.RBR))
             `uvm_info(get_type_name(),"\n-------In scoreboard loop back comparison passed",UVM_LOW)
           else
             `uvm_info(get_type_name(),"\n-------In scoreboard loop back comparison failed",UVM_LOW)
         end
     end

   if(uart1.IIR[3:1]==3)
     begin
       if((uart1.LSR[1]==1))
     `uvm_info(get_type_name(),"\n-------In scoreboard overrun error",UVM_LOW)
       if((uart1.LSR[2]==1))
         `uvm_info(get_type_name(),"\n-------In scoreboard parity error",UVM_LOW)
       if((uart1.LSR[3]==1))
         `uvm_info(get_type_name(),"\n-------In scoreboard framing error",UVM_LOW)
       if((uart1.LSR[4]==1))
         `uvm_info(get_type_name(),"\n-------In scoreboard break interrupt error",UVM_LOW)
     end
   if((uart1.IIR[3:1]==3'b110))
     `uvm_info(get_type_name(),"\n-------In scoreboard timeout error",UVM_LOW)
   if((uart1.IIR[3:1]==3'b001))
     `uvm_info(get_type_name(),"\n-------In scoreboard thr empty ",UVM_LOW)


//	if((thr1size==0)&&(thr2size==0)) $display("NO DATA IN THR1 AND THR2. SOMETHING WENT WRONG. \n");

endfunction
	
	function void report_phase(uvm_phase phase);
		$display("\n\n\n------------------------ SCOREBOARD REPORT -----------------------");
	      	$display("UART CORE Coverage = %0f", apb_lcr_cov.get_coverage());
                       
	      	$display("------------------------------------------------------------------\n\n\n");
	endfunction
endclass

