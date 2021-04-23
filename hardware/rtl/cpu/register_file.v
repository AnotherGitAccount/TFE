module register_file(
	clk,
	cpu_clk_en,
	cpu_read_address1,
	cpu_read_address2,
	cpu_write_address,
	cpu_data_write,
	cpu_data_read1,
	cpu_data_read2,
	cpu_wren,
	mau_clk_en,
	mau_address,
	mau_data_write,
	mau_wren,
	alive
);

	input  wire        clk;
	input  wire [1:0]  cpu_clk_en;
	input  wire [31:0] cpu_read_address1;
	input  wire [31:0] cpu_read_address2;
	input  wire [31:0] cpu_write_address;
	input  wire [31:0] cpu_data_write;
	output wire [31:0] cpu_data_read1;
	output wire [31:0] cpu_data_read2;
	input  wire        cpu_wren;
	input  wire      	 mau_clk_en;
	input  wire [31:0] mau_address;
	input  wire [31:0] mau_data_write;
	input  wire        mau_wren;
	input  wire        alive;
	
	// MAU uses port 1
	wire [4:0]  ram_read_address1;
	wire [4:0]  ram_write_address;
	wire [31:0] ram_data_write;
	wire 			ram_wren;
	wire			ram_clk_en;

	assign ram_read_address1 = (alive == 1'b0) ? mau_address[6:2] : cpu_read_address1[6:2];
	assign ram_write_address = (alive == 1'b0) ? mau_address[6:2] : cpu_write_address[6:2];
	assign ram_data_write    = (alive == 1'b0) ? mau_data_write : cpu_data_write;
	assign ram_wren          = (alive == 1'b0) ? mau_wren : (cpu_wren & cpu_clk_en[1]);
	assign ram_clk_en        = (alive == 1'b0) ? mau_clk_en : (cpu_clk_en[1] | cpu_clk_en[0]);
	
	register_file_bank port0(
		.clock(clk),
		.clk_en(ram_clk_en),
		.data(ram_data_write),
		.rdaddress(ram_read_address1),
		.wraddress(ram_write_address),
		.wren(ram_wren),
		.q(cpu_data_read1)
	);

	register_file_bank port1(
		.clock(clk),
		.clk_en(ram_clk_en),
		.data(ram_data_write),
		.rdaddress(cpu_read_address2[6:2]),
		.wraddress(ram_write_address),
		.wren(ram_wren),
		.q(cpu_data_read2)
	);

endmodule 