module gpu(
	input wire         cpu_clk,
	input wire			 gpu_clk,
	input wire  [6:0]  clk_sequence,
	input wire         wren,
	input wire  [31:0] data,
	input wire  [31:0] address,

	
	input  wire [7:0]   mau_address_mask,
	output wire [127:0] mau_read_data_mask,
	input  wire [127:0] mau_write_data_mask,
	input  wire         mau_wren_mask,
	input  wire         alive,

	output wire         hdmi_sync_h,
	output wire         hdmi_sync_v,
	output wire         hdmi_disp_en,
	output wire [23:0]  hdmi_tx_d,
	output wire  		  hdmi_i2c_scl,
	inout  wire 		  hdmi_i2c_sda,
	input  wire         hdmi_tx_int
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
	
	wire [12:0] address_b;
	
	memory mem(
		.clr(1'b0),
		.clk_a(cpu_clk),
		.clk_en_a(clk_sequence[4] | clk_sequence[6]),
		.clk_b(gpu_clk),
		.wren(wren & clk_sequence[6]),
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
	
	assign mau_read_data_mask = mask;
	
	mask_memory mm(
		.clk(cpu_clk),
		.cpu_clk_en(clk_sequence[4]),
		.cpu_address(data[31:24]),
		.cpu_data_write(128'b0),
		.cpu_wren(1'b0),
		.mau_clk_en(~alive),
		.mau_address(mau_address_mask),
		.mau_data_write(mau_write_data_mask),
		.mau_wren(mau_wren_mask),
		.data_read(mask),
		.alive(alive)
	);
	
	shifter shift(
		.clk(cpu_clk),
		.clk_en(clk_sequence[5]),
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
	
	wire [10:0] cnt_h;
	wire [9:0] cnt_v;
	wire [6:0] blk_x;
	wire [5:0] blk_y;
	wire [2:0] off_x;
	wire [2:0] off_y;
	wire in_mem;
	
	graphic_counter gc(                                    
	  .clk(gpu_clk),
	  .cnt_h(cnt_h),
	  .cnt_v(cnt_v),
	  .blk_x(blk_x),
	  .blk_y(blk_y),
	  .in_mem(in_mem),
	  .off_x(off_x),
	  .off_y(off_y)
	);
	
	synchronizer sync(
		.clk(gpu_clk),
		.cnt_h(cnt_h),
		.cnt_v(cnt_v),
		.sync_h(hdmi_sync_h),
		.sync_v(hdmi_sync_v),
		.disp_en(hdmi_disp_en)     
	);
	
	I2C_HDMI_Config u_I2C_HDMI_Config (
		.iCLK(cpu_clk),
		.iRST_N(1'b1),
		.I2C_SCLK(hdmi_i2c_scl),
		.I2C_SDAT(hdmi_i2c_sda),
		.HDMI_TX_INT(hdmi_tx_int)
	);
	
	reg [5:0] location;
	reg 		 in_mem_reg;
	
	assign address_b = {blk_x, blk_y};
	
	always @(posedge gpu_clk) begin
		location   <= {2'b0, off_x} + {2'b0, off_y} * 5'b01000;
		in_mem_reg <= in_mem;
	end 
	
	wire [3:0] red;
	wire [3:0] green;
	wire [3:0] blue;
		
	assign red   = (in_mem_reg == 1'b1) ? next_redsb[{2'b0, location}   << 2 +: 4] : 4'b0000;
	assign green = (in_mem_reg == 1'b1) ? next_greensb[{2'b0, location} << 2 +: 4] : 4'b0000;
	assign blue  = (in_mem_reg == 1'b1) ? next_bluesb[{2'b0, location}  << 2 +: 4] : 4'b0000;
	
	assign hdmi_tx_d[23:16] = {red, 4'b0};
	assign hdmi_tx_d[15:8]  = {green, 4'b0};
	assign hdmi_tx_d[7:0]   = {blue, 4'b0};
	
endmodule 