class base_test extends uvm_test;

   // Factory Registration
`uvm_component_utils(base_test)	

  
   	env envh;

	env_cfg e_cfgh;
	apb_cfg apb_cfgh;
	aux_cfg aux_cfgh;
	io_cfg io_cfgh;
 
   bit has_apb_agent=1;
   bit has_aux_agent=1;
   bit has_io_agent=1;
	

	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
	extern function new(string name = "base_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
        extern function void config_ram();

 endclass

//-----------------  constructor new method  -------------------//
// Define Constructor new() function
 function base_test::new(string name = "base_test" , uvm_component parent);
super.new(name,parent);
endfunction


//-----------------  config_ram() method  -------------------//

function void base_test::config_ram();
    if(has_apb_agent)
		begin 	
	 	   apb_cfgh.is_active = UVM_ACTIVE;
  
         	   if(!uvm_config_db #(virtual apb_if)::get(this,"","apb_if",apb_cfgh.vif))
	   	       `uvm_fatal("VIF CONFIG","cannot get()interface apb_vif from uvm_config_db. Have you set() it?") 			
	 	   e_cfgh.apb_cfgh = apb_cfgh;
		end


    if(has_aux_agent) 
		begin 	
	 	   aux_cfgh.is_active = UVM_ACTIVE;
  
         	   if(!uvm_config_db #(virtual aux_input_if)::get(this,"","aux_input_if",aux_cfgh.vif))
	   	       `uvm_fatal("VIF CONFIG","cannot get()interface aux_vif from uvm_config_db. Have you set() it?") 			
	 	   e_cfgh.aux_cfgh = aux_cfgh;
		end


    if(has_io_agent) 
		begin 	
	 	   io_cfgh.is_active = UVM_ACTIVE;
  
         	   if(!uvm_config_db #(virtual io_pad_if)::get(this,"","io_pad_if",io_cfgh.vif))
	   	       `uvm_fatal("VIF CONFIG","cannot get()interface io_vif from uvm_config_db. Have you set() it?") 			
	 	   e_cfgh.io_cfgh = io_cfgh;
		end
      
                
		
endfunction
	

//-----------------  build() phase method  -------------------//
            
function void base_test::build_phase(uvm_phase phase);

	e_cfgh=env_cfg::type_id::create("e_cfgh");
 
    if(has_apb_agent)
        apb_cfgh=apb_cfg::type_id::create("apb_cfgh");

    if(has_aux_agent)
		aux_cfgh=aux_cfg::type_id::create("aux_cfgh");

    if(has_io_agent)
        io_cfgh=io_cfg::type_id::create("io_cfgh");
   
	 config_ram();
 
    super.build_phase(phase);

	envh=env::type_id::create("envh",this);
        
	uvm_config_db #(env_cfg)::set(this,"*","env_cfg",e_cfgh);


endfunction


//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

// Extend test1 from base_test;
class input_test extends base_test;

  
   // Factory Registration
	
`uvm_component_utils(input_test)

	input_seqs apb_seqh;
	aux_seq1 aux_seqh;
	io_seq1 io_seqh;
	apb_read_seqs rd_seqh;	

	// Standard UVM Methods:
 	extern function new(string name = "input_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//-----------------  constructor new method  -------------------//
 function input_test::new(string name = "input_test" , uvm_component parent);
super.new(name,parent);
endfunction



//-----------------  build() phase method  -------------------//
	  // In build phase call super.build_phase(phase);
 function void input_test::build_phase(uvm_phase phase);

super.build_phase(phase);
endfunction
//-----------------  run() phase method  -------------------//
task input_test::run_phase(uvm_phase phase);
	//raise objection

	phase.raise_objection(this);

	apb_seqh = input_seqs::type_id::create("apb_seqh");
	rd_seqh = apb_read_seqs::type_id::create("rd_seqh");
	aux_seqh = aux_seq1::type_id::create("aux_seqh");
	io_seqh = io_seq1::type_id::create("io_seqh");
//  repeat(2)
   begin
	fork
   	    apb_seqh.start(envh.apb_agt_toph.agnth.seqr);
   	    aux_seqh.start(envh.aux_agt_toph.agnth.seqr);
	join
    repeat(1)
     begin 
   	    io_seqh.start(envh.io_agt_toph.agnth.seqr);
   	    rd_seqh.start(envh.apb_agt_toph.agnth.seqr);
    end
end
	    #1000;

	phase.drop_objection(this);
endtask   
