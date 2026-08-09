
   class rgpio_reg_block extends uvm_reg_block;
      `uvm_object_utils(rgpio_reg_block)

      rand rgpioIN_reg inreg;
      rand rgpioOUT_reg outreg;
      rand rgpioOE_reg oereg;
      rand rgpioINTE_reg intereg;
      rand rgpioPTRIG_reg ptrigreg;
      rand rgpioAUX_reg auxreg;
      rand rgpioCTRL_reg ctrlreg;
      rand rgpioINTS_reg intsreg;
      rand rgpioECLK_reg eclkreg;
      rand rgpioNEC_reg necreg;


      uvm_reg_map map; 


      // Function: new
      
      function new(string name = "rgpio_reg_block");
         super.new(name);
      endfunction


      // Function: build
      // 
      virtual function void build();
         inreg = rgpioIN_reg::type_id::create("inreg");
         inreg.configure(this);
         inreg.build();
	 inreg.add_hdl_path_slice("GPIO_REGISTER.rgpio_in",0,63);

         outreg = rgpioOUT_reg::type_id::create("outreg");
         outreg.configure(this);
         outreg.build();
	 outreg.add_hdl_path_slice("GPIO_REGISTER.rgpio_out",0,31);

         oereg = rgpioOE_reg::type_id::create("oereg");
         oereg.configure(this);
         oereg.build();
	 oereg.add_hdl_path_slice("GPIO_REGISTER.rgpio_oe",0,31);

         intereg = rgpioINTE_reg::type_id::create("intereg");
         intereg.configure(this);
         intereg.build();
	 intereg.add_hdl_path_slice("GPIO_REGISTER.rgpio_inte",0,31);

         ptrigreg = rgpioPTRIG_reg::type_id::create("ptrigreg");
         ptrigreg.configure(this);
         ptrigreg.build();
	 ptrigreg.add_hdl_path_slice("GPIO_REGISTER.rgpio_ptrig",0,31);

         auxreg = rgpioAUX_reg::type_id::create("auxreg");
         auxreg.configure(this);
         auxreg.build();
	 auxreg.add_hdl_path_slice("GPIO_REGISTER.rgpio_aux",0,31);

         ctrlreg = rgpioCTRL_reg::type_id::create("ctrlreg");
         ctrlreg.configure(this);
         ctrlreg.build();
	 ctrlreg.add_hdl_path_slice("GPIO_REGISTER.rgpio_ctrl",0,31);

         intsreg = rgpioINTS_reg::type_id::create("intsreg");
         intsreg.configure(this);
         intsreg.build();
	 intsreg.add_hdl_path_slice("GPIO_REGISTER.rgpio_ints",0,31);


         eclkreg = rgpioECLK_reg::type_id::create("eclkreg");
         eclkreg.configure(this);
         eclkreg.build();
	 eclkreg.add_hdl_path_slice("GPIO_REGISTER.rgpio_eclk",0,31);


         necreg = rgpioNEC_reg::type_id::create("necreg");
         necreg.configure(this);
         necreg.build();
	 necreg.add_hdl_path_slice("GPIO_REGISTER.rgpio_nec",0,31);


         map = create_map("map", 'h0, 4, UVM_LITTLE_ENDIAN, 1);
					// name of the map handle,
					// base addr,
					// access width in bytes
					// map endians
					// byte addressing support ? 

         default_map = map;

         map.add_reg(inreg, 'h0, "RO");
         map.add_reg(outreg, 'h1, "RW");
         map.add_reg(oereg, 'h2, "RW");
         map.add_reg(intereg, 'h3, "RW");
         map.add_reg(ptrigreg, 'h4, "RW");
         map.add_reg(auxreg, 'h5, "RW");
         map.add_reg(ctrlreg, 'h6, "RW");
         map.add_reg(intsreg, 'h7, "RW");
         map.add_reg(eclkreg, 'h8, "RW");
         map.add_reg(necreg, 'h9, "RW");

	add_hdl_path("top.DUV","RTL");

         lock_model();  // finilize the addr mapping 
      endfunction
		
   endclass


