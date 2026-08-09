class apb_seqs extends uvm_sequence #(apb_xtn);
   `uvm_object_utils(apb_seqs)

   spi_env_config m_cfg;
   spi_reg_block reg_block;

   uvm_status_e status;
   logic [7:0] d1, d2, d3, d4, d5;

   extern function new(string name="apb_seqs");
   extern task body();
 endclass

 function apb_seqs :: new(string name="apb_seqs");
   super.new(name);
 endfunction

 task apb_seqs :: body();


   if(!uvm_config_db #(spi_env_config)::get(null, get_full_name(), "spi_env_config", m_cfg))
     `uvm_fatal(get_type_name(), "Cannot get env_cfg inside sequence class")

   this.reg_block = m_cfg.spi_rg_blk;

 endtask


/*************************  reset sequence  *****************************/

 class apb_reset_seqs extends apb_seqs;
   `uvm_object_utils(apb_reset_seqs)

   bit [7:0] ctrl;

   extern function new(string name="apb_reset_seqs");
   extern task body();
 endclass

 function apb_reset_seqs :: new(string name ="apb_reset_seqs");
   super.new(name);
 endfunction

 task apb_reset_seqs :: body();
   super.body();

   if(!uvm_config_db#(bit[7:0])::get(null, get_full_name(), "bit[7:0]", ctrl))
     `uvm_fatal(get_type_name(), "Cannot get ctrl which is set in test")

       d1= ctrl;
       d2=8'b0001_1000;
       d3=8'b0001_0001;

       req = apb_xtn :: type_id :: create("req");
       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b0;})
       finish_item(req);

       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b001;})
       finish_item(req);

       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b010;})
       finish_item(req);

       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b011;})
       finish_item(req);

       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b101;})
       finish_item(req);
 endtask


/***************************    CPHA1 =1 & CPOL = 1 inside control reg 1 & lsb=1  **************************/


 class apb_cpha1_cpol1_seqs extends apb_seqs;
   `uvm_object_utils(apb_cpha1_cpol1_seqs)

   bit [7:0] ctrl;

   extern function new(string name="apb_cpha1_cpol1_seqs");
   extern task body();
 endclass

 function apb_cpha1_cpol1_seqs::new(string name="apb_cpha1_cpol1_seqs");
   super.new(name);
 endfunction

 task apb_cpha1_cpol1_seqs :: body();
   super.body();

   if(!uvm_config_db#(bit[7:0])::get(null, get_full_name(), "bit[7:0]", ctrl))
     `uvm_fatal(get_type_name(), "Cannot get ctrl which is set in test")
	
       req = apb_xtn :: type_id :: create("req");
       d1= ctrl;
       d2=8'b0001_1000;
       d3=8'b0001_0001;

       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR!=3'b101;})
       finish_item(req);

       this.reg_block.cntr_reg1.write(status,d1,.path(UVM_BACKDOOR),.map(reg_block.spi_reg_map),.parent(this));
       this.reg_block.cntr_reg2.write(status,d2,.path(UVM_BACKDOOR),.map(reg_block.spi_reg_map),.parent(this));
       this.reg_block.baud_reg.write(status,d3,.path(UVM_BACKDOOR),.map(reg_block.spi_reg_map),.parent(this));

			
       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b101;})
       finish_item(req);
 endtask

/***************************    CPHA1 =1 & CPOL = 0 inside control reg 1 & lsb=1  **************************/

 class apb_cpha1_cpol0_seqs extends apb_seqs;
   `uvm_object_utils(apb_cpha1_cpol0_seqs)

   bit[7:0] ctrl;

   extern function new(string name="apb_cpha1_cpol0_seqs");
   extern task body();
 endclass

 function apb_cpha1_cpol0_seqs :: new(string name="apb_cpha1_cpol0_seqs");
   super.new(name);
 endfunction

 task apb_cpha1_cpol0_seqs :: body();
   super.body();

   if(!uvm_config_db#(bit[7:0])::get(null, get_full_name(), "bit[7:0]", ctrl))
     `uvm_fatal(get_type_name(), "Cannot get ctrl which is set in test")

       req = apb_xtn :: type_id :: create("req");
       d1= ctrl;
       d2=8'b0001_1001;
       d3=8'b0000_0001;

       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR!=3'b101;})
       finish_item(req);

       this.reg_block.cntr_reg1.write(status,d1,.path(UVM_BACKDOOR),.map(reg_block.spi_reg_map),.parent(this));
       this.reg_block.cntr_reg2.write(status,d2,.path(UVM_BACKDOOR),.map(reg_block.spi_reg_map),.parent(this));
       this.reg_block.baud_reg.write(status,d3,.path(UVM_BACKDOOR),.map(reg_block.spi_reg_map),.parent(this));

	
       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b101;})
       finish_item(req);
 endtask

