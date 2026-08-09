module decoder(haddr,hwdata,hsel);

     input[31:0]haddr;
     input[31:0]hwdata;
     output reg[2:0]hsel;
always @(*)
     begin
          if(haddr > 32'h8000_0000 && haddr < 32'h8000_03FF)
          begin
               hsel='b001;
          end
          else if(haddr > 32'h8400_0000 && haddr < 32'h8400_03FF)
          begin
               hsel='b010;
          end
          else if(haddr > 32'h8800_0000 && haddr < 32'h8800_03FF)
          begin
               hsel='b100;
          end

     end
endmodule
