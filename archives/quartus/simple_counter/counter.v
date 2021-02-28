// A simple 8bits counter
module counter (CLK, CLK_EN, COUT);
	input CLK, CLK_EN;
	output [7:0] COUT;
	
	reg [7:0] cnt;
	
	// cnt is initialy set to 0
	initial begin
		cnt <= 8'b0;
	end
	
	always @ (posedge CLK)
	begin
		// Increments the counter until it reaches
		// the max value (255 in digital notation)
		// and reset to 0 once reached.
		if(CLK_EN == 1'b1) begin
			if(cnt != 8'b11111111)
				cnt <= cnt + 8'b1;
			else
				cnt <= 8'b0;
		end
	end
	
	// The output is always simply linked to cnt
	assign COUT = cnt;
endmodule
