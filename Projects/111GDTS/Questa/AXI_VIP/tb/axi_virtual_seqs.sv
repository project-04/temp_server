class axi_base_seqs extends uvm_sequence #(uvm_sequence_item);
      `uvm_object_utils(axi_base_seqs)

      axi_env_config env_cfg_h;
      virtual_sequencer vseqr_h;

      master_sequencer mst_seqrh[];
      slave_sequencer slv_seqrh[];

      extern function new(string name="axi_base_seqs");
      extern task body();
endclass


     function axi_base_seqs::new(string name="axi_base_seqs");
          super.new(name);
     endfunction

     task axi_base_seqs::body();
         if(!uvm_config_db#(axi_env_config)::get(null,get_full_name(),"axi_env_config",env_cfg_h))
             `uvm_fatal("axi base sequence","Unable to get axi env config, have you set it?")
         assert($cast(vseqr_h,m_sequencer))
             else
                 `uvm_error("axi base seqs task body","m_sequencer and axi sequencer are of different types")
         mst_seqrh=new[env_cfg_h.no_of_master];
         slv_seqrh=new[env_cfg_h.no_of_slave];

         foreach(mst_seqrh[i])
             mst_seqrh=vseqr_h.mst_seqr_h;

         foreach(slv_seqrh[i])
             slv_seqrh=vseqr_h.slv_seqr_h;
     endtask

//================================fixed burst type virtual sequence==============================================//
class vseq_fixed extends axi_base_seqs;
    `uvm_object_utils(vseq_fixed)

     master_seq_fixed m_seq;
     extern function new(string name="vseq_fixed");
     extern task body();
endclass

    function vseq_fixed::new(string name="vseq_fixed");
        super.new(name);
    endfunction

    task vseq_fixed::body();
        super.body();
        m_seq=master_seq_fixed::type_id::create("m_seq");
        fork
           m_seq.start(mst_seqrh[0]);
        join
    endtask
	
//================================increment burst type virtual sequence==============================================//
class vseq_incr extends axi_base_seqs;
    `uvm_object_utils(vseq_incr)

     master_seq_incr m_seq;
     extern function new(string name="vseq_incr");
     extern task body();
endclass

    function vseq_incr::new(string name="vseq_incr");
        super.new(name);
    endfunction

    task vseq_incr::body();
        super.body();
        m_seq=master_seq_incr::type_id::create("m_seq");
        fork
           m_seq.start(mst_seqrh[0]);
        join
    endtask
	
//================================wraping burst type virtual sequence==============================================//
class vseq_wrap extends axi_base_seqs;
    `uvm_object_utils(vseq_wrap)

     master_seq_wrap m_seq;
     extern function new(string name="vseq_wrap");
     extern task body();
endclass

    function vseq_wrap::new(string name="vseq_wrap");
        super.new(name);
    endfunction

    task vseq_wrap::body();
        super.body();
        m_seq=master_seq_wrap::type_id::create("m_seq");
        fork
           m_seq.start(mst_seqrh[0]);
        join
    endtask
	
//================================randoming burst type virtual sequence==============================================//
class vseq_random extends axi_base_seqs;
    `uvm_object_utils(vseq_random)

     master_seq_random m_seq;
     extern function new(string name="vseq_random");
     extern task body();
endclass

    function vseq_random::new(string name="vseq_random");
        super.new(name);
    endfunction

    task vseq_random::body();
        super.body();
        m_seq=master_seq_random::type_id::create("m_seq");
        fork
           m_seq.start(mst_seqrh[0]);
        join
    endtask


//=============================================coverage100===========================================================//
class vseq_rsize2 extends axi_base_seqs;
    `uvm_object_utils(vseq_rsize2)

     master_seq_rsize2 m_seq;
     extern function new(string name="vseq_rsize2");
     extern task body();
endclass

    function vseq_rsize2::new(string name="vseq_rsize2");
        super.new(name);
    endfunction

    task vseq_rsize2::body();
        super.body();
        m_seq=master_seq_rsize2::type_id::create("m_seq");
        fork
           m_seq.start(mst_seqrh[0]);
        join
    endtask


