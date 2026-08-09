class sl_sequence extends uvm_sequence#(sl_xtn);
	`uvm_object_utils(sl_sequence)

function new(string name ="sl_sequence");
	super.new(name);
endfunction

task body();
	
	req=sl_xtn::type_id::create("req");

	
	start_item(req);
	req.randomize() with {miso_pad_i=='h4;};
	finish_item(req);

endtask
endclass



class sl_sequence1 extends sl_sequence;
	`uvm_object_utils(sl_sequence1)

function new(string name ="sl_sequence1");
	super.new(name);
endfunction

task body();
begin	
	req=sl_xtn::type_id::create("req");

	
	start_item(req);
	req.randomize() with {miso_pad_i=='h4;};
	finish_item(req);


end
endtask
endclass


class sl_sequence2 extends sl_sequence1;
	`uvm_object_utils(sl_sequence2)

function new(string name ="sl_sequence2");
	super.new(name);
endfunction

task body();
begin	
	req=sl_xtn::type_id::create("req");

	
	start_item(req);
	req.randomize() with {miso_pad_i=='h5;};
	finish_item(req);


end
endtask
endclass
class sl_sequence3 extends sl_sequence2;
	`uvm_object_utils(sl_sequence3)

function new(string name ="sl_sequence3");
	super.new(name);
endfunction

task body();
begin	
	req=sl_xtn::type_id::create("req");

	
	start_item(req);
	req.randomize() with {miso_pad_i=='hab;};
	finish_item(req);


end
endtask
endclass







