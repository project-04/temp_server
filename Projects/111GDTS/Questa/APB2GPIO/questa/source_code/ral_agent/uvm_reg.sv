   //--------------------------------------------------------------------
   // Class: RGPIO_OUT_reg
   //--------------------------------------------------------------------


 class rgpioIN_reg extends uvm_reg;

	`uvm_object_utils(rgpioIN_reg)
	 // uvm_reg_field class type
	rand uvm_reg_field in_reg;
	
	function new(string name = "rgpioIN_reg");
		super.new(name,32,UVM_NO_COVERAGE); // if yes - UVM_CVR_ALL
			 // instance name, no.of bits in reg, func cov for reg
	endfunction
	
	virtual function void build();
	
		in_reg = uvm_reg_field::type_id::create("in_reg");
		
			in_reg.configure(this,32,0,"RO",0,'h0,1,1,1);
				//parent for reg_feld ,
				//size of field,
				//lsb postion of field, 
				//access,
				// volatile(fc),
				// rst val,
				// bit has_rst - sens
				// suports randomization 
				// bit_accessable
	endfunction
	
endclass



   
   //--------------------------------------------------------------------
   // Class: RGPIO_OUT_reg
   //--------------------------------------------------------------------

  class rgpioOUT_reg extends uvm_reg;

	`uvm_object_utils(rgpioOUT_reg)
	
	rand uvm_reg_field out_reg;

function new(string name = "rgpioOUT_reg");
		super.new(name, 32, UVM_NO_COVERAGE);
endfunction

virtual function void build;
	out_reg = uvm_reg_field::type_id::create("out_reg");
	
	out_reg.configure(this, 32, 0, "RW", 0, 'd0, 1, 1,1);
endfunction
	
endclass


   //--------------------------------------------------------------------
   // Class: RGPIO_OE_reg
   //--------------------------------------------------------------------

  class rgpioOE_reg extends uvm_reg;

	`uvm_object_utils(rgpioOE_reg)
	
	rand uvm_reg_field oe_reg;

function new(string name = "rgpioOE_reg");
		super.new(name, 32, UVM_NO_COVERAGE);
endfunction

virtual function void build;
	oe_reg = uvm_reg_field::type_id::create("oe_reg");
	
	oe_reg.configure(this, 32, 0, "RW", 0, 'd0, 1, 1,1);
endfunction
	
endclass

  
   //--------------------------------------------------------------------
   // Class: RGPIO_INTE_reg
   //--------------------------------------------------------------------

  class rgpioINTE_reg extends uvm_reg;

	`uvm_object_utils(rgpioINTE_reg)
	
	rand uvm_reg_field inte_reg;

function new(string name = "rgpioINTE_reg");
		super.new(name, 32, UVM_NO_COVERAGE);
endfunction

virtual function void build;
	inte_reg = uvm_reg_field::type_id::create("inte_reg");
	
	inte_reg.configure(this, 32, 0, "RW", 0, 'd0, 1, 1,1);
endfunction
	
endclass
  

   //--------------------------------------------------------------------
   // Class: RGPIO_PTRIG_reg
   //--------------------------------------------------------------------

  class rgpioPTRIG_reg extends uvm_reg;

	`uvm_object_utils(rgpioPTRIG_reg)
	
	rand uvm_reg_field ptrig_reg;

function new(string name = "rgpioPTRIG_reg");
		super.new(name, 32, UVM_NO_COVERAGE);
endfunction

virtual function void build;
	ptrig_reg = uvm_reg_field::type_id::create("ptrig_reg");
	
	ptrig_reg.configure(this, 32, 0, "RW", 0, 'd0, 1, 1,1);
endfunction
	
endclass



   //--------------------------------------------------------------------
   // Class: RGPIO_AUX_reg
   //--------------------------------------------------------------------

  class rgpioAUX_reg extends uvm_reg;

	`uvm_object_utils(rgpioAUX_reg)
	
	rand uvm_reg_field aux_reg;

function new(string name = "rgpioAUX_reg");
		super.new(name, 32, UVM_NO_COVERAGE);
endfunction

virtual function void build;
	aux_reg = uvm_reg_field::type_id::create("aux_reg");
	
	aux_reg.configure(this, 32, 0, "RW", 0, 'd0, 1, 1,1);
endfunction
	
endclass



   //--------------------------------------------------------------------
   // Class: RGPIO_CTRL_reg
   //--------------------------------------------------------------------

  class rgpioCTRL_reg extends uvm_reg;

	`uvm_object_utils(rgpioCTRL_reg)
	
	rand uvm_reg_field ctrl_reg;

function new(string name = "rgpioCTRL_reg");
		super.new(name, 32, UVM_NO_COVERAGE);
endfunction

virtual function void build;
	ctrl_reg = uvm_reg_field::type_id::create("ctrl_reg");
	
	ctrl_reg.configure(this, 32, 0, "RW", 0, 'd0, 1, 1,1);
endfunction
	
endclass


   //--------------------------------------------------------------------
   // Class: RGPIO_INTS_reg
   //--------------------------------------------------------------------

  class rgpioINTS_reg extends uvm_reg;

	`uvm_object_utils(rgpioINTS_reg)
	
	rand uvm_reg_field ints_reg;

function new(string name = "rgpioINTS_reg");
		super.new(name, 32, UVM_NO_COVERAGE);
endfunction

virtual function void build;
	ints_reg = uvm_reg_field::type_id::create("ints_reg");
	
	ints_reg.configure(this, 32, 0, "RW", 0, 'd0, 1, 1,1);
endfunction
	
endclass

   //--------------------------------------------------------------------
   // Class: RGPIO_ECLK_reg
   //--------------------------------------------------------------------

  class rgpioECLK_reg extends uvm_reg;

	`uvm_object_utils(rgpioECLK_reg)
	
	rand uvm_reg_field eclk_reg;

function new(string name = "rgpioECLK_reg");
		super.new(name, 32, UVM_NO_COVERAGE);
endfunction

virtual function void build;
	eclk_reg = uvm_reg_field::type_id::create("eclk_reg");
	
	eclk_reg.configure(this, 32, 0, "RW", 0, 'd0, 1, 1,1);
endfunction
	
endclass



   //--------------------------------------------------------------------
   // Class: RGPIO_NEC_reg
   //--------------------------------------------------------------------

  class rgpioNEC_reg extends uvm_reg;

	`uvm_object_utils(rgpioNEC_reg)
	
	rand uvm_reg_field nec_reg;

function new(string name = "rgpioNEC_reg");
		super.new(name, 32, UVM_NO_COVERAGE);
endfunction

virtual function void build;
	nec_reg = uvm_reg_field::type_id::create("nec_reg");
	
	nec_reg.configure(this, 32, 0, "RW", 0, 'd0, 1, 1,1);
endfunction
	
endclass

