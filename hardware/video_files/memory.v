module memory(
	input  wire clk_a,
	input  wire clk_b,
	input  wire clk_en_a,
	input  wire wren,
	input  wire [12:0] block_address_a,
	input  wire [12:0] block_address_b,
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
	
	output  wire [255:0] qreds_b,
	output  wire [255:0] qgreens_b,
	output  wire [255:0] qblues_b,
	output  wire [255:0] qreds0,
	output  wire [255:0] qgreens0,
	output  wire [255:0] qblues0,
	output  wire [255:0] qreds1,
	output  wire [255:0] qgreens1,
	output  wire [255:0] qblues1,
	output  wire [255:0] qreds2,
	output  wire [255:0] qgreens2,
	output  wire [255:0] qblues2,
	output  wire [255:0] qreds3,
	output  wire [255:0] qgreens3,
	output  wire [255:0] qblues3
);
	
	wire [6:0] x0;
	wire [5:0] y0;
	wire [6:0] x1;
	wire [5:0] y1;
	wire [6:0] x;
	wire [5:0] y;

	assign x0 = block_address_a[12:6];
	assign y0 = block_address_a[5:0];
	assign x1 = block_address_a[12:6] + 7'b1;
	assign y1 = block_address_a[5:0]  + 6'b1;
	
	assign x = block_address_b[12:6];
	assign y = block_address_b[5:0];
	
	// Switches
	wire [1:0] sw0;
	wire [1:0] sw1;
	wire [1:0] sw2;
	wire [1:0] sw3;
	reg  [1:0] swb;
	
	assign sw0 = { y0[0],  x0[0]};
	assign sw1 = { y0[0], ~x0[0]};
	assign sw2 = {~y0[0],  x0[0]};
	assign sw3 = {~y0[0], ~x0[0]};
	
	always @(posedge clk_b) begin
		swb <= {  y[0],   x[0]};
	end
	
	// Locations
	wire [5:0] xb0;
	wire [4:0] yb0;
	wire [5:0] xb1;
	wire [4:0] yb1;
	wire [5:0] xb2;
	wire [4:0] yb2;
	wire [5:0] xb3;
	wire [4:0] yb3;
	wire [5:0] xbb;
	wire [4:0] ybb;
	
	assign xb0 = (x0[0] == 1'b0) ? x0[6:1] : x1[6:1];
	assign yb0 = (y0[0] == 1'b0) ? y0[5:1] : y1[5:1];
	assign xb1 = (x0[0] == 1'b0) ? x1[6:1] : x0[6:1];
	assign yb1 = (y0[0] == 1'b0) ? y0[5:1] : y1[5:1];
	assign xb2 = (x0[0] == 1'b0) ? x0[6:1] : x1[6:1];
	assign yb2 = (y0[0] == 1'b0) ? y1[5:1] : y0[5:1];
	assign xb3 = (x0[0] == 1'b0) ? x1[6:1] : x0[6:1];
	assign yb3 = (y0[0] == 1'b0) ? y1[5:1] : y0[5:1];
	assign xbb = x[6:1];
	assign ybb = y[5:1];
	
	// BLOCK Screen
	wire [9:0] blkb_addr;
	assign blkb_addr = {4'b0, xbb} + 10'd36 * {5'b0, ybb};
	
	// BLOCK 0
	wire [9:0]    blk0_addr;
	wire [255:0] blk0_red;
	wire [255:0] blk0_green;
	wire [255:0] blk0_blue;
	wire [255:0] blk0_qred;
	wire [255:0] blk0_qgreen;
	wire [255:0] blk0_qblue;
	wire [255:0] blk0_sred;
	wire [255:0] blk0_sgreen;
	wire [255:0] blk0_sblue;
	
	assign blk0_addr = {4'b0, xb0} + 10'd36 * {5'b0, yb0};
	
	assign blk0_red = (sw0 == 2'b00) ? reds0 :
							(sw0 == 2'b01) ? reds1 :
							(sw0 == 2'b10) ? reds2 :
							                 reds3;
													
	assign blk0_green = (sw0 == 2'b00) ? greens0 :
							  (sw0 == 2'b01) ? greens1 :
							  (sw0 == 2'b10) ? greens2 :
							                   greens3;
	
	assign blk0_blue = (sw0 == 2'b00) ? blues0 :
							 (sw0 == 2'b01) ? blues1 :
							 (sw0 == 2'b10) ? blues2 :
							                  blues3;
	
	memory_unit mem0(
		.clock_a(clk_a),
		.clock_b(clk_b),
		.clk_en_a(clk_en_a),
		.wren(wren),
		.address_a(blk0_addr),
		.address_b(blkb_addr),
		.reds(blk0_red),
		.greens(blk0_green),
		.blues(blk0_blue),
		.qreds(blk0_qred),
		.qgreens(blk0_qgreen),
		.qblues(blk0_qblue),
		.sreds(blk0_sred),
		.sgreens(blk0_sgreen),
		.sblues(blk0_sblue)
	);
	
	
	// BLOCK 1
	wire [9:0]    blk1_addr;
	wire [255:0] blk1_red;
	wire [255:0] blk1_green;
	wire [255:0] blk1_blue;
	wire [255:0] blk1_qred;
	wire [255:0] blk1_qgreen;
	wire [255:0] blk1_qblue;
	wire [255:0] blk1_sred;
	wire [255:0] blk1_sgreen;
	wire [255:0] blk1_sblue;
	
	assign blk1_addr = {4'b0, xb1} + 10'd36 * {5'b0, yb1};
	
	assign blk1_red = (sw1 == 2'b00) ? reds0 :
							(sw1 == 2'b01) ? reds1 :
							(sw1 == 2'b10) ? reds2 :
							                 reds3;
													
	assign blk1_green = (sw1 == 2'b00) ? greens0 :
							  (sw1 == 2'b01) ? greens1 :
							  (sw1 == 2'b10) ? greens2 :
							                   greens3;
	
	assign blk1_blue = (sw1 == 2'b00) ? blues0 :
							 (sw1 == 2'b01) ? blues1 :
							 (sw1 == 2'b10) ? blues2 :
							                  blues3;
	
	memory_unit mem1(
		.clock_a(clk_a),
		.clock_b(clk_b),
		.clk_en_a(clk_en_a),
		.wren(wren),
		.address_a(blk1_addr),
		.address_b(blkb_addr),
		.reds(blk1_red),
		.greens(blk1_green),
		.blues(blk1_blue),
		.qreds(blk1_qred),
		.qgreens(blk1_qgreen),
		.qblues(blk1_qblue),
		.sreds(blk1_sred),
		.sgreens(blk1_sgreen),
		.sblues(blk1_sblue)
	);
	
	// BLOCK 2
	wire [9:0]    blk2_addr;
	wire [255:0] blk2_red;
	wire [255:0] blk2_green;
	wire [255:0] blk2_blue;
	wire [255:0] blk2_qred;
	wire [255:0] blk2_qgreen;
	wire [255:0] blk2_qblue;
	wire [255:0] blk2_sred;
	wire [255:0] blk2_sgreen;
	wire [255:0] blk2_sblue;
	
	assign blk2_addr = {4'b0, xb2} + 10'd36 * {5'b0, yb2};
	
	assign blk2_red = (sw2 == 2'b00) ? reds0 :
							(sw2 == 2'b01) ? reds1 :
							(sw2 == 2'b10) ? reds2 :
							                 reds3;
													
	assign blk2_green = (sw2 == 2'b00) ? greens0 :
							  (sw2 == 2'b01) ? greens1 :
							  (sw2 == 2'b10) ? greens2 :
							                   greens3;
	
	assign blk2_blue = (sw2 == 2'b00) ? blues0 :
							 (sw2 == 2'b01) ? blues1 :
							 (sw2 == 2'b10) ? blues2 :
							                  blues3;
	
	memory_unit mem2(
		.clock_a(clk_a),
		.clock_b(clk_b),
		.clk_en_a(clk_en_a),
		.wren(wren),
		.address_a(blk2_addr),
		.address_b(blkb_addr),
		.reds(blk2_red),
		.greens(blk2_green),
		.blues(blk2_blue),
		.qreds(blk2_qred),
		.qgreens(blk2_qgreen),
		.qblues(blk2_qblue),
		.sreds(blk2_sred),
		.sgreens(blk2_sgreen),
		.sblues(blk2_sblue)
	);
	
	// BLOCK 3
	wire [9:0]    blk3_addr;
	wire [255:0] blk3_red;
	wire [255:0] blk3_green;
	wire [255:0] blk3_blue;
	wire [255:0] blk3_qred;
	wire [255:0] blk3_qgreen;
	wire [255:0] blk3_qblue;
	wire [255:0] blk3_sred;
	wire [255:0] blk3_sgreen;
	wire [255:0] blk3_sblue;
	
	assign blk3_addr = {4'b0, xb3} + 10'd36 * {5'b0, yb3};
	
	assign blk3_red = (sw3 == 2'b00) ? reds0 :
							(sw3 == 2'b01) ? reds1 :
							(sw3 == 2'b10) ? reds2 :
							                 reds3;
													
	assign blk3_green = (sw3 == 2'b00) ? greens0 :
							  (sw3 == 2'b01) ? greens1 :
							  (sw3 == 2'b10) ? greens2 :
							                   greens3;
	
	assign blk3_blue = (sw3 == 2'b00) ? blues0 :
							 (sw3 == 2'b01) ? blues1 :
							 (sw3 == 2'b10) ? blues2 :
							                  blues3;
	
	memory_unit mem3(
		.clock_a(clk_a),
		.clock_b(clk_b),
		.clk_en_a(clk_en_a),
		.wren(wren),
		.address_a(blk3_addr),
		.address_b(blkb_addr),
		.reds(blk3_red),
		.greens(blk3_green),
		.blues(blk3_blue),
		.qreds(blk3_qred),
		.qgreens(blk3_qgreen),
		.qblues(blk3_qblue),
		.sreds(blk3_sred),
		.sgreens(blk3_sgreen),
		.sblues(blk3_sblue)
	);
	
	// Port b
	assign qreds_b = (swb == 2'b00) ? blk0_sred :
						  (swb == 2'b01) ? blk1_sred :
						  (swb == 2'b10) ? blk2_sred :
							                blk3_sred;
												 
	assign qgreens_b = (swb == 2'b00) ? blk0_sgreen :
						    (swb == 2'b01) ? blk1_sgreen :
						    (swb == 2'b10) ? blk2_sgreen :
							                  blk3_sgreen;
												 
	assign qblues_b = (swb == 2'b00) ? blk0_sblue :
						   (swb == 2'b01) ? blk1_sblue :
						   (swb == 2'b10) ? blk2_sblue :
							                 blk3_sblue;
	
	// First
	assign qreds0 = (sw0 == 2'b00) ? blk0_qred :
						 (sw0 == 2'b01) ? blk1_qred :
						 (sw0 == 2'b10) ? blk2_qred :
							               blk3_qred;
												 
	assign qgreens0 = (sw0 == 2'b00) ? blk0_qgreen :
						   (sw0 == 2'b01) ? blk1_qgreen :
						   (sw0 == 2'b10) ? blk2_qgreen :
							                 blk3_qgreen;
												 
	assign qblues0 = (sw0 == 2'b00) ? blk0_qblue :
						  (sw0 == 2'b01) ? blk1_qblue :
						  (sw0 == 2'b10) ? blk2_qblue :
							                blk3_qblue;
	
	// Second
	assign qreds1 = (sw1 == 2'b00) ? blk0_qred :
						 (sw1 == 2'b01) ? blk1_qred :
						 (sw1 == 2'b10) ? blk2_qred :
							               blk3_qred;
												 
	assign qgreens1 = (sw1 == 2'b00) ? blk0_qgreen :
						   (sw1 == 2'b01) ? blk1_qgreen :
						   (sw1 == 2'b10) ? blk2_qgreen :
							                 blk3_qgreen;
												 
	assign qblues1 = (sw1 == 2'b00) ? blk0_qblue :
						  (sw1 == 2'b01) ? blk1_qblue :
						  (sw1 == 2'b10) ? blk2_qblue :
							                blk3_qblue;
	
	// Third
	assign qreds2 = (sw2 == 2'b00) ? blk0_qred :
						 (sw2 == 2'b01) ? blk1_qred :
						 (sw2 == 2'b10) ? blk2_qred :
							               blk3_qred;
												 
	assign qgreens2 = (sw2 == 2'b00) ? blk0_qgreen :
						   (sw2 == 2'b01) ? blk1_qgreen :
						   (sw2 == 2'b10) ? blk2_qgreen :
							                 blk3_qgreen;
												 
	assign qblues2 = (sw2 == 2'b00) ? blk0_qblue :
						  (sw2 == 2'b01) ? blk1_qblue :
						  (sw2 == 2'b10) ? blk2_qblue :
							                blk3_qblue;
	
	// Fourth
	assign qreds3 = (sw3 == 2'b00) ? blk0_qred :
						 (sw3 == 2'b01) ? blk1_qred :
						 (sw3 == 2'b10) ? blk2_qred :
							               blk3_qred;
												 
	assign qgreens3 = (sw3 == 2'b00) ? blk0_qgreen :
						   (sw3 == 2'b01) ? blk1_qgreen :
						   (sw3 == 2'b10) ? blk2_qgreen :
							                 blk3_qgreen;
												 
	assign qblues3 = (sw3 == 2'b00) ? blk0_qblue :
						  (sw3 == 2'b01) ? blk1_qblue :
						  (sw3 == 2'b10) ? blk2_qblue :
							                blk3_qblue;
endmodule 