/***************************    CPHA1 =0 & CPOL = 1 inside control reg 1 & lsb=1  **************************/

 class apb_cpha0_cpol1_seqs extends apb_seqs;
   `uvm_object_utils(apb_cpha0_cpol1_seqs)

   bit [7:0] ctrl;
   extern function new(string name="apb_cpha0_cpol1_seqs");
   extern task body();
 endclass

 function apb_cpha0_cpol1_seqs :: new(string name="apb_cpha0_cpol1_seqs");
   super.new(name);
 endfunction

 task apb_cpha0_cpol1_seqs :: body();
   super.body();
	
   if(!uvm_config_db #(bit[7:0])::get(null, get_full_name(), "bit[7:0]", ctrl))
     `uvm_fatal(get_type_name(), "Cannot get ctrl which is set in test")

       req = apb_xtn :: type_id :: create("req");
       d1=ctrl;	
       d2=8'b0000_1001;
       d3=8'b0010_0000;
			
       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR!=3'b101;});
       finish_item(req);

       this.reg_block.cntr_reg1.write(status,d1,.path(UVM_BACKDOOR),.map(reg_block.spi_reg_map),.parent(this));
       this.reg_block.cntr_reg2.write(status,d2,.path(UVM_BACKDOOR),.map(reg_block.spi_reg_map),.parent(this));
       this.reg_block.baud_reg.write(status,d3,.path(UVM_BACKDOOR),.map(reg_block.spi_reg_map),.parent(this));

       reg_block.spi_reg_cg.sample(d1, d2, d3);
	
       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b101;})
       finish_item(req);
 endtask

/***************************    CPHA1 =0 & CPOL = 0 inside control reg 1 & lsb=1   **************************/

 class apb_cpha0_cpol0_seqs extends apb_seqs;
   `uvm_object_utils(apb_cpha0_cpol0_seqs)

   bit [7:0] ctrl;
   extern function new(string name="apb_cpha0_cpol0_seqs");
   extern task body();
 endclass

 function apb_cpha0_cpol0_seqs :: new(string name="apb_cpha0_cpol0_seqs");
   super.new(name);
 endfunction

 task apb_cpha0_cpol0_seqs :: body();
   super.body();
	
   if(!uvm_config_db #(bit[7:0])::get(null, get_full_name(), "bit[7:0]", ctrl))
     `uvm_fatal(get_type_name(), "Cannot get ctrl which is set in test")

       req = apb_xtn :: type_id :: create("req");
       d1=ctrl;	
       d2=8'b0000_0001;
       d3=8'b0110_0000;
			
       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0;PADDR!=3'b101;});
       finish_item(req);

       this.reg_block.cntr_reg1.write(status,d1,.path(UVM_BACKDOOR),.map(reg_block.spi_reg_map),.parent(this));
       this.reg_block.cntr_reg2.write(status,d2,.path(UVM_BACKDOOR),.map(reg_block.spi_reg_map),.parent(this));
       this.reg_block.baud_reg.write(status,d3,.path(UVM_BACKDOOR),.map(reg_block.spi_reg_map),.parent(this));

	
       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b101;})
       finish_item(req);
 endtask


/***************************    CPHA1 =1 & CPOL = 1 inside control reg 1 with lsb=0  **************************/
 class apb_cpha1_cpol1_lsbfe0_seqs extends apb_seqs;
   `uvm_object_utils(apb_cpha1_cpol1_lsbfe0_seqs)
   
   bit[7:0] ctrl;

   extern function new(string name="apb_cpha1_cpol1_lsbfe0_seqs");
   extern task body();
 endclass

 function apb_cpha1_cpol1_lsbfe0_seqs :: new(string name="apb_cpha1_cpol1_lsbfe0_seqs");
   super.new(name);
 endfunction

 task apb_cpha1_cpol1_lsbfe0_seqs :: body();
   super.body();

   if(!uvm_config_db#(bit[7:0])::get(null, get_full_name(), "bit[7:0]", ctrl))
     `uvm_fatal(get_type_name(), "Cannot get ctrl which is set in test")

	
       req = apb_xtn :: type_id :: create("req");
       d1= ctrl;
       d2=8'b0001_1011;
       d3=8'b0001_0010;

       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR!=3'b101;})
       finish_item(req);

       this.reg_block.cntr_reg1.write(status,d1,.path(UVM_BACKDOOR),.map(reg_block.spi_reg_map),.parent(this));
       this.reg_block.cntr_reg2.write(status,d2,.path(UVM_BACKDOOR),.map(reg_block.spi_reg_map),.parent(this));
       this.reg_block.baud_reg.write(status,d3,.path(UVM_BACKDOOR),.map(reg_block.spi_reg_map),.parent(this));

	
       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b101;})
       finish_item(req);
 endtask


