module im_dma(					
	input  wire clk,
	
	output reg         bus_acknowledge,                  
	output wire        bus_irq,                          
	input  wire [16:0] bus_address,                     
	input  wire        bus_bus_enable,                   
	input  wire [3:0]  bus_byte_enable,                  
	input  wire        bus_rw,                          
	input  wire [31:0] bus_write_data,                   
	output wire [31:0] bus_read_data,
	
	input  wire        dma_en,
	output reg  [14:0] address,
	output reg  [31:0] data,
	output wire        wren
);

	assign bus_irq = 0;
	assign bus_read_data = 32'b0;
	assign wren = 1'b1;
	
	always @(posedge(clk)) begin
		if(dma_en) begin 
			if(bus_acknowledge == 1'b1) begin
				bus_acknowledge <= 1'b0;
			end else begin
				if(bus_rw == 1'b0) begin
					// Write
					address <= bus_address[16:2];
					data    <= bus_write_data;	
					bus_acknowledge <= 1'b1;
				end else begin
					// Read
					bus_acknowledge <= 1'b1; 
					// Read not supported
				end			
			end
		end else begin
			bus_acknowledge <= 1'b0;
		end
	end

endmodule 