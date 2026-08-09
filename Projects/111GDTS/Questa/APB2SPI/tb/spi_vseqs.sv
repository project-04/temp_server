class spi_virt_sequence extends uvm_sequence #(uvm_sequence_item);
   `uvm_object_utils(spi_virt_sequence)

   //Properties
   spi_env_config m_cfg;

   spi_reg_block spi_rg_blk;

   spi_virt_sequencer v_seqrh;
	
   apb_sequencer apb_seqrh[];
   spi_sequencer spi_seqrh[];

   rand uvm_reg_data_t data;
   uvm_status_e status;

   //Methods
   extern function new(string name="spi_virt_sequence");
   extern task body();
 endclass

 function spi_virt_sequence :: new(string name="spi_virt_sequence");
   super.new(name);
 endfunction

 task spi_virt_sequence :: body();
   if(!uvm_config_db #(spi_env_config)::get(null, get_full_name(), "spi_env_config", m_cfg))
     `uvm_fatal(get_type_name(), "Cannot get m_cfg from uvm_config. Have you set it?")

   apb_seqrh = new[m_cfg.no_of_apb_agent];
   spi_seqrh = new[m_cfg.no_of_spi_agent];

   spi_rg_blk = m_cfg.spi_rg_blk;

   assert($cast(v_seqrh, m_sequencer))
   else
     `uvm_error(get_type_name(), "Error in cast of virtual sequencer")

   foreach(apb_seqrh[i])
     apb_seqrh[i]=v_seqrh.apb_seqrh[i];
   foreach(spi_seqrh[i])
     spi_seqrh[i]=v_seqrh.spi_seqrh[i];
 endtask

 //--------------- SPI Reset Virtual Sequence --------------------------
 /* Virtual sequence to start the apb_reset sequence and
   uvm_reg_hw_reset sequence */
 class spi_virt_reset_sequence extends spi_virt_sequence;
   `uvm_object_utils(spi_virt_reset_sequence)

   apb_reset_seqs apb_seqh;
   uvm_reg_hw_reset_seq rst_seq;
	
   //Standard UVM Methods
   extern function new(string name="spi_virt_reset_sequence");
   extern task body();
 endclass

 function spi_virt_reset_sequence :: new(string name="spi_virt_reset_sequence");
   super.new(name);
 endfunction

 task spi_virt_reset_sequence :: body();
   apb_seqh = apb_reset_seqs :: type_id :: create("apb_seqh");
   rst_seq = uvm_reg_hw_reset_seq :: type_id :: create("rst_seq");
   super.body();

   rst_seq.model = spi_rg_blk;
   rst_seq.start(apb_seqrh[0]);
   `uvm_info(get_type_name(), $sformatf("The Register Vaules in Register Block is \n %s",spi_rg_blk.sprint()), UVM_LOW)
	
   if(m_cfg.has_apb_agt)
     begin
       for(int i=0; i<m_cfg.no_of_apb_agent; i++)
	 apb_seqh.start(apb_seqrh[i]);
     end 
 endtask

 //--------------------- SPI VIRT CPHA1 CPOL1 Sequence ---------------------
 /* Virtual sequence to start the apb sequence and spi sequence on the 
    respective sequencers where control register values are set as
    cphase =1, cpol =1  and lsbfe =1                                     */
 class spi_virt_cpha1_cpol1_sequence extends spi_virt_sequence;
   `uvm_object_utils(spi_virt_cpha1_cpol1_sequence)

   apb_cpha1_cpol1_seqs apb_seqh;
   spi_cpha1_cpol1_seqs spi_seqh;

   //Standard UVM Methods
   extern function new(string name="spi_virt_cpha1_cpol1_sequence");
   extern task body();
 endclass

 function spi_virt_cpha1_cpol1_sequence :: new(string name="spi_virt_cpha1_cpol1_sequence");
   super.new(name);
 endfunction

 task spi_virt_cpha1_cpol1_sequence :: body();
   super.body();

   apb_seqh = apb_cpha1_cpol1_seqs :: type_id :: create("apb_seqh");
   spi_seqh = spi_cpha1_cpol1_seqs :: type_id :: create("spi_seqh");

   if(m_cfg.has_apb_agt)
     begin
       for(int i=0; i<m_cfg.no_of_apb_agent; i++)
	 apb_seqh.start(apb_seqrh[i]);
     end

   if(m_cfg.has_spi_agt)
     begin
       for(int i=0; i<m_cfg.no_of_spi_agent; i++)
	 spi_seqh.start(spi_seqrh[i]);
     end
 endtask

 //--------------------- SPI VIRT CPHA1 CPOL0 Sequence ---------------------
  /* Virtual sequence to start the apb sequence and spi sequence on the 
    respective sequencers where control register values are set as
    cphase =1, cpol =0  and lsbfe =1                                     */
 class spi_virt_cpha1_cpol0_sequence extends spi_virt_sequence;
   `uvm_object_utils(spi_virt_cpha1_cpol0_sequence)

   apb_cpha1_cpol0_seqs apb_seqh;
   spi_cpha1_cpol0_seqs spi_seqh;

   extern function new(string name="spi_virt_cpha1_cpol0_sequence");
   extern task body();
 endclass

 function spi_virt_cpha1_cpol0_sequence :: new(string name="spi_virt_cpha1_cpol0_sequence");
   super.new(name);
 endfunction

 task spi_virt_cpha1_cpol0_sequence :: body();
   super.body();

   apb_seqh = apb_cpha1_cpol0_seqs :: type_id :: create("apb_seqh");
   spi_seqh = spi_cpha1_cpol0_seqs :: type_id :: create("spi_seqh");

   if(m_cfg.has_apb_agt)
     begin
       for(int i=0; i<m_cfg.no_of_apb_agent; i++)
	 apb_seqh.start(apb_seqrh[i]);
     end

   if(m_cfg.has_spi_agt)
     begin
       for(int i=0; i<m_cfg.no_of_spi_agent; i++)
	 spi_seqh.start(spi_seqrh[i]);
     end
 endtask

 //---------------------SPI CPHA0 CPOL1 Sequence ----------------------
  /* Virtual sequence to start the apb sequence and spi sequence on the 
    respective sequencers where control register values are set as
    cphase =0, cpol =1  and lsbfe =1                                     */
 class spi_virt_cpha0_cpol1_sequence extends spi_virt_sequence;
   `uvm_object_utils(spi_virt_cpha0_cpol1_sequence)

   apb_cpha0_cpol1_seqs apb_seqh;
   spi_cpha0_cpol1_seqs spi_seqh;

   extern function new(string name="spi_virt_cpha0_cpol1_sequence");
   extern task body();
 endclass

 function spi_virt_cpha0_cpol1_sequence :: new(string name="spi_virt_cpha0_cpol1_sequence");
   super.new(name);
 endfunction

 task spi_virt_cpha0_cpol1_sequence :: body();
   super.body();

   apb_seqh = apb_cpha0_cpol1_seqs :: type_id :: create("apb_seqh");
   spi_seqh = spi_cpha0_cpol1_seqs :: type_id :: create("spi_seqh");

   if(m_cfg.has_apb_agt)
     begin
       for(int i=0; i<m_cfg.no_of_apb_agent; i++)
	 apb_seqh.start(apb_seqrh[i]);
     end
	
   if(m_cfg.has_spi_agt)
     begin
       for(int i=0; i<m_cfg.no_of_spi_agent; i++)
	 spi_seqh.start(spi_seqrh[i]);
     end
 endtask

 //---------------- SPI CPHA0 CPOL0 virtual sequence -----------------
  /* Virtual sequence to start the apb sequence and spi sequence on the 
    respective sequencers where control register values are set as
    cphase =0, cpol =0  and lsbfe =1                                     */
 class spi_virt_cpha0_cpol0_sequence extends spi_virt_sequence;
   `uvm_object_utils(spi_virt_cpha0_cpol0_sequence)

   apb_cpha0_cpol0_seqs apb_seqh;
   spi_cpha0_cpol0_seqs spi_seqh;
	
   extern function new(string name ="spi_virt_cpha0_cpol0_sequence");
   extern task body();
 endclass

 function spi_virt_cpha0_cpol0_sequence :: new(string name="spi_virt_cpha0_cpol0_sequence");
   super.new(name);
 endfunction

 task spi_virt_cpha0_cpol0_sequence :: body();
   super.body();

   apb_seqh = apb_cpha0_cpol0_seqs :: type_id :: create("apb_seqh");
   spi_seqh = spi_cpha0_cpol0_seqs :: type_id :: create("spi_seqh");

   if(m_cfg.has_apb_agt)
     begin
       for(int i=0; i<m_cfg.no_of_apb_agent; i++)
	 apb_seqh.start(apb_seqrh[i]);
     end

   if(m_cfg.has_spi_agt)
     begin
       for(int i=0; i<m_cfg.no_of_spi_agent; i++)
	 spi_seqh.start(spi_seqrh[i]);
     end
 endtask

 //--------------------- SPI VIRT CPHA1 CPOL1 LSBFE0 Sequence ---------------------
  /* Virtual sequence to start the apb sequence and spi sequence on the 
    respective sequencers where control register values are set as
    cphase =1, cpol =1  and lsbfe =0                                     */
 
 class spi_virt_cpha1_cpol1_lsbfe0_sequence extends spi_virt_sequence;
   `uvm_object_utils(spi_virt_cpha1_cpol1_lsbfe0_sequence)

   apb_cpha1_cpol1_lsbfe0_seqs apb_seqh;
   spi_cpha1_cpol1_lsbfe0_seqs spi_seqh;

   //Standard UVM Methods
   extern function new(string name="spi_virt_cpha1_cpol1_lsbfe0_sequence");
   extern task body();
 endclass

 function spi_virt_cpha1_cpol1_lsbfe0_sequence :: new(string name="spi_virt_cpha1_cpol1_lsbfe0_sequence");
   super.new(name);
 endfunction

 task spi_virt_cpha1_cpol1_lsbfe0_sequence :: body();
   super.body();

   apb_seqh = apb_cpha1_cpol1_lsbfe0_seqs :: type_id :: create("apb_seqh");
   spi_seqh = spi_cpha1_cpol1_lsbfe0_seqs :: type_id :: create("spi_seqh");

   if(m_cfg.has_apb_agt)
     begin
       for(int i=0; i<m_cfg.no_of_apb_agent; i++)
	 apb_seqh.start(apb_seqrh[i]);
     end

   if(m_cfg.has_spi_agt)
     begin
       for(int i=0; i<m_cfg.no_of_spi_agent; i++)
	 spi_seqh.start(spi_seqrh[i]);
     end
 endtask

 //--------------------- SPI VIRT CPHA1 CPOL0 LSBFE0 Sequence ---------------------
  /* Virtual sequence to start the apb sequence and spi sequence on the 
    respective sequencers where control register values are set as
    cphase =1, cpol =0 and lsbfe =0                                     */
 class spi_virt_cpha1_cpol0_lsbfe0_sequence extends spi_virt_sequence;
   `uvm_object_utils(spi_virt_cpha1_cpol0_lsbfe0_sequence)

   apb_cpha1_cpol0_lsbfe0_seqs apb_seqh;
   spi_cpha1_cpol0_lsbfe0_seqs spi_seqh;

   //Standard UVM Methods
   extern function new(string name="spi_virt_cpha1_cpol0_lsbfe0_sequence");
   extern task body();
 endclass

 function spi_virt_cpha1_cpol0_lsbfe0_sequence :: new(string name="spi_virt_cpha1_cpol0_lsbfe0_sequence");
   super.new(name);
 endfunction

 task spi_virt_cpha1_cpol0_lsbfe0_sequence :: body();
   super.body();

   apb_seqh = apb_cpha1_cpol0_lsbfe0_seqs :: type_id :: create("apb_seqh");
   spi_seqh = spi_cpha1_cpol0_lsbfe0_seqs :: type_id :: create("spi_seqh");

   if(m_cfg.has_apb_agt)
     begin
       for(int i=0; i<m_cfg.no_of_apb_agent; i++)
	 apb_seqh.start(apb_seqrh[i]);
     end

   if(m_cfg.has_spi_agt)
     begin
       for(int i=0; i<m_cfg.no_of_spi_agent; i++)
       spi_seqh.start(spi_seqrh[i]);
     end
 endtask

 //--------------------- SPI VIRT CPHA0 CPOL1 LSBFE0 Sequence ---------------------
  /* Virtual sequence to start the apb sequence and spi sequence on the 
    respective sequencers where control register values are set as
    cphase =0, cpol =1  and lsbfe =0                                    */
 class spi_virt_cpha0_cpol1_lsbfe0_sequence extends spi_virt_sequence;
   `uvm_object_utils(spi_virt_cpha0_cpol1_lsbfe0_sequence)

   apb_cpha0_cpol1_lsbfe0_seqs apb_seqh;
   spi_cpha0_cpol1_lsbfe0_seqs spi_seqh;

   //Standard UVM Methods
   extern function new(string name="spi_virt_cpha0_cpol1_lsbfe0_sequence");
   extern task body();
 endclass

 function spi_virt_cpha0_cpol1_lsbfe0_sequence :: new(string name="spi_virt_cpha0_cpol1_lsbfe0_sequence");
   super.new(name);
 endfunction

 task spi_virt_cpha0_cpol1_lsbfe0_sequence :: body();
   super.body();

   apb_seqh = apb_cpha0_cpol1_lsbfe0_seqs :: type_id :: create("apb_seqh");
   spi_seqh = spi_cpha0_cpol1_lsbfe0_seqs :: type_id :: create("spi_seqh");

   if(m_cfg.has_apb_agt)
     begin
       for(int i=0; i<m_cfg.no_of_apb_agent; i++)
	 apb_seqh.start(apb_seqrh[i]);
     end

   if(m_cfg.has_spi_agt)
     begin
       for(int i=0; i<m_cfg.no_of_spi_agent; i++)
	 spi_seqh.start(spi_seqrh[i]);
     end
 endtask

 //--------------------- SPI VIRT CPHA0 CPOL0 LSBFE0 Sequence ---------------------
  /* Virtual sequence to start the apb sequence and spi sequence on the 
    respective sequencers where control register values are set as
    cphase =0, cpol =0  and lsbfe =0                                     */
 class spi_virt_cpha0_cpol0_lsbfe0_sequence extends spi_virt_sequence;
   `uvm_object_utils(spi_virt_cpha0_cpol0_lsbfe0_sequence)

   apb_cpha0_cpol0_lsbfe0_seqs apb_seqh;
   spi_cpha0_cpol0_lsbfe0_seqs spi_seqh;

   //Standard UVM Method
   extern function new(string name="spi_virt_cpha0_cpol0_lsbfe0_sequence");
   extern task body();
 endclass

 function spi_virt_cpha0_cpol0_lsbfe0_sequence :: new(string name="spi_virt_cpha0_cpol0_lsbfe0_sequence");
   super.new(name);
 endfunction

 task spi_virt_cpha0_cpol0_lsbfe0_sequence :: body();
   super.body();

   apb_seqh = apb_cpha0_cpol0_lsbfe0_seqs :: type_id :: create("apb_seqh");
   spi_seqh = spi_cpha0_cpol0_lsbfe0_seqs :: type_id :: create("spi_seqh");

   if(m_cfg.has_apb_agt)
     begin
       for(int i=0; i<m_cfg.no_of_apb_agent; i++)
	 apb_seqh.start(apb_seqrh[i]);
     end

   if(m_cfg.has_spi_agt)
     begin
       for(int i=0; i<m_cfg.no_of_spi_agent; i++)
	 spi_seqh.start(spi_seqrh[i]);
     end
 endtask

 //--------------------- SPI VIRT low power mode Sequence ---------------------
 /* Virtual sequence to start the apb sequence on the apb sequencer when 
    control register is set to operate in a low power mode */
 class spi_virt_low_power_mode_sequence extends spi_virt_sequence;
   `uvm_object_utils(spi_virt_low_power_mode_sequence)

   apb_low_power_mode_seqs apb_seqh;

   //Standard UVM Method
   extern function new(string name="spi_virt_low_power_mode_sequence");
   extern task body();

 endclass

 function spi_virt_low_power_mode_sequence :: new(string name="spi_virt_low_power_mode_sequence");
   super.new(name);
 endfunction

 task spi_virt_low_power_mode_sequence :: body();
   super.body();

   apb_seqh = apb_low_power_mode_seqs :: type_id :: create("apb_seqh");

   if(m_cfg.has_apb_agt)
     begin
       for(int i=0; i<m_cfg.no_of_apb_agent; i++)
	 apb_seqh.start(apb_seqrh[i]);
     end
 endtask

 //------------------ SPI Virtual read data register sequence -------------------------
 /* Virtual sequence to start the apb read sequence on the apb sequencer */
 class spi_virt_data_reg_read_sequence extends spi_virt_sequence;
   `uvm_object_utils(spi_virt_data_reg_read_sequence)

   apb_data_read_seqs read_seqh;

   extern function new(string name="spi_virt_data_reg_read_sequence");
   extern task body();
 endclass

 function spi_virt_data_reg_read_sequence :: new(string name="spi_virt_data_reg_read_sequence");
   super.new(name);
 endfunction

 task spi_virt_data_reg_read_sequence :: body();
   super.body();

   read_seqh = apb_data_read_seqs :: type_id :: create("read_seqh");
   if(m_cfg.has_apb_agt)
     begin
       for(int i=0; i<m_cfg.no_of_apb_agent;i++)
	 read_seqh.start(apb_seqrh[i]);
     end
 endtask

 //--------------------- SPI VIRT Random Mode Sequence ---------------------
  /* Virtual sequence to start the apb sequence and spi sequence on the 
    respective sequencers where control register values are set randomly*/
 class spi_virt_random_mode_sequence extends spi_virt_sequence;
   `uvm_object_utils(spi_virt_random_mode_sequence)

   apb_rand_mode_seqs apb_seqh;
   spi_rand_mode_seqs spi_seqh;

   //Standard UVM Method
   extern function new(string name="spi_virt_random_mode_sequence");
   extern task body();
 endclass

 function spi_virt_random_mode_sequence :: new(string name="spi_virt_random_mode_sequence");
   super.new(name);
 endfunction

 task spi_virt_random_mode_sequence :: body();
   super.body();

   apb_seqh = apb_rand_mode_seqs :: type_id :: create("apb_seqh");
   spi_seqh = spi_rand_mode_seqs :: type_id :: create("spi_seqh");

   if(m_cfg.has_apb_agt)
     begin
       for(int i=0; i<m_cfg.no_of_apb_agent; i++)
	 apb_seqh.start(apb_seqrh[i]);
     end

   if(m_cfg.has_spi_agt)
     begin
       for(int i=0; i<m_cfg.no_of_spi_agent; i++)
	 spi_seqh.start(spi_seqrh[i]);
     end
 endtask

 //--------------------- SPI VIRT Random Sequence ---------------------
  /* Virtual sequence to start the apb sequence and spi sequence on the 
    respective sequencers where control register values are set randomly*/
 class spi_virt_random_sequence extends spi_virt_sequence;
   `uvm_object_utils(spi_virt_random_sequence)

   apb_rand_seqs apb_seqh;
   spi_rand_seqs spi_seqh;

   //Standard UVM Method
   extern function new(string name="spi_virt_random_sequence");
   extern task body();
 endclass

 function spi_virt_random_sequence :: new(string name="spi_virt_random_sequence");
   super.new(name);
 endfunction

 task spi_virt_random_sequence :: body();
   super.body();

   apb_seqh = apb_rand_seqs :: type_id :: create("apb_seqh");
   spi_seqh = spi_rand_seqs :: type_id :: create("spi_seqh");

   if(m_cfg.has_apb_agt)
     begin
       for(int i=0; i<m_cfg.no_of_apb_agent; i++)
	 apb_seqh.start(apb_seqrh[i]);
     end

   if(m_cfg.has_spi_agt)
     begin
       for(int i=0; i<m_cfg.no_of_spi_agent; i++)
	 spi_seqh.start(spi_seqrh[i]);
     end
 endtask





