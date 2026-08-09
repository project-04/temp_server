class spi_seqs extends uvm_sequence #(spi_xtn);
   `uvm_object_utils(spi_seqs)

   spi_env_config m_cfg;
   spi_reg_block spi_rg_blk;

   extern function new(string name="spi_seqs");
   extern task body();
 endclass

 function spi_seqs :: new(string name="spi_seqs");
   super.new(name);
 endfunction

 task spi_seqs :: body();
   if(!uvm_config_db #(spi_env_config)::get(null, get_full_name(), "spi_env_config", m_cfg))
     `uvm_fatal(get_type_name(), "Cannot get m_cfg from uvm_config_db. Have you set it?")

   this.spi_rg_blk = m_cfg.spi_rg_blk;
 endtask

//------------------ SPI CPHA1 CPOL1 SEQUENCE ------------------
  /* Sequence to generate the random MISO data */

 class spi_cpha1_cpol1_seqs extends spi_seqs;
   `uvm_object_utils(spi_cpha1_cpol1_seqs)

   extern function new(string name="spi_cpha1_cpol1_seqs");
   extern task body();
 endclass

 function spi_cpha1_cpol1_seqs :: new(string name="spi_cpha1_cpol1_seqs");
   super.new(name);
 endfunction

 task spi_cpha1_cpol1_seqs :: body();
   super.body();

   repeat(1)
     begin
       req = spi_xtn :: type_id :: create("req");
       start_item(req);
       assert(req.randomize());
       finish_item(req);
     end
 endtask

 //----------------- SPI CPHA1 CPOL1 SEQUENCE -------------------
  /* Sequence to generate the random MISO data */

 class spi_cpha1_cpol0_seqs extends spi_seqs;
   `uvm_object_utils(spi_cpha1_cpol0_seqs)

   extern function new(string name="spi_cpha1_cpol0_seqs");
   extern task body();
 endclass

 function spi_cpha1_cpol0_seqs :: new(string name="spi_cpha1_cpol0_seqs");
   super.new(name);
 endfunction

 task spi_cpha1_cpol0_seqs :: body();
   super.body();

   repeat(1)
     begin
       req = spi_xtn :: type_id :: create("req");
       start_item(req);
       assert(req.randomize());
       finish_item(req);
     end
 endtask

 //----------------- SPI CPHA0 CPOL1 SEQUENCE -------------------
  /* Sequence to generate the random MISO data */

 class spi_cpha0_cpol1_seqs extends spi_seqs;
   `uvm_object_utils(spi_cpha0_cpol1_seqs)

   extern function new(string name="spi_cpha0_cpol1_seqs");
   extern task body();
 endclass

 function spi_cpha0_cpol1_seqs :: new(string name="spi_cpha0_cpol1_seqs");
   super.new(name);
 endfunction

 task spi_cpha0_cpol1_seqs :: body();
   super.body();
   repeat(1)
     begin
       req = spi_xtn :: type_id :: create("req");
       start_item(req);
       assert(req.randomize());
       finish_item(req);
     end
 endtask

 //----------------- SPI CPHA0 CPOL0 SEQUENCE -------------------
  /* Sequence to generate the random MISO data */

 class spi_cpha0_cpol0_seqs extends spi_seqs;
   `uvm_object_utils(spi_cpha0_cpol0_seqs)

   extern function new(string name="spi_cpha0_cpol0_seqs");
   extern task body();
 endclass

 function spi_cpha0_cpol0_seqs :: new(string name="spi_cpha0_cpol0_seqs");
   super.new(name);
 endfunction

 task spi_cpha0_cpol0_seqs :: body();
   super.body();
   repeat(1)
     begin
       req = spi_xtn :: type_id :: create("req");
       start_item(req);
       assert(req.randomize());
       finish_item(req);
     end
 endtask

 //------------------ SPI CPHA1 CPOL1 LSBFE0 SEQUENCE ------------------
  /* Sequence to generate the random MISO data */

 class spi_cpha1_cpol1_lsbfe0_seqs extends spi_seqs;
   `uvm_object_utils(spi_cpha1_cpol1_lsbfe0_seqs)

   extern function new(string name="spi_cpha1_cpol1_lsbfe0_seqs");
   extern task body();
 endclass

 function spi_cpha1_cpol1_lsbfe0_seqs :: new(string name="spi_cpha1_cpol1_lsbfe0_seqs");
   super.new(name);
 endfunction

 task spi_cpha1_cpol1_lsbfe0_seqs :: body();
   super.body();

   repeat(1)
     begin
       req = spi_xtn :: type_id :: create("req");
       start_item(req);
       assert(req.randomize());
       finish_item(req);
     end
 endtask

 //------------------ SPI CPHA1 CPOL0 LSBFE0 SEQUENCE ------------------
  /* Sequence to generate the random MISO data */

 class spi_cpha1_cpol0_lsbfe0_seqs extends spi_seqs;
   `uvm_object_utils(spi_cpha1_cpol0_lsbfe0_seqs)

   extern function new(string name="spi_cpha1_cpol0_lsbfe0_seqs");
   extern task body();
 endclass

 function spi_cpha1_cpol0_lsbfe0_seqs :: new(string name="spi_cpha1_cpol0_lsbfe0_seqs");
   super.new(name);
 endfunction

 task spi_cpha1_cpol0_lsbfe0_seqs :: body();
   super.body();
   repeat(1)
     begin
       req = spi_xtn :: type_id :: create("req");
       start_item(req);
       assert(req.randomize());
       finish_item(req);
     end
 endtask

 //------------------ SPI CPHA0 CPOL1 LSBFE0 SEQUENCE ------------------
  /* Sequence to generate the random MISO data */
