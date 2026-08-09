interface count_if(input bit clock);

logic [3:0]data_in;
logic [3:0]count;
logic load;
logic up_down;
logic resetn;

clocking dr_cb@(posedge clock);
	default input #1 output #1;
	output data_in;
	output load;
	output up_down;
  output resetn;
endclocking

clocking wr_cb@(posedge clock);
	default input #1 output #1;
	input data_in;
	input load;
	input up_down;
  	input resetn;
  	input count; //
endclocking

clocking rd_cb@(posedge clock);
	default input #1 output #1;
	input count;
	input data_in;//
	input load;//
	input up_down;//
  	input resetn; //
endclocking

modport DRV(clocking dr_cb);

modport WR_MON(clocking wr_cb);

modport RD_MON(clocking rd_cb);

endinterface
