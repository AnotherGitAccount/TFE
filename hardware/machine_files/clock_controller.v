module clock_controller(
	input  wire clk,
	output reg  [6:0] clks,
	input  wire [7:0] ctrl_export,
	output reg        alive
);

	reg [2:0] sc; // sequence counter
	
	always @(posedge(clk)) begin
		alive <= ctrl_export[0];
		
		if(ctrl_export[0] == 1'b1) begin
			case(sc)
				3'd0: clks <= 7'b0000001;
				3'd1: clks <= 7'b0000010;
				3'd2: clks <= 7'b0000100;
				3'd3: clks <= 7'b0001000;
				3'd4: clks <= 7'b0010000;
				3'd5: clks <= 7'b0100000;
				3'd6: clks <= 7'b1000000;
			endcase		
			
			if(sc == 3'd6) begin
				sc <= 3'd0;
			end else begin
				sc <= sc + 3'd1;
			end
		end else begin
			sc   <= 1'b0;
			clks <= 7'b0000001;
		end
	end
endmodule
