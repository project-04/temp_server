class scoreboard extends uvm_scoreboard;

    `uvm_component_utils (scoreboard)

       	uvm_tlm_analysis_fifo #(apb_xtn) apb_fifo;
    	uvm_tlm_analysis_fifo #(aux_xtn) aux_fifo;
    	uvm_tlm_analysis_fifo #(io_xtn) io_fifo;
    
	apb_xtn apb_xtnh,apb_cov;
	aux_xtn aux_xtnh,aux_cov;
	io_xtn io_xtnh,io_cov;

	uvm_reg_data_t dat,dat1,dat2,dat3,dat4,dat5,dat6,dat7,dat8;
	uvm_status_e status;
	rgpio_reg_block reg_block;
	env_cfg cfg;


	logic[31:0] in_reg;
	logic[31:0] out_reg;
	logic[31:0] oe_reg;
	logic[31:0] ints_reg;
	logic[31:0] inte_reg;
	logic[31:0] ptrig_reg;
	logic[31:0] nec_reg;
	logic[31:0] eclk_reg;
	logic[31:0] aux_reg;

	logic[31:0]in_muxed,extc_in,in_pad_i,rgpio_ints;

	int in_seqs,in_err_seqs,out_seqs,out_err_seqs,inte_seqs,inte_err_seqs,aux_seqs,aux_err_seqs;


   covergroup apb_covh;
	RESET: coverpoint apb_cov.PRESETn{bins r[] = {0};}
	ADDR: coverpoint apb_cov.PADDR{ bins addr[] =  {['h0:'h9]};}
	DATA: coverpoint apb_cov.PWDATA{ bins data = {[0:'hffff_ffff]};}
	WRITE: coverpoint apb_cov.PWRITE{ bins w[] = {[0:1]};}
	SEL: coverpoint apb_cov.PSEL{ bins sel[] = {1};}
	ENABLE: coverpoint apb_cov.PENABLE{ bins enab[] = {1};}
	READY: coverpoint apb_cov.PREADY{ bins ready[] = {1};}
   endgroup


   covergroup aux_covh;
	AUX: coverpoint aux_cov.aux_in { bins aux = {['h0:'hffff_ffff]};}
   endgroup

	
   covergroup iopad_covh;
	IO_PAD: coverpoint io_cov.io_pad { bins pad = {['h0:'hffff_ffff]};}
   endgroup





    extern function new(string name = "Scoreboard",  uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern task run_phase (uvm_phase phase);
    extern task compare (apb_xtn apb,aux_xtn aux,io_xtn io);
    extern task ref_model();
    extern function void report_phase(uvm_phase phase);
endclass


  function scoreboard::new(string name = "Scoreboard",  uvm_component parent);
        super.new(name, parent);        
        apb_fifo = new("apb_fifo",this);
        aux_fifo = new("aux_fifo",this);
        io_fifo = new("io_fifo",this);
	apb_covh = new();
	aux_covh = new();
	iopad_covh = new();
    endfunction: new
    
    /////////////////////////////////////////////////////////////////////////////////////
    
    function void scoreboard::build_phase(uvm_phase phase);

             super.build_phase(phase); 

	if(!uvm_config_db#(env_cfg)::get(this,"","env_cfg",cfg))
		`uvm_fatal("Scoreboard","Unable to get the env_config inside Scoreboard class")

	reg_block=cfg.reg_model;

    endfunction

    /////////////////////////////////////////////////////////////////////////////////////

    task scoreboard::run_phase(uvm_phase phase);
        forever
	begin
            fork 
                begin
                    apb_fifo.get(apb_xtnh);
		    apb_cov = apb_xtnh;
		    apb_covh.sample();
                end 
                begin
                    aux_fifo.get(aux_xtnh);
		    aux_cov = aux_xtnh;
		    aux_covh.sample();
                end
                begin
                    io_fifo.get(io_xtnh);
		    io_cov = io_xtnh;
		    iopad_covh.sample();
                end
            join
		compare(apb_xtnh,aux_xtnh,io_xtnh);
	end
    endtask

    /////////////////////////////////////////////////////////////////////////////////////
   
   task scoreboard::compare(apb_xtn apb,aux_xtn aux,io_xtn io);
	
