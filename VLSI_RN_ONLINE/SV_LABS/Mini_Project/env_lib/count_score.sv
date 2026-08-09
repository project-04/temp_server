class count_sb;

event DONE;

count_trans rm_data;
count_trans rdm_data;
count_trans cov_wr_data, cov_rd_data;

static int ref_data, mon_data, data_verified, no_of_data_compared;

mailbox #(count_trans) ref2sb;
mailbox #(count_trans) rdm2sb;


covergroup wr_coverage;
	option.per_instance = 1;
	 
	RST	: coverpoint cov_wr_data.resetn{
						bins resetn[] = {[0:1]};
						}
	DATA	: coverpoint cov_wr_data.data_in iff(!cov_wr_data.resetn){
						bins data_in[] = {[0:11]};
						ignore_bins ignore_data_in = {[12:15]};
						}                               
        MODE	: coverpoint cov_wr_data.up_down iff(!cov_wr_data.resetn){
        					bins up_down[] = {[0:1]};
        					}
	LOAD	: coverpoint cov_wr_data.load iff(!cov_wr_data.resetn){
						bins load[] = {[0:1]};
						}
        MxLDxIN	: cross MODE, LOAD, DATA;
endgroup:wr_coverage

covergroup rd_coverage;
	option.per_instance = 1;
	
	COUNT	: coverpoint cov_rd_data.count iff(!cov_wr_data.resetn){
						bins count[] = {[0:11]};
						ignore_bins ignore_data_in = {[12:15]};
						}
endgroup

function new(mailbox #(count_trans) ref2sb, mailbox #(count_trans)rdm2sb);
	this.ref2sb=ref2sb;
	this.rdm2sb=rdm2sb;
	wr_coverage = new;
	rd_coverage = new;
endfunction


virtual task start();
fork
	forever begin
		ref2sb.get(rm_data);
		ref_data++;
		$display("ref2sb = %p", rm_data);

		rdm2sb.get(rdm_data);
		mon_data++;
		$display("rdm2sb = %p", rdm_data);


		check();
	end
join_none
endtask

virtual task check();
	begin
		if(rm_data.count == rdm_data.count) begin
			$display("Count Matches");
			data_verified++;
			cov_wr_data=new rm_data;
        		wr_coverage.sample();
        		cov_rd_data=new rdm_data;
        		rd_coverage.sample();
		end
		else
			$display("Count not matching");
	end
	
	no_of_data_compared++;
	$display("no_of_transaction 	= %0d",no_of_transaction);
	$display("data_verified 	= %0d",data_verified);
	$display("no_of_data_compared 	= %0d", no_of_data_compared);
	
	if(no_of_data_compared == no_of_transaction)
	begin
		->DONE;
	end
endtask

virtual function void report();
	$display("................SCOREBOARD REPORT..............");
	//$display("ref_data = %0d",ref_data);
	//$display("mon_data = %0d",mon_data);
	$display("data_verified 	= %0d",data_verified);
	$display("no_of_data_compared 	= %0d", no_of_data_compared);
	$display("write coverage 	= %0f", wr_coverage.get_coverage());
	$display("read coverage 	= %0f", rd_coverage.get_coverage());
	$display("..............................................");
endfunction
endclass
