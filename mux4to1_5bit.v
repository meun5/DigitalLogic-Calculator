module mux4to1_5bit(W0, W1, W2, W3, F, S);
	input [4:0] W0;
	input [4:0] W1;
	input [4:0] W2; 
	input [4:0] W3;
	input [0:1] S;
	
	output [4:0] F;
	
	reg [4:0] F;
	
	always @(S) begin
		case ({S})
			2'b00: F = W0;
			2'b01: F = W1;
			2'b10: F = W2;
			2'b11: F = W3;
		endcase
	end
endmodule