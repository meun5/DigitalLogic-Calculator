module FSM(OP, K, PERFORM, IN_WA, RESET, IN_DATA, CLOCK, OUT_DATA, WA, RA, DONE, IN_DONE, IN_STATE, STATE, ALU_SET, ALU_MODE, ALU_READ);
	input [2:0] OP;
	input [1:0] K;
	input [4:0] IN_DATA;
	input [1:0] IN_WA;
	input [4:0] IN_STATE;
	input PERFORM, RESET, CLOCK, IN_DONE;
	
	output reg [4:0] OUT_DATA;
	output reg [4:0] STATE;
	output reg [1:0] WA;
	output reg [1:0] RA;
	output reg DONE;
	output reg ALU_SET, ALU_READ;
	output reg [1:0] ALU_MODE;
	
	always @(posedge CLOCK) begin
		if (PERFORM == 0 && RESET == 0) begin
			DONE = 0;
			STATE = 5'b00000;
		end
		
		if (RESET == 1) begin
			OUT_DATA = 5'b00000;
			WA = 2'b00;
			RA = 2'b00;
			DONE = 1;
			STATE = 5'b00000;
			ALU_MODE = 2'b00;
			ALU_SET = 0;
		end
		
		case ({IN_DONE, PERFORM, OP})
			5'b01000: begin
				case (IN_WA)
					2'b00: begin	
						WA = 2'b01;
						OUT_DATA = 5'b00001;
					end
					2'b01: begin
						WA = 2'b10;
						OUT_DATA = 5'b00010;
					end
					2'b10: begin
						WA = 2'b11;
						OUT_DATA = 5'b00011;
					end
					2'b11: begin
						WA = 2'b00;
						OUT_DATA = 5'b00000;
						DONE = 1;
					end
				endcase
			end
			5'b01001: begin
				WA = 2'b00;
				OUT_DATA = K;
				DONE = 1;
			end
			5'b01010: begin
				RA = K;
				if (IN_STATE == 5'b00001) begin
					WA = 2'b00;
					OUT_DATA = IN_DATA;
					
					STATE = 5'b00000;
					DONE = 1;
				end
				else begin
					STATE = 5'b00001;
				end
			end
			5'b01011: begin
				WA = K;
				RA = 2'b00;
				if (IN_STATE == 5'b00001) begin
					OUT_DATA = IN_DATA;
					
					STATE = 5'b00000;
					DONE = 1;
				end
				
				STATE = 5'b00001;
			end
			5'b01100: begin
				if (IN_STATE == 5'b00100) begin // PUSH IN BUFFER TO OUT BUFFER. WRITE TO R0. DISABLE ALU.
					WA = 2'b00;
					OUT_DATA = IN_DATA;
					
					ALU_SET = 0;
					ALU_READ = 0;
					DONE = 1;
					
					STATE = 5'b00000;
				end
				
				else if (IN_STATE == 5'b00011) begin // PUSH IN BUFFER TO OUT BUFFER. RK SHOULD NOW BE IN THE B LINE. SET ALU TO ADD MODE. READ FROM ALU.
					ALU_READ = 1;
					OUT_DATA = IN_DATA;
					ALU_MODE = 2'b00;
					
					STATE = 5'b00100;
				end
				
				else if (IN_STATE == 5'b00010) begin // READ FROM RK TO BUFFER. DISABLE A READ LINE.
					RA = K;
					ALU_SET = 1;
					
					STATE = 5'b00011;
				end
				
				else if (IN_STATE == 5'b00001) begin // PUSH IN BUFFER TO OUT BUFFER. A SHOULD NOW CONTAIN R0
					OUT_DATA = IN_DATA;
					
					STATE = 5'b00010;
				end
				
				else begin // READ FROM A TO BUFFER
					RA = 2'b00;
					
					STATE = 5'b00001;
				end
			end
			5'b01101: begin
				if (IN_STATE == 5'b00100) begin // PUSH IN BUFFER TO OUT BUFFER. WRITE TO R0. DISABLE ALU.
					WA = 2'b00;
					OUT_DATA = IN_DATA;
					
					ALU_SET = 0;
					ALU_READ = 0;
					DONE = 1;
					
					STATE = 5'b00000;
				end
				
				else if (IN_STATE == 5'b00011) begin // PUSH IN BUFFER TO OUT BUFFER. RK SHOULD NOW BE IN THE B LINE. SET ALU TO SUBTRACT MODE. READ FROM ALU.
					ALU_READ = 1;
					OUT_DATA = IN_DATA;
					ALU_MODE = 2'b01;
					
					STATE = 5'b00100;
				end
				
				else if (IN_STATE == 5'b00010) begin // READ FROM RK TO BUFFER. DISABLE A READ LINE.
					RA = K;
					ALU_SET = 1;
					
					STATE = 5'b00011;
				end
				
				else if (IN_STATE == 5'b00001) begin // PUSH IN BUFFER TO OUT BUFFER. A SHOULD NOW CONTAIN R0
					OUT_DATA = IN_DATA;
					
					STATE = 5'b00010;
				end
				
				else begin // READ FROM A TO BUFFER
					RA = 2'b00;
					
					STATE = 5'b00001;
				end
			end
			5'b01110: begin
				if (IN_STATE == 5'b00100) begin // PUSH IN BUFFER TO OUT BUFFER. WRITE TO R0. DISABLE ALU.
					WA = 2'b00;
					OUT_DATA = IN_DATA;
					
					ALU_SET = 0;
					ALU_READ = 0;
					DONE = 1;
					
					STATE = 5'b00000;
				end
				
				else if (IN_STATE == 5'b00011) begin // PUSH IN BUFFER TO OUT BUFFER. RK SHOULD NOW BE IN THE B LINE. SET ALU TO MULTIPLY MODE. READ FROM ALU.
					ALU_READ = 1;
					OUT_DATA = IN_DATA;
					ALU_MODE = 2'b10;
					
					STATE = 5'b00100;
				end
				
				else if (IN_STATE == 5'b00010) begin // READ FROM RK TO BUFFER. DISABLE A READ LINE.
					RA = K;
					ALU_SET = 1;
					
					STATE = 5'b00011;
				end
				
				else if (IN_STATE == 5'b00001) begin // PUSH IN BUFFER TO OUT BUFFER. A SHOULD NOW CONTAIN R0
					OUT_DATA = IN_DATA;
					
					STATE = 5'b00010;
				end
				
				else begin // READ FROM A TO BUFFER
					RA = 2'b00;
					
					STATE = 5'b00001;
				end
			end
			5'b01111: begin // TODO: FIXME
				if (IN_STATE == 5'b00010) begin // PUSH IN BUFFER TO OUT BUFFER. WRITE TO R0. DISABLE ALU.
					WA = 2'b00;
					OUT_DATA = IN_DATA;
					
					ALU_SET = 0;
					ALU_READ = 0;
					DONE = 1;
					
					STATE = 5'b00000;
				end
				
				else if (IN_STATE == 5'b00001) begin // PUSH IN BUFFER TO OUT BUFFER. A SHOULD NOW CONTAIN RK. SET ALU TO EXPONENT MODE. READ FROM ALU.
					OUT_DATA = IN_DATA;
					ALU_READ = 1;
					ALU_MODE = 2'b11;
					
					STATE = 5'b00010;
				end
				
				else begin // READ FROM RK TO BUFFER
					RA = K;
					
					STATE = 5'b00001;
				end
			end
		endcase
	end
endmodule