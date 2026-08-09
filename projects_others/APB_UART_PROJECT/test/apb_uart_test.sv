class apb_uart_test extends uvm_test;

	`uvm_component_utils(apb_uart_test)

	function new (string name = "apb_uart_test",uvm_component parent);
		super.new(name,parent);
	endfunction 

	apb_uart_env_config apb_uart_env_cfg; //env config handle 
	apb_uart_agt_config apb_uart_agt_cfg[]; //agt config handle
	apb_uart_environment apb_uart_env;
	reg_block rg_bl;

	//values 
	int no_of_agent = 2;
	bit has_sb = 1;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		rg_bl = reg_block::type_id::create("rg_bl");

		apb_uart_env_cfg = apb_uart_env_config::type_id::create("apb_uart_env_cfg",this);

		apb_uart_env_cfg.no_of_agent = no_of_agent;
		apb_uart_env_cfg.has_sb = has_sb;

	
		apb_uart_agt_cfg = new [no_of_agent];

		apb_uart_env_cfg.apb_uart_agt_cfg = new [no_of_agent];

		foreach(apb_uart_agt_cfg[i])
			begin 
			apb_uart_agt_cfg[i] = apb_uart_agt_config::type_id::create($sformatf("apb_uart_agt_cfg[%0d]",i));
			
			//get virtual interface
			if(!uvm_config_db#(virtual uart_if)::get(this,"",$sformatf("uart_if[%0d]",i),apb_uart_agt_cfg[i].vif))
				`uvm_fatal("apb_uart_test","failed to get config");


			apb_uart_env_cfg.apb_uart_agt_cfg[i] = apb_uart_agt_cfg[i];

			if(i == 0 || i == 1)
			begin 
				apb_uart_agt_cfg[i].is_active = UVM_ACTIVE;
				uvm_config_db#(apb_uart_agt_config)::set(this,$sformatf("*apb_uart_agt[%0d]*",i),"apb_uart_agt_config",apb_uart_agt_cfg[i]);
			end
			else
			begin 
				apb_uart_agt_cfg[i].is_active = UVM_PASSIVE;
				uvm_config_db#(apb_uart_agt_config)::set(this,$sformatf("*apb_uart_agt[%0d]*",i),"apb_uart_agt_config",apb_uart_agt_cfg[i]);
			end

			end

			rg_bl.build();
			apb_uart_env_cfg.rg_bl = this.rg_bl;
			uvm_config_db#(apb_uart_env_config)::set(this,"*","apb_uart_env_config",apb_uart_env_cfg);
		
			apb_uart_env = apb_uart_environment::type_id::create("apb_uart_env",this);
			
	endfunction 

	function void start_of_simulation_phase(uvm_phase phase);
		super.start_of_simulation_phase(phase);
			
			uvm_top.print();

	endfunction 			
			

endclass

//-----------------------------------------------------------------------------------------------------------------------------------------

// 							FULLL DUPLEXXXXX 
 
//-----------------------------------------------------------------------------------------------------------------------------------------

class apb_uart_fd_test extends apb_uart_test;	

	`uvm_component_utils(apb_uart_fd_test)

	function new (string name = "apb_uart_fd_test",uvm_component parent);
		super.new(name,parent);
	endfunction 

	//sequence handle 
	fd_seq1 fd_s1;
	fd_seq2 fd_s2;


	task run_phase(uvm_phase phase);

			fd_s1 = fd_seq1::type_id::create("fd_s1");//full duplex seq1 frm uart 1 to uart 2
			fd_s2 = fd_seq2::type_id::create("fd_s2"); //full duplex seq2 frm uart 2 to uart 1


		phase.raise_objection(this); 

		fork
			fd_s1.start(apb_uart_env.apb_uart_agt_top.apb_uart_agt[0].apb_uart_seqr);
			fd_s2.start(apb_uart_env.apb_uart_agt_top.apb_uart_agt[1].apb_uart_seqr);
		join	
		
		phase.drop_objection(this);
	
	endtask	

endclass
	

//-----------------------------------------------------------------------------------------------------------------------------------------

// 							HALF DUPLEXXXXX 
 
//-----------------------------------------------------------------------------------------------------------------------------------------

	
class apb_uart_hd_test extends apb_uart_test;	

	`uvm_component_utils(apb_uart_hd_test)

	function new (string name = "apb_uart_hd_test",uvm_component parent);
		super.new(name,parent);
	endfunction 

	//sequence handle 
	hd_seq1 hd_s1;
	hd_seq2 hd_s2;


	task run_phase(uvm_phase phase);

			hd_s1 = hd_seq1::type_id::create("hd_s1");//half duplex seq1 frm uart 1 to uart 2
			hd_s2 = hd_seq2::type_id::create("hd_s2"); //half duplex seq2 reading the data frm uart 1 in uart 2 


		phase.raise_objection(this); 

		fork
			hd_s1.start(apb_uart_env.apb_uart_agt_top.apb_uart_agt[0].apb_uart_seqr);
			hd_s2.start(apb_uart_env.apb_uart_agt_top.apb_uart_agt[1].apb_uart_seqr);
		join	
		
		phase.drop_objection(this);
	
	endtask	

