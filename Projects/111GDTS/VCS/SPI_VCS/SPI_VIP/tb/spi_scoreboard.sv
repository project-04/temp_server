class spi_scoreboard extends uvm_scoreboard;

//FACTORY REGISTRAIION
	`uvm_component_utils(spi_scoreboard)

uvm_tlm_analysis_fifo#(master_xtn) master_fifo;
uvm_tlm_analysis_fifo#(slave_xtn)  slave_fifo;

spi_env_config m_cfg;


master_xtn  master_data;

slave_xtn   slave_data;

bit [127:0]tx,rx;
bit [6:0] char_len;
//METHODS

 extern function new(string name = "spi_scoreboard",uvm_component parent);
 extern function void build_phase(uvm_phase phase);
 extern task run_phase(uvm_phase phase);
 extern function void report_phase(uvm_phase phase);
master_xtn cov_data;


covergroup spi_cov;
		option.per_instance=1;
        CHAR_LENGTH : coverpoint cov_data.control_reg[6:0] {
						bins low = {[0:32]};
						bins mid1 = {[33:64]};
						bins mid2 = {[64:96]};
						bins high = {[96:128]};}
												
    	     	   
        TX_RX : coverpoint cov_data.control_reg[10:9] {
							bins rx = {1};
							bins tx = {2};}
												
        LSB_MSB :  coverpoint cov_data.control_reg[11];
        
	//	cross CHAR_LENGHTH,TX_RX,LSB_MSB
          
    endgroup


endclass


function spi_scoreboard::new(string name = "spi_scoreboard",uvm_component parent);
	super.new(name,parent);
		spi_cov=new;

endfunction


function void spi_scoreboard::build_phase (uvm_phase phase);

	if(!uvm_config_db#(spi_env_config)::get(this,"","spi_env_config",m_cfg))
		`uvm_fatal("SCOREBOARD","unable to get the config")
	
	if(m_cfg.has_master_agent)
		master_fifo=new("master_fifo",this);

	if(m_cfg.has_slave_agent)
		slave_fifo=new("slave_fifo",this);

	
endfunction


task spi_scoreboard::run_phase(uvm_phase phase);
int i;
	begin

		master_fifo.get(master_data);
				tx={master_data.tx3,master_data.tx2,master_data.tx1,master_data.tx0};	
		slave_fifo.get(slave_data);
			
				char_len=master_data.control_reg[6:0];
				if(char_len==0)
					char_len=128;
					

		
		if(char_len<=32)
	        	master_fifo.get(master_data);
		else if (char_len<=64)	
			begin	
			master_fifo.get(master_data);
			master_fifo.get(master_data);
			end
		else if(char_len<=96)
			begin
			master_fifo.get(master_data);
			master_fifo.get(master_data);
			master_fifo.get(master_data);
			end
		else
			begin
			master_fifo.get(master_data);
			master_fifo.get(master_data);
			master_fifo.get(master_data);
			master_fifo.get(master_data);
			end

			rx={master_data.rx3,master_data.rx2,master_data.rx1,master_data.rx0};	
			for(i=0;i<char_len;i++)
					if(rx[i]==slave_data.miso_pad_i[i])
							$display("SUCESSFULL COMPARE %d rx = %d   mosi = %d ",i,rx[i],slave_data.miso_pad_i[i]);
		
			for(i=0;i<char_len;i++)
					if(tx[i]==slave_data.mosi_pad_o[i])
							$display("SUCESSFULL COMPARE %d tx = %d   mosi = %d ",i,tx[i],slave_data.mosi_pad_o[i]);
		
			cov_data=master_data;
			spi_cov.sample();
	end


endtask
		
function void spi_scoreboard::report_phase(uvm_phase phase);
	$display("FINAL RESULT");
		$display("CHAR LEN =\t%d",char_len);
		$display("MOSI  =\t%0d\nMISO  =\t%0d\nRX  =\t\t%0d\nTX  =\t\t%0d",slave_data.mosi_pad_o,slave_data.miso_pad_i,rx,tx);
endfunction
	
				
