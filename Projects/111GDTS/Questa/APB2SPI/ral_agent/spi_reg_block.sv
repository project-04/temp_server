class spi_reg_block extends uvm_reg_block;
   `uvm_object_utils(spi_reg_block)

   uvm_reg_map spi_reg_map;
   spi_reg_access_wrapper spi_reg_cg;
	
   rand spi_reg_file_control_register_1 cntr_reg1;
   rand spi_reg_file_control_register_2 cntr_reg2;
   rand spi_reg_file_baud_register baud_reg;
   rand spi_reg_file_status_register status_reg;
   rand spi_reg_file_data_register data_reg;


   function new(string name="spi_reg_block");
     super.new(name, build_coverage(UVM_CVR_ALL));
   endfunction

   function void build();

     cntr_reg1 = spi_reg_file_control_register_1 :: type_id :: create("cntr_reg1");
     cntr_reg2 = spi_reg_file_control_register_2 :: type_id :: create("cntr_reg2");
     baud_reg = spi_reg_file_baud_register :: type_id :: create("baud_reg");
     status_reg =    spi_reg_file_status_register :: type_id :: create("status_reg");
     data_reg = spi_reg_file_data_register :: type_id :: create("data_reg");

     cntr_reg1.configure(this, null, "");
     cntr_reg2.configure(this, null, "");
     baud_reg.configure(this, null, "");
     status_reg.configure(this, null, "");
     data_reg.configure(this, null, "");

     cntr_reg1.build();
     cntr_reg2.build();
     baud_reg.build();
     status_reg.build();
     data_reg.build();

     add_hdl_path("top.CORE", "RTL");
		
     cntr_reg1.add_hdl_path_slice("APB_INTERFACE.SPI_CR_1", 0, 8);
     cntr_reg2.add_hdl_path_slice("APB_INTERFACE.SPI_CR_2", 0, 8);
     baud_reg.add_hdl_path_slice("APB_INTERFACE.SPI_BR", 0, 8);
     status_reg.add_hdl_path_slice("APB_INTERFACE.SPI_SR", 0, 8);
     data_reg.add_hdl_path_slice("APB_INTERFACE.SPI_DR", 0, 8);
     
     spi_reg_map=create_map("spi_reg_map", 'h0, 1, UVM_LITTLE_ENDIAN, 0);
		
     spi_reg_map.add_reg(cntr_reg1, 8'h0, "RW");
     spi_reg_map.add_reg(cntr_reg2, 8'h1, "RW");
     spi_reg_map.add_reg(baud_reg, 8'h2, "RW");
     spi_reg_map.add_reg(status_reg, 8'h3, "RO");
     spi_reg_map.add_reg(data_reg, 8'h5, "RW");


     lock_model();
   endfunction
 endclass