endclass




//-----------------------------------------------------------------------------------------------------------------------------------------

// 							LOPPP BACKK MODE 
 
//-----------------------------------------------------------------------------------------------------------------------------------------

	
class apb_uart_lb_test extends apb_uart_test;	

	`uvm_component_utils(apb_uart_lb_test)

	function new (string name = "apb_uart_lb_test",uvm_component parent);
		super.new(name,parent);
	endfunction 

	//sequence handle 
	lb_seq1 lb_s1;
	lb_seq2 lb_s2;


	task run_phase(uvm_phase phase);

			lb_s1 = lb_seq1::type_id::create("lb_s1");//loop back 
			lb_s2 = lb_seq2::type_id::create("lb_s2"); //loop back  


		phase.raise_objection(this); 

		fork
			lb_s1.start(apb_uart_env.apb_uart_agt_top.apb_uart_agt[0].apb_uart_seqr);
			lb_s2.start(apb_uart_env.apb_uart_agt_top.apb_uart_agt[1].apb_uart_seqr);
		join	
		
		phase.drop_objection(this);
	
	endtask	

endclass

//-----------------------------------------------------------------------------------------------------------------------------------------

// 							 PARITY ERROR 
 
//-----------------------------------------------------------------------------------------------------------------------------------------

	
class apb_uart_pe_test extends apb_uart_test;	

	`uvm_component_utils(apb_uart_pe_test)

	function new (string name = "apb_uart_pe_test",uvm_component parent);
		super.new(name,parent);
	endfunction 

	//sequence handle 
	pe_seq1 pe_s1;
	pe_seq2 pe_s2;


	task run_phase(uvm_phase phase);

			pe_s1 = pe_seq1::type_id::create("pe_s1");//loop back 
			pe_s2 = pe_seq2::type_id::create("pe_s2"); //loop back  


		phase.raise_objection(this); 

		fork
			pe_s1.start(apb_uart_env.apb_uart_agt_top.apb_uart_agt[0].apb_uart_seqr);
			pe_s2.start(apb_uart_env.apb_uart_agt_top.apb_uart_agt[1].apb_uart_seqr);
		join	
		
		phase.drop_objection(this);
	
	endtask	

endclass


//-----------------------------------------------------------------------------------------------------------------------------------------

// 							 FRAMING ERROR 
 
//-----------------------------------------------------------------------------------------------------------------------------------------

	
class apb_uart_fe_test extends apb_uart_test;	

	`uvm_component_utils(apb_uart_fe_test)

	function new (string name = "apb_uart_fe_test",uvm_component parent);
		super.new(name,parent);
	endfunction 

	//sequence handle 
	fe_seq1 fe_s1;
	fe_seq2 fe_s2;


	task run_phase(uvm_phase phase);

			fe_s1 = fe_seq1::type_id::create("fe_s1");//loop back 
			fe_s2 = fe_seq2::type_id::create("fe_s2"); //loop back  


		phase.raise_objection(this); 

		fork
			fe_s1.start(apb_uart_env.apb_uart_agt_top.apb_uart_agt[0].apb_uart_seqr);
			fe_s2.start(apb_uart_env.apb_uart_agt_top.apb_uart_agt[1].apb_uart_seqr);
		join	
		
		phase.drop_objection(this);
	
	endtask	

endclass


//-----------------------------------------------------------------------------------------------------------------------------------------

// 							 BREAKINGGGG ERROR 
 
//-----------------------------------------------------------------------------------------------------------------------------------------

	
class apb_uart_be_test extends apb_uart_test;	

	`uvm_component_utils(apb_uart_be_test)

	function new (string name = "apb_uart_be_test",uvm_component parent);
		super.new(name,parent);
	endfunction 

	//sequence handle 
	be_seq1 be_s1;
	be_seq2 be_s2;


	task run_phase(uvm_phase phase);

			be_s1 = be_seq1::type_id::create("be_s1");//loop back 
			be_s2 = be_seq2::type_id::create("be_s2"); //loop back  


		phase.raise_objection(this); 

		fork
			be_s1.start(apb_uart_env.apb_uart_agt_top.apb_uart_agt[0].apb_uart_seqr);
			be_s2.start(apb_uart_env.apb_uart_agt_top.apb_uart_agt[1].apb_uart_seqr);
		join	
		
		phase.drop_objection(this);
	
	endtask	

