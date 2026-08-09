/*module test_test;
	class test_1;
		rand bit [7:0] temp;

		constraint c1 {temp%5==0;}
		constraint c2 {temp inside{[1:50]};}

		function void post_randomize();
			$write("%d ",temp);
		endfunction

	endclass

	class test_2;
		rand bit [7:0] temp;
		
		int d[]={1,2,3,4,5,6};

		function int fun(int a);
		int ans;
		for(int i=a; i<a; i++)
			ans = i;
		endfunction	

		//foreach(d[i]) d[i]=i+1;
		//d=[1,2,3,4,55,6];

		//constraint c1{temp inside{d};}
		constraint c0{temp == fun(foreach(a[i]));

		function void post_randomize();
			$write("%d ",temp);
		endfunction

	endclass


	test_1 h1;
	test_2 h2;

	initial
	begin
	
		//d=new[10];

		//h1=new;
		//repeat(10) assert(h1.randomize());

		h2=new;
		repeat(10) assert(h2.randomize());

	end
endmodule*/



module test_mailbox;
	
	class packet;
		rand bit [3:0] temp;
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
