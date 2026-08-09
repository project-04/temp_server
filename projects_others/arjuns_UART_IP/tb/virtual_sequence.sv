//***************************************************************//Base virtual sequence
class virtual_seq extends uvm_sequence #(uvm_sequence_item);
 	`uvm_object_utils(virtual_seq)

	uart_seqr uart_seqrh[];
	apb_seqr apb_seqrh[];
	virtual_seqr virtual_seqrh;

	env_config env_cfg;

	function new(string name ="virtual_seq");
		super.new(name);
	endfunction

        
        task body();
                assert($cast(virtual_seqrh,m_sequencer)) else 
          	`uvm_error("BODY", "Error in $cast of virtual sequencer")

                if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",env_cfg))
		`uvm_fatal("CONFIG","cannot get() env_cfg from uvm_config_db. Have you set() it?")

                apb_seqrh=new[env_cfg.no_of_apb_agents];
		uart_seqrh=new[env_cfg.no_of_uart_agents];

		foreach(apb_seqrh[i])
                	apb_seqrh[i] = virtual_seqrh.apb_seqrh[i];

		foreach(uart_seqrh[i])
                	uart_seqrh[i] = virtual_seqrh.uart_seqrh[i];
        endtask
endclass

//**************************************************************//HD0_sequence
class HD0_sequence extends virtual_seq;
      `uvm_object_utils(HD0_sequence)

	apb_HD0  			hd0_apb_seqh;
	uart_HD0 			hd0_uart_seqh;
  
     function new(string name = "HD0_sequence");
	      super.new(name);
     endfunction 

     task body();
	  super.body();
	
 	  hd0_apb_seqh = apb_HD0::type_id::create("hd0_apb_seqh");
	  hd0_uart_seqh = uart_HD0::type_id::create("hd0_uart_seqh");
         
          fork
		foreach(apb_seqrh[i])begin
	    		hd0_apb_seqh.start(apb_seqrh[i]);
		end

		foreach(uart_seqrh[i])begin
	    		hd0_uart_seqh.start(uart_seqrh[i]);
		end
          join
     endtask

endclass

//**************************************************************//HD0_multiple_sequence
class HD0_multiple_sequence extends virtual_seq;
      `uvm_object_utils(HD0_multiple_sequence)
  
	apb_HD0_multiple_sequence 	hd0_multiple_apb_seqh;
	uart_HD0_multiple 		hd0_multiple_uart_seqh;

     function new(string name = "HD0_multiple_sequence");
	      super.new(name);
     endfunction 

     task body();
	  super.body();
	
 	  hd0_multiple_apb_seqh = apb_HD0_multiple_sequence::type_id::create("hd0_multiple_apb_seqh");
	  hd0_multiple_uart_seqh = uart_HD0_multiple::type_id::create("hd0_multiple_uart_seqh");
         
          fork
		foreach(apb_seqrh[i])begin
	    		hd0_multiple_apb_seqh.start(apb_seqrh[i]);
		end

		foreach(uart_seqrh[i])begin
	    		hd0_multiple_uart_seqh.start(uart_seqrh[i]);
		end
          join
     endtask

endclass

//**************************************************************//HD1_sequence
class HD1_sequence extends virtual_seq;
      `uvm_object_utils(HD1_sequence)

	apb_HD1  			hd1_apb_seqh;
	uart_HD1 			hd1_uart_seqh;
  
     function new(string name = "HD1_sequence");
	      super.new(name);
     endfunction 

     task body();
	  super.body();
	
 	  hd1_apb_seqh = apb_HD1::type_id::create("hd1_apb_seqh");
	  hd1_uart_seqh = uart_HD1::type_id::create("hd1_uart_seqh");
         
          fork
		foreach(apb_seqrh[i])begin
	    		hd1_apb_seqh.start(apb_seqrh[i]);
		end

		foreach(uart_seqrh[i])begin
	    		hd1_uart_seqh.start(uart_seqrh[i]);
		end
          join
     endtask

endclass

