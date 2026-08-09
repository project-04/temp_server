class base_test extends uvm_test;
        `uvm_component_utils(base_test)

        env_config env_cfg;
        uart_config uart_cfg[];
        apb_config apb_cfg[];

        env env_h;
        virtual_seq virtual_seqh;
        bit [7:0]lcr;

        //int no_of_agents = 2;
        int no_of_apb_agents = 1;
        int no_of_uart_agents = 1;
        bit has_virtual_sequencer = 1'b1;
        uart_reg_block regmodel;        //ral


        function new(string name="base_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void config_test();
                apb_cfg = new[no_of_apb_agents];
                uart_cfg = new[no_of_uart_agents];

                foreach(apb_cfg[i])begin
                        apb_cfg[i] = apb_config::type_id::create($sformatf("apb_cfg[%0d]",i));

                        if(! uvm_config_db #(virtual apb_if)::get(this,"","apb_vif",apb_cfg[i].vif))
                                `uvm_fatal(get_type_name(),"Have you set the config correctly?");

                        apb_cfg[i].is_active =  UVM_ACTIVE;
                end

                foreach(uart_cfg[i])begin
                        uart_cfg[i] = uart_config::type_id::create($sformatf("uart_cfg[%0d]",i));

                        if(! uvm_config_db #(virtual uart_if)::get(this,"","uart_vif",uart_cfg[i].vif))
                                `uvm_fatal(get_type_name(),"Have you set the config correctly?");

                        uart_cfg[i].is_active = UVM_ACTIVE;
                end

                env_cfg.apb_cfg = apb_cfg;
                env_cfg.uart_cfg = uart_cfg;
                //env_cfg.no_of_agents = no_of_agents;
                env_cfg.no_of_uart_agents = no_of_uart_agents;
                env_cfg.no_of_apb_agents = no_of_apb_agents;
                //env_cfg.has_virtual_sequencer = has_virtual_sequencer;
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                env_cfg = env_config::type_id::create("env_cfg");

                config_test();

                uvm_config_db #(env_config)::set(this,"*","env_config",env_cfg);

                regmodel = uart_reg_block ::type_id ::create("regmodel");       // ral
                regmodel.build();
                env_cfg.regmodel = this.regmodel;

                env_h = env::type_id::create("env_h",this);

                virtual_seqh = virtual_seq::type_id::create("virtual_seqh",this);
                $display("\n\n\n################## Base test for testing\n\n\n");
        endfunction

        function void end_of_elaboration_phase(uvm_phase phase);
                uvm_top.print_topology();
        endfunction

endclass


//**********************************************************************//HD0_sequence_test
class HD0_sequence_test extends base_test;
      `uvm_component_utils(HD0_sequence_test)
     
        HD0_sequence 	hd0_seq;

 	function new(string name = "HD0_sequence_test", uvm_component parent);
		 super.new(name, parent);
  	endfunction

        function void build_phase(uvm_phase phase);
         	super.build_phase(phase);
	 	lcr = 8'b0000_0011;
	 	uvm_config_db #(int)::set(this,"*","lcr",lcr);
	 	//$display(" uvm_config_db #(bit)::set(this,\"*\",\"lcr\",lcr); ");
        endfunction
       
        task run_phase(uvm_phase phase);
	     phase.raise_objection(this);

             hd0_seq= HD0_sequence::type_id ::create("hd0_seq");
 	     hd0_seq.start(env_h.virtual_seqrh);
#1_00_000;
	     phase.drop_objection(this);
	     $display("\n\n\n################## UART_CORE sending the data and UART_AGENT receiving the data - HALF_DUPLEX single\n\n\n");
  	endtask
endclass

//**********************************************************************//HD0_multiple_sequence_test 2 stop bits
class HD0_multiple_sequence_test extends base_test;
      `uvm_component_utils(HD0_multiple_sequence_test)
     
        HD0_multiple_sequence 	hd0_multiple_seq;

 	function new(string name = "HD0_multiple_sequence_test", uvm_component parent);
		 super.new(name, parent);
  	endfunction

        function void build_phase(uvm_phase phase);
         	super.build_phase(phase);
	 	lcr = 8'b0000_0111;
	 	uvm_config_db #(int)::set(this,"*","lcr",lcr);
        endfunction
       
        task run_phase(uvm_phase phase);
	     phase.raise_objection(this);

             hd0_multiple_seq= HD0_multiple_sequence::type_id ::create("hd0_multiple_seq");
 	     hd0_multiple_seq.start(env_h.virtual_seqrh);
#1_00_000;
	     phase.drop_objection(this);
	     $display("\n\n\n################## UART_CORE sending the data and UART_AGENT receiving the data - HALF_DUPLEX multiple 2 stop bits\n\n\n");	
  	endtask
endclass

//**********************************************************************//HD1_sequence_test
class HD1_sequence_test extends base_test;
      `uvm_component_utils(HD1_sequence_test)
     
        HD1_sequence 	hd1_seq;

 	function new(string name = "HD1_sequence_test", uvm_component parent);
		 super.new(name, parent);
  	endfunction

        function void build_phase(uvm_phase phase);
         	super.build_phase(phase);
	 	lcr = 8'b0000_0011;
	 	uvm_config_db #(int)::set(this,"*","lcr",lcr);
        endfunction
       
        task run_phase(uvm_phase phase);
	     phase.raise_objection(this);

             hd1_seq= HD1_sequence::type_id ::create("hd1_seq");
 	     hd1_seq.start(env_h.virtual_seqrh);
//#2000000;
	     phase.drop_objection(this);
	     $display("\n\n\n################## UART_AGENT sending the data and UART_CORE receiving the data - HALF_DUPLEX single\n\n\n");
  	endtask
endclass

//**********************************************************************//HD1_multiple_sequence_test
class HD1_multiple_sequence_test extends base_test;
      `uvm_component_utils(HD1_multiple_sequence_test)
     
        HD1_multiple_sequence 	hd1_multiple_seq;

 	function new(string name = "HD1_multiple_sequence_test", uvm_component parent);
		 super.new(name, parent);
  	endfunction

        function void build_phase(uvm_phase phase);
         	super.build_phase(phase);
	 	lcr = 8'b0000_0011;
	 	uvm_config_db #(int)::set(this,"*","lcr",lcr);
        endfunction
       
        task run_phase(uvm_phase phase);
	     phase.raise_objection(this);

             hd1_multiple_seq= HD1_multiple_sequence::type_id ::create("hd1_multiple_seq");
 	     hd1_multiple_seq.start(env_h.virtual_seqrh);

	     phase.drop_objection(this);
	     $display("\n\n\n################## UART_AGENT sending the data and UART_CORE receiving the data - HALF_DUPLEX multiple\n\n\n");	
  	endtask
endclass

//**********************************************************************//FD_sequence_test
class FD_sequence_test extends base_test;
      `uvm_component_utils(FD_sequence_test)
     
        FD_sequence 	fd_seqh;

 	function new(string name = "FD_sequence_test", uvm_component parent);
		 super.new(name, parent);
  	endfunction

        function void build_phase(uvm_phase phase);
         	super.build_phase(phase);
	 	lcr = 8'b0000_0011;
	 	uvm_config_db #(int)::set(this,"*","lcr",lcr);
        endfunction
       
        task run_phase(uvm_phase phase);
	     phase.raise_objection(this);

             fd_seqh= FD_sequence::type_id ::create("fd_seqh");
 	     fd_seqh.start(env_h.virtual_seqrh);
#1_00_000;
	     phase.drop_objection(this);
	     $display("\n\n\n################## UART_AGENT and UART_CORE sending the data and UART_AGENT and UART_CORE receiving the data - FULL_DUPLEX single\n\n\n");
  	endtask
endclass

//**********************************************************************//FD_multiple_sequence_test
class FD_multiple_sequence_test extends base_test;
      `uvm_component_utils(FD_multiple_sequence_test)
     
        FD_multiple_sequence 	fd_multiple_seqh;

 	function new(string name = "FD_multiple_sequence_test", uvm_component parent);
		 super.new(name, parent);
  	endfunction

        function void build_phase(uvm_phase phase);
         	super.build_phase(phase);
	 	lcr = 8'b0000_0011;
	 	uvm_config_db #(int)::set(this,"*","lcr",lcr);
        endfunction
       
        task run_phase(uvm_phase phase);
	     phase.raise_objection(this);

             fd_multiple_seqh= FD_multiple_sequence::type_id ::create("fd_multiple_seqh");
 	     fd_multiple_seqh.start(env_h.virtual_seqrh);
#1_00_000;
	     phase.drop_objection(this);
	    	     $display("\n\n\n################## UART_AGENT and UART_CORE sending the data and UART_AGENT and UART_CORE receiving the data - FULL_DUPLEX multiple\n\n\n");
  	endtask
endclass

//**********************************************************************//loopback_sequence_test
class loopback_sequence_test extends base_test;
      `uvm_component_utils(loopback_sequence_test)
     
        loopback_sequence 	loopback_seqh;

 	function new(string name = "loopback_sequence_test", uvm_component parent);
		 super.new(name, parent);
  	endfunction

        function void build_phase(uvm_phase phase);
         	super.build_phase(phase);
	 	lcr = 8'b0000_0011;
	 	uvm_config_db #(int)::set(this,"*","lcr",lcr);
        endfunction
       
        task run_phase(uvm_phase phase);
	     phase.raise_objection(this);

             loopback_seqh= loopback_sequence::type_id ::create("loopback_seqh");
 	     loopback_seqh.start(env_h.virtual_seqrh);

	     phase.drop_objection(this);
	     
	     	     $display("\n\n\n################## UART_CORE sending the data and UART_CORE receiving the data - LOOPBACK single\n\n\n");
  	endtask
endclass

//**********************************************************************//loopback_multiple_sequence_test
class loopback_multiple_sequence_test extends base_test;
      `uvm_component_utils(loopback_multiple_sequence_test)
     
        loopback_multiple_sequence 	loopback_multiple_seqh;

 	function new(string name = "loopback_multiple_sequence_test", uvm_component parent);
		 super.new(name, parent);
  	endfunction

        function void build_phase(uvm_phase phase);
         	super.build_phase(phase);
	 	lcr = 8'b0000_0011;
	 	uvm_config_db #(int)::set(this,"*","lcr",lcr);
        endfunction
       
        task run_phase(uvm_phase phase);
	     phase.raise_objection(this);

             loopback_multiple_seqh= loopback_multiple_sequence::type_id ::create("loopback_multiple_seqh");
 	     loopback_multiple_seqh.start(env_h.virtual_seqrh);

	     phase.drop_objection(this);
	     	     $display("\n\n\n################## UART_CORE sending the data and UART_CORE receiving the data - LOOPBACK multiple\n\n\n");
  	endtask
endclass

//**********************************************************************//THR_empty_sequence_test
class THR_empty_sequence_test extends base_test;
      `uvm_component_utils(THR_empty_sequence_test)
     
        THR_empty_sequence 	THR_empty_seqh;

 	function new(string name = "THR_empty_sequence_test", uvm_component parent);
		 super.new(name, parent);
  	endfunction

        function void build_phase(uvm_phase phase);
         	super.build_phase(phase);
	 	lcr = 8'b0000_0011;
	 	uvm_config_db #(int)::set(this,"*","lcr",lcr);
        endfunction
       
        task run_phase(uvm_phase phase);
	     phase.raise_objection(this);

             THR_empty_seqh= THR_empty_sequence::type_id ::create("THR_empty_seqh");
 	     THR_empty_seqh.start(env_h.virtual_seqrh);

	     phase.drop_objection(this);
	     	     $display("\n\n\n################## UART_CORE sending the data and no one receiving the data - THR_EMPTY\n\n\n");
  	endtask
endclass

//**********************************************************************//HD0_parity_sequence_test
class HD0_parity_sequence_test extends base_test;
      `uvm_component_utils(HD0_parity_sequence_test)
     
        parity_error_hd0_sequence 	parity_error_hd0_seqh;

 	function new(string name = "HD0_parity_sequence_test", uvm_component parent);
		 super.new(name, parent);
  	endfunction

        function void build_phase(uvm_phase phase);
         	super.build_phase(phase);
	 	lcr = 8'b0000_1011;
	 	uvm_config_db #(int)::set(this,"*","lcr",lcr);
        endfunction
       
        task run_phase(uvm_phase phase);
	     phase.raise_objection(this);

             parity_error_hd0_seqh= parity_error_hd0_sequence::type_id ::create("parity_error_hd0_seqh");
 	     parity_error_hd0_seqh.start(env_h.virtual_seqrh);
#1_00_000;
	     phase.drop_objection(this);
	     	     $display("\n\n\n################## UART_CORE sending the data and UART_AGENT receiving the data - HALF DUPLEX, PARITY single\n\n\n");
  	endtask
endclass

//**********************************************************************//HD1_parity_sequence_test
class HD1_parity_sequence_test extends base_test;
      `uvm_component_utils(HD1_parity_sequence_test)
     
        parity_error_hd1_sequence 	parity_error_hd1_seqh;

 	function new(string name = "HD1_parity_sequence_test", uvm_component parent);
		 super.new(name, parent);
  	endfunction

        function void build_phase(uvm_phase phase);
         	super.build_phase(phase);
	 	lcr = 8'b0000_1011;
	 	uvm_config_db #(int)::set(this,"*","lcr",lcr);
        endfunction
       
        task run_phase(uvm_phase phase);
	     phase.raise_objection(this);

             parity_error_hd1_seqh= parity_error_hd1_sequence::type_id ::create("parity_error_hd1_seqh");
 	     parity_error_hd1_seqh.start(env_h.virtual_seqrh);

	     phase.drop_objection(this);
	     	     $display("\n\n\n################## UART_AGENT sending the data and UART_CORE receiving the data - HALF DUPLEX, PARITY error single\n\n\n");
  	endtask
endclass

//**********************************************************************//FD_parity_sequence_test
class FD_parity_sequence_test extends base_test;
      `uvm_component_utils(FD_parity_sequence_test)
     
        parity_error_fd_sequence 	parity_error_fd_seqh;

 	function new(string name = "FD_parity_sequence_test", uvm_component parent);
		 super.new(name, parent);
  	endfunction

        function void build_phase(uvm_phase phase);
         	super.build_phase(phase);
	 	lcr = 8'b0000_1011;
	 	uvm_config_db #(int)::set(this,"*","lcr",lcr);
        endfunction
       
        task run_phase(uvm_phase phase);
	     phase.raise_objection(this);

             parity_error_fd_seqh= parity_error_fd_sequence::type_id ::create("parity_error_fd_seqh");
 	     parity_error_fd_seqh.start(env_h.virtual_seqrh);
#1_00_000;
	     phase.drop_objection(this);
	     	     $display("\n\n\n################## UART_AGENT and UART_CORE sending the data and UART_AGENT and UART_CORE receiving the data - FULL DUPLEX, PARITY error single\n\n\n");
  	endtask
endclass

//**********************************************************************//HD1_break_sequence_test
class HD1_break_sequence_test extends base_test;
      `uvm_component_utils(HD1_break_sequence_test)
     
        break_error_hd_sequence 	break_error_hd_seqh;

 	function new(string name = "HD1_break_sequence_test", uvm_component parent);
		 super.new(name, parent);
  	endfunction

        function void build_phase(uvm_phase phase);
         	super.build_phase(phase);
	 	lcr = 8'b0100_0011;
	 	uvm_config_db #(int)::set(this,"*","lcr",lcr);
        endfunction
       
        task run_phase(uvm_phase phase);
	     phase.raise_objection(this);

             break_error_hd_seqh= break_error_hd_sequence::type_id ::create("break_error_hd_seqh");
 	     break_error_hd_seqh.start(env_h.virtual_seqrh);

	     phase.drop_objection(this);
	     	     $display("\n\n\n################## UART_AGENT sending the data and UART_CORE receiving the data - HALF DUPLEX, BREAK error\n\n\n");
  	endtask
endclass

//**********************************************************************//HD1_frame_sequence_test
class HD_frame_sequence_test extends base_test;
      `uvm_component_utils(HD_frame_sequence_test)
     
        frame_error_hd_sequence 	frame_error_hd_seqh;

 	function new(string name = "HD_frame_sequence_test", uvm_component parent);
		 super.new(name, parent);
  	endfunction

        function void build_phase(uvm_phase phase);
         	super.build_phase(phase);
	 	lcr = 8'b0000_0011;
	 	uvm_config_db #(int)::set(this,"*","lcr",lcr);
        endfunction
       
        task run_phase(uvm_phase phase);
	     phase.raise_objection(this);

             frame_error_hd_seqh= frame_error_hd_sequence::type_id ::create("frame_error_hd_seqh");
 	     frame_error_hd_seqh.start(env_h.virtual_seqrh);

	     phase.drop_objection(this);
	     	     $display("\n\n\n################## UART_AGENT sending the data and UART_CORE receiving the data - HALF DUPLEX, FRAMING error\n\n\n");
  	endtask
endclass

//**********************************************************************//FD_frame_sequence_test
class FD_frame_sequence_test extends base_test;
      `uvm_component_utils(FD_frame_sequence_test)
     
        frame_error_fd_sequence 	frame_error_fd_seqh;

 	function new(string name = "FD_frame_sequence_test", uvm_component parent);
		 super.new(name, parent);
  	endfunction

        function void build_phase(uvm_phase phase);
         	super.build_phase(phase);
	 	lcr = 8'b0000_0011;
	 	uvm_config_db #(int)::set(this,"*","lcr",lcr);
        endfunction
       
        task run_phase(uvm_phase phase);
	     phase.raise_objection(this);

             frame_error_fd_seqh= frame_error_fd_sequence::type_id ::create("frame_error_fd_seqh");
 	     frame_error_fd_seqh.start(env_h.virtual_seqrh);

	     phase.drop_objection(this);
	     	     $display("\n\n\n################## UART_AGENT sending the data and UART_CORE receiving the data - FULL DUPLEX, FRAMING error\n\n\n");
  	endtask
endclass

//**********************************************************************//HD1_overrun_sequence_test
class HD1_overrun_sequence_test extends base_test;
      `uvm_component_utils(HD1_overrun_sequence_test)
     
        overrun_sequence 	hd1_overrun_seqh;

 	function new(string name = "HD1_overrun_sequence_test", uvm_component parent);
		 super.new(name, parent);
  	endfunction

        function void build_phase(uvm_phase phase);
         	super.build_phase(phase);
	 	lcr = 8'b0000_0011;
	 	uvm_config_db #(int)::set(this,"*","lcr",lcr);
        endfunction
       
        task run_phase(uvm_phase phase);
	     phase.raise_objection(this);

             hd1_overrun_seqh= overrun_sequence::type_id ::create("hd1_overrun_seqh");
 	     hd1_overrun_seqh.start(env_h.virtual_seqrh);

	     phase.drop_objection(this);
	     	     $display("\n\n\n################## UART_AGENT sending the data and UART_CORE receiving the data - HALF DUPLEX, OVERRUN error\n\n\n");
  	endtask
endclass

//**********************************************************************//HD1_timeout_sequence_test
class HD1_timeout_sequence_test extends base_test;
      `uvm_component_utils(HD1_timeout_sequence_test)
     
        timeout_sequence 	hd1_timeout_seqh;

 	function new(string name = "HD1_timeout_sequence_test", uvm_component parent);
		 super.new(name, parent);
  	endfunction

        function void build_phase(uvm_phase phase);
         	super.build_phase(phase);
	 	lcr = 8'b0000_0011;
	 	uvm_config_db #(int)::set(this,"*","lcr",lcr);
        endfunction
       
        task run_phase(uvm_phase phase);
	     phase.raise_objection(this);

             hd1_timeout_seqh= timeout_sequence::type_id ::create("hd1_timeout_seqh");
 	     hd1_timeout_seqh.start(env_h.virtual_seqrh);

	     phase.drop_objection(this);
	     	     $display("\n\n\n################## UART_AGENT sending the data and UART_CORE receiving the data - HALF DUPLEX, TIMEOUT error\n\n\n");
  	endtask
endclass

