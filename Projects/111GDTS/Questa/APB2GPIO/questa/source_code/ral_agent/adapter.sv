class rgpio_adapter extends uvm_reg_adapter;
	`uvm_object_utils(rgpio_adapter)

function new(string name ="rgpio_adapter");
	super.new(name);
endfunction

virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);

apb_xtn xtn;

xtn=apb_xtn::type_id::create("xtn");

	xtn.PWRITE=(rw.kind==UVM_WRITE)? 1:0;
	xtn.PADDR=rw.addr;
	xtn.PWDATA=rw.data;
	return xtn;
	// n_bits
	// byte_en
	// status -ok | not ok | x

	endfunction


virtual function void bus2reg(uvm_sequence_item bus_item,ref uvm_reg_bus_op rw);

apb_xtn xtn;

if(!$cast(xtn,bus_item))
	begin
	`uvm_fatal("Adapter","Inside the adapter Casting failed")
	 return;
	end

	rw.kind=(xtn.PWRITE==0)? UVM_READ:UVM_WRITE;
	rw.addr=xtn.PADDR;
	rw.data=xtn.PWDATA;
	rw.status=UVM_IS_OK;
endfunction

endclass
