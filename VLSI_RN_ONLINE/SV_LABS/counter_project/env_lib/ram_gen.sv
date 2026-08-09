class ram_gen;

ram_trans gen_data;
ram_trans data2send;
mailbox#(ram_trans) gen2wdrv;

function new(mailbox#(ram_trans) gen2wdrv);
this.gen2wdrv=gen2wdrv;
this.gen_data=new();
endfunction

virtual task start();
fork
	begin
	for(int i=0;i<no_of_transaction;i++)
	begin
		
		assert(gen_data.randomize());
		data2send=new gen_data;
		gen2wdrv.put(data2send);
		
	end
	end
join_none
endtask

endclass