/***************************    CPHA1 =1 & CPOL = 0 inside control reg 1 with lsb=0  **************************/

 class apb_cpha1_cpol0_lsbfe0_seqs extends apb_seqs;
   `uvm_object_utils(apb_cpha1_cpol0_lsbfe0_seqs)

   bit[7:0] ctrl;

   extern function new(string name="apb_cpha1_cpol0_lsbfe0_seqs");
   extern task body();
 endclass

 function apb_cpha1_cpol0_lsbfe0_seqs :: new(string name="apb_cpha1_cpol0_lsbfe0_seqs");
   super.new(name);
 endfunction

 task apb_cpha1_cpol0_lsbfe0_seqs :: body();
   super.body();

   if(!uvm_config_db#(bit[7:0])::get(null, get_full_name(), "bit[7:0]", ctrl))
     `uvm_fatal(get_type_name(), "Cannot get ctrl which is set in test")

	
       req = apb_xtn :: type_id :: create("req");

       d1= ctrl;
       d2=8'b0001_1001;
       d3=8'b0100_0000;

       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR!=3'b101;})
       finish_item(req);

       this.reg_block.cntr_reg1.write(status,d1,.path(UVM_BACKDOOR),.map(reg_block.spi_reg_map),.parent(this));
       this.reg_block.cntr_reg2.write(status,d2,.path(UVM_BACKDOOR),.map(reg_block.spi_reg_map),.parent(this));
       this.reg_block.baud_reg.write(status,d3,.path(UVM_BACKDOOR),.map(reg_block.spi_reg_map),.parent(this));
	

       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b101;})
       finish_item(req);
 endtask


/***************************    CPHA1 =0 & CPOL = 1 inside control reg 1 with lsb=0  **************************/

 class apb_cpha0_cpol1_lsbfe0_seqs extends apb_seqs;
   `uvm_object_utils(apb_cpha0_cpol1_lsbfe0_seqs)

   bit[7:0] ctrl;

   extern function new(string name="apb_cpha0_cpol1_lsbfe0_seqs");
   extern task body();
 endclass

 function apb_cpha0_cpol1_lsbfe0_seqs :: new(string name="apb_cpha0_cpol1_lsbfe0_seqs");
   super.new(name);
 endfunction

 task apb_cpha0_cpol1_lsbfe0_seqs :: body();
   super.body();

   if(!uvm_config_db#(bit[7:0])::get(null, get_full_name(), "bit[7:0]", ctrl))
     `uvm_fatal(get_type_name(), "Cannot get ctrl which is set in test")

       req = apb_xtn :: type_id :: create("req");

       d1= ctrl;
       d2=8'b0001_1001;
       d3=8'b0100_0001;

       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR!=3'b101;})
       finish_item(req);

       this.reg_block.cntr_reg1.write(status,d1,.path(UVM_BACKDOOR),.map(reg_block.spi_reg_map),.parent(this));
       this.reg_block.cntr_reg2.write(status,d2,.path(UVM_BACKDOOR),.map(reg_block.spi_reg_map),.parent(this));
       this.reg_block.baud_reg.write(status,d3,.path(UVM_BACKDOOR),.map(reg_block.spi_reg_map),.parent(this));

       reg_block.spi_reg_cg.sample(d1, d2, d3);

       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b101;})
       finish_item(req);
 endtask

