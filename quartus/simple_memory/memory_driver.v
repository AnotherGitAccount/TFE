module memory_driver(
	CLK, 
	ADDRESS, 
	RDATA, 
	WDATA, 
	READ,
	WRITE,
	PENDING,
	
	AVL_ADDRESS, 
	AVL_BEGIN, 
	AVL_COUNT, 
	AVL_READ, 
	AVL_WRITE, 
	AVL_RDATA, 
	AVL_WDATA, 
	AVL_WAIT, 
	AVL_RDATA_VALID
);

	// IOS
	input CLK;
	input [25:0] ADDRESS;
	output reg[127:0] RDATA;
	input [127:0] WDATA;
	input READ;
	input WRITE;
	output reg PENDING;

	output reg[25:0] AVL_ADDRESS;
	output reg AVL_BEGIN;
	output [8:0] AVL_COUNT;
	output reg AVL_READ;
	output reg AVL_WRITE;
	input [127:0] AVL_RDATA;
	output reg[127:0] AVL_WDATA;
	input AVL_WAIT;
	input AVL_RDATA_VALID;
	
	// CONSTANTS
	`define READY  2'b00	// READY STATE
	`define WRITE  2'b01 // WRITE STATE
	`define READ   2'b10 // READ  STATE

	// VARIABLES AND INITS
	reg [1:0] state;
	

	initial begin
		state <= `READY;
	end
	
	assign AVL_COUNT = 9'b000000001;
	
	// LOGIC
	always @ (posedge CLK) begin
		case(state)
			`READY:
				begin
					if(READ == 1'b1) 
						begin
							AVL_READ  <= 1'b1;
							AVL_BEGIN <= 1'b1;
							AVL_ADDRESS <= ADDRESS;
							AVL_READ <= 1'b1;
							PENDING <= 1'b1;
						end
					else if(WRITE == 1'b1)
						begin
							AVL_BEGIN <= 1'b1;
							AVL_ADDRESS <= ADDRESS + 32'd1; // The address must be last burst address + 1
							AVL_WDATA <= WDATA;
							AVL_WRITE <= 1'b1;
							PENDING <= 1'b1;
						end
					else
						begin
							state <= `READY;
							AVL_BEGIN <= 1'b0;
							AVL_WRITE <= 1'b0;
							AVL_READ <= 1'b0;
							AVL_WRITE <= 1'b0;
							PENDING <= 1'b0;
						end
				end
			`WRITE:
				begin
					if(AVL_WAIT == 1'b0)
						begin
							AVL_BEGIN   <= 1'b0;
							AVL_ADDRESS <= ADDRESS + 32'd1;
							AVL_WDATA <= WDATA;
							AVL_WRITE <= 1'b1;
							PENDING <= 1'b0;
							state <= `READY;
						end
				end
			`READ:
				begin
					if(AVL_WAIT == 1'b0 && AVL_RDATA_VALID == 1'b0)
						begin
							AVL_BEGIN   <= 1'b0;
							AVL_ADDRESS <= ADDRESS;
							AVL_WRITE <= 1'b0;
							PENDING <= 1'b1;
						end
					else if(AVL_WAIT == 1'b0 && AVL_RDATA_VALID == 1'b1)
						begin
							AVL_BEGIN   <= 1'b0;
							PENDING <= 1'b0;
							AVL_WRITE <= 1'b0;
							RDATA <= AVL_RDATA;
							PENDING <= 1'b0;
							state <= `READY;
						end
				end
		endcase 
	end
	
endmodule 