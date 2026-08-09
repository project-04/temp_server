module apb_slave (
    input p_clk,       
    input p_rst,      
    input p_sel,     
    input p_enable,  
    input p_write,    
    input [31:0]p_addr,      
    input [31:0]pw_data,     
    output reg [31:0]pr_data,    
    output reg p_ready,    
    output reg p_slverr);

    reg valid_add;

    // Memory for the slave
    reg [31:0] mem [0:15]; 
    integer i;

    always @(posedge p_clk) 
    begin
        if (!p_rst) 
		begin
			//pr_data  <= 32'b0;
			for (i = 0; i < 16; i = i + 1) 
		            begin
				mem[i] <= 'b0;
			    end
        	end 
			
	 else if  (valid_add)
		begin
			if (p_sel && p_enable) 
			   begin
			     if (p_write) 
				begin
				   mem[p_addr[3:0]] <= pw_data;
				end 
			
			  end
                end
	   //else 
	     //begin
			//pr_data  <= 32'b0;
            		//p_ready <= 0;
             //end
    end

/*always@(posedge p_clk)
begin
	if (!p_rst)
		p_slverr <= 0;
	else if(valid_add)
		p_slverr <= 0;
	else
		p_slverr <= 1;
end*/

always@(posedge p_clk)
        begin
            if(!p_rst)
                p_slverr <= 1'b0;
            else
                begin
                    case(valid_add)
                        0 : p_slverr <= 1'b1;
                       1 : p_slverr <= 1'b0;
                    endcase
                end
        end
always@(posedge p_clk)
begin
	if(p_sel && p_enable)
		p_ready <= 1;
	else
		p_ready <= 0;
end

always@(posedge p_clk)
begin
 if (!p_rst) 
	pr_data  <= 32'b0;

   else	if (p_sel && p_enable)
		begin
			if (~p_write)
				begin
					pr_data <= mem[p_addr[3:0]];
				end
		end
end


//assign valid_add = ((p_addr >= 32'h00000000) && (p_addr <= 32'h00000fff))?1'b1: 1'b0;

always@(*)
begin
	if((p_addr >= 32'h00000000) && (p_addr <= 32'h00000fff))
		valid_add = 1'b1;
	else
		valid_add = 1'b0;
end

endmodule


