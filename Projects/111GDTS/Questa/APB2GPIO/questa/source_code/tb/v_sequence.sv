
class vbase_seq extends uvm_sequence #(uvm_sequence_item);
	
	`uvm_object_utils(vbase_seq)  


   apb_sequencer apb_seqrh;
   aux_sequencer aux_seqrh;
   io_sequencer io_seqrh;

   v_sequencer vsqrh;
 


 	extern function new(string name = "vbase_seq");
	extern task body();
endclass 


function vbase_seq::new(string name ="vbase_seq");
	 super.new(name);
endfunction


task vbase_seq::body();

  
   assert($cast(vsqrh,m_sequencer)) 
   else
	    begin
         `uvm_error("BODY", "Error in $cast of virtual sequencer")
      end

      apb_seqrh = vsqrh.apb_seqrh;
      aux_seqrh = vsqrh.aux_seqrh;
      io_seqrh = vsqrh.io_seqrh;

endtask

   
/*****************************     Input_seqs   ****************************/
class input_vseqs extends vbase_seq;

   `uvm_object_utils(input_vseqs)
 
	input_seqs apb_seqh;
	aux_seq1 aux_seqh;
	io_seq1 io_seqh;
	apb_read_seqs rd_seqh;	 

	extern function new (string name = "input_vseqs");
	 extern task body();
endclass   


function input_vseqs::new(string name ="input_vseqs");
	 super.new(name);
endfunction


task input_vseqs::body();
  
   super.body();
	apb_seqh = input_seqs::type_id::create("apb_seqh");
	rd_seqh = apb_read_seqs::type_id::create("rd_seqh");
	aux_seqh = aux_seq1::type_id::create("aux_seqh");
	io_seqh = io_seq1::type_id::create("io_seqh");
//  repeat(2)
   begin
	fork
   	    apb_seqh.start(apb_seqrh);
   	    aux_seqh.start(aux_seqrh);
	join
    repeat(5)
     begin 
   	    io_seqh.start(io_seqrh);
   	
   	    rd_seqh.start(apb_seqrh);
    end
end
	 		               
endtask        


/*****************************     Input_Interrupt_seqs   ****************************/
class interrupt_vseqs extends vbase_seq;

   `uvm_object_utils(interrupt_vseqs)
 
	input_int_seqs apb_seqh1;
	aux_seq1 aux_seqh1;
	io_seq1 io_seqh1;
	apb_read_seqs rd_seqh1;
 

	extern function new (string name = "interrupt_vseqs");
	 extern task body();
endclass   


function interrupt_vseqs::new(string name ="interrupt_vseqs");
	 super.new(name);
endfunction


task interrupt_vseqs::body();
  
   super.body();
	apb_seqh1 = input_int_seqs::type_id::create("apb_seqh1");
	rd_seqh1 = apb_read_seqs::type_id::create("rd_seqh1");
	aux_seqh1 = aux_seq1::type_id::create("aux_seqh1");
	io_seqh1 = io_seq1::type_id::create("io_seqh1");
     begin
   	    io_seqh1.start(io_seqrh);
	fork
   	    apb_seqh1.start(apb_seqrh);
   	    io_seqh1.start(io_seqrh);
   	    aux_seqh1.start(aux_seqrh);
	join
   	
   	    io_seqh1.start(io_seqrh);
   	    rd_seqh1.start(apb_seqrh);
    end
	 		               
endtask    


/*****************************     Output_seqs   ****************************/
class output_vseqs extends vbase_seq;

   `uvm_object_utils(output_vseqs)
 
	output_seqs apb_seqh2;
	aux_seq1 aux_seqh2;
	io_seq3 io_seqh3;
	apb_read_seqs rd_seqh2;
 

	extern function new (string name = "output_vseqs");
	 extern task body();
endclass   


function output_vseqs::new(string name ="output_vseqs");
	 super.new(name);
endfunction


task output_vseqs::body();
  
   super.body();

	apb_seqh2 = output_seqs::type_id::create("apb_seqh2");
	rd_seqh2 = apb_read_seqs::type_id::create("rd_seqh2");
	aux_seqh2 = aux_seq1::type_id::create("aux_seqh2");
	io_seqh3 = io_seq3::type_id::create("io_seqh2");
     begin
	fork
   	    apb_seqh2.start(apb_seqrh);
   	    io_seqh3.start(io_seqrh);
   	    aux_seqh2.start(aux_seqrh);
	join
   	
   	    rd_seqh2.start(apb_seqrh);
    end
	 		               
endtask 


/*****************************     Bidirectional_seqs   ****************************/
class bidirectional_vseqs extends vbase_seq;

   `uvm_object_utils(bidirectional_vseqs)
 
	bi_directional_seqs apb_seqh3;
	aux_seq1 aux_seqh3;
	io_seq2 io_seqh2;
	apb_read_seqs rd_seqh3;
 

	extern function new (string name = "bidirectional_vseqs");
	 extern task body();
