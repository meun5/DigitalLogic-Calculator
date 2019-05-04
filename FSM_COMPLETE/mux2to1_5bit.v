module mux2to1_5bit(W0, W1, F, S);
	input [4:0] W0;
	input [4:0] W1;
	input S;
	
	output reg [4:0] F;
	
	always @(S) begin
		case (S)
			1'b0: F = W0;
			1'b1: F = W1;
		endcase
	end
endmodule