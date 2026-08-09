module test_mailbox;
	
	class packet;
		rand bit [3:0] addr;
		rand bit [3:0] data;
		
		function display(string str);
			$display("%s",str);
			$display("addr=%d, data=%d\n", addr, data);
		endfunction

		function void post_randomize;
			display("Randomized data");
		endfunction
	endclass

	class generator;
		packet p_h;
		mailbox #(packet) gen2drv;

		function new(mailbox #(packet) gen2drv);
			this.gen2drv = gen2drv;
		endfunction

		task start;
		fork
			repeat(10)
			begin
				p_h = new;
				assert(p_h.randomize());
				gen2drv.put(p_h);
			end
		join_none
		endtask
	endclass

	class driver;
		packet p_h;
		mailbox #(packet) gen2drv;

		function new(mailbox #(packet) gen2drv);
			this.gen2drv = gen2drv;
		endfunction

		task start;
		fork
			repeat(10)
			begin
				//p_h = new;
				gen2drv.get(p_h);
				p_h.display("Recived data");
			end
		join_none
		endtask
	endclass

	class env;
		mailbox #(packet) gen2drv = new;
		generator gen;
		driver drv;
		
		function void build;
			gen = new(gen2drv);
			drv = new(gen2drv);
		endfunction

		task start;
			gen.start;
			drv.start;
		endtask
	endclass
	
	env en;

	initial 
	begin
		en = new;
		en.build;
		en.start;
		//$display("mailbox=%p",en.gen2drv);
	end
endmodule