//**************************************************************//HD1_multiple_sequence
class HD1_multiple_sequence extends virtual_seq;
      `uvm_object_utils(HD1_multiple_sequence)

	apb_HD1_multiple_sequence hd1_multiple_apb_seqh;
	uart_HD1_multiple	hd1_multiple_uart_seqh;
  
     function new(string name = "HD1_multiple_sequence");
	      super.new(name);
     endfunction 

     task body();
	  super.body();
	
 	  hd1_multiple_apb_seqh = apb_HD1_multiple_sequence::type_id::create("hd1_multiple_apb_seqh");
	  hd1_multiple_uart_seqh = uart_HD1_multiple::type_id::create("hd1_multiple_uart_seqh");
         
          fork
		foreach(apb_seqrh[i])begin
	    		hd1_multiple_apb_seqh.start(apb_seqrh[i]);
		end

		foreach(uart_seqrh[i])begin
	    		hd1_multiple_uart_seqh.start(uart_seqrh[i]);
		end
          join
     endtask

endclass

//**************************************************************//FD_sequence
class FD_sequence extends virtual_seq;
      `uvm_object_utils(FD_sequence)

	apb_FD_sequence 		fd_apb_seqh;
	uart_FD 			fd_uart_seqh;
  
     function new(string name = "FD_sequence");
	      super.new(name);
     endfunction 

     task body();
	  super.body();
	
 	  fd_apb_seqh = apb_FD_sequence::type_id::create("fd_apb_seqh");
	  fd_uart_seqh = uart_FD::type_id::create("fd_uart_seqh");
         
          fork
		foreach(apb_seqrh[i])begin
	    		fd_apb_seqh.start(apb_seqrh[i]);
		end

		foreach(uart_seqrh[i])begin
	    		fd_uart_seqh.start(uart_seqrh[i]);
		end
          join
     endtask

endclass

//**************************************************************//FD_multiple_sequence
class FD_multiple_sequence extends virtual_seq;
      `uvm_object_utils(FD_multiple_sequence)

	apb_FD_multiple_sequence	fd_multiple_apb_seqh;
	uart_FD_multiple		fd_multiple_uart_seqh;
  
     function new(string name = "FD_multiple_sequence");
	      super.new(name);
     endfunction 

     task body();
	  super.body();
	
 	  fd_multiple_apb_seqh = apb_FD_multiple_sequence::type_id::create("fd_multiple_apb_seqh");
	  fd_multiple_uart_seqh = uart_FD_multiple::type_id::create("fd_multiple_uart_seqh");
         
          fork
		foreach(apb_seqrh[i])begin
	    		fd_multiple_apb_seqh.start(apb_seqrh[i]);
		end

		foreach(uart_seqrh[i])begin
	    		fd_multiple_uart_seqh.start(uart_seqrh[i]);
		end
          join
     endtask

endclass

//**************************************************************//Loopback_sequence
class loopback_sequence extends virtual_seq;
      `uvm_object_utils(loopback_sequence)

	apb_loopback_sequence 		loopback_apb_seqh;
  
     function new(string name = "loopback_sequence");
	      super.new(name);
     endfunction 

     task body();
	  super.body();
	
 	  loopback_apb_seqh = apb_loopback_sequence::type_id::create("loopback_apb_seqh");
	  
	  fork
		foreach(apb_seqrh[i])begin
	    		loopback_apb_seqh.start(apb_seqrh[i]);
		end
          join
     endtask	

endclass

//**************************************************************//loopback_multiple_sequence
class loopback_multiple_sequence extends virtual_seq;
      `uvm_object_utils(loopback_multiple_sequence)
  	
     apb_loopback_multiple_sequence 	loopback_apb_multiple_seqh;

     function new(string name = "loopback_multiple_sequence");
	      super.new(name);
     endfunction 

     task body();
	  super.body();
	
 	  loopback_apb_multiple_seqh = apb_loopback_multiple_sequence::type_id::create("loopback_apb_multiple_seqh");
          
	  fork
		foreach(apb_seqrh[i])begin
	    		loopback_apb_multiple_seqh.start(apb_seqrh[i]);
		end
          join
     endtask

endclass

//**************************************************************//THR_empty_sequence
class THR_empty_sequence extends virtual_seq;
      `uvm_object_utils(THR_empty_sequence)
  	
     apb_THR_empty_sequence 	apb_THR_empty_seqh;

     function new(string name = "THR_empty_sequence");
	      super.new(name);
     endfunction 

     task body();
	  super.body();
	
 	  apb_THR_empty_seqh = apb_THR_empty_sequence::type_id::create("apb_THR_empty_seqh");
          
	  fork
		foreach(apb_seqrh[i])begin
	    		apb_THR_empty_seqh.start(apb_seqrh[i]);
		end
          join
     endtask

