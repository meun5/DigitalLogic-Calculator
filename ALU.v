module ALU(OP, A, B, RESULT);
	input [1:0] OP;
	input [4:0] A;
	input [4:0] B;
	
	output [4:0] RESULT;
	
	reg [4:0] RESULT;
	
	always @(OP or A or B) begin
		case (OP)
			2'b00: RESULT = A + B;
			2'b01: RESULT = A - B;
			2'b10: RESULT = A * B;
			2'b11: RESULT = 2 ** B;
		endcase
	end
endmodule