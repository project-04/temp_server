class ram_sb;

event e;

static int data_verified=0;
static int rm_data_count=0;
static int mon_data_count=0;

ram_trans ref_h,cov_data;
ram_trans rdmon_h;

mailbox#(ram_trans) rmon2sb;
mailbox#(ram_trans) ref2sb;

covergroup mem_coverage;
DATA: coverpoint cov_data.data_out{
bins COUNT[] = {1,2,3,4,5,6,7,8,9,10,11};
}

endgroup

function new(mailbox#(ram_trans) ref2sb,mailbox#(ram_trans) rmon2sb);
this.ref2sb=ref2sb;
this.rmon2sb=rmon2sb;
mem_coverage=new();
endfunction


task start();
fork
while(1) begin

	ref2sb.get(ref_h);
	rm_data_count++;

	rmon2sb.get(rdmon_h);
	mon_data_count++;
			
	check(rdmon_h);
end
join_none
endtask

virtual task check(ram_trans data);
	begin
	
	if(data.data_out==ref_h.data_out)
	$display("Counter Working");
	else
	$display("Counter not working");

	cov_data=new ref_h;
	mem_coverage.sample();
	end

	data_verified++;
	
	if(data_verified>=no_of_transaction)
	begin
		->e;
	end
endtask

function void report();
$display("----------------------SCOREBOARD REPORT-----------------------");
$display("%0d read data generated,%0d recieved data recieved,%0d read data verified\n",rm_data_count,mon_data_count,data_verified);
$display(" no of load: %0d , no of up: %0d, no of down: %0d\n",ref_h.no_of_load,ref_h.no_of_up,ref_h.no_of_down);
$display("--------------------------------------------------------------");
endfunction

endclass

