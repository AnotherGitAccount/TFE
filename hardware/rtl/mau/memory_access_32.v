`define ST_IDDLE 2'b00
`define ST_READ1 2'b01
`define ST_READ2 2'b10
`define ST_WRITE 2'b11

module memory_access_32(
	clk,
	bus_acknowledge,                  
	bus_irq,                          
	bus_address,                     
	bus_bus_enable,                   
	bus_byte_enable,                  
	bus_rw,                          
	bus_write_data,                   
	bus_read_data,
	address,
	read_data,
	write_data,
	byte_en,
	wren
);

	input  wire 		  clk;
	output reg          bus_acknowledge;                  
	output wire         bus_irq;                          
	input  wire [15:0]  bus_address;                     
	input  wire         bus_bus_enable;                   
	input  wire [3:0]   bus_byte_enable;                  
	input  wire         bus_rw;                         
	input  wire [31:0]  bus_write_data;                   
	output reg  [31:0]  bus_read_data;
	output reg  [31:0]  address;
	input  wire [31:0]  read_data;
	output reg  [31:0]  write_data;
	output wire [3:0]   byte_en;
	output reg          wren;

	reg [1:0] state;
	
	assign bus_irq = 0;
	assign byte_en = bus_byte_enable;
	
	always @(posedge(clk)) begin
		case(state)
			`ST_IDDLE: begin
				wren <= 1'b0;
				bus_acknowledge <= 1'b0;
				address <= {14'b0, bus_address, 2'b0};
				// bus_enable is high when data on bus is valid
				if((bus_bus_enable == 1'b1) && (bus_acknowledge == 1'b0)) begin
					if(bus_rw == 1'b0) begin
						state <= `ST_WRITE;
					end else begin
						state <= `ST_READ1;
					end
				end else begin
					state <= `ST_IDDLE;
				end
			end
			
			`ST_READ1: begin
				// This state is only used to add latency and let the value be
				// retrieved from the memory
				state <= `ST_READ2;
			end
			
			`ST_READ2: begin
				bus_acknowledge <= 1'b1;
				bus_read_data   <= read_data;
				state <= `ST_IDDLE;
			end
			
			`ST_WRITE: begin
				bus_acknowledge <= 1'b1;
				wren <= 1'b1;
				write_data <= bus_write_data;
				address    <= {14'b0, bus_address, 2'b0};
				state <= `ST_IDDLE;
			end
		endcase
	end

endmodule 
