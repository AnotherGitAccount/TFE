module iou(
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
	alive,
	buttons,
	leds,
	switches
);

	input wire         clk;
	input wire         cpu_clk_en;
	input wire  [31:0] cpu_address;
	input wire  [31:0] cpu_data_write;
	input wire         cpu_wren;
	input wire      	 mau_clk_en;
	input wire  [31:0] mau_address;
	input wire  [31:0] mau_data_write;
	input wire         mau_wren;
	input wire 	       alive;
	output reg [31:0] data_read;

	input  wire [1:0]  buttons;
	output reg  [7:0]  leds;
	input  wire [3:0]  switches;
	
	reg [1:0] buttons_reg;
	reg [7:0] leds_reg;
	reg [3:0] switches_reg;
	
	wire [15:0] ram_address;
	wire [31:0] ram_data_write;
	wire 			ram_wren;
	wire			ram_clk_en;

	assign ram_address    = (alive == 1'b0) ? mau_address[16:2] : cpu_address[16:2];
	assign ram_data_write = (alive == 1'b0) ? mau_data_write : cpu_data_write;
	assign ram_wren       = (alive == 1'b0) ? mau_wren : cpu_wren;
	assign ram_clk_en     = (alive == 1'b0) ? mau_clk_en : cpu_clk_en;

	always @(posedge clk) begin
		buttons_reg <= buttons;
		leds <= leds_reg;
		switches_reg <= switches;
		
		if(ram_clk_en == 1'b1) begin
			case(ram_address[1:0])
					2'b00: begin
						// Buttons
						if(ram_wren == 1'b1) begin
							/* not supported */
						end else begin
							data_read <= {30'b0, buttons_reg};
						end
					end
					
					2'b01: begin
						// LEDs
						if(ram_wren == 1'b1) begin
							leds_reg  <= ram_data_write[7:0];
						end else begin
							data_read <= {24'b0, leds_reg};
						end
					end
					
					2'b10: begin
						// SWITCHES
						if(ram_wren == 1'b1) begin
							/* not supported */
						end else begin
							data_read <= {28'b0, switches_reg};
						end
					end
			endcase
		end
	end
endmodule 