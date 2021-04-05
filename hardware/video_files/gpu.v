module gpu(
	input wire clk,
	input wire[6:0]  clk_en,
	input wire wren,
	input wire[31:0] data,
	input wire[31:0] address,
	output wire [3:0] red,
	output wire [3:0] green,
	output wire [3:0] blue,
	output wire       sync_h,
	output wire       sync_v,
	output wire       disp_en,
   output wire       pclk	
);

	wire [255:0] reds0;
	wire [255:0] greens0;
	wire [255:0] blues0;
	wire [255:0] reds1;
	wire [255:0] greens1;
	wire [255:0] blues1;
	wire [255:0] reds2;
	wire [255:0] greens2;
	wire [255:0] blues2;
	wire [255:0] reds3;
	wire [255:0] greens3;
	wire [255:0] blues3;
	
	wire [127:0]  mask;
	wire [127:0]  mask0;
	wire [127:0]  mask1;
	wire [127:0]  mask2;
	wire [127:0]  mask3;
	
	wire [255:0] next_redsb;
	wire [255:0] next_greensb;
	wire [255:0] next_bluesb;
	
	wire [255:0] next_reds0;
	wire [255:0] next_greens0;
	wire [255:0] next_blues0;
	wire [255:0] next_reds1;
	wire [255:0] next_greens1;
	wire [255:0] next_blues1;
	wire [255:0] next_reds2;
	wire [255:0] next_greens2;
	wire [255:0] next_blues2;
	wire [255:0] next_reds3;
	wire [255:0] next_greens3;
	wire [255:0] next_blues3;
	
	wire clk12MHz;
	assign pclk = clk12MHz;
	
	wire [12:0] address_b;
	
	memory mem(
		.clk_a(clk),
		.clk_en_a(clk_en[4] | clk_en[6]),
		.clk_b(clk12MHz),
		.wren(wren & address[31] & clk_en[6]),
		.block_address_a(address[18:6]),
		.block_address_b(address_b),
		.reds0(reds0),
		.greens0(greens0),
		.blues0(blues0),
		.reds1(reds1),
		.greens1(greens1),
		.blues1(blues1),
		.reds2(reds2),
		.greens2(greens2),
		.blues2(blues2),
		.reds3(reds3),
		.greens3(greens3),
		.blues3(blues3),
	
		.qreds_b(next_redsb),
		.qgreens_b(next_greensb),
		.qblues_b(next_bluesb),
		.qreds0(next_reds0),
		.qgreens0(next_greens0),
		.qblues0(next_blues0),
		.qreds1(next_reds1),
		.qgreens1(next_greens1),
		.qblues1(next_blues1),
		.qreds2(next_reds2),
		.qgreens2(next_greens2),
		.qblues2(next_blues2),
		.qreds3(next_reds3),
		.qgreens3(next_greens3),
		.qblues3(next_blues3)
	);
	
	mask_rom rom(
		.address(data[31:24]),
		.clock(clk),
		.clken(clk_en[4]),
		.q(mask)
	);
	
	shifter shift(
		.clk(clk),
		.clk_en(clk_en[5]),
		.offset_x(address[5:3]),
		.offset_y(address[2:0]),
		.mask(mask),
		.mask0(mask0),
		.mask1(mask1),
		.mask2(mask2),
		.mask3(mask3)
	);
	
	mlu mask_logic_unit(
		.reds0(next_reds0),
		.greens0(next_greens0),
		.blues0(next_blues0),
		.reds1(next_reds1),
		.greens1(next_greens1),
		.blues1(next_blues1),
		.reds2(next_reds2),
		.greens2(next_greens2),
		.blues2(next_blues2),
		.reds3(next_reds3),
		.greens3(next_greens3),
		.blues3(next_blues3),
	
		.mask0(mask0),
		.mask1(mask1),
		.mask2(mask2),
		.mask3(mask3),
		.primary(data[11:0]),
		.secondary(data[23:12]),
	
		.next_reds0(reds0),
		.next_greens0(greens0),
		.next_blues0(blues0),
		.next_reds1(reds1),
		.next_greens1(greens1),
		.next_blues1(blues1),
		.next_reds2(reds2),
		.next_greens2(greens2),
		.next_blues2(blues2),
		.next_reds3(reds3),
		.next_greens3(greens3),
		.next_blues3(blues3)
	);
	
	// PORT B LOGIC (HDMI CONTROLLER)
	
	graphic_pll pll(
		.refclk(clk),
		.rst(1'b0),
		.outclk_0(clk12MHz)
	);
	
	wire [9:0] cnt_h;
	wire [9:0] cnt_v;
	wire [6:0] blk_x;
	wire [5:0] blk_y;
	wire [2:0] off_x;
	wire [2:0] off_y;
	
	graphic_counter gc(                                    
	  .clk(clk12MHz),
	  .cnt_h(cnt_h),
	  .cnt_v(cnt_v),
	  .blk_x(blk_x),
	  .blk_y(blk_y),
	  .off_x(off_x),
	  .off_y(off_y)
	);
	
	synchronizer sync(
		.clk(clk12MHz),
		.cnt_h(cnt_h),
		.cnt_v(cnt_v),
		.sync_h(sync_h),
		.sync_v(sync_v),
		.disp_en(disp_en)     
	);
	
	wire in_mem;
	reg [5:0] location;
	
	assign in_mem    = (blk_x < 7'd72) & (blk_y < 6'd54);
	assign address_b = {blk_x, blk_y};
	
	always @(posedge clk12MHz) begin
		location  <= {2'b0, off_x} + {2'b0, off_y} * 5'b01000;
	end 
		
	assign red   = (in_mem == 1'b1) ? next_redsb[{2'b0, location} << 2 +: 4]   : 4'b0000;
	assign green = (in_mem == 1'b1) ? next_greensb[{2'b0, location} << 2 +: 4] : 4'b0000;
	assign blue  = (in_mem == 1'b1) ? next_bluesb[{2'b0, location} << 2 +: 4]  : 4'b0000;
	
endmodule 