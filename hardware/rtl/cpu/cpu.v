module cpu(
	clk,
	mau_address_im,
	mau_read_data_im,
	mau_write_data_im,
	mau_wren_im,
	mau_address_dm,
	mau_read_data_dm,
	mau_write_data_dm,
	mau_wren_dm,
	mau_address_rf,
	mau_read_data_rf,
	mau_write_data_rf,
	mau_wren_rf,
	alive,
	halt,
	clk_sequence,
	exported_wren,
	exported_data,
	exported_address,
	io_data
);

	input  wire        clk;
	input  wire [31:0] mau_address_im;
	output wire [31:0] mau_read_data_im;
	input  wire [31:0] mau_write_data_im;
	input  wire        mau_wren_im;
	input  wire [31:0] mau_address_dm;
	output wire [31:0] mau_read_data_dm;
	input  wire [31:0] mau_write_data_dm;
	input  wire        mau_wren_dm;
	input  wire [31:0] mau_address_rf;
	output wire [31:0] mau_read_data_rf;
	input  wire [31:0] mau_write_data_rf;
	input  wire        mau_wren_rf;
	input  wire        alive;
	output wire        halt;
	output wire [6:0]  clk_sequence;
	output wire 		 exported_wren;
	output wire [31:0] exported_data;
	output wire [31:0] exported_address;
	input  wire [31:0] io_data;

	clock_controller cc(
		.clk(clk),
		.clk_sequence(clk_sequence),
		.alive(alive)	
	);

	// CONTROL LOGIC

	wire [5:0]  cl_addr;
	wire [11:0] cl_data;

	control_logic clogic(
		.address(cl_addr),
		.clock(clk),
		.clk_en(clk_sequence[1]),
		.q(cl_data)
	);

	// CONTROL SIGNALS

	wire [1:0] pcsel;
	wire       ra2sel;
	wire       wr;
	wire [1:0] wdsel;
	wire       bsel;
	wire       werf;
	wire [3:0] alufn;

	assign pcsel    = cl_data[1:0];
	assign ra2sel   = cl_data[2];
	assign wr       = cl_data[3];
	assign wdsel    = cl_data[5:4];
	assign bsel     = cl_data[6];
	assign werf     = cl_data[7];
	assign alufn    = cl_data[11:8];
	assign exported_wren = wr;

	// PROGRAM COUNTER
	wire [31:0] pc_curr;
	wire [31:0] pc_next;
	wire [31:0] pc_addr;
	wire [15:0] lit;

	program_counter pc(
		.clk(clk),
		.rst(~alive),
		.clk_en(clk_sequence[6]),
		.pcsel(pcsel),
		.pc_in(pc_next),
		.offset(lit),
		.address(pc_addr),
		.pc_out(pc_curr),
		.pc_next(pc_next)
	);
	
	// INSTRUCTION MEMORY

	wire im_clk_en;
	wire [31:0] im_data;
	assign mau_read_data_im = im_data;
	
	instruction_memory im(
		.clk(clk),
		.cpu_clk_en(clk_sequence[0]),
		.cpu_address(pc_curr),
		.cpu_data_write(32'b0),
		.cpu_wren(1'b0),
		.mau_clk_en(~alive),
		.mau_address(mau_address_im),
		.mau_data_write(mau_write_data_im),
		.mau_wren(mau_wren_im),
		.data_read(im_data),
		.alive(alive)
	);
								 
	// OPERATION SIGNALS

	wire [4:0]  ra;
	wire [4:0]  rb;
	wire [4:0]  rc;
	wire [5:0]  opcode;

	assign lit     = im_data[15:0];
	assign rb      = im_data[15:11];
	assign ra      = im_data[20:16];
	assign rc      = im_data[25:21];
	assign opcode  = im_data[31:26];
	assign cl_addr = opcode;
	assign halt    = opcode[5] & opcode[4] & opcode[3] 
						& opcode[2] & opcode[1] & opcode[0];

	// REGISTER FILE
	
	wire [1:0]  rf_clk_en;
	wire [31:0] rf_addr_r1;
	wire [31:0] rf_addr_r2;
	wire [31:0] rf_addr_w;
	wire [31:0] rf_data_w;
	wire [31:0] rf_data_r1;
	wire [31:0] rf_data_r2;

	assign rf_clk_en  = {clk_sequence[5], clk_sequence[2]};
	assign rf_addr_r1 = {25'b0, ra, 2'b0};
	assign rf_addr_r2 = (ra2sel == 1'b0) ? {25'b0, rb, 2'b0} : {25'b0, rc, 2'b0};
	assign rf_addr_w  = {25'b0, rc, 2'b0};
	assign pc_addr    = rf_data_r1;
	
	assign mau_read_data_rf = rf_data_r1; 
	
	register_file rf(
		.clk(clk),
		.cpu_clk_en(rf_clk_en),
		.cpu_read_address1(rf_addr_r1),
		.cpu_read_address2(rf_addr_r2),
		.cpu_write_address(rf_addr_w),
		.cpu_data_write(rf_data_w),
		.cpu_data_read1(rf_data_r1),
		.cpu_data_read2(rf_data_r2),
		.cpu_wren(werf),
		.mau_clk_en(~alive),
		.mau_address(mau_address_rf),
		.mau_data_write(mau_write_data_rf),
		.mau_wren(mau_wren_rf),
		.alive(alive)
	);

	// ALU

	wire [31:0] alu_data_b;
	wire [31:0] alu_res;
	wire [31:0] lit_32;
	
	assign lit_32 = (lit[15] == 1'b0) ? {16'h0000, lit} : {16'hffff, lit};
	assign alu_data_b = (bsel == 1'b0) ? lit_32 : rf_data_r2;

	alu the_alu(
		.clk(clk),
		.clk_en(clk_sequence[3]),
		.data_a(rf_data_r1),
		.data_b(alu_data_b),
		.alufn(alufn),
		.res(alu_res)
	);

	// DATA MEMORY

	wire [31:0] dm_data_r;
	
	assign mau_read_data_dm = dm_data_r;
	assign exported_address = alu_res;
	assign exported_data    = rf_data_r2;
	
	data_memory dm(
		.clk(clk),
		.cpu_clk_en(clk_sequence[4]),
		.cpu_address(alu_res),
		.cpu_data_write(rf_data_r2),
		.cpu_wren(wr & (alu_res[31:30] == 2'b00)),
		.mau_clk_en(~alive),
		.mau_address(mau_address_dm),
		.mau_data_write(mau_write_data_dm),
		.mau_wren(mau_wren_dm),
		.data_read(dm_data_r),
		.alive(alive)
   );
	
	wire [31:0] st_data;
	assign st_data = (alu_res[31:30] == 2'b00) ? dm_data_r : (alu_res[31:30] == 2'b01) ? io_data : 32'b0;

	assign rf_data_w = (wdsel[1] == 1'b0) ? ((wdsel[0] == 1'b0) ? pc_next : alu_res) : st_data;


endmodule 