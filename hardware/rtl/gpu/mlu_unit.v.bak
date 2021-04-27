module mlu_unit(
	input  wire [255:0] reds,
	input  wire [255:0] greens,
	input  wire [255:0] blues,
	input  wire [127:0]  mask,
	input  wire [11:0]   primary,
	input  wire [11:0]   secondary,
	output wire [255:0] next_reds,
	output wire [255:0] next_greens,
	output wire [255:0] next_blues
);

	genvar i;
	generate
		for (i = 0; i < 64; i = i + 1) begin : mlu_unit_loop
			assign next_reds[(i + 1) * 4 - 1 : i * 4] = mask[(i + 1) * 2 - 1 : i * 2] == 2'b00 ? reds[(i + 1) * 4 - 1 : i * 4] :
															        mask[(i + 1) * 2 - 1 : i * 2] == 2'b01 ? primary[11:8]                 :
															        secondary[11:8];
																									 
			assign next_greens[(i + 1) * 4 - 1 : i * 4] = mask[(i + 1) * 2 - 1 : i * 2] == 2'b00 ? greens[(i + 1) * 4 - 1 : i * 4] :
																       mask[(i + 1) * 2 - 1 : i * 2] == 2'b01 ? primary[7:4]                    :
																       secondary[7:4];
																										
			assign next_blues[(i + 1) * 4 - 1 : i * 4] = mask[(i + 1) * 2 - 1 : i * 2] == 2'b00 ? blues[(i + 1) * 4 - 1 : i * 4] :
																	   mask[(i + 1) * 2 - 1 : i * 2] == 2'b01 ? primary[3:0]                   :
																      secondary[3:0];
		end
	endgenerate

endmodule 