/*********************    read method to read the register using RAL BACKDOOR access      *******************/

	this.reg_block.inreg.read(status,dat,.path(UVM_BACKDOOR),.map(reg_block.map));	
	this.reg_block.outreg.read(status,dat1,.path(UVM_BACKDOOR),.map(reg_block.map));	
	this.reg_block.oereg.read(status,dat2,.path(UVM_BACKDOOR),.map(reg_block.map));	
	this.reg_block.intsreg.read(status,dat3,.path(UVM_BACKDOOR),.map(reg_block.map));	
	this.reg_block.intereg.read(status,dat4,.path(UVM_BACKDOOR),.map(reg_block.map));	
	this.reg_block.necreg.read(status,dat5,.path(UVM_BACKDOOR),.map(reg_block.map));	
	this.reg_block.eclkreg.read(status,dat6,.path(UVM_BACKDOOR),.map(reg_block.map));	
	this.reg_block.ptrigreg.read(status,dat7,.path(UVM_BACKDOOR),.map(reg_block.map));	
	this.reg_block.auxreg.read(status,dat8,.path(UVM_BACKDOOR),.map(reg_block.map));	

	
	in_reg=dat[31:0];
	out_reg=dat1[31:0];
	inte_reg=dat4[31:0];
	ints_reg=dat3[31:0];
	oe_reg=dat2[31:0];
	in_pad_i =dat1[31:0];
	nec_reg=dat5[31:0];
	eclk_reg=dat6[31:0];
	ptrig_reg=dat7[31:0];
	rgpio_ints=ints_reg;
	aux_reg=dat8[31:0];
	in_pad_i=io_xtnh.io_pad;
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  %h",in_reg);


 /**************************  General-Purpose I/O as Polled Input  **************************/

	if(oe_reg==0 && ints_reg==0)
	  begin
		if(io_xtnh.io_pad==in_reg)
		begin
			in_seqs++;
		end
		begin
			in_err_seqs++;
		end

	  end


 /*************************  General-Purpose I/O as Polled output or bidirectional  *************************/

     if(oe_reg!=0 && aux_reg==0)
	begin
	for(int i=0;i<32;i++)	
	 begin
	   if(oe_reg[i]==1)
	    begin	
		if(io_xtnh.io_pad[i]==out_reg[i])
		begin
			out_seqs++;
		end
		else
		begin
			out_err_seqs++;
		end
  	    end
	  else
	    begin
		if(io_xtnh.io_pad[i]==in_reg[i])
		begin
			out_seqs++;
		end
		else
		begin
			out_err_seqs++;
		end
	    end
	end
	end


 /*************************  General-Purpose I/O as Polled Input with Interrupt  ****************************/

	ref_model();

      if(oe_reg==0)
	  begin
		if(io_xtnh.io_pad==in_reg)
		begin
			if(ints_reg==rgpio_ints)
			inte_seqs++;
		end
		
		else
		begin
			inte_err_seqs++;
		end
	end

 /****************************  General-Purpose I/O driven by Auxiliary Input  **************************/

    if(oe_reg!=0 && aux_reg!=0)
	begin
	for(int i=0;i<32;i++)	
	 begin
	   if(oe_reg[i]==1 && aux_reg[i]==1)
	    begin	
		if(io_xtnh.io_pad[i]==aux_xtnh.aux_in[i])
		begin
			aux_seqs++;
		end
		else
		begin
			aux_err_seqs++;
		end
  	    end
	  else if(oe_reg[i]==1 && aux_reg[i]!=1)
	    begin
		if(io_xtnh.io_pad[i]==out_reg[i])
		begin
			aux_seqs++;
		end
		else
		begin
			aux_err_seqs++;
		end
	    end
	  else if(oe_reg[i]==0)
	    begin
		if(io_xtnh.io_pad[i]==in_reg[i])
		begin
			aux_seqs++;
		end
		else
		begin
			aux_err_seqs++;
		end
	    end

	end
       end



   endtask


 /************************  Referrence Model Logic for Interrupt Status  ************************/

task scoreboard::ref_model();

	extc_in = (~nec_reg & in_pad_i) | (nec_reg & in_pad_i);
	in_muxed = (eclk_reg & extc_in) | (~eclk_reg & in_pad_i) ;
	rgpio_ints = (rgpio_ints | ((in_muxed ^ in_reg) & ~(in_muxed ^ ptrig_reg)) & inte_reg);


endtask



function void scoreboard::report_phase(uvm_phase phase);

/*******************************    General-Purpose I/O as Polled Input     ******************************/ 
	if(in_seqs>0)
            `uvm_info("SB_input","General-Purpose I/O as Polled Input Working",UVM_LOW)
	else if(in_err_seqs>0)
	    `uvm_error("scoreboard","General-Purpose I/O as Polled Input Not Working")



/*******************************    General-Purpose I/O as Polled Output or Bidirectional     ******************************/ 
	if(out_seqs>0)
	    `uvm_info("SB_out_or_bidir","General-Purpose I/O as Polled Out or bi directional id Working",UVM_LOW)
	else if(out_err_seqs>0)
            `uvm_error("scoreboard","General-Purpose I/O as Polled Output or bi directional is  Not Working")



/*******************************    General-Purpose I/O as Polled Input with Interrupt     ******************************/ 
	if(inte_seqs>0)
		 `uvm_info("SB_interrupt","General-Purpose I/O as Polled Input with Interrupt is Working",UVM_LOW)
	else if(inte_err_seqs>0)
		 `uvm_error("scoreboard","General-Purpose I/O as Polled Input with Interrupt is Not Working")
	

/*******************************    General-Purpose I/O as Auxiliary Input    ******************************/ 
	if(aux_seqs>0)
		 `uvm_info("SB_AUX","General-Purpose I/O as Auxiliary input is Working",UVM_LOW)
	else if(aux_err_seqs>0)
		 `uvm_error("scoreboard","General-Purpose I/O as Auxiliary input is Not Working")

endfunction
