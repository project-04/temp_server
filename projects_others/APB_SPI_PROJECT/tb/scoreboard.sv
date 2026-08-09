

class scoreboard extends uvm_scoreboard;

	`uvm_component_utils(scoreboard)

	covergroup cg;

		prdata : coverpoint at.Prdata {
				bins b1 = {[0:49]};
				bins b2 = {[50:100]};
				bins b3 = {[101:150]};
				bins b4 = {[151:200]};
				bins b5 = {[201:255]}; 		
					}
	
		pwdata : coverpoint at.Pwdata {
				bins b1 = {[0:49]};
				bins b2 = {[50:100]};
				bins b3 = {[101:150]};
				bins b4 = {[151:200]};
				bins b5 = {[201:255]}; 							}	
		
		miso : coverpoint st.miso {
				bins b1 = {[0:49]};
				bins b2 = {[50:100]};
				bins b3 = {[101:150]};
				bins b4 = {[151:200]};
				bins b5 = {[201:255]}; 							}

		mosi : coverpoint st.mosi {
				bins b1 = {[0:49]};
				bins b2 = {[50:100]};
				bins b3 = {[101:150]};
				bins b4 = {[151:200]};
				bins b5 = {[201:255]}; 		
					}

		presetn : coverpoint at.Presetn {
				bins b1 = {[0:1]};
					}
		
		psel : coverpoint at.Psel {
				bins b1 = {[0:1]};
					}	
		
		penalbe : coverpoint at.Penable {
				bins b1 = {[0:1]};
					}

		Pready : coverpoint at.Pready {
				bins b1 = {[0:1]};
					}

		Pwrite : coverpoint at.Pwrite {
				bins b1[] = {[0:1]};
					}

		Pslverr : coverpoint at.Pslverr {
				bins b1 = {[0:1]};
					}
		
		

	endgroup
	
	function new (string name = "scoreboard",uvm_component parent);
		super.new(name,parent);
		cg =  new;
	endfunction 

	uvm_tlm_analysis_fifo#(apb_trans) am2sb;
	uvm_tlm_analysis_fifo#(spi_trans) sm2sb;
	
	apb_trans at;
	spi_trans st;
	
	int ap_rdata[$];
	int ap_wdata[$];

	int sp_miso[$];
	int sp_mosi[$];

	int Prdata,Pwdata;
	int mosi,miso;


		
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		am2sb = new("am2sb",this);
		sm2sb = new("sm2sb",this);
		
		at = apb_trans::type_id::create("at");
		st = spi_trans::type_id::create("st");
	
		

	endfunction
	
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
	
	
		fork
			forever
				begin
					am2sb.get(at);
					`uvm_info(get_type_name(),"DATA FRM APB_MON",UVM_LOW);
					at.print();	
					ap_rdata.push_back(at.Prdata);
					ap_wdata.push_back(at.Pwdata);
					cg.sample();
				end
				
			forever
				begin
					sm2sb.get(st);
					`uvm_info(get_type_name(),"DATA FRM SPI_MON",UVM_LOW);
					st.print();	
					sp_miso.push_back(st.miso);	
					sp_mosi.push_back(st.mosi);
					cg.sample();
				end		
	
		join
		

		
	endtask	
		


		
	function void report_phase(uvm_phase phase);	
		super.report_phase(phase);

		
/*		$display("\nthe value of miso");	
		foreach(sp_miso[i])
			 begin
				$display("%0d",sp_miso[i]);			
			end

		$display("\nthe value of mosi");
		foreach(sp_mosi[i]) 
			begin	
				$display("%0d",sp_mosi[i]);			
			end			
		
		$display("\nthe rdata value");
		foreach(ap_rdata[i])
			begin 
				$display("%0d",ap_rdata[i]);
			end
		
		$display("\nthe wdata value");
		foreach(ap_wdata[i])
			begin 
				$display("%0d",ap_wdata[i]);
			end		
	
*/
	
/*
		at_1 = ap.pop_back;	
		st_1 = sp.pop_back;
		
		at_1.print();
		st_1.print();
		
			if(at_1.Pwdata == st_1.mosi)
				begin
					$display("\n\n ============= THE MOSI DATA IS CORRECT ============= ");
					$display("\tPWDATA == %b   \t  MOSI == %b" ,at_1.Pwdata,st_1.mosi);	
					$display(" ================ COMPARISSION PASSED ================ \n\n");
				end
			else
				begin 
					$display("\n\n ============= THE MOSI DATA IS INCORRECT ============= ");
					$display("\tPWDATA == %b   \t  MOSI == %b" ,at_1.Pwdata,st_1.mosi);	
					$display(" ================ COMPARISSION FAILED ================ \n\n");
				end		
	

	
			if(at_1.Prdata == st_1.miso)
				begin
					$display(" ============= THE MISO DATA IS CORRECT ============= ");
					$display("\tMISO == %b   \t  PRDATA == %b" ,st_1.miso,at_1.Prdata);
					$display(" ================ COMPARISSION PASSED ================ \n\n");
				end	
			else	
				begin
					$display("\n\n ============= THE MOSI DATA IS INCORRECT ============= ");
					$display("\tPWDATA == %b   \t  MOSI == %b" ,at_1.Pwdata,st_1.mosi);	
					$display(" ================ COMPARISSION FAILED ================ \n\n");
				end		
*/
			

		for(int i = 0 ; i < $size(sp_miso) ; i++ )
			begin 
				foreach(ap_rdata[j])
					begin 
						if(sp_miso[i] == ap_rdata[j] )
							begin 
								$display("\n\n ============= THE MISO DATA IS CORRECT ============= ");
								$display("\tPRDATA == %d   \t  MISO == %d" ,ap_rdata[j],sp_miso[i]);	
								$display(" ================ COMPARISSION PASSED ================ \n\n");
							end
						else
							begin 
							//	$display(" ================ COMPARISSION FAILED ================ \n\n");
							end
					end
			end


		for(int i = 0 ; i < $size(sp_mosi) ; i++ )
			begin 
				foreach(ap_wdata[j])
					begin 
						if(sp_mosi[i] == ap_wdata[j] )
							begin 
								$display("\n\n ============= THE MOSI DATA IS CORRECT ============= ");
								$display("\tPWDATA == %d   \t  MOSI == %d" ,ap_wdata[j],sp_mosi[i]);	
								$display(" ================ COMPARISSION PASSED ================ \n\n");
							end
						else
							begin 
							//	$display(" ================ COMPARISSION FAILED ================ \n\n");
							end
					end
			end

			
		
	endfunction 	


endclass	
	
		