/***************************    CPHA1 =0 & CPOL = 0 inside control reg 1 with lsb=0  **************************/
 class apb_cpha0_cpol0_lsbfe0_seqs extends apb_seqs;
   `uvm_object_utils(apb_cpha0_cpol0_lsbfe0_seqs)

   bit[7:0] ctrl;

   extern function new(string name="apb_cpha0_cpol0_lsbfe0_seqs");
   extern task body();
 endclass

 function apb_cpha0_cpol0_lsbfe0_seqs :: new(string name="apb_cpha0_cpol0_lsbfe0_seqs");
   super.new(name);
 endfunction

 task apb_cpha0_cpol0_lsbfe0_seqs :: body();
   super.body();

   if(!uvm_config_db#(bit[7:0])::get(null, get_full_name(), "bit[7:0]", ctrl))
     `uvm_fatal(get_type_name(), "Cannot get ctrl which is set in test")

       req = apb_xtn :: type_id :: create("req");
       d1= ctrl;
       d2=8'b0001_1000;
       d3=8'b0011_0010;

       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR!=3'b101;})
       finish_item(req);

       this.reg_block.cntr_reg1.write(status, d1, .path(UVM_BACKDOOR), .map(reg_block.spi_reg_map), .parent(this));
       this.reg_block.cntr_reg2.write(status, d2, .path(UVM_BACKDOOR), .map(reg_block.spi_reg_map), .parent(this));
       this.reg_block.baud_reg.write(status, d3, .path(UVM_BACKDOOR), .map(reg_block.spi_reg_map), .parent(this));

       reg_block.spi_reg_cg.sample(d1, d2, d3);

       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b101;})
       finish_item(req);
 endtask


