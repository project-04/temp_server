interface mux_if();

	logic i0,i1,i2,i3, s0,s1, d_out;
	
	modport DRV_MP(
		output i0,i1,i2,i3, s0,s1, input d_out
	);
	
	modport MON_MP(
		input i0,i1,i2,i3, s0,s1, d_out
	);
	
	modport WR_MON_MP(
		input i0,i1,i2,i3, s0,s1
	);
	
	modport RD_MON_MP(
		input d_out
	);
endinterface
