module moore_vending_mechine(
  input rst, clk, 
  input [1:0] coin,
  output pr_en);
  
  parameter S0 = 3'b000, // 00
  			S1 = 3'b001, // 25
  			S2 = 3'b010, // 50
  			S3 = 3'b011, // 75
  			S4 = 3'b100; // 100
  
  reg [2:0] ps, ns;
  reg [7:0] count_clk;
  reg [2:0] count_sec;
  
  always@(posedge clk, posedge rst)
    begin
      if(rst)
        ps <= S0;
      else
        ps <= ns;
    end
  
  always@(ps, coin)
    begin
      ns = S0;
      case(ps)
        S0 : if(coin==2'b00) ns = S1; // coin=00 -> 25 paise
        else if(coin==2'b01) ns = S2; // coin=01 -> 50 paise
        else if(coin==2'b10) ns = S4; // coin=10 -> 100 paise or 1 rupee
        else if(coin==2'b11) ns = S0; // coin=11 -> no coin
        
        S1 : if(coin==2'b00) ns = S2;
        else if(coin==2'b01) ns = S3;
        else if(coin==2'b10) ns = S4;
        else if(coin==2'b11) ns = S1;
        
        S2 : if(coin==2'b00) ns = S3;
        else if(coin==2'b01) ns = S4;
        else if(coin==2'b10) ns = S4;
        else if(coin==2'b11) ns = S2;
        
        S3 : if(coin==2'b00) ns = S4;
        else if(coin==2'b01) ns = S4;
        else if(coin==2'b10) ns = S4;
        else if(coin==2'b11) ns = S3;
        
        S4 : if(coin==2'b00) ns = S0;
        else if(coin==2'b01) ns = S0;
        else if(coin==2'b10) ns = S0;
        
        default: ns=S0;
      endcase
    end
  
  assign pr_en = (ps == S4) ? 1'b1: 1'b0;
  
  // Logic for counter that counts clock cycles
  always@(posedge clk)
    begin
      if(rst)
        count_clk <= 0;
      else
        begin
          if ((coin == 2'b11) && ((ps == S1) || (ps == S2) || (ps == S3)))
            count_clk <= count_clk + 1'b1;
          else
            count_clk <= 0;
		end
	end

  // Logic for counter that counts sec pulses
  always@(posedge clk)
    begin
      if (rst)
        count_sec <= 0;
      else
        begin
          if (coin != 2'b11)
            count_sec <= 0;
          else
            begin
              if (count_clk == 255)
                begin
                  if (count_sec == 4)
                    begin
                      count_sec <= 0;
                      ns <= S0;
                    end
                  else
                    count_sec <= count_sec + 1'b1;
                end
            end
        end
    end
endmodule