/*******************************    SPE = 0 & SPISWAI = 1 (low power mode) *******************************/

 class apb_low_power_mode_seqs extends apb_seqs;
   `uvm_object_utils(apb_low_power_mode_seqs)

   bit[7:0] ctrl;
   rand bit [2:0] spr;
   rand bit [2:0] sppr;

   extern function new(string name="apb_low_power_mode_seqs");
   extern task body();
 endclass

 function apb_low_power_mode_seqs :: new(string name="apb_low_power_mode_seqs");
   super.new(name);
 endfunction

 task apb_low_power_mode_seqs :: body();
   super.body();

   if(!uvm_config_db#(bit[7:0])::get(null, get_full_name(), "bit[7:0]", ctrl))
     `uvm_fatal(get_type_name(), "Cannot get ctrl which is set in test")

       this.randomize() with {spr inside{[0:7]}; sppr inside{[0:7]};};

       req = apb_xtn :: type_id :: create("req");
       d1= ctrl;
       d2=8'b0001_1011;
       d3={1'b0, sppr, 1'b0, spr};

       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR!=3'b101;})
       finish_item(req);

       this.reg_block.cntr_reg1.write(status, d1, .path(UVM_BACKDOOR), .map(reg_block.spi_reg_map), .parent(this));
       this.reg_block.cntr_reg2.write(status, d2, .path(UVM_BACKDOOR), .map(reg_block.spi_reg_map), .parent(this));
       this.reg_block.baud_reg.write(status, d3, .path(UVM_BACKDOOR), .map(reg_block.spi_reg_map), .parent(this));


       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b101;})
       finish_item(req);
 endtask

 //--------------- apb low mode sequence -------------
 /* In this sequence, we are generating the sequence to enter a low power mode.
    Low power mode will be achieved by making SPE bit as 0 and SPISWAI bit as 1
    SPR and SPPR fields are taken with random values. 
   
    Control register1, control register2 and baud register are updated by backdoor read method
    
    sequence to generate the random data to update for data register */
 class apb_low_mode_seqs extends apb_seqs;
   `uvm_object_utils(apb_low_mode_seqs)

   bit[7:0] ctrl;

   extern function new(string name="apb_low_mode_seqs");
   extern task body();
 endclass

 function apb_low_mode_seqs :: new(string name="apb_low_mode_seqs");
   super.new(name);
 endfunction

 task apb_low_mode_seqs :: body();
   super.body();

   if(!uvm_config_db#(bit[7:0])::get(null, get_full_name(), "bit[7:0]", ctrl))
     `uvm_fatal(get_type_name(), "Cannot get ctrl from uvm_config_db. Have you set it?")

   repeat(1)
     begin

       req = apb_xtn :: type_id :: create("req");
       d1= ctrl;
       d2=8'b0001_1001;


       this.reg_block.cntr_reg1.write(status, d1, .path(UVM_BACKDOOR), .map(reg_block.spi_reg_map), .parent(this));
       this.reg_block.cntr_reg2.write(status, d2, .path(UVM_BACKDOOR), .map(reg_block.spi_reg_map), .parent(this));

       reg_block.spi_reg_cg.sample(d1, d2, d3);
     end
 endtask


 //------------------- Data Register Read Sequence -------------------------
 class apb_data_read_seqs extends apb_seqs;
   `uvm_object_utils(apb_data_read_seqs)

   extern function new(string name="apb_data_read_seqs");
   extern task body();	
 endclass

 function apb_data_read_seqs :: new(string name ="apb_data_read_seqs");
   super.new(name);
 endfunction

 task apb_data_read_seqs :: body();
   super.body();
   repeat(1)
     begin
       req = apb_xtn :: type_id :: create("req");
       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b101;})
       finish_item(req);
     end
 endtask

 //-------------------- APB Rand Mode seqs ----------------------------
    
 class apb_rand_mode_seqs extends apb_seqs;
   `uvm_object_utils(apb_rand_mode_seqs)

   bit [7:0] ctrl;
   rand bit [2:0] spr;
   rand bit [2:0] sppr;
   rand bit [1:0] swai_spco;
   rand bit [1:0] modfen_bidiroe;
   extern function new(string name="apb_rand_mode_seqs");
   extern task body();
 endclass

 function apb_rand_mode_seqs :: new(string name="apb_rand_mode_seqs");
   super.new(name);
 endfunction

 task apb_rand_mode_seqs :: body();
   super.body();
	
   if(!uvm_config_db #(bit[7:0])::get(null, get_full_name(), "bit[7:0]", ctrl))
     `uvm_fatal(get_type_name(), "Cannot get ctrl from uvm_config_db. Have you set it?")

       if(!this.randomize() with {spr inside{[0:7]}; sppr inside{[0:7]}; modfen_bidiroe inside{[0:3]}; swai_spco inside {0,1};})
	 `uvm_fatal(get_type_name(),"Randomization failed in apb_sequence")

       req = apb_xtn :: type_id :: create("req");
       d1=ctrl;	
       d2={3'b000, modfen_bidiroe, 1'b0, swai_spco};
       d3={1'b0, sppr, 1'b0, spr};
			
       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0;PADDR!=3'b101;});
       finish_item(req);

       this.reg_block.cntr_reg1.write(status, d1, .path(UVM_BACKDOOR), .map(reg_block.spi_reg_map), .parent(this));
       this.reg_block.cntr_reg2.write(status, d2, .path(UVM_BACKDOOR), .map(reg_block.spi_reg_map), .parent(this));
       this.reg_block.baud_reg.write(status, d3, .path(UVM_BACKDOOR), .map(reg_block.spi_reg_map), .parent(this));

       reg_block.spi_reg_cg.sample(d1, d2, d3);
	
       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b101;})
       finish_item(req);
 endtask

 //-------------------- APB Rand Mode seqs ----------------------------
    
 class apb_rand_seqs extends apb_seqs;
   `uvm_object_utils(apb_rand_seqs)

   bit [7:0] ctrl;
   rand bit [2:0] spr;
   rand bit [2:0] sppr;
   rand bit [1:0] swai_spco;
   rand bit [1:0] modfen_bidiroe;
   extern function new(string name="apb_rand_seqs");
   extern task body();
 endclass

 function apb_rand_seqs :: new(string name="apb_rand_seqs");
   super.new(name);
 endfunction

 task apb_rand_seqs :: body();
   super.body();
	
   if(!uvm_config_db #(bit[7:0])::get(null, get_full_name(), "bit[7:0]", ctrl))
     `uvm_fatal(get_type_name(), "Cannot get ctrl from uvm_config_db. Have you set it?")

   repeat(1)
     begin
       if(!this.randomize() with {spr inside{[0:7]}; sppr inside{[0:7]}; modfen_bidiroe inside{[0:3]}; swai_spco inside {0,1};})
	       `uvm_fatal(get_type_name(),"Randomization failed in apb_sequence")

       req = apb_xtn :: type_id :: create("req");
       d1=ctrl;	
       d2={3'b000, modfen_bidiroe, 1'b0, swai_spco};
       d3={1'b0, sppr, 1'b0, spr};

       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0;PADDR!=3'b101;});
       finish_item(req);

       this.reg_block.cntr_reg1.write(status, d1, .path(UVM_BACKDOOR), .map(reg_block.spi_reg_map), .parent(this));
       this.reg_block.cntr_reg2.write(status, d2, .path(UVM_BACKDOOR), .map(reg_block.spi_reg_map), .parent(this));
       this.reg_block.baud_reg.write(status, d3, .path(UVM_BACKDOOR), .map(reg_block.spi_reg_map), .parent(this));

       reg_block.spi_reg_cg.sample(d1, d2, d3);
	
       start_item(req);
       assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b101;})
       finish_item(req);
     end
 endtask

