

class reg_block extends uvm_reg_block;

	`uvm_object_utils(reg_block)

	LINE_CONTROL_REG lcr_h;
	LINE_STATUS_REG lsr_h;
	INTERRUPT_ENABLE_REG ier_h;
	MODEM_CONTROL_REG mcr_h;
	FIFO_CONTROL_REG fcr_h;
	MODEM_STATUS_REG msr_h;

	function new (string name = "reg_block");
		super.new(name,UVM_NO_COVERAGE);
	endfunction 

	
	function void build();

		lcr_h = LINE_CONTROL_REG::type_id::create("lcr_h");
		lcr_h.build();
		lcr_h.configure(this);
		default_map = create_map("default_map",0,4,UVM_LITTLE_ENDIAN);
		default_map.add_reg(lcr_h,32'hC,"RW");
		lcr_h.add_hdl_path_slice("LCR",0,8);
		add_hdl_path("top.duv1.control","RTL");


		lsr_h = LINE_STATUS_REG::type_id::create("lsr_h");
		lsr_h.build();
		lsr_h.configure(this);
		default_map.add_reg(lsr_h,32'h14,"RW");
		lsr_h.add_hdl_path_slice("LSR",0,8);
		add_hdl_path("top.duv1.control","RTL");




		ier_h = INTERRUPT_ENABLE_REG::type_id::create("ier_h");
		ier_h.build();
		ier_h.configure(this);
		default_map.add_reg(ier_h,32'h4,"RW");
		ier_h.add_hdl_path_slice("IER",0,8);
		add_hdl_path("top.duv1.control","RTL");




		mcr_h = MODEM_CONTROL_REG::type_id::create("mcr_h");
		mcr_h.build();
		mcr_h.configure(this);
		default_map.add_reg(mcr_h,32'h10,"RW");
		mcr_h.add_hdl_path_slice("MCR",0,8);
		add_hdl_path("top.duv1.control","RTL");



		fcr_h = FIFO_CONTROL_REG::type_id::create("fcr_h");
		fcr_h.build();
		fcr_h.configure(this);
		default_map.add_reg(fcr_h,32'h8,"RW");
		fcr_h.add_hdl_path_slice("FCR",0,8);
		add_hdl_path("top.duv1.control","RTL");



		msr_h = MODEM_STATUS_REG::type_id::create("msr_h");		
		msr_h.build();
		msr_h.configure(this);
		default_map.add_reg(msr_h,32'h18,"RW");
		msr_h.add_hdl_path_slice("MSR",0,8);
		add_hdl_path("top.duv1.control","RTL");

		
	endfunction 

endclass
