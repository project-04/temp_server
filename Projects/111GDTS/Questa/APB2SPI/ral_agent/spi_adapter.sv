 class spi_adapter extends uvm_reg_adapter;
   `uvm_object_utils(spi_adapter)

   function new(string name="spi_adapter");
     super.new(name);
   endfunction

   virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);

     apb_xtn apb = apb_xtn :: type_id :: create("apb");
     apb.PWRITE = (rw.kind == UVM_READ)? 1'b0 : 1'b1;
     apb.PADDR = rw.addr;

     if(rw.kind == UVM_READ)
       apb.PRDATA = rw.data;
     else
       apb.PWDATA = rw.data;
     return apb;
   endfunction

   virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
     apb_xtn apb;
		
     if(!$cast(apb, bus_item))
       begin
	 `uvm_fatal("not_apb_type", "Provided bus item is not of the correct type")
       end

     rw.kind =(apb.PWRITE ==1'b0)? UVM_READ:UVM_WRITE;
     rw.addr = apb.PADDR;
     rw.data =(rw.kind==UVM_READ)? apb.PRDATA:apb.PWDATA;
     rw.status = UVM_IS_OK;

     `uvm_info(get_type_name(), $sformatf("The Values of rw.kind =%p", rw), UVM_LOW)
   endfunction
 endclass