endclass

//**************************************************************//parity_error_hd0_sequence
class parity_error_hd0_sequence extends virtual_seq;
      `uvm_object_utils(parity_error_hd0_sequence)
  	
     apb_HD0_parity_sequence 	hd0_apb_parity_seqh;
     uart_HD0_parity		hd0_uart_parity_seqh;

     function new(string name = "parity_error_hd0_sequence");
	      super.new(name);
     endfunction 

     task body();
	  super.body();
	
 	  hd0_apb_parity_seqh = apb_HD0_parity_sequence::type_id::create("hd0_apb_parity_seqh");
          hd0_uart_parity_seqh = uart_HD0_parity::type_id::create("hd0_uart_parity_seqh");

	  fork
		foreach(apb_seqrh[i])begin
	    		hd0_apb_parity_seqh.start(apb_seqrh[i]);
		end

		foreach(uart_seqrh[i])begin
	    		hd0_uart_parity_seqh.start(uart_seqrh[i]);
		end
          join
     endtask

endclass

//**************************************************************//parity_error_hd1_sequence
class parity_error_hd1_sequence extends virtual_seq;
      `uvm_object_utils(parity_error_hd1_sequence)
  	
     apb_HD1_parity_sequence 	hd1_apb_parity_seqh;
     uart_HD1_parity		hd1_uart_parity_seqh;

     function new(string name = "parity_error_hd1_sequence");
	      super.new(name);
     endfunction 

     task body();
	  super.body();
	
 	  hd1_apb_parity_seqh = apb_HD1_parity_sequence::type_id::create("hd1_apb_parity_seqh");
          hd1_uart_parity_seqh = uart_HD1_parity::type_id::create("hd1_uart_parity_seqh");

	  fork
		foreach(apb_seqrh[i])begin
	    		hd1_apb_parity_seqh.start(apb_seqrh[i]);
		end

		foreach(uart_seqrh[i])begin
	    		hd1_uart_parity_seqh.start(uart_seqrh[i]);
		end
          join
     endtask

endclass

//**************************************************************//parity_error_fd_sequence
class parity_error_fd_sequence extends virtual_seq;
      `uvm_object_utils(parity_error_fd_sequence)
  	
     apb_FD_parity_sequence 	fd_apb_parity_seqh;
     uart_FD_parity		fd_uart_parity_seqh;

     function new(string name = "parity_error_fd_sequence");
	      super.new(name);
     endfunction 

     task body();
	  super.body();
	
 	  fd_apb_parity_seqh = apb_FD_parity_sequence::type_id::create("fd_apb_parity_seqh");
          fd_uart_parity_seqh = uart_FD_parity::type_id::create("fd_uart_parity_seqh");

	  fork
		foreach(apb_seqrh[i])begin
	    		fd_apb_parity_seqh.start(apb_seqrh[i]);
		end

		foreach(uart_seqrh[i])begin
	    		fd_uart_parity_seqh.start(uart_seqrh[i]);
		end
          join
     endtask

endclass

//**************************************************************//break_error_hd_sequence
class break_error_hd_sequence extends virtual_seq;
      `uvm_object_utils(break_error_hd_sequence)
  	
     uart_HD_break	 		hd_uart_break_seqh;
     apb_HD1_break_sequence		hd_apb_break_seqh;		

     function new(string name = "break_error_hd_sequence");
	      super.new(name);
     endfunction 

     task body();
	  super.body();
	
 	  hd_apb_break_seqh = apb_HD1_break_sequence::type_id::create("hd_apb_break_seqh");
          hd_uart_break_seqh = uart_HD_break::type_id::create("hd_uart_break_seqh");

	  fork
		foreach(apb_seqrh[i])begin
	    		hd_apb_break_seqh.start(apb_seqrh[i]);
		end

		foreach(uart_seqrh[i])begin
	    		hd_uart_break_seqh.start(uart_seqrh[i]);
		end
          join
     endtask

