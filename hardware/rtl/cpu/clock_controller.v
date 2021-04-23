module clock_controller(
	input  wire clk,
	output reg  [6:0] clk_sequence,
	input wire alive
);

	reg [2:0] sc; // clk_sequence counter
	
	always @(posedge(clk)) begin
		if(alive) begin
			case(sc)
				3'd0: clk_sequence <= 7'b0000001;
				3'd1: clk_sequence <= 7'b0000010;
				3'd2: clk_sequence <= 7'b0000100;
				3'd3: clk_sequence <= 7'b0001000;
				3'd4: clk_sequence <= 7'b0010000;
				3'd5: clk_sequence <= 7'b0100000;
				3'd6: clk_sequence <= 7'b1000000;
			endcase		
			
			if(sc == 3'd6) begin
				sc <= 3'd0;
			end else begin
				sc <= sc + 3'd1;
			end
		end else begin
			sc   <= 1'b0;
			clk_sequence <= 7'b0000001;
		end
	end
endmodule