endclass


//-----------------------------------------------------------------------------------------------------------------------------------------

// 							 OVERRUNN ERROR 
 
//-----------------------------------------------------------------------------------------------------------------------------------------

	
class apb_uart_oe_test extends apb_uart_test;	

	`uvm_component_utils(apb_uart_oe_test)

	function new (string name = "apb_uart_oe_test",uvm_component parent);
		super.new(name,parent);
	endfunction 

	//sequence handle 
	oe_seq1 oe_s1;
	oe_seq2 oe_s2;


	task run_phase(uvm_phase phase);

			oe_s1 = oe_seq1::type_id::create("oe_s1");//loop back 
			oe_s2 = oe_seq2::type_id::create("oe_s2"); //loop back  


		phase.raise_objection(this); 

		fork
			oe_s1.start(apb_uart_env.apb_uart_agt_top.apb_uart_agt[0].apb_uart_seqr);
			oe_s2.start(apb_uart_env.apb_uart_agt_top.apb_uart_agt[1].apb_uart_seqr);
		join	
		
		phase.drop_objection(this);
	
	endtask	

endclass


//-----------------------------------------------------------------------------------------------------------------------------------------

// 							 THR EMPTY ERROR 
 
//-----------------------------------------------------------------------------------------------------------------------------------------

	
class apb_uart_thr_e_test extends apb_uart_test;	

	`uvm_component_utils(apb_uart_thr_e_test)

	function new (string name = "apb_uart_thr_e_test",uvm_component parent);
		super.new(name,parent);
	endfunction 

	//sequence handle 
	thr_e_seq1 thr_e_s1;
	thr_e_seq2 thr_e_s2;


	task run_phase(uvm_phase phase);

			thr_e_s1 = thr_e_seq1::type_id::create("thr_e_s1");//loop back 
			thr_e_s2 = thr_e_seq2::type_id::create("thr_e_s2"); //loop back  


		phase.raise_objection(this); 

		fork
			thr_e_s1.start(apb_uart_env.apb_uart_agt_top.apb_uart_agt[0].apb_uart_seqr);
			thr_e_s2.start(apb_uart_env.apb_uart_agt_top.apb_uart_agt[1].apb_uart_seqr);
		join	
		
		phase.drop_objection(this);
	
	endtask	

endclass



//-----------------------------------------------------------------------------------------------------------------------------------------

// 							 TIME OUTT ERROR 
 
//-----------------------------------------------------------------------------------------------------------------------------------------

	
class apb_uart_te_test extends apb_uart_test;	

	`uvm_component_utils(apb_uart_te_test)

	function new (string name = "apb_uart_te_test",uvm_component parent);
		super.new(name,parent);
	endfunction 

	//sequence handle 
	te_seq1 te_s1;
	te_seq2 te_s2;


	task run_phase(uvm_phase phase);

			te_s1 = te_seq1::type_id::create("te_s1");//loop back 
			te_s2 = te_seq2::type_id::create("te_s2"); //loop back  


		phase.raise_objection(this); 

		fork
			te_s1.start(apb_uart_env.apb_uart_agt_top.apb_uart_agt[0].apb_uart_seqr);
			te_s2.start(apb_uart_env.apb_uart_agt_top.apb_uart_agt[1].apb_uart_seqr);
		join	
		
		phase.drop_objection(this);
	
	endtask	

endclass
