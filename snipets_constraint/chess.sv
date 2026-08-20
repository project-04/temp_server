/*
# 0 0 0 0 0 0 0 1
# 0 0 0 0 1 0 0 0
# 0 0 0 0 0 1 0 0
# 0 0 0 1 0 0 0 0
# 0 0 0 0 0 0 1 0
# 0 0 1 0 0 0 0 0
# 0 1 0 0 0 0 0 0
# 1 0 0 0 0 0 0 0
# 
# 
# 1 0 0 0 0 0 0 0
# 0 0 0 0 0 1 0 0
# 0 0 0 0 0 0 0 1
# 0 0 1 0 0 0 0 0
# 0 1 0 0 0 0 0 0
# 0 0 0 1 0 0 0 0
# 0 0 0 0 0 0 1 0
# 0 0 0 0 1 0 0 0
# 
# 
# 0 0 0 1 0 0 0 0
# 0 0 0 0 0 0 0 1
# 1 0 0 0 0 0 0 0
# 0 0 1 0 0 0 0 0
# 0 1 0 0 0 0 0 0
# 0 0 0 0 1 0 0 0
# 0 0 0 0 0 0 1 0
# 0 0 0 0 0 1 0 0
# 
# 
# --------------------------------------------
# 
# 
# 0 0 0 0 0 0 0 0
# 0 0 0 0 0 0 0 0
# 0 0 0 0 0 0 0 0
# 0 0 0 0 0 0 0 0
# 0 0 0 0 0 0 0 0
# 0 1 0 0 0 0 0 0
# 0 0 0 0 0 0 0 1
# 0 0 0 0 0 0 0 0
# horse_1 [6,7]
# horse_2 [5,1]
# 
# 
# 0 0 0 0 0 0 0 0
# 0 0 0 0 0 0 0 1
# 0 0 0 0 0 0 0 0
# 1 0 0 0 0 0 0 0
# 0 0 0 0 0 0 0 0
# 0 0 0 0 0 0 0 0
# 0 0 0 0 0 0 0 0
# 0 0 0 0 0 0 0 0
# horse_1 [1,7]
# horse_2 [3,0]
# 
# 
# 0 0 0 0 0 0 0 0
# 0 0 0 0 0 0 0 0
# 0 0 0 0 0 0 0 0
# 0 0 0 0 0 0 0 0
# 0 0 0 0 0 0 0 0
# 0 0 0 0 0 0 0 0
# 0 0 0 0 0 0 0 0
# 0 0 0 1 0 1 0 0
# horse_1 [7,5]
# horse_2 [7,3]
*/
class test;
	rand bit board[8][8];

	constraint c1{
			foreach(board[j])
				board[0][j] + board[1][j] + board[2][j] + board[3][j] + board[4][j] + board[5][j] + board[6][j] + board[7][j] == 1;
		}

        constraint c2{
			foreach(board[i])
				board[i][0] + board[i][1] + board[i][2] + board[i][3] + board[i][4] + board[i][5] + board[i][6] + board[i][7] == 1;

//board[i].sum == 1; //is not working why?
                }

	/*constraint c3{
			foreach(board[i, j])
				foreach(board[k, l])
					if ((i != k) && (j != l))
						!(board[i][j] && board[k][l] && ((i-k) == (j-l) || (i-k) == -(j-l)));
		}
*/

endclass

class test2;
	rand bit board[8][8];
	
	rand bit [2:0]  r1,r2,c1,c2;
	
	constraint a{ r1 != r2 || c1 != c2;}
	constraint b{
			foreach(board[i,j]){
				if((r1 == i && c1 ==j) || (r2 == i && c2 ==j)) board[i][j] == 1;
				else  board[i][j] == 0;
			}
	}
endclass

module top;
	test h1;
	test2 h2;

	initial begin
		repeat(3)
		begin
			h1 = new();
			void'(h1.randomize());
			foreach(h1.board[i])
			$display("%0p", h1.board[i]);
			$display("\n");
		end	
	
		$display("--------------------------------------------\n\n");
	
		repeat(3)
		begin
			h2 = new();
			void'(h2.randomize());
			foreach(h2.board[i])
			$display("%0p", h2.board[i]);
			$display("horse_1 [%0d,%0d]", h2.r1, h2.c1);
			$display("horse_2 [%0d,%0d]", h2.r2, h2.c2);
			$display("\n");
		end
	end
endmodule
