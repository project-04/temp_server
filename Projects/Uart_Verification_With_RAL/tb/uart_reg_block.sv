class uart_reg_block extends uvm_reg_block;

        rand uart_lcr_reg lcr;
//      rand uart_ier_reg ier;

        `uvm_object_utils(uart_reg_block)

        function new(string name = "uart_reg_block");
                super.new(name,UVM_NO_COVERAGE);
        endfunction

        virtual function void build();
                // create registers
//              ier = uart_ier_reg :: type_id ::create("ier", , get_full_name());
                lcr = uart_lcr_reg :: type_id ::create("lcr", , get_full_name());


                //build registers
//              ier.build();
//              ier.configure(this,null,"");

                lcr.build();
                lcr.configure(this,null,"");


                //create default address map
                default_map = create_map("default_map", 0, 4, UVM_LITTLE_ENDIAN);
//              default_map.add_reg(ier , 'h04, "RW")!l!*
                default_map.add_reg(lcr , 'h0C, "RW");

                lcr.add_hdl_path_slice("LCR",0,7);
//              ier.add_hdl_path_slice("IER",0,7);

                //set backdoor root(DUT path)
                add_hdl_path("top.DUT", "RTL");
        endfunction

endclass
