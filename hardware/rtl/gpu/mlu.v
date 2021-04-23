module mlu(
	input  wire [255:0] reds0,
	input  wire [255:0] greens0,
	input  wire [255:0] blues0,
	input  wire [255:0] reds1,
	input  wire [255:0] greens1,
	input  wire [255:0] blues1,
	input  wire [255:0] reds2,
	input  wire [255:0] greens2,
	input  wire [255:0] blues2,
	input  wire [255:0] reds3,
	input  wire [255:0] greens3,
	input  wire [255:0] blues3,
	
	input  wire [127:0]  mask0,
	input  wire [127:0]  mask1,
	input  wire [127:0]  mask2,
	input  wire [127:0]  mask3,
	input  wire [11:0]   primary,
	input  wire [11:0]   secondary,
	
	output wire [255:0] next_reds0,
	output wire [255:0] next_greens0,
	output wire [255:0] next_blues0,
	output wire [255:0] next_reds1,
	output wire [255:0] next_greens1,
	output wire [255:0] next_blues1,
	output wire [255:0] next_reds2,
	output wire [255:0] next_greens2,
	output wire [255:0] next_blues2,
	output wire [255:0] next_reds3,
	output wire [255:0] next_greens3,
	output wire [255:0] next_blues3
);

	mlu_unit mlu0(
		.reds(reds0),
		.greens(greens0),
		.blues(blues0),
		.mask(mask0),
		.primary(primary),
		.secondary(secondary),
		.next_reds(next_reds0),
		.next_greens(next_greens0),
		.next_blues(next_blues0)
	);

	mlu_unit mlu1(
		.reds(reds1),
		.greens(greens1),
		.blues(blues1),
		.mask(mask1),
		.primary(primary),
		.secondary(secondary),
		.next_reds(next_reds1),
		.next_greens(next_greens1),
		.next_blues(next_blues1)
	);

	mlu_unit mlu2(
		.reds(reds2),
		.greens(greens2),
		.blues(blues2),
		.mask(mask2),
		.primary(primary),
		.secondary(secondary),
		.next_reds(next_reds2),
		.next_greens(next_greens2),
		.next_blues(next_blues2)
	);

	mlu_unit mlu3(
		.reds(reds3),
		.greens(greens3),
		.blues(blues3),
		.mask(mask3),
		.primary(primary),
		.secondary(secondary),
		.next_reds(next_reds3),
		.next_greens(next_greens3),
		.next_blues(next_blues3)
	);

endmodule
