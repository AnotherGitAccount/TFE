module memory_unit(
	input  wire          clr,
	input	 wire 			clock_a,
	input  wire				clk_en_a,
	input	 wire 			clock_b,
	input	 wire 		   wren,
	input	 wire [9:0]    address_a,
	input	 wire [9:0]    address_b,
	input	 wire [255:0] reds,
	input	 wire [255:0] greens,
	input	 wire [255:0] blues,
	output wire [255:0] qreds,
	output wire [255:0] qgreens,
	output wire [255:0] qblues,
	output wire [255:0] sreds,
	output wire [255:0] sgreens,
	output wire [255:0] sblues
);

	memory_color_unit red(
		.aclr_a(clr),
		.aclr_b(clr),
		.address_a(address_a),
		.address_b(address_b),
		.clock_a(clock_a),
		.clock_b(clock_b),
		.enable_a(clk_en_a),
		.data_a(reds),
		.data_b(256'b0),
		.wren_a(wren),
		.wren_b(1'b0),
		.q_a(qreds),
		.q_b(sreds)
	);
	
	memory_color_unit green(
		.aclr_a(clr),
		.aclr_b(clr),
		.address_a(address_a),
		.address_b(address_b),
		.clock_a(clock_a),
		.clock_b(clock_b),
		.enable_a(clk_en_a),
		.data_a(greens),
		.data_b(256'b0),
		.wren_a(wren),
		.wren_b(1'b0),
		.q_a(qgreens),
		.q_b(sgreens)
	);

	memory_color_unit blue(
		.aclr_a(clr),
		.aclr_b(clr),
		.address_a(address_a),
		.address_b(address_b),
		.clock_a(clock_a),
		.clock_b(clock_b),
		.enable_a(clk_en_a),
		.data_a(blues),
		.data_b(256'b0),
		.wren_a(wren),
		.wren_b(1'b0),
		.q_a(qblues),
		.q_b(sblues)
	);

endmodule