class spi_cpha0_cpol1_lsbfe0_seqs extends spi_seqs;
   `uvm_object_utils(spi_cpha0_cpol1_lsbfe0_seqs)

   extern function new(string name="spi_cpha0_cpol1_lsbfe0_seqs");
   extern task body();
 endclass

 function spi_cpha0_cpol1_lsbfe0_seqs :: new(string name="spi_cpha0_cpol1_lsbfe0_seqs");
   super.new(name);
 endfunction

 task spi_cpha0_cpol1_lsbfe0_seqs :: body();
   super.body();

   repeat(1)
     begin
       req = spi_xtn :: type_id :: create("req");
       start_item(req);
       assert(req.randomize());
       finish_item(req);
     end
 endtask

 //------------------ SPI CPHA0 CPOL0 LSBFE0 SEQUENCE ------------------
  /* Sequence to generate the random MISO data */
class spi_cpha0_cpol0_lsbfe0_seqs extends spi_seqs;
   `uvm_object_utils(spi_cpha0_cpol0_lsbfe0_seqs)

   extern function new(string name="spi_cpha0_cpol0_lsbfe0_seqs");
   extern task body();
 endclass

 function spi_cpha0_cpol0_lsbfe0_seqs :: new(string name="spi_cpha0_cpol0_lsbfe0_seqs");
   super.new(name);
 endfunction

 task spi_cpha0_cpol0_lsbfe0_seqs :: body();
   super.body();

   repeat(1)
     begin
       req = spi_xtn :: type_id :: create("req");
       start_item(req);
       assert(req.randomize());
       finish_item(req);
     end
 endtask


 //------------------ SPI Random mode SEQUENCE ------------------
  /* Sequence to generate the random MISO data */
class spi_rand_mode_seqs extends spi_seqs;
   `uvm_object_utils(spi_rand_mode_seqs)

   extern function new(string name="spi_rand_mode_seqs");
   extern task body();
 endclass

 function spi_rand_mode_seqs :: new(string name="spi_rand_mode_seqs");
   super.new(name);
 endfunction

 task spi_rand_mode_seqs :: body();
   super.body();

   repeat(1)
     begin
       req = spi_xtn :: type_id :: create("req");
       start_item(req);
       assert(req.randomize());
       finish_item(req);
     end
 endtask

 //------------------ SPI Random SEQUENCE ------------------
  /* Sequence to generate the random MISO data */
class spi_rand_seqs extends spi_seqs;
   `uvm_object_utils(spi_rand_seqs)

   extern function new(string name="spi_rand_seqs");
   extern task body();
 endclass

 function spi_rand_seqs :: new(string name="spi_rand_seqs");
   super.new(name);
 endfunction

 task spi_rand_seqs :: body();
   super.body();

   repeat(1)
     begin
       req = spi_xtn :: type_id :: create("req");
       start_item(req);
       assert(req.randomize());
       finish_item(req);
     end
 endtask

 
