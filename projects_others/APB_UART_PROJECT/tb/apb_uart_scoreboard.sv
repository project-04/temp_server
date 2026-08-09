
class apb_uart_scoreboard extends uvm_scoreboard;

	`uvm_component_utils(apb_uart_scoreboard)



	apb_uart_env_config  apb_uart_env_cfg;

	uvm_tlm_analysis_fifo#(apb_uart_trans) fifo0;
	uvm_tlm_analysis_fifo#(apb_uart_trans) fifo1;

	apb_uart_trans t1;
	apb_uart_trans t2;

	apb_uart_trans cov_trans;

	reg_block rg_bl;

	uvm_status_e status_e;
	bit [7:0] LCR;
	bit [7:0] LSR;
	bit [7:0] IER;
	bit [7:0] MCR;
	bit [7:0] FCR;
	bit [7:0] MSR;



	


	covergroup apb_signals_cg;

		option.per_instance=1;

		PWRITE : coverpoint cov_trans.Pwrite;

		PADDR : coverpoint cov_trans.Paddr { 
							bins Paddr = {[0:255]}; 
						  }
 
	endgroup

	//covergroup for IER register
	covergroup uart_ier_cg;

                option.per_instance=1;

                RCVD_INT : coverpoint cov_trans.IER[0] { 
							bins zero = {1'b0};
                                                        bins one = {1'b1}; 
						      }

                THRE_INT : coverpoint cov_trans.IER[1] {
							bins zero = {1'b0};
                                                //        bins one = {1'b1}; 
						      }

                LSR_INT : coverpoint cov_trans.IER[2] { 
							bins zero = {1'b0};
                                                        bins one = {1'b1}; 
						     }

		IER_RST : coverpoint cov_trans.IER[7:0] { bins rst = {8'd0};}

        endgroup

	//covergroup for IIR register
	covergroup uart_iir_cg;

                option.per_instance=1;

                IIR : coverpoint cov_trans.IIR[3:1] {
							bins LSR = {3'b011};
                                                   	bins rdf = {3'b010};
                                                   	bins ti_o = {3'b110};
                                                   }

        endgroup

	//covergroup for FCR register
	covergroup uart_fcr_cg;

                option.per_instance=1;

                RX_FIFO_FLUSH : coverpoint cov_trans.FCR[1] { 
								bins dis = {1'b0};
                                                    		bins clr = {1'b1}; 
							   }

                TX_FIFO_FLUSH : coverpoint cov_trans.FCR[2] {
								bins dis = {1'b0};
                                                    		bins clr = {1'b1}; 
							   }

                TRG_LVL: coverpoint cov_trans.FCR[7:6] {
							bins one = {2'b00};
                                                        bins fourteen = {2'b11}; 
						      }

        endgroup

	//covergroup for LCR register
	covergroup uart_lcr_cg;

                option.per_instance=1;

                CHAR_SIZE : coverpoint cov_trans.LCR[1:0] { 
								bins five = {2'b00};
                                                          	bins eight = {2'b11}; 
							 }

                STOP_BIT : coverpoint cov_trans.LCR[2] {
 							bins one = {1'b0};
                                                        bins more = {1'b1}; 
						      }

                PARITY : coverpoint cov_trans.LCR[3] { 
							bins no_parity = {1'b0};
                                                       	bins parity_en = {1'b1}; 
						    }
		
                EV_ODD_PARITY : coverpoint cov_trans.LCR[4] { 
								bins odd_parity = {1'b0};
								bins even_parity = {1'b1};
							   }
	                
                BREAK : coverpoint cov_trans.LCR[6] { 
							bins low = {1'b0};
                                                      	bins high = {1'b1}; 
						   }

        endgroup

	//covergroup for MCR register
	covergroup uart_mcr_cg;

                option.per_instance=1;

                LB: coverpoint cov_trans.MCR[4] {
						bins mot_loop_back = {1'b0};
                                                bins loop_back = {1'b1}; 
					       }
	
		MCR_RST: coverpoint cov_trans.MCR[7:0] { 
							bins mcr_rst = {8'd0};
						      }

        endgroup

	//covergroup for LSR register
	covergroup uart_lsr_cg;

                option.per_instance=1;

                DATA_READY : coverpoint cov_trans.LSR[0] {
								bins fifoempty = {1'b0};
                                                        //	bins datarcvd = {1'b1}; 
							}

                OVER_RUN : coverpoint cov_trans.LSR[1] {
							bins nooverrun = {1'b0};
                                                        //bins overrun = {1'b1}; 
						      }

                PARITY_ERR : coverpoint cov_trans.LSR[2] {
								bins noparityerr = {1'b0};
                                                        //	bins parityerr = {1'b1} ;
							}

                FRAME_ERR : coverpoint cov_trans.LSR[3] {
                                                        bins frameerr = {1'b0}; 
						       }

                BREAK_INT : coverpoint cov_trans.LSR[4] {
							bins nobreakint = {1'b0};
                                                        //bins breakint = {1'b1}; 
						       }

		TRANSMIT_FIFO_EMPTY: coverpoint cov_trans.LSR[5] {
									bins a1 = {1'b0};
								//	bins a2 = {1'b1}; 
					       			}	
        endgroup



	function new (string name = "apb_uart_scoreboard",uvm_component parent);
		super.new(name,parent);

		apb_signals_cg 	= new();
		uart_lcr_cg    	= new();
	        uart_ier_cg 	= new();
	        uart_fcr_cg 	= new();
	        uart_mcr_cg 	= new();
	        uart_iir_cg 	= new();
        	uart_lsr_cg 	= new();



	endfunction 





	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db#(apb_uart_env_config)::get(this,"","apb_uart_env_config",apb_uart_env_cfg))
			`uvm_fatal("apb_uart_agent_top","failed to get config");


		fifo0 = new ("fifo0",this);
		fifo1 = new ("fifo1",this);
		rg_bl = apb_uart_env_cfg.rg_bl;


		`uvm_info("apb_uart_agent_top","build phase is done",UVM_HIGH);
	endfunction 

	
	virtual task run_phase(uvm_phase phase);
	forever
		begin 
			fork
				begin
					fifo0.get(t1);

					cov_trans = t1;
					apb_signals_cg.sample();
					uart_lcr_cg.sample();
	        			uart_ier_cg.sample();
	        			uart_fcr_cg.sample();
	        			uart_mcr_cg.sample();
	        			uart_iir_cg.sample();
        				uart_lsr_cg.sample();

					`uvm_info("SCOREBOARD","UART 1 DATAS",UVM_NONE)
					t1.print();
					
				end
	
				begin
					fifo1.get(t2);

					cov_trans = t2;
					apb_signals_cg.sample();
					uart_lcr_cg.sample();
	        			uart_ier_cg.sample();
	        			uart_fcr_cg.sample();
	        			uart_mcr_cg.sample();
	        			uart_iir_cg.sample();
        				uart_lsr_cg.sample();

					`uvm_info("SCOREBOARD","UART 2 DATAS",UVM_NONE)
					t2.print();
				end
			join
			
			reg_ral();	
	
		end
		`uvm_info("apb_uart_scoreboard","run phase is over",UVM_HIGH);
	endtask

	function void check_phase(uvm_phase phase);
		$display("-----------------------------------------------");

		$display("	value of THR1	= %0p",t1.THR);
		$display("	size of THR1	= %0d",t1.THR.size);
		$display(" ");
		$display("	value of THR2	= %0p",t2.THR);
		$display("	size of THR2	= %0d",t2.THR.size);
		$display(" ");
		$display("	value of RBR1	= %0p",t1.RBR);
		$display("	size of RBR1	= %0d",t1.RBR.size);
		$display(" ");
		$display("	value of RBR2	= %0p",t2.RBR);
		$display("	size of RBR2	= %0d",t2.RBR.size);
		$display(" ");
		$display("	value of lsr in t1 = %0b ",t1.LSR);
		$display("	value of lsr in t2 = %0b ",t2.LSR);
		$display(" ");	
		$display("	value of iir in t1 = %0b ",t1.IIR);
		$display("	value of iir in t2 = %0b ",t2.IIR);
		$display(" ");			
		$display("-----------------------------------------------");


