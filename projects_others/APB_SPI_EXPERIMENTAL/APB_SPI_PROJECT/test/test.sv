

class base_test extends uvm_test;

	`uvm_component_utils(base_test)

	function new (string name = "base_test",uvm_component parent);
		super.new(name,parent);
	endfunction 


	env_config env_cfg;
	apb_config apb_cfg[];
	spi_config spi_cfg[];
	environment env;


	int no_of_spi_agents = 1;
	int no_of_apb_agents = 1;
	bit [7:0] ctrl_reg_1;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		env_cfg = env_config::type_id::create("env_cfg",this);
		ctrl_reg_1= 8'b0001_0001;

		uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg_1",ctrl_reg_1);

		
	
		env_cfg.no_of_spi_agents = this.no_of_spi_agents;
		env_cfg.no_of_apb_agents = this.no_of_apb_agents;

		apb_cfg = new [no_of_apb_agents];
		spi_cfg = new [no_of_spi_agents];

		env_cfg.apb_cfg = new [no_of_apb_agents];
		env_cfg.spi_cfg = new [no_of_spi_agents];

		
		foreach(apb_cfg[i])
			begin 
			
				apb_cfg[i] = apb_config::type_id::create($sformatf("apb_cfg[%0d]",i),this);
			
				if(!uvm_config_db#(virtual apb_intf)::get(this,"","apb_intf",apb_cfg[i].apbf))
					`uvm_fatal("TEST","failed to get apb interface");

				
				if(i == 0)
					begin 
						apb_cfg[i].is_active = UVM_ACTIVE;
						uvm_config_db#(apb_config)::set(this,$sformatf("*apb_agt[%0d]*",i),"apb_config",apb_cfg[i]);
					end
				else 
					begin 
						apb_cfg[i].is_active = UVM_PASSIVE;
						uvm_config_db#(apb_config)::set(this,$sformatf("*apb_agt[%0d]*",i),"apb_config",apb_cfg[i]);
					end

				env_cfg.apb_cfg[i] = apb_cfg[i];

			end
	


		foreach(spi_cfg[i])
			begin 
				spi_cfg[i] = spi_config::type_id::create($sformatf("spi_cfg[%0d]",i),this);

				if(!uvm_config_db#(virtual spi_intf)::get(this,"","spi_intf",spi_cfg[i].spif))
					`uvm_fatal("TEST","failed to get spi interface");

				if(i == 0)
					begin
						spi_cfg[i].is_active = UVM_ACTIVE;
						uvm_config_db#(spi_config)::set(this,$sformatf("*spi_agt[%0d]*",i),"spi_config",spi_cfg[i]);
					end

				else
					begin 
						spi_cfg[i].is_active = UVM_PASSIVE;
						uvm_config_db#(spi_config)::set(this,$sformatf("*spi_agt[%0d]*",i),"spi_config",spi_cfg[i]);
					end
				
				env_cfg.spi_cfg[i] = spi_cfg[i];

			end

			uvm_config_db#(env_config)::set(this,"*","env_config",env_cfg);
						 
			env = environment::type_id::create("env",this);		
		
			
	endfunction


	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);

		uvm_top.print_topology();
		
	endfunction


endclass



class apb_rst_seq_test extends base_test;

	`uvm_component_utils(apb_rst_seq_test)

	function new (string name = "apb_rst_seq_test",uvm_component parent);
		super.new(name,parent);
	endfunction 

	apb_reset_sequence apb_rst_seq;
	bit [7:0] ctrl_reg_1;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		apb_rst_seq = apb_reset_sequence::type_id::create("apb_rst_seq");	
		ctrl_reg_1= 8'b0001_0001;

		uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg_1",ctrl_reg_1);
	

	endfunction 	

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		
			phase.raise_objection(this);
				apb_rst_seq.start(env.apb_agt_top.apb_agt[0].apb_seqr);	
			phase.drop_objection(this);
	endtask		
		

endclass


class cpol_cphase_00_test extends base_test;

	`uvm_component_utils(cpol_cphase_00_test)

	function new (string name = "cpol_cphase_00_test",uvm_component parent);
		super.new(name,parent);
	endfunction 

	cpol_cphase_00_apb cp_00_a;
	cpol_cphase_00_spi cp_00_s;
	status_read_seq s1;

	bit [7:0] ctrl_reg_1;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		cp_00_a = cpol_cphase_00_apb::type_id::create("cp_00_a");
		cp_00_s = cpol_cphase_00_spi::type_id::create("cp_00_s");
		s1=status_read_seq::type_id::create("s1");


		ctrl_reg_1= 8'b0101_0000;

		uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg_1",ctrl_reg_1);


	endfunction 	

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		
			phase.raise_objection(this);
			fork
				cp_00_s.start(env.spi_agt_top.spi_agt[0].spi_seqr);	
				cp_00_a.start(env.apb_agt_top.apb_agt[0].apb_seqr);	
			join
			#1000;	
				s1.start(env.apb_agt_top.apb_agt[0].apb_seqr);
			phase.drop_objection(this);
	endtask		
		

endclass


//////////////////////LOW POWER MODE/////////////////////////////


class low_power_mode_test extends base_test;

	`uvm_component_utils(low_power_mode_test)

	function new (string name = "low_power_mode_test",uvm_component parent);
		super.new(name,parent);
	endfunction 

	low_power_mode lpm;
	status_read_seq s1;
	cpol_cphase_00_spi cp_00_s;


	bit [7:0] ctrl_reg_1;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		lpm = low_power_mode::type_id::create("lpm");
		s1=status_read_seq::type_id::create("s1");
		cp_00_s = cpol_cphase_00_spi::type_id::create("cp_00_s");


		ctrl_reg_1= 8'b0001_0001;

		uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg_1",ctrl_reg_1);


	endfunction 	

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		
			phase.raise_objection(this);
			fork
				lpm.start(env.apb_agt_top.apb_agt[0].apb_seqr);
			//	cp_00_s.start(env.spi_agt_top.spi_agt[0].spi_seqr);		
				s1.start(env.apb_agt_top.apb_agt[0].apb_seqr);
			join
			phase.drop_objection(this);
	endtask		
		

endclass


