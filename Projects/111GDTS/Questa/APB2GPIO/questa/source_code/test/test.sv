class base_test extends uvm_test;

   // Factory Registration
`uvm_component_utils(base_test)	

  
   	env envh;

	env_cfg e_cfgh;
	apb_cfg apb_cfgh;
	aux_cfg aux_cfgh;
	io_cfg io_cfgh;
 
	rgpio_reg_block reg_model;

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

	reg_model = rgpio_reg_block::type_id::create("reg_model");
	reg_model.build();
	e_cfgh.reg_model = reg_model;

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

	input_vseqs apb_seqh;

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



	apb_seqh = input_vseqs::type_id::create("apb_seqh");
	
   	    apb_seqh.start(envh.vseqrh);
	
	    #100;

	phase.drop_objection(this);
endtask   



// Extend interrupt_test from base_test;
class interrupt_test extends base_test;

  
   // Factory Registration
	
`uvm_component_utils(interrupt_test)

	interrupt_vseqs seqh1;

	// Standard UVM Methods:
 	extern function new(string name = "interrupt_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//-----------------  constructor new method  -------------------//
 function interrupt_test::new(string name = "interrupt_test" , uvm_component parent);
super.new(name,parent);
endfunction



//-----------------  build() phase method  -------------------//
	  // In build phase call super.build_phase(phase);
 function void interrupt_test::build_phase(uvm_phase phase);

super.build_phase(phase);
endfunction
//-----------------  run() phase method  -------------------//
task interrupt_test::run_phase(uvm_phase phase);

	phase.raise_objection(this);

	seqh1 = interrupt_vseqs::type_id::create("seqh1");
	
   	seqh1.start(envh.vseqrh);
	
	#10000;
	
	phase.drop_objection(this);
endtask   



// Extend output_test from base_test;
class output_test extends base_test;

  
   // Factory Registration
	
`uvm_component_utils(output_test)

	output_vseqs seqh2;


	// Standard UVM Methods:
 	extern function new(string name = "output_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//-----------------  constructor new method  -------------------//
 function output_test::new(string name = "output_test" , uvm_component parent);
super.new(name,parent);
endfunction



//-----------------  build() phase method  -------------------//
	  // In build phase call super.build_phase(phase);
 function void output_test::build_phase(uvm_phase phase);

super.build_phase(phase);
endfunction
//-----------------  run() phase method  -------------------//
task output_test::run_phase(uvm_phase phase);
	//raise objection

	phase.raise_objection(this);

	seqh2 = output_vseqs::type_id::create("seqh2");

    	seqh2.start(envh.vseqrh);
	
	#10000;

	phase.drop_objection(this);
endtask   



// Extend bi_directional_test from base_test;
class bi_directional_test extends base_test;

  
   // Factory Registration
	
`uvm_component_utils(bi_directional_test)

     bidirectional_vseqs seqh3;


	// Standard UVM Methods:
 	extern function new(string name = "bi_directional_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//-----------------  constructor new method  -------------------//
 function bi_directional_test::new(string name = "bi_directional_test" , uvm_component parent);
super.new(name,parent);
endfunction



function void bi_directional_test::build_phase(uvm_phase phase);

super.build_phase(phase);
endfunction

//-----------------  run() phase method  -------------------//
task bi_directional_test::run_phase(uvm_phase phase);

	phase.raise_objection(this);

	seqh3 = bidirectional_vseqs::type_id::create("seqh3");

    	seqh3.start(envh.vseqrh);

	#10000;

	phase.drop_objection(this);
endtask   



// Extend aux_test from base_test;
class aux_test extends base_test;

  
   // Factory Registration
	
`uvm_component_utils(aux_test)

	aux_vseqs seqh4;

	// Standard UVM Methods:
 	extern function new(string name = "aux_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//-----------------  constructor new method  -------------------//
 function aux_test::new(string name = "aux_test" , uvm_component parent);
super.new(name,parent);
endfunction



//-----------------  build() phase method  -------------------//
	  // In build phase call super.build_phase(phase);
 function void aux_test::build_phase(uvm_phase phase);

super.build_phase(phase);
endfunction
//-----------------  run() phase method  -------------------//
task aux_test::run_phase(uvm_phase phase);
	//raise objection

	phase.raise_objection(this);

	seqh4 = aux_vseqs::type_id::create("seqh4");

    	seqh4.start(envh.vseqrh);

	#10000;

	phase.drop_objection(this);
endtask   




// Extend output_with interrupt_test from base_test;
class output_with_inte_test extends base_test;

  
   // Factory Registration
	
`uvm_component_utils(output_with_inte_test)

	output_with_inte_vseqs seqh5;


	// Standard UVM Methods:
 	extern function new(string name = "output_with_inte_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//-----------------  constructor new method  -------------------//
 function output_with_inte_test::new(string name = "output_with_inte_test" , uvm_component parent);
super.new(name,parent);
endfunction



//-----------------  build() phase method  -------------------//
	  // In build phase call super.build_phase(phase);
 function void output_with_inte_test::build_phase(uvm_phase phase);

super.build_phase(phase);
endfunction
//-----------------  run() phase method  -------------------//
task output_with_inte_test::run_phase(uvm_phase phase);
	//raise objection

	phase.raise_objection(this);

	seqh5 = output_with_inte_vseqs::type_id::create("seqh5");

    	seqh5.start(envh.vseqrh);

	#10000;

	phase.drop_objection(this);
endtask  




// Extend eclk_test from base_test;
class eclk_test extends base_test;

  
   // Factory Registration
	
`uvm_component_utils(eclk_test)

	eclk_vseqs seqh6;

	// Standard UVM Methods:
 	extern function new(string name = "eclk_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//-----------------  constructor new method  -------------------//
 function eclk_test::new(string name = "eclk_test" , uvm_component parent);
super.new(name,parent);
endfunction



//-----------------  build() phase method  -------------------//
	  // In build phase call super.build_phase(phase);
 function void eclk_test::build_phase(uvm_phase phase);

super.build_phase(phase);
endfunction
//-----------------  run() phase method  -------------------//
task eclk_test::run_phase(uvm_phase phase);
	//raise objection

	phase.raise_objection(this);

	seqh6 = eclk_vseqs::type_id::create("apb_seqh6");

    	seqh6.start(envh.vseqrh);

	#10000;	

	phase.drop_objection(this);
endtask   

