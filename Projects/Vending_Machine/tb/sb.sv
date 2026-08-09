class sb extends uvm_scoreboard;
	`uvm_component_utils(sb)
	uvm_tlm_analysis_fifo #(wr_trans) wr_fifo;
	uvm_tlm_analysis_fifo #(rd_trans) rd_fifo;
	
	wr_trans wr_data, wr_cov;
	rd_trans rd_data, rd_cov;
	
	covergroup wr_cove;
		option.per_instance = 1;
		c1 : coverpoint wr_cov.reset;
		c2 : coverpoint wr_cov.coin_in;
	endgroup
	
	covergroup rd_cove;
		option.per_instance = 1;
		c1 : coverpoint rd_cov.done_out;
		c2 : coverpoint rd_cov.lsb7seg_out{
			bins b1[] = {7'b0100100, 7'b0010010, 7'b1111000, 7'b0010010, 7'b0001001};
			}
		c3 : coverpoint rd_cov.msb7seg_out{
			bins b2[] = {7'b0010010, 7'b1000000, 7'b0010010, 7'b0001000, 7'b1000000};
			}
	endgroup
	
	
	function new(string name = "sb", uvm_component parent);
		super.new(name, parent);
		wr_fifo = new("wr_fifo", this);
		rd_fifo = new("rd_fifo", this);
		wr_cove = new();
		rd_cove = new();
	endfunction
	
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever
		begin
			wr_fifo.get(wr_data);
			rd_fifo.get(rd_data);
			
			wr_cov = wr_data;
			rd_cov = rd_data;
			
			wr_cove.sample();
			rd_cove.sample();
		end
	endtask
	
	function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		$display("\n\n\nwr_cov = %f", wr_cove.get_inst_coverage);
		$display("rd_cov = %f\n\n\n", rd_cove.get_inst_coverage);
	endfunction
endclass
