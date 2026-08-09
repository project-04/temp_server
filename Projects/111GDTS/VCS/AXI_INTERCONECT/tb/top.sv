module top();
bit clock;
bit Resetn;

	import test_packages::*;
	import uvm_pkg::*;

	// Interface Instantiation
	axi_if a_if(clock);
	
	// DUT Instantiation


	initial
		begin
			clock =1'b0;
			forever
			#5 clock =~clock;
		end

		
		

	initial
	  begin

                       `ifdef VCS
                                $fsdbDumpvars(0, top);
                                $fsdbDumpSVA(0, top);
                        `endif

		
		// Set Virtual Interface
		uvm_config_db #(virtual axi_if) :: set(null, "*", "axi_if", a_if);

		//Call Run Test
		run_test();
	  end

	
endmodule


 {xtn.FetchBuffer[7:0],xtn.FetchBuffer[15:8],xtn.FetchBuffer[23:16],xtn.FetchBuffer[31:24],xtn.FetchBuffer[39:32],xtn.FetchBuffer[47:40],xtn.FetchBuffer[55:48],xtn.FetchBuffer[63:56],xtn.FetchBuffer[71:64],xtn.FetchBuffer[79:72],xtn.FetchBuffer[87:80],xtn.FetchBuffer[95:88],xtn.FetchBuffer[103:96],xtn.FetchBuffer[111:104],xtn.FetchBuffer[119:112],xtn.FetchBuffer[127:120],xtn.FetchBuffer[135:128],xtn.FetchBuffer[143:136],xtn.FetchBuffer[151:144],xtn.FetchBuffer[159:152],xtn.FetchBuffer[167:160],xtn.FetchBuffer[175:168],xtn.FetchBuffer[185:176],xtn.FetchBuffer[191:184],xtn.FetchBuffer[199:192],xtn.FetchBuffer[207:200],xtn.FetchBuffer[215:208],xtn.FetchBuffer[223:216],xtn.FetchBuffer[231:224],xtn.FetchBuffer[239:232],xtn.FetchBuffer[247:240],xtn.FetchBuffer[255:248]}
