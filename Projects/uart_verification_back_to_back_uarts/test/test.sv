class base_test extends uvm_test;
	`uvm_component_utils(base_test)
    		
	env envh;
	env_config env_configh;
	     
	agent_config agent_configh[];
	
 	virtual uart_if vif0;
     	virtual uart_if vif1;

    	int no_of_agents = 2;
    	
	HD_0_and_HD_1_sequence_xtns_vseq HD_sequence_xtns_vseq;
	
	HDM_0_and_HDM_1_sequence_xtns_vseq HDM_sequence_xtns_vseq;
 
  	FD_0_and_FD_1_sequence_xtns_vseq FD_sequence_xtns_vseq;
  	
  	FDM_0_and_FDM_1_sequence_xtns_vseq FDM_sequence_xtns_vseq;
  	
  	FDLB_0_and_FDLB_1_sequence_xtns_vseq FDLB_sequence_xtns_vseq;
  	
  	FDLBM_0_and_FDLBM_1_sequence_xtns_vseq FDLBM_sequence_xtns_vseq;
  	
  	FDM_0_thr_empty_and_FDM_1_thr_empty_sequence_xtns_vseq FDM_thr_empty_sequence_xtns_vseq;
   
   FDM_EP_0_and_FDM_EP_1_sequence_xtns_vseq FDM_EP_sequence_xtns_vseq;
		
	function new(string name = "base_test" , uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
	    	super.build_phase(phase);
         
         	if(!uvm_config_db #(virtual uart_if)::get(this, "", "uart_if0", vif0))
        		`uvm_fatal("base_test", "cannot get the vif0 form uart_if0");
           	
           	if(!uvm_config_db #(virtual uart_if)::get(this, "", "uart_if1", vif1))
        		`uvm_fatal("base_test", "cannot get the vif1 form uart_if1");
	
      		envh = env::type_id::create("envh", this);
      		env_configh = env_config::type_id::create("env_configh", this);
      		env_configh.no_of_agents = no_of_agents;
      		uvm_config_db #(env_config)::set(this,"envh*","env_config",env_configh);
      		
      		agent_configh = new[no_of_agents];
      		
      		foreach(agent_configh[i])
		begin
      			agent_configh[i] = agent_config::type_id::create($sformatf("agent_configh[%d]",i), this);
       			agent_configh[i].is_active = UVM_ACTIVE;
       			if(i==0) agent_configh[i].vif = vif0;
           		else 	 agent_configh[i].vif = vif1;
           		
		 	uvm_config_db #(agent_config)::set(this,$sformatf("envh.apb_agenth[%0d]*",i),"agent_config",agent_configh[i]);
        	end
	endfunction: build_phase
    	
	function void end_of_elaboration_phase(uvm_phase phase);
     		super.end_of_elaboration_phase(phase);
     		
		uvm_top.print_topology;
	endfunction
endclass

class HD_0_and_HD_1_sequence_test extends base_test;
	`uvm_component_utils(HD_0_and_HD_1_sequence_test)
	
	//HD_0_and_HD_1_sequence_xtns_vseq HD_sequence_xtns_vseq;

 	function new(string name = "HD_0_and_HD_1_sequence_test", uvm_component parent);
		super.new(name, parent);
  	endfunction
 
  	task run_phase(uvm_phase phase);
    		super.run_phase(phase);

         	phase.raise_objection(this);
          	HD_sequence_xtns_vseq = HD_0_and_HD_1_sequence_xtns_vseq::type_id::create("HD_sequence_xtns_vseq");
          	HD_sequence_xtns_vseq.start(envh.v_sequencer);
          	#1000;
         	phase.drop_objection(this);
          
          $display("\n\n\n------------------------------------------------HALF DUPLEX------------------------------------------------\n\n\n");
  	endtask
endclass

class HDM_0_and_HDM_1_sequence_test extends base_test;
	`uvm_component_utils(HDM_0_and_HDM_1_sequence_test)
	
	//HDM_0_and_HDM_1_sequence_xtns_vseq HDM_sequence_xtns_vseq;

 	function new(string name = "HDM_0_and_HDM_1_sequence_test", uvm_component parent);
		super.new(name, parent);
  	endfunction
 
  	task run_phase(uvm_phase phase);
    		super.run_phase(phase);

         	phase.raise_objection(this);
          	HDM_sequence_xtns_vseq = HDM_0_and_HDM_1_sequence_xtns_vseq::type_id::create("HDM_sequence_xtns_vseq");
          	HDM_sequence_xtns_vseq.start(envh.v_sequencer);
          	#1000;
         	phase.drop_objection(this);
          $display("\n\n\n------------------------------------------------HALF DUPLEX MULTIPLE------------------------------------------------\n\n\n");
  	endtask
endclass

class FD_0_and_FD_1_sequence_test extends base_test;
	`uvm_component_utils(FD_0_and_FD_1_sequence_test)
	
	//FD_0_and_FD_1_sequence_xtns_vseq FD_sequence_xtns_vseq;

 	function new(string name = "FD_0_and_FD_1_sequence_test", uvm_component parent);
		super.new(name, parent);
  	endfunction
 
  	task run_phase(uvm_phase phase);
    		super.run_phase(phase);

         	phase.raise_objection(this);
          	FD_sequence_xtns_vseq = FD_0_and_FD_1_sequence_xtns_vseq::type_id::create("FD_sequence_xtns_vseq");
          	FD_sequence_xtns_vseq.start(envh.v_sequencer);
          	#1000;
         	phase.drop_objection(this);
          
          $display("\n\n\n------------------------------------------------FULL DUPLEX------------------------------------------------\n\n\n");
  	endtask
endclass

class FDM_0_and_FDM_1_sequence_test extends base_test;
	`uvm_component_utils(FDM_0_and_FDM_1_sequence_test)
	
	//FDM_0_and_HDM_1_sequence_xtns_vseq FDM_sequence_xtns_vseq;

 	function new(string name = "FDM_0_and_FDM_1_sequence_test", uvm_component parent);
		super.new(name, parent);
  	endfunction
 
  	task run_phase(uvm_phase phase);
    		super.run_phase(phase);

         	phase.raise_objection(this);
          	FDM_sequence_xtns_vseq = FDM_0_and_FDM_1_sequence_xtns_vseq::type_id::create("FDM_sequence_xtns_vseq");
          	FDM_sequence_xtns_vseq.start(envh.v_sequencer);
          	#1000;
         	phase.drop_objection(this);
          $display("\n\n\n------------------------------------------------FULL DUPLEX MULTIPLE------------------------------------------------\n\n\n");
  	endtask
endclass

 
class FDLB_0_and_FDLB_1_sequence_test extends base_test;
	`uvm_component_utils(FDLB_0_and_FDLB_1_sequence_test)
	
	//FDLB_0_and_FDLB_1_sequence_xtns_vseq FDLB_sequence_xtns_vseq;

 	function new(string name = "FDLB_0_and_FDLB_1_sequence_test", uvm_component parent);
		super.new(name, parent);
  	endfunction
 
  	task run_phase(uvm_phase phase);
    		super.run_phase(phase);

         	phase.raise_objection(this);
          	FDLB_sequence_xtns_vseq = FDLB_0_and_FDLB_1_sequence_xtns_vseq::type_id::create("FDLB_sequence_xtns_vseq");
          	FDLB_sequence_xtns_vseq.start(envh.v_sequencer);
          	#1000;
         	phase.drop_objection(this);
          
          $display("\n\n\n------------------------------------------------FULL DUPLEX LOOPBACK------------------------------------------------\n\n\n");
  	endtask
endclass

class FDLBM_0_and_FDLBM_1_sequence_test extends base_test;
	`uvm_component_utils(FDLBM_0_and_FDLBM_1_sequence_test)
	
  	//FDLBM_0_and_FDLBM_1_sequence_xtns_vseq FDLBM_sequence_xtns_vseq;

 	function new(string name = "FDLBM_0_and_FDLBM_1_sequence_test", uvm_component parent);
		super.new(name, parent);
  	endfunction
 
  	task run_phase(uvm_phase phase);
    		super.run_phase(phase);

         	phase.raise_objection(this);
          	FDLBM_sequence_xtns_vseq = FDLBM_0_and_FDLBM_1_sequence_xtns_vseq::type_id::create("FDLBM_sequence_xtns_vseq");
          	FDLBM_sequence_xtns_vseq.start(envh.v_sequencer);
          	#1000;
         	phase.drop_objection(this);
          
          $display("\n\n\n------------------------------------------------FULL DUPLEX LOOPBACK MULTIPLE------------------------------------------------\n\n\n");
  	endtask
endclass

class FDM_0_thr_empty_and_FDM_1_thr_empty_sequence_test extends base_test;
	`uvm_component_utils(FDM_0_thr_empty_and_FDM_1_thr_empty_sequence_test)
	
  	//FDM_0_thr_empty_and_FDM_1_thr_empty_sequence_xtns_vseq FDM_thr_empty_sequence_xtns_vseq;

 	function new(string name = "FDM_0_thr_empty_and_FDM_1_thr_empty_sequence_test", uvm_component parent);
		super.new(name, parent);
  	endfunction
 
  	task run_phase(uvm_phase phase);
    		super.run_phase(phase);

         	phase.raise_objection(this);
          	FDM_thr_empty_sequence_xtns_vseq = FDM_0_thr_empty_and_FDM_1_thr_empty_sequence_xtns_vseq::type_id::create("FDM_thr_empty_sequence_xtns_vseq");
          	FDM_thr_empty_sequence_xtns_vseq.start(envh.v_sequencer);
          	#1000;
         	phase.drop_objection(this);
          $display("\n\n\n------------------------------------------------FULL DUPLEX MULTIPLE THR EMPTY------------------------------------------------\n\n\n");
  	endtask
endclass


class FDM_EP_0_and_FDM_EP_1_sequence_test extends base_test;
	`uvm_component_utils(FDM_EP_0_and_FDM_EP_1_sequence_test)
	
	//FDM_EP_0_and_FDM_EP_1_sequence_xtns_vseq FDM_EP_sequence_xtns_vseq;

 	function new(string name = "FDM_EP_0_and_FDM_EP_1_sequence_test", uvm_component parent);
		super.new(name, parent);
  	endfunction
 
  	task run_phase(uvm_phase phase);
    		super.run_phase(phase);

         	phase.raise_objection(this);
          	FDM_EP_sequence_xtns_vseq = FDM_EP_0_and_FDM_EP_1_sequence_xtns_vseq::type_id::create("FDM_EP_sequence_xtns_vseq");
          	FDM_EP_sequence_xtns_vseq.start(envh.v_sequencer);
          	#1000;
         	phase.drop_objection(this);
          $display("\n\n\n------------------------------------------------FULL DUPLEX MULTIPLE WITH EVEN PARITY------------------------------------------------\n\n\n");
  	endtask
endclass


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class FD_P_sequence_test extends base_test;
	`uvm_component_utils(FD_P_sequence_test)
	
	FD_P_sequence_vseq FD_vseq;

 	function new(string name = "FD_P_sequence_test", uvm_component parent);
		super.new(name, parent);
  	endfunction
 
  	task run_phase(uvm_phase phase);
    		super.run_phase(phase);

         	phase.raise_objection(this);
          	FD_vseq = FD_P_sequence_vseq::type_id::create("FD_vseq");
          	FD_vseq.start(envh.v_sequencer);
          	#1000;
         	phase.drop_objection(this);
          
          $display("\n\n\n------------------------------------------------FULL DUPLEX PARITY------------------------------------------------\n\n\n");
  	endtask
endclass

class FD_BE_sequence_test extends base_test;
	`uvm_component_utils(FD_BE_sequence_test)
	
	FD_BE_sequence_vseq FD_vseq;

 	function new(string name = "FD_BE_sequence_test", uvm_component parent);
		super.new(name, parent);
  	endfunction
 
  	task run_phase(uvm_phase phase);
    		super.run_phase(phase);

         	phase.raise_objection(this);
          	FD_vseq = FD_BE_sequence_vseq::type_id::create("FD_vseq");
          	FD_vseq.start(envh.v_sequencer);
          	#1000;
         	phase.drop_objection(this);
          
          $display("\n\n\n------------------------------------------------FULL DUPLEX BREAK ERROR------------------------------------------------\n\n\n");
  	endtask
endclass

class FD_ORE_sequence_test extends base_test;
	`uvm_component_utils(FD_ORE_sequence_test)
	
	FD_ORE_sequence_vseq FD_vseq;

 	function new(string name = "FD_ORE_sequence_test", uvm_component parent);
		super.new(name, parent);
  	endfunction
 
  	task run_phase(uvm_phase phase);
    		super.run_phase(phase);

         	phase.raise_objection(this);
          	FD_vseq = FD_ORE_sequence_vseq::type_id::create("FD_vseq");
          	FD_vseq.start(envh.v_sequencer);
          	#1000;
         	phase.drop_objection(this);
          
          $display("\n\n\n------------------------------------------------FULL DUPLEX OVERRUN ERROR------------------------------------------------\n\n\n");
  	endtask
endclass

class FD_FE_sequence_test extends base_test;
	`uvm_component_utils(FD_FE_sequence_test)
	
	FD_FE_sequence_vseq FD_vseq;

 	function new(string name = "FD_FE_sequence_test", uvm_component parent);
		super.new(name, parent);
  	endfunction
 
  	task run_phase(uvm_phase phase);
    		super.run_phase(phase);

         	phase.raise_objection(this);
          	FD_vseq = FD_FE_sequence_vseq::type_id::create("FD_vseq");
          	FD_vseq.start(envh.v_sequencer);
          	#1000;
         	phase.drop_objection(this);
          
          $display("\n\n\n------------------------------------------------FULL DUPLEX FRAMING ERROR------------------------------------------------\n\n\n");
  	endtask
endclass

class FD_TOE_sequence_test extends base_test;
	`uvm_component_utils(FD_TOE_sequence_test)
	
	FD_TOE_sequence_vseq FD_vseq;

 	function new(string name = "FD_TOE_sequence_test", uvm_component parent);
		super.new(name, parent);
  	endfunction
 
  	task run_phase(uvm_phase phase);
    		super.run_phase(phase);

         	phase.raise_objection(this);
          	FD_vseq = FD_TOE_sequence_vseq::type_id::create("FD_vseq");
          	FD_vseq.start(envh.v_sequencer);
          	#1000;
         	phase.drop_objection(this);
          
          $display("\n\n\n------------------------------------------------FULL DUPLEX TIME OUT ERROR------------------------------------------------\n\n\n");
  	endtask
endclass