// FULL DUPLEX COMPARISION LOGIC 

		if((t1.IIR[3:1] == 3'b010) || (t1.IIR[3:1] == 3'b010))
			begin 
				if((t1.MCR[4] == 0  ) || (t2.MCR[4] == 0))
					begin 
						if((t1.THR.size() != 0) && (t2.THR.size() != 0))
							begin
								if((t1.THR == t2.RBR) && (t2.THR == t1.RBR))
									begin 
									$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
									$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
									$display("				FULL DUPLEX PASSED				");
									$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
									$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
									end 
								else
									begin
									$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
									$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
									$display("				FULL DUPLEX FAILED				");
									$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
									$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
									end 
							end 
					end
			end 




// HALF DUPLEX COMPARISION LOGIC 

		
		if((t1.IIR[3:1] == 3'b010) || (t1.IIR[3:1] == 3'b010))
			begin 
				if((t1.MCR[4] == 0  ) || (t2.MCR[4] == 0))
					begin 
						if((t1.THR.size() == 0) || (t2.THR.size() == 0))
							begin
								if((t1.THR == t2.RBR) || (t2.THR == t1.RBR))
									begin 
									$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
									$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
									$display("				HALF DUPLEX PASSED				");
									$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
									$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
									end 
								else
									begin 
									$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
									$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
									$display("				HALF DUPLEX FAILED				");
									$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
									$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
									end 
							end 
					end
			end

	

	