endclass

//**************************************************************//frame_error_hd_sequence
class frame_error_hd_sequence extends virtual_seq;
      `uvm_object_utils(frame_error_hd_sequence)
  	
     uart_HD_frame 			hd_uart_frame_seqh;
     apb_HD_frame_sequence		hd_apb_frame_seqh;		

     function new(string name = "frame_error_hd_sequence");
	      super.new(name);
     endfunction 

     task body();
	  super.body();
	
 	  hd_apb_frame_seqh = apb_HD_frame_sequence::type_id::create("hd_apb_frame_seqh");
          hd_uart_frame_seqh = uart_HD_frame::type_id::create("hd_uart_frame_seqh");

	  fork
		foreach(apb_seqrh[i])begin
	    		hd_apb_frame_seqh.start(apb_seqrh[i]);
		end

		foreach(uart_seqrh[i])begin
	    		hd_uart_frame_seqh.start(uart_seqrh[i]);
		end
          join
     endtask

endclass

//**************************************************************//frame_error_fd_sequence
class frame_error_fd_sequence extends virtual_seq;
      `uvm_object_utils(frame_error_fd_sequence)
  	
     uart_FD_frame 			fd_uart_frame_seqh;
     apb_FD_frame_sequence		fd_apb_frame_seqh;		

     function new(string name = "frame_error_fd_sequence");
	      super.new(name);
     endfunction 

     task body();
	  super.body();
	
 	  fd_apb_frame_seqh = apb_FD_frame_sequence::type_id::create("fd_apb_frame_seqh");
          fd_uart_frame_seqh = uart_FD_frame::type_id::create("fd_uart_frame_seqh");

	  fork
		foreach(apb_seqrh[i])begin
	    		fd_apb_frame_seqh.start(apb_seqrh[i]);
		end

		foreach(uart_seqrh[i])begin
	    		fd_uart_frame_seqh.start(uart_seqrh[i]);
		end
          join
     endtask

endclass
 
//**************************************************************//overrun_sequence
class overrun_sequence extends virtual_seq;
      `uvm_object_utils(overrun_sequence)
  	
     uart_HD1_overrun 		hd1_uart_overrun_seqh;
     apb_HD1_overrun		hd1_apb_overrun_seqh;		

     function new(string name = "overrun_sequence");
	      super.new(name);
     endfunction 

     task body();
	  super.body();
	
 	  hd1_apb_overrun_seqh = apb_HD1_overrun::type_id::create("hd1_apb_overrun_seqh");
          hd1_uart_overrun_seqh = uart_HD1_overrun::type_id::create("hd1_uart_overrun_seqh");

	  fork
		foreach(apb_seqrh[i])begin
	    		hd1_apb_overrun_seqh.start(apb_seqrh[i]);
		end

		foreach(uart_seqrh[i])begin
	    		hd1_uart_overrun_seqh.start(uart_seqrh[i]);
		end
          join
     endtask

endclass

//**************************************************************//timeout_sequence
class timeout_sequence extends virtual_seq;
      `uvm_object_utils(timeout_sequence)
  	
     uart_HD1_timeout 			hd1_uart_timeout_seqh;
     apb_HD1_timeout_sequence		hd1_apb_timeout_seqh;		

     function new(string name = "timeout_sequence");
	      super.new(name);
     endfunction 

     task body();
	  super.body();
	
 	  hd1_uart_timeout_seqh = uart_HD1_timeout::type_id::create("hd1_uart_timeout_seqh");
          hd1_apb_timeout_seqh = apb_HD1_timeout_sequence::type_id::create("hd1_apb_timeout_seqh");

	  fork
		foreach(apb_seqrh[i])begin
	    		hd1_apb_timeout_seqh.start(apb_seqrh[i]);
		end

		foreach(uart_seqrh[i])begin
	    		hd1_uart_timeout_seqh.start(uart_seqrh[i]);
		end
          join
     endtask

endclass

