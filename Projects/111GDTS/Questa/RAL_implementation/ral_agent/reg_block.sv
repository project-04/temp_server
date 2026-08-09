class reg_block extends uvm_reg_block;

	`uvm_object_utils(reg_block)
	
	function new (string name = "reg_block");
		super.new(name,UVM_NO_COVERAGE);
		
	endfunction
	
	mem memh;
	reg_data data;

	uvm_reg_map map1;
//	uvm_reg_map map2;
		
	virtual function void build();
	
		data = reg_data::type_id::create("data");
		data.configure(this,null,"");
		data.build();
		data.add_hdl_path_slice("reg_data",0,8);
		map1 = create_map("map1",8'h0,4,UVM_LITTLE_ENDIAN);
		map1.add_reg(data,8'h0000,"RW");
		



 	     memh = mem::type_id::create("memh");
		memh.configure(this,"");
		memh.add_hdl_path_slice("mem",0,8);
		
		map1 = create_map("map2",8'h0,4,UVM_LITTLE_ENDIAN,0);
		
		map1.add_mem(memh,'h0,"RW");

		add_hdl_path("top.DUV","RTL");
			
		lock_model();

	endfunction
	
endclass



