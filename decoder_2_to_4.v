module DECODER_2_TO_4(IN, OUT, ENABLE);
	input [1:0] IN;
	input ENABLE;
	output [3:0] OUT;
	
	reg [3:0] OUT;
	
	always @(IN or ENABLE) begin
		case ({ENABLE, IN})
			3'b100: OUT = 4'b0001;
			3'b101: OUT = 4'b0010;
			3'b110: OUT = 4'b0100;
			3'b111: OUT = 4'b1000;
			default: OUT = 4'b0000;
		endcase
	end
endmodule