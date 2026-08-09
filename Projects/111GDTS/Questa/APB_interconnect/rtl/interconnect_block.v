module apb_interconnect(
    input p_write,
    input p_enable,
    input p_sel,
    input [3:0]p_slvr_ready,
    input [3:0]p_slvr_slverr,
    input [31:0]p_addr,
    input [31:0]pw_data,
    input [127:0]p_slvr_pr_data,
    output p_slvr_enable,
    output p_slvr_write,
    output reg [3:0]p_slvr_sel,
    output  [31:0]p_slvr_pw_data,
    output reg [31:0]pr_data,
    output reg p_ready,
    output [31:0]paddro,
    output reg p_slverr);

    assign p_slvr_write = p_write;
    assign p_slvr_enable = p_enable;
    assign paddro = p_addr;
    assign p_slvr_pw_data = pw_data; 

    always @(*) 
	begin
		//p_slvr_sel = 4'b0000; 
		if(p_sel)
		begin
			case (p_addr[11:10])  
				2'b00: p_slvr_sel = 4'b0001;
				2'b01: p_slvr_sel = 4'b0010;
				2'b10: p_slvr_sel = 4'b0100;
				2'b11: p_slvr_sel = 4'b1000;
				default: p_slvr_sel = 4'b0000;
			endcase
		end
		else
			p_slvr_sel = 4'b0000;
    	end

    always @(*) 
	begin
			p_ready  = 1'b0;
			//p_slverr = 1'b0;
			pr_data  = 32'b0; 

			case (p_addr[11:10])
			2'b00: begin
					p_ready  = p_slvr_ready[0];
					
					pr_data  = p_slvr_pr_data[31:0];
				end
			2'b01: begin
					p_ready  = p_slvr_ready[1];
					
					pr_data  = p_slvr_pr_data[63:32];
				end
			2'b10: begin
					p_ready  = p_slvr_ready[2];
					
					pr_data  = p_slvr_pr_data[95:64];
				end
			2'b11: begin
					p_ready  = p_slvr_ready[3];
					
					pr_data  = p_slvr_pr_data[127:96];
				end
			
			default : ; //p_slverr = 0;
			endcase
    	end

    always@(*)
        begin
            case(p_addr[11:10])
                2'b00 : p_slverr = p_slvr_slverr[0];
                2'b01 : p_slverr = p_slvr_slverr[1];
                2'b10 : p_slverr = p_slvr_slverr[2];
                2'b11 : p_slverr = p_slvr_slverr[3];
                //default : Pslverr_o = Pslverr_i[0];
            endcase
        end

endmodule


