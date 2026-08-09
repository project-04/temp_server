class count_model;

count_trans w_data;

static logic [3:0]ref_count =0;

mailbox #(count_trans)wrmon2rm;
mailbox #(count_trans)rm2sb;

function new(mailbox #(count_trans)wrmon2rm, mailbox #(count_trans)rm2sb);
	this.wrmon2rm=wrmon2rm;
	this.rm2sb =rm2sb;
endfunction

virtual task count_mod(count_trans model_counter);
begin
	if(model_counter.resetn)
		ref_count <= 4'd0;
	else if(model_counter.load == 1)
		ref_count <= model_counter.data_in;
	else 
		if(model_counter.up_down == 1)
			if(ref_count == 4'd11) ref_count <= 4'd0;
			else ref_count <= ref_count+1'b1;
		else
			if(ref_count == 4'd0) ref_count <= 4'd11;
			else ref_count <= ref_count-1'b1;
end
endtask

virtual task start();
fork
  begin
    forever
      begin
	wrmon2rm.get(w_data);
	count_mod(w_data);
	w_data.count=ref_count;
	rm2sb.put(w_data);
	//$display("rm2sb=%p", rm2sb.peek(w_data));
     end
  end
join_none
endtask
endclass
