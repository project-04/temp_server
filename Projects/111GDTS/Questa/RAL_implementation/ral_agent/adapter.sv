 class adapter extends uvm_reg_adapter;
   `uvm_object_utils(adapter)

   function new(string name="adapter");
     super.new(name);
   endfunction

   /* Function to convert a register transaction into bus transaction */
   virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
     trans xtn = trans :: type_id :: create("xtn");
     xtn.wr_en = (rw.kind == UVM_READ)? 1'b0 : 1'b1;
     xtn.addr = rw.addr;
     if(rw.kind == UVM_READ)
       xtn.data_out = rw.data;
     else
       xtn.data_in = rw.data;
     return xtn;
   endfunction

   /*Function to convert a bus transactions into a register transactions */
   virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
     trans xtn;
		
     if(!$cast(xtn, bus_item))
       begin
	 `uvm_fatal("not_xtn_type", "Provided bus item is not of the correct type")
	 return;	
       end

     rw.kind =(xtn.wr_en ==1'b0)? UVM_READ:UVM_WRITE;
     rw.addr = xtn.addr;
     rw.data =(rw.kind==UVM_READ)? xtn.data_out:xtn.data_in;
     rw.status = UVM_IS_OK;
     `uvm_info(get_type_name(), $sformatf("The Values of rw.kind =%p", rw), UVM_LOW)
   endfunction
 endclass