// LOOP BACK COMPARISION

		if((t1.IIR[3:1] == 3'b010) || (t1.IIR[3:1] == 3'b010))
			begin 
				if((t1.MCR[4] == 1  ) || (t2.MCR[4] == 1))
					begin 
						if((t1.THR == t1.RBR) && (t2.THR == t2.RBR))
							begin 
								$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
								$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
								$display("				LOOP BACK PASSED				");
								$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
								$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
							end 
						else
							begin
								$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
								$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
								$display("				LOOP BACK FAILED				");
								$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
								$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
							end 
					end 
			end
 


// PARITYY ERROR
		
		if(t1.LCR[3] == 1 && t2.LCR[3] == 1 )
			begin 
				if(t1.LSR[2] == 1 || t2.LSR[2] == 1)
					begin 
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("				PARITY ERROR OCCURED	 			");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
					end 
				else
					begin
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("				PARITY ERROR NOT OCCURED				");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
					end 
			end	
// FRAMINGGG ERROR
		
		if(t1.LCR[1:0] == 2'b11 && t2.LCR[1:0] == 2'b10 )
			begin 
				if(t1.LSR[3] == 1 || t2.LSR[3] == 1)
					begin 
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("				FRAMING ERROR OCCURED	 			");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
					end 
				else
					begin
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("				FRAMING ERROR NOT OCCURED				");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
					end 
			end	


// BREAKK ERROR
		
		if(t1.LCR[6] == 1 && t2.LCR[6] == 1 )
			begin 
				if(t1.LSR[4] == 1 || t2.LSR[4] == 1)
					begin 
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("				BREAKINGGG ERROR OCCURED	 			");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
					end 
				else
					begin
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("				BREAKINGG ERROR NOT OCCURED				");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
					end 
			end	

// OVERRUNNN ERROR
		
  		if(t1.THR.size() > 1 && t2.THR.size() > 1)
			begin
				if(t1.LSR[1] == 1 || t2.LSR[1] == 1)
					begin 
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("			OVERRR RUNN ERROR OCCURED	 			");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
					end 
				else
					begin
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("			OVERRR RUNN ERROR NOT OCCURED				");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
					end 
			end

// THR EMPTYYY ERROR
		
 		if(t1.THR.size() == 0 && t2.THR.size() == 0)
			begin
				if(t1.IIR[1] == 1 || t2.IIR[1] == 1)
					begin 
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("			THR EMPTYYY ERROR OCCURED	 			");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
					end 
				else
					begin
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("			THR EMPTY ERROR NOT OCCURED				");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
					end
			end


// TIME OUT ERROR
		
 		if(t1.IER == 0 && t2.IER == 0)
			begin
				if(t1.IIR[3:2] == 2'b11 && t2.IIR[3:2] == 2'b11)
					begin 
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("			TIME OUT ERROR OCCURED	 			");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
					end 
				else
					begin
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("			TIME OUT ERROR NOT OCCURED				");
						$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
						$display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
					end
			end

	endfunction	

	task reg_ral;


			rg_bl.lcr_h.read(status_e,LCR,UVM_BACKDOOR,.map(rg_bl.default_map));
			$display("LCR = %0b",LCR);
			$display("lcr = %0b",t2.LCR);
	
			if(t2.LCR == LCR)
				$display("LCR REGISTER VERIFIED\n");
			else
				$display("LCR VERIFICATION FAILED\n");


			rg_bl.lsr_h.read(status_e,LSR,UVM_BACKDOOR,.map(rg_bl.default_map));
			$display("LSR = %0b",LSR);
			$display("lsr = %0b",t2.LSR);
	
			if(t2.LSR == LSR)
				$display("LSR REGISTER VERIFIED\n");
			else
				$display("LSR VERIFICATION FAILED\n");



			rg_bl.ier_h.read(status_e,IER,UVM_BACKDOOR,.map(rg_bl.default_map));
			$display("IER = %0b",IER);
			$display("ier = %0b",t2.IER);
	
			if(t2.IER == IER)
				$display("IER REGISTER VERIFIED\n");
			else
				$display("IER VERIFICATION FAILED\n");



			rg_bl.mcr_h.read(status_e,MCR,UVM_BACKDOOR,.map(rg_bl.default_map));
			$display("MCR = %0b",MCR);
			$display("mcr = %0b",t2.MCR);
	
			if(t2.MCR == MCR)
				$display("MCR REGISTER VERIFIED\n");
			else
				$display("MCR VERIFICATION FAILED\n");


			rg_bl.fcr_h.read(status_e,FCR,UVM_BACKDOOR,.map(rg_bl.default_map));
			$display("FCR = %0b",FCR);
			$display("fcr = %0b",t2.FCR);
	
			if(t2.FCR == FCR)
				$display("FCR REGISTER VERIFIED\n");
			else
				$display("FCR VERIFICATION FAILED\n");

			rg_bl.msr_h.read(status_e,MSR,UVM_BACKDOOR,.map(rg_bl.default_map));
			$display("MSR = %0b",MSR);
			$display("msr = %0b",t2.MSR);
	
			if(t2.MSR == MSR)
				$display("MSR REGISTER VERIFIED\n");
			else
				$display("MSR VERIFICATION FAILED\n");

	endtask


endclass


