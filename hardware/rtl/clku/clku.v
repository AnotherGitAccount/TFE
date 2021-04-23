module clku(
	clk,
	rst,
	cpu_clk,
	gpu_clk
);
	
	input  wire clk;
	input  wire rst;
	output wire cpu_clk;
	output wire gpu_clk;

	assign cpu_clk = clk;

	graphic_pll pll(
		.refclk(clk),
		.rst(1'b0),
		.outclk_0(gpu_clk)
	);
	
endmodule 