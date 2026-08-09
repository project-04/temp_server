class ram_ref;

ram_trans wr_h;

static logic [3:0] ref_count=0;

mailbox#(ram_trans) wmon2ref;
mailbox#(ram_trans) ref2sb;

function new(mailbox#(ram_trans) wmon2ref,mailbox#(ram_trans) ref2sb);

this.wmon2ref=wmon2ref;
this.ref2sb=ref2sb;
endfunction

task counter(ram_trans wr_h);
begin
		if(wr_h.reset_n)
			ref_count<=4'd0;

		else if(wr_h.load)
			ref_count<=(wr_h.data_in<=4'd11)?wr_h.data_in:4'd0;
		else if(wr_h.up)
		begin
			if(ref_count>=4'd11)
			ref_count<=4'd0;
			else
			ref_count<=ref_count+1'b1;
		end
		else
		begin
			if(ref_count==4'd0)
			ref_count<=4'd11;
			else
			ref_count<=ref_count-1'b1;
		end	
		
end
endtask


virtual task start();
fork
begin
	fork
	begin 
		forever begin
		wmon2ref.get(wr_h);
		counter(wr_h);
		wr_h.data_out=ref_count;
		ref2sb.put(wr_h);
		end 
	end
	join
end
join_none
endtask


endclass