endclass   


function bidirectional_vseqs::new(string name ="bidirectional_vseqs");
	 super.new(name);
endfunction


task bidirectional_vseqs::body();
  
   super.body();

	apb_seqh3 = bi_directional_seqs::type_id::create("apb_seqh3");
	rd_seqh3 = apb_read_seqs::type_id::create("rd_seqh3");
	aux_seqh3 = aux_seq1::type_id::create("aux_seqh3");
	io_seqh2 = io_seq2::type_id::create("io_seqh3");
     begin
	fork
   	    apb_seqh3.start(apb_seqrh);
   	    aux_seqh3.start(aux_seqrh);
	join
   	    io_seqh2.start(io_seqrh);
   	
   	    rd_seqh3.start(apb_seqrh);
    end
	 		               
endtask

/*****************************     Aux_seqs   ****************************/
class aux_vseqs extends vbase_seq;

   `uvm_object_utils(aux_vseqs)
 
	aux_seqs apb_seqh4;
	aux_seq1 aux_seqh4;
	io_seq3 io_seqh3;
	apb_read_seqs rd_seqh4;
 

	extern function new (string name = "aux_vseqs");
	 extern task body();
endclass   


function aux_vseqs::new(string name ="aux_vseqs");
	 super.new(name);
endfunction


task aux_vseqs::body();
  
   super.body();

	apb_seqh4 = aux_seqs::type_id::create("apb_seqh4");
	rd_seqh4 = apb_read_seqs::type_id::create("rd_seqh4");
	aux_seqh4 = aux_seq1::type_id::create("aux_seqh4");
	io_seqh3 = io_seq3::type_id::create("io_seqh3");
     begin
	fork
   	    apb_seqh4.start(apb_seqrh);
   	    aux_seqh4.start(aux_seqrh);
	join
   	    io_seqh3.start(io_seqrh);
   	
   	    rd_seqh4.start(apb_seqrh);
    end
	 		               
endtask


/*****************************     output_with_interrupt_seqs   ****************************/
class output_with_inte_vseqs extends vbase_seq;

   `uvm_object_utils(output_with_inte_vseqs)
 
	output_with_int_seqs apb_seqh5;
	aux_seq1 aux_seqh5;
	io_seq3 io_seqh5;
	apb_read_seqs rd_seqh5;

 

	extern function new (string name = "output_with_inte_vseqs");
	 extern task body();
endclass   


function output_with_inte_vseqs::new(string name ="output_with_inte_vseqs");
	 super.new(name);
endfunction


task output_with_inte_vseqs::body();
  
   super.body();

	apb_seqh5 = output_with_int_seqs::type_id::create("apb_seqh5");
	rd_seqh5 = apb_read_seqs::type_id::create("rd_seqh5");
	aux_seqh5 = aux_seq1::type_id::create("aux_seqh5");
	io_seqh5 = io_seq3::type_id::create("io_seqh5");
     begin
   	    io_seqh5.start(io_seqrh);
	fork
   	    apb_seqh5.start(apb_seqrh);
   	    io_seqh5.start(io_seqrh);
   	    aux_seqh5.start(aux_seqrh);
	join
   	
   	    io_seqh5.start(io_seqrh);
   	    rd_seqh5.start(apb_seqrh);
    end
	 		               
endtask


/*****************************     ECLK_seqs   ****************************/
class eclk_vseqs extends vbase_seq;

   `uvm_object_utils(eclk_vseqs)
 
	eclk_seqs apb_seqh6;
	aux_seq1 aux_seqh6;
	io_seq1 io_seqh6;
	apb_read_seqs rd_seqh6;

 

	extern function new (string name = "eclk_vseqs");
	 extern task body();
endclass   


function eclk_vseqs::new(string name ="eclk_vseqs");
	 super.new(name);
endfunction


task eclk_vseqs::body();
  
   super.body();

	apb_seqh6 = eclk_seqs::type_id::create("apb_seqh6");
	rd_seqh6 = apb_read_seqs::type_id::create("rd_seqh6");
	aux_seqh6 = aux_seq1::type_id::create("aux_seqh6");
	io_seqh6 = io_seq1::type_id::create("io_seqh6");
     begin
	fork
   	    apb_seqh6.start(apb_seqrh);
   	    aux_seqh6.start(aux_seqrh);
	join
   	    io_seqh6.start(io_seqrh);
   	
   	    rd_seqh6.start(apb_seqrh);
    end
  
endtask
