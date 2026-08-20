module test_coverage;

	class packet;
		rand bit [3:0] addr;
		rand bit [3:0] data;

		function void display(string str);
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


	//=====================================================
	// Coverage class - samples packets seen by the driver
	//=====================================================
	class coverage;
		packet p_h;

		covergroup cg_packet;
			option.per_instance = 1;

			cp_addr: coverpoint p_h.addr {
				bins low  = {[0:5]};
				bins mid  = {[6:10]};
				bins high = {[11:15]};
			}

			cp_data: coverpoint p_h.data {
				bins zero   = {0};
				bins max    = {15};
				bins others = {[1:14]};
				//bins test[] = {[0:15]} with ((item%3==0)*item); // only {3,6,9,12,15
			}

			cx_addr_data: cross cp_addr, cp_data;

		endgroup

		function new();
			cg_packet = new();
		endfunction

		function void sample(packet pkt);
			p_h = pkt;
			cg_packet.sample();
		endfunction

		function void report;
			$display("Functional Coverage = %0.2f%%", cg_packet.get_coverage());
		endfunction

	endclass


	class driver;
		packet p_h;
		mailbox #(packet) gen2drv;
		coverage cov;                      // coverage handle added

		function new(mailbox #(packet) gen2drv);
			this.gen2drv = gen2drv;
			cov = new();                    // instantiate coverage
		endfunction

		task start;
		fork
          	repeat(10)
			begin
				gen2drv.get(p_h);
				p_h.display("Recived data");
				cov.sample(p_h);             // sample coverage on received packet
			end
		join_none
		endtask

		function void report;
			cov.report();
		endfunction
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

		function void report;
			drv.report;
		endfunction
	endclass

	env en;
	initial 
	begin
		en = new;
		en.build;
		en.start;
		#100;                 // wait for forked processes to finish
		en.report;             // print final coverage
	end

endmodule





