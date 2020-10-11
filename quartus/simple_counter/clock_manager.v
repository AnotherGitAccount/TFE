// 26 bits counter used to generate a 1Hz
// clock enable
module clock_manager (CLK, CLK_EN);
	input CLK;
	output CLK_EN;

	reg [25:0] cnt;
	reg clk_en;

	// cnt and clk_en are initialy 0 and
	// low (0).
	initial begin
		cnt <= 26'b0;
		clk_en <= 1'b0;
	end

	always @ (posedge CLK)
	begin
		// When the counter reaches 50 000 000 - 1
		// the counter is reset and clk_en goes to
		// high state (1) for 1 clock cycle.
		if(cnt != 26'd49999999) begin
			cnt <= cnt + 26'b1;
			clk_en <= 1'b0;
		end else begin
			cnt <= 26'b0;
			clk_en <= 1'b1;
		end
	end
	
	// The output CLK_EN is always simply connected
	// to clk_en
	assign CLK_EN = clk_en;
endmodule
