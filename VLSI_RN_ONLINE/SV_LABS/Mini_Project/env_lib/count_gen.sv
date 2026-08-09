class count_gen;
count_trans trans_h;
count_trans data2send;

mailbox #(count_trans)gen2dr;

function new(mailbox #(count_trans)gen2dr);
	this.gen2dr=gen2dr;
endfunction

virtual task start();
	fork
	begin
		for(int i=0;i<no_of_transaction;i++)
		begin
			this.trans_h=new;
			
			if(trans_h.randomize())
				$display("randomization done");
			else 
				$display("randomization not done");
			//data2send=new trans_h;
			gen2dr.put(trans_h);
			//$display("data2send = %p", trans_h);
			//gen2dr.get(trans_h);
			//$display("gen2dr = %p", trans_h);

		end
	end
	join_none
endtask
endclass
