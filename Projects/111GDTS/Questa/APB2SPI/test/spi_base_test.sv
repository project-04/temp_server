class spi_test extends uvm_test;
   `uvm_component_utils(spi_test)
	
   // Properties
   spi_env env_h;
   spi_env_config m_cfg;

   bit has_apb_agt=1;
   bit has_spi_agt=1;

   int no_of_apb_agent=1;
   int no_of_spi_agent=1;

   apb_agent_config apb_cfg[];
   spi_agent_config spi_cfg[];

   spi_reg_block spi_rg_blk;

   bit [7:0] ctrl;

   //Methods
   extern function new(string name="spi_test", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void config_tb();
 endclass

 function spi_test :: new(string name="spi_test", uvm_component parent);
   super.new(name, parent);
 endfunction

 function void spi_test :: config_tb();
   if(has_apb_agt)
     begin
       apb_cfg=new[no_of_apb_agent];
			
       foreach(apb_cfg[i])
	 begin
	   apb_cfg[i]=apb_agent_config :: type_id :: create($sformatf("apb_cfg[%0d]",i));
	   if(!uvm_config_db #(virtual apb_intf)::get(this, "", "apb_intf", apb_cfg[i].apb_if))
	     `uvm_fatal(get_type_name(),"Cannot get m_cfg from uvm_confif_db. Have you set it?")

	   apb_cfg[i].is_active = UVM_ACTIVE;
	   m_cfg.apb_cfg[i]=apb_cfg[i];
	 end
     end

   if(has_spi_agt)
     begin
       spi_cfg = new[no_of_spi_agent];

       foreach(spi_cfg[i])
	 begin
	   spi_cfg[i]=spi_agent_config :: type_id :: create($sformatf("spi_cfg[%0d]", i));
	   if(!uvm_config_db #(virtual spi_intf)::get(this, "", "spi_intf", spi_cfg[i].spi_if))
	     `uvm_fatal(get_type_name(), "Cannot get m_cfg from uvm_config_db. Have you set it?")

	   spi_cfg[i].is_active = UVM_ACTIVE;
	   m_cfg.spi_cfg[i]=spi_cfg[i];
         end
     end

   m_cfg.has_apb_agt = has_apb_agt;
   m_cfg.has_spi_agt = has_spi_agt;
   m_cfg.no_of_apb_agent = no_of_apb_agent;
   m_cfg.no_of_spi_agent = no_of_spi_agent;
   m_cfg.has_scoreboard=1;
   m_cfg.has_virtual_sequencer =1;
 endfunction

 function void spi_test::build_phase(uvm_phase phase);
   m_cfg = spi_env_config :: type_id :: create("m_cfg");

   uvm_reg :: include_coverage("*", UVM_CVR_ALL);

   spi_rg_blk = spi_reg_block::type_id::create("spi_rg_blk");
   spi_rg_blk.build();
   m_cfg.spi_rg_blk = this.spi_rg_blk;

   if(has_apb_agt)
     m_cfg.apb_cfg=new[no_of_apb_agent];

   if(has_spi_agt)
     m_cfg.spi_cfg=new[no_of_spi_agent];

   config_tb();
	
   uvm_config_db #(spi_env_config)::set(this, "*", "spi_env_config", m_cfg);
	
   super.build_phase(phase);

   env_h = spi_env :: type_id :: create("env_h", this);

   ctrl = 8'b1111_1111;

   uvm_config_db #(bit[7:0])::set(this, "*", "bit[7:0]", ctrl);
 endfunction

 //-----------------------SPI RESET Test---------------------
 /* Test case to verify reset operation of the SPI Module */
 class spi_reset_test extends spi_test;
   `uvm_component_utils(spi_reset_test)

   spi_virt_reset_sequence rst_seqh;
	
   bit [7:0] ctrl;
   bit reset_test;

   extern function new(string name="spi_reset_test", uvm_component parent);
   extern function void build_phase(uvm_phase phase);	
   extern task run_phase(uvm_phase phase);
 endclass

 function spi_reset_test :: new(string name ="spi_reset_test", uvm_component parent);
   super.new(name, parent);
 endfunction

 function void spi_reset_test ::build_phase(uvm_phase phase);
   super.build_phase(phase);
 endfunction

 task spi_reset_test :: run_phase(uvm_phase phase);
   phase.raise_objection(this);
     begin
       ctrl = 8'b1110_1111;
       reset_test=1'b1;

       uvm_config_db #(bit[7:0])::set(this, "*", "bit[7:0]", ctrl);
       uvm_config_db #(bit)::set(this, "*", "bit", reset_test);

       rst_seqh = spi_virt_reset_sequence :: type_id :: create("rst_seqh");
       rst_seqh.start(env_h.v_seqrh);
     end
   phase.drop_objection(this);
 endtask

 //-------------------SPI CPHA1 CPOL1 test ----------------------------
 /* Test case to verify the operation of the SPI module when cphase is 1
  and cpol is 1 and lsbfe is 1 */
 class spi_cpha1_cpol1_test extends spi_test;
   `uvm_component_utils(spi_cpha1_cpol1_test)

   spi_virt_cpha1_cpol1_sequence cpha1_cpol1_seqh;
   spi_virt_data_reg_read_sequence read_seqh;

   bit [7:0] ctrl;

   extern function new(string name="spi_cpha1_cpol1_test", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
 endclass

 function spi_cpha1_cpol1_test :: new(string name="spi_cpha1_cpol1_test", uvm_component parent);
   super.new(name, parent);
 endfunction

 function void spi_cpha1_cpol1_test :: build_phase(uvm_phase phase);
   super.build_phase(phase);
 endfunction

 task spi_cpha1_cpol1_test :: run_phase(uvm_phase phase);
   repeat(5)
     begin
       phase.raise_objection(this);
	 begin
	   ctrl = 8'b1111_1111;
           uvm_config_db #(bit[7:0])::set(this, "*", "bit[7:0]", ctrl);

	   cpha1_cpol1_seqh = spi_virt_cpha1_cpol1_sequence :: type_id :: create("cpha1_cpol1_seqh");
	   read_seqh = spi_virt_data_reg_read_sequence :: type_id :: create("read_seqh");

	   cpha1_cpol1_seqh.start(env_h.v_seqrh);
	   #400;
	   read_seqh.start(env_h.v_seqrh);
	   #100;
   	 end
       phase.drop_objection(this);
     end
 endtask

 //------------------- SPI CPHA1 CPOL0 test -----------------------------------
 /* Test case to verify the operation of the SPI module when cphase is 1,
    cpol is 0 and lsbfe is 1 */
 class spi_cpha1_cpol0_test extends spi_test;
   `uvm_component_utils(spi_cpha1_cpol0_test)

   spi_virt_cpha1_cpol0_sequence cpha1_cpol0_seqh;
   spi_virt_data_reg_read_sequence read_seqh;

   bit [7:0] ctrl;

   extern function new(string name ="spi_cpha1_cpol0_test", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
 endclass

 function spi_cpha1_cpol0_test :: new(string name="spi_cpha1_cpol0_test", uvm_component parent);
   super.new(name, parent);
 endfunction

 function void spi_cpha1_cpol0_test :: build_phase(uvm_phase phase);
   super.build_phase(phase);
 endfunction

 task spi_cpha1_cpol0_test :: run_phase(uvm_phase phase);
   repeat(5)
     begin
       phase.raise_objection(this);
	 begin	
	   ctrl = 8'b1111_0111;
           uvm_config_db #(bit[7:0])::set(this, "*", "bit[7:0]", ctrl);

	   cpha1_cpol0_seqh = spi_virt_cpha1_cpol0_sequence::type_id::create("cpha1_cpol0_seqh");
	   read_seqh = spi_virt_data_reg_read_sequence :: type_id :: create("read_seqh");

	   cpha1_cpol0_seqh.start(env_h.v_seqrh);
	   #500;
	   read_seqh.start(env_h.v_seqrh);
	   #100;
         end
       phase.drop_objection(this);
     end
 endtask

 //------------------SPI Cphase 0 and Cpol1 Test -----------------
 /* Test case to verify the working of a SPI Module when cphase is 0,
    cpol is 1 and lsbfe is 1 */
 class spi_cpha0_cpol1_test extends spi_test;
   `uvm_component_utils(spi_cpha0_cpol1_test)

   spi_virt_cpha0_cpol1_sequence cpha0_cpol1_seqh;
   spi_virt_data_reg_read_sequence read_seqh;

   bit [7:0] ctrl;

   extern function new(string name="spi_cpha0_cpol1_test", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
 endclass

 function spi_cpha0_cpol1_test :: new(string name="spi_cpha0_cpol1_test", uvm_component parent);
   super.new(name, parent);
 endfunction

 function void spi_cpha0_cpol1_test :: build_phase(uvm_phase phase);
   super.build_phase(phase);
 endfunction

 task spi_cpha0_cpol1_test :: run_phase(uvm_phase phase);
   repeat(5)
     begin
       phase.raise_objection(this);
	 begin
	   ctrl = 8'b1011_1011;
           uvm_config_db #(bit[7:0])::set(this, "*", "bit[7:0]", ctrl);
			
           cpha0_cpol1_seqh = spi_virt_cpha0_cpol1_sequence :: type_id :: create("cpha0_cpol1_seqh");
	   read_seqh = spi_virt_data_reg_read_sequence :: type_id :: create("read_seqh");

	   cpha0_cpol1_seqh.start(env_h.v_seqrh);
	   #500;
           read_seqh.start(env_h.v_seqrh);
	   #100;
	 end
       phase.drop_objection(this);
     end
 endtask

 //-------------- SPI Cphase 0 and CPOL 0 test ---------------------
 /* Test case to verify the operation of the SPI Module when cphase is 0
    cpol is 0 and lsbfe is 1 */
 class spi_cpha0_cpol0_test extends spi_test;
   `uvm_component_utils(spi_cpha0_cpol0_test)

   spi_virt_cpha0_cpol0_sequence cpha0_cpol0_seqh;
   spi_virt_data_reg_read_sequence read_seqh;

   bit [7:0] ctrl;

   extern function new(string name="spi_cpha0_cpol0_test", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
 endclass

 function spi_cpha0_cpol0_test :: new(string name="spi_cpha0_cpol0_test", uvm_component parent);
   super.new(name, parent);
 endfunction

 function void spi_cpha0_cpol0_test :: build_phase(uvm_phase phase);
   super.build_phase(phase);
 endfunction

 task spi_cpha0_cpol0_test :: run_phase(uvm_phase phase);
   repeat(5)
     begin
       phase.raise_objection(this);
	 begin
	   ctrl = 8'b0001_0011;
	   uvm_config_db#(bit[7:0])::set(this, "*", "bit[7:0]", ctrl);
			
           cpha0_cpol0_seqh = spi_virt_cpha0_cpol0_sequence :: type_id :: create("cpha0_cpol0_seqh");
	   read_seqh = spi_virt_data_reg_read_sequence :: type_id :: create("read_seqh");

	   cpha0_cpol0_seqh.start(env_h.v_seqrh);
	   #500;
	   read_seqh.start(env_h.v_seqrh);
           #100;
         end
       phase.drop_objection(this);
     end
 endtask

 //-------------------SPI CPHA1 CPOL1 LSBFE0 test ----------------------------
 /* Testcase to verify the operation of the SPI module when cphase is 1,
    cpol is 1 and lsbfe is 0 */
 class spi_cpha1_cpol1_lsbfe0_test extends spi_test;
   `uvm_component_utils(spi_cpha1_cpol1_lsbfe0_test)

   spi_virt_cpha1_cpol1_lsbfe0_sequence cpha1_cpol1_seqh;
   spi_virt_data_reg_read_sequence read_seqh;

   bit [7:0] ctrl;

   extern function new(string name="spi_cpha1_cpol1_lsbfe0_test", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
 endclass

 function spi_cpha1_cpol1_lsbfe0_test :: new(string name="spi_cpha1_cpol1_lsbfe0_test", uvm_component parent);
   super.new(name, parent);
 endfunction

 function void spi_cpha1_cpol1_lsbfe0_test :: build_phase(uvm_phase phase);
   super.build_phase(phase);
 endfunction

 task spi_cpha1_cpol1_lsbfe0_test :: run_phase(uvm_phase phase);
   repeat(5)
     begin
       phase.raise_objection(this);
	 begin
	   ctrl = 8'b0101_1100;
           uvm_config_db #(bit[7:0])::set(this, "*", "bit[7:0]", ctrl);

	   cpha1_cpol1_seqh = spi_virt_cpha1_cpol1_lsbfe0_sequence :: type_id :: create("cpha1_cpol1_seqh");
	   read_seqh = spi_virt_data_reg_read_sequence :: type_id :: create("read_seqh");

	   cpha1_cpol1_seqh.start(env_h.v_seqrh);
	   #500;
	   read_seqh.start(env_h.v_seqrh);
	   #100;
         end
       phase.drop_objection(this);
     end
 endtask

 //-------------------SPI CPHA1 CPOL0 LSBFE0 test ----------------------------
 /* Test case to verify the operation of SPI Module when control register1 is
    set with cphase as 1, cpol as 0 dnd lsbfe as 0 */
 class spi_cpha1_cpol0_lsbfe0_test extends spi_test;
   `uvm_component_utils(spi_cpha1_cpol0_lsbfe0_test)

   spi_virt_cpha1_cpol0_lsbfe0_sequence cpha1_cpol0_seqh;
   spi_virt_data_reg_read_sequence read_seqh;

   bit [7:0] ctrl;

   extern function new(string name="spi_cpha1_cpol0_lsbfe0_test", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
 endclass

 function spi_cpha1_cpol0_lsbfe0_test :: new(string name="spi_cpha1_cpol0_lsbfe0_test", uvm_component parent);
   super.new(name, parent);
 endfunction

 function void spi_cpha1_cpol0_lsbfe0_test :: build_phase(uvm_phase phase);
   super.build_phase(phase);
 endfunction

 task spi_cpha1_cpol0_lsbfe0_test :: run_phase(uvm_phase phase);
   repeat(5)
     begin
       phase.raise_objection(this);
	 begin
	   ctrl = 8'b0011_0110;
           uvm_config_db #(bit[7:0])::set(this, "*", "bit[7:0]", ctrl);

	   cpha1_cpol0_seqh = spi_virt_cpha1_cpol0_lsbfe0_sequence :: type_id :: create("cpha1_cpol0_seqh");
	   read_seqh = spi_virt_data_reg_read_sequence :: type_id :: create("read_seqh");

	   cpha1_cpol0_seqh.start(env_h.v_seqrh);
	   #500;
	   read_seqh.start(env_h.v_seqrh);
	   #100;
         end
       phase.drop_objection(this);
     end
 endtask

 //-------------------SPI CPHA0 CPOL1 LSBFE0 test ----------------------------
 /* Testcase to verify the operation of the SPI Module when control register1
    is set with cphase as 0, cpol as 1 and lsbfe as 1 */
 class spi_cpha0_cpol1_lsbfe0_test extends spi_test;
   `uvm_component_utils(spi_cpha0_cpol1_lsbfe0_test)

   spi_virt_cpha0_cpol1_lsbfe0_sequence cpha0_cpol1_seqh;
   spi_virt_data_reg_read_sequence read_seqh;

   bit [7:0] ctrl;

   extern function new(string name="spi_cpha0_cpol1_lsbfe0_test", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
 endclass

 function spi_cpha0_cpol1_lsbfe0_test :: new(string name="spi_cpha0_cpol1_lsbfe0_test", uvm_component parent);
   super.new(name, parent);
 endfunction

 function void spi_cpha0_cpol1_lsbfe0_test :: build_phase(uvm_phase phase);
   super.build_phase(phase);
 endfunction

 task spi_cpha0_cpol1_lsbfe0_test :: run_phase(uvm_phase phase);
   repeat(5)
     begin
       phase.raise_objection(this);
	 begin
	   ctrl = 8'b0101_1010;
           uvm_config_db #(bit[7:0])::set(this, "*", "bit[7:0]", ctrl);

	   cpha0_cpol1_seqh = spi_virt_cpha0_cpol1_lsbfe0_sequence :: type_id :: create("cpha0_cpol1_seqh");
	   read_seqh = spi_virt_data_reg_read_sequence :: type_id :: create("read_seqh");

	   cpha0_cpol1_seqh.start(env_h.v_seqrh);
	   #500;
	   read_seqh.start(env_h.v_seqrh);
	   #100;
         end
       phase.drop_objection(this);
     end
 endtask

 //-------------------SPI CPHA0 CPOL0 LSBFE0 test ----------------------------
 /* Test case to verify the operation of the SPI module when control  register1
    is set with cphase as 0, cpol as 0 and lsbfe as 0 */
 class spi_cpha0_cpol0_lsbfe0_test extends spi_test;
   `uvm_component_utils(spi_cpha0_cpol0_lsbfe0_test)

   spi_virt_cpha0_cpol0_lsbfe0_sequence cpha0_cpol0_seqh;
   spi_virt_data_reg_read_sequence read_seqh;

   bit [7:0] ctrl;

   extern function new(string name="spi_cpha0_cpol0_lsbfe0_test", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
 endclass

 function spi_cpha0_cpol0_lsbfe0_test :: new(string name="spi_cpha0_cpol0_lsbfe0_test", uvm_component parent);
   super.new(name, parent);
 endfunction

 function void spi_cpha0_cpol0_lsbfe0_test :: build_phase(uvm_phase phase);
   super.build_phase(phase);
 endfunction

 task spi_cpha0_cpol0_lsbfe0_test :: run_phase(uvm_phase phase);
   repeat(5)
     begin
       phase.raise_objection(this);
	 begin
	   ctrl = 8'b1111_0000;
           uvm_config_db #(bit[7:0])::set(this, "*", "bit[7:0]", ctrl);

	   cpha0_cpol0_seqh = spi_virt_cpha0_cpol0_lsbfe0_sequence :: type_id :: create("cpha0_cpol0_seqh");
	   read_seqh = spi_virt_data_reg_read_sequence :: type_id :: create("read_seqh");
	   cpha0_cpol0_seqh.start(env_h.v_seqrh);
	   #800;
	   read_seqh.start(env_h.v_seqrh);
	   #100;
         end
       phase.drop_objection(this);
     end
 endtask

 //-------------------SPI low power mode test ----------------------------
 /* Testcase to verify the low power mode operation of the SPI Module */
 class spi_low_power_mode_test extends spi_test;
   `uvm_component_utils(spi_low_power_mode_test)

   spi_virt_low_power_mode_sequence low_pwr_seqh;
   spi_virt_data_reg_read_sequence read_seqh;

   bit [7:0] ctrl;
   bit [1:0] low_pwr_mode;

   extern function new(string name="spi_low_power_mode_test", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
 endclass

 function spi_low_power_mode_test :: new(string name="spi_low_power_mode_test", uvm_component parent);
   super.new(name, parent);
 endfunction

 function void spi_low_power_mode_test :: build_phase(uvm_phase phase);
   super.build_phase(phase);
 endfunction

 task spi_low_power_mode_test :: run_phase(uvm_phase phase);
   repeat(15)
     begin
       phase.raise_objection(this);
	 begin
	   ctrl = 8'b0001_1101;
           low_pwr_mode=2'b01;
           uvm_config_db #(bit[7:0])::set(this, "*", "bit[7:0]", ctrl);
	   uvm_config_db #(bit[1:0])::set(this, "*", "bit[1:0]", low_pwr_mode);

	   low_pwr_seqh = spi_virt_low_power_mode_sequence :: type_id :: create("low_pwr_seqh");
	   read_seqh = spi_virt_data_reg_read_sequence :: type_id :: create("read_seqh");
	   low_pwr_seqh.start(env_h.v_seqrh);
	   #600;
	   read_seqh.start(env_h.v_seqrh);
	   #100;
	 end
       phase.drop_objection(this);
     end
 endtask

 //-------------------SPI Random Mode Test Case  ----------------------------
 /* Testcase to verify the opearation of the SPI Module when the control register1
    is set with random values */
 class spi_random_mode_test extends spi_test;
   `uvm_component_utils(spi_random_mode_test)

   spi_virt_random_mode_sequence random_seqh;
   spi_virt_data_reg_read_sequence read_seqh;

   bit [7:0] ctrl;

   extern function new(string name="spi_random_mode_test", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
 endclass

 function spi_random_mode_test :: new(string name="spi_random_mode_test", uvm_component parent);
   super.new(name, parent);
 endfunction

 function void spi_random_mode_test :: build_phase(uvm_phase phase);
   super.build_phase(phase);
 endfunction
 
 task spi_random_mode_test :: run_phase(uvm_phase phase);
   repeat(50)
     begin
       phase.raise_objection(this);
	 begin
	   ctrl = 8'b1111_1111;
           uvm_config_db #(bit[7:0])::set(this, "*", "bit[7:0]", ctrl);

	   random_seqh = spi_virt_random_mode_sequence :: type_id :: create("random_seqh");
	   read_seqh = spi_virt_data_reg_read_sequence :: type_id :: create("read_seqh");
	   random_seqh.start(env_h.v_seqrh);
	   #29000;
	   read_seqh.start(env_h.v_seqrh);
	   #100;
	 end
       phase.drop_objection(this);
     end
 endtask

 //-------------------SPI Random Test Case  ----------------------------
  /* Testcase to verify the opearation of the SPI Module when the control register1
    is set with random values */
 class spi_random_test extends spi_test;
   `uvm_component_utils(spi_random_test)

   spi_virt_random_sequence random_seqh;
   spi_virt_data_reg_read_sequence read_seqh;

   bit [7:0] ctrl;

   extern function new(string name="spi_random_test", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
 endclass

 function spi_random_test :: new(string name="spi_random_test", uvm_component parent);
   super.new(name, parent);
 endfunction

 function void spi_random_test :: build_phase(uvm_phase phase);
   super.build_phase(phase);
 endfunction

 task spi_random_test :: run_phase(uvm_phase phase);
   repeat(50)
     begin
       phase.raise_objection(this);
	 begin
	   ctrl =8'b1111_0000;
	   uvm_config_db #(bit[7:0])::set(this, "*", "bit[7:0]", ctrl);

	   random_seqh = spi_virt_random_sequence :: type_id :: create("random_seqh");
	   read_seqh = spi_virt_data_reg_read_sequence :: type_id :: create("read_seqh");
	   random_seqh.start(env_h.v_seqrh);
	   #35000;
	   read_seqh.start(env_h.v_seqrh);
	   #100;
	 end
       phase.drop_objection(this);
     end
 endtask

 

