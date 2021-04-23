module mask_memory(
	clk,
	cpu_clk_en,
	cpu_address,
	cpu_data_write,
	cpu_wren,
	mau_clk_en,
	mau_address,
	mau_data_write,
	mau_wren,
	data_read,
	alive
);

	input wire          clk;
	input wire          cpu_clk_en;
	input wire  [7:0]   cpu_address;
	input wire  [127:0] cpu_data_write;
	input wire          cpu_wren;
	input wire      	  mau_clk_en;
	input wire  [7:0]   mau_address;
	input wire  [127:0] mau_data_write;
	input wire          mau_wren;
	input wire 	        alive;
	output wire [127:0] data_read;

	wire [7:0]   ram_address;
	wire [127:0] ram_data_write;
	wire 			 ram_wren;
	wire			 ram_clk_en;

	assign ram_address    = (alive == 1'b0) ? mau_address : cpu_address;
	assign ram_data_write = (alive == 1'b0) ? mau_data_write : cpu_data_write;
	assign ram_wren       = (alive == 1'b0) ? mau_wren : cpu_wren;
	assign ram_clk_en     = (alive == 1'b0) ? mau_clk_en : cpu_clk_en;
		
	ram_256x128 mask_memory_ram(
		.clock(clk),
		.clken(ram_clk_en),
		.address(ram_address),
		.data(ram_data_write),
		.wren(ram_wren),
		.q(data_read)
	);
endmodule 