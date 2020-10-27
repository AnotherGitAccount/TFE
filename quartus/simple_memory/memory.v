module memory(CLK, DRIVER_ADDRESS, DRIVER_RDATA, DRIVER_WDATA, DRIVER_RW, DRIVER_PENDING, ADDRESS, RDATA, WDATA, RW, PENDING);
	// INPUTS
	input CLK;

	output reg[25:0]  DRIVER_ADDRESS;
	input     [127:0] DRIVER_RDATA;
	output reg[127:0] DRIVER_WDATA;
	output reg  	    DRIVER_RW;
	input  			      DRIVER_PENDING;

	input     [31:0] ADDRESS;
	output reg[31:0] RDATA;
	input     [31:0] WDATA;
	input  		       RW;
	output 		       PENDING;

	// CONSTANTS
	`define READY  2'b00	// READY STATE
	`define SET    2'b01 // SET STATE
	`define LOAD   2'b10 // LOAD STATE

	// VARIABLES AND INITS
	reg [1:0]   state;
	reg [1:0]   word_address;
	reg [31:0]  word_data;
	reg [25:0]  cache_address;
	reg [127:0] cache_data;
	reg 			  cache_modified;

	initial begin
		state          <= `READY;
		word_address   <= 2'b0;
		word_data      <= 32'b0;
		cache_address  <= 26'b0;
		cache_data     <= 128'b0;
		cache_modified <= 1'b0;
	end

	// LOGIC
	always @ (posedge CLK) begin
		if(DRIVER_PENDING == 1'b0) begin
			case (state)
				`READY :
					begin
						word_address <= ADDRESS[5:4];
						word_data <= WDATA;
						if(cache_address != ADDRESS[31: 6])
							begin
								if(cache_modified == 1'b0)
									begin
										// Inits cache loading (driver read) and set state to LOAD
										cache_address  <= ADDRESS[31: 6];
										DRIVER_ADDRESS <= ADDRESS[31: 6];
										DRIVER_RW <= 1'b0;
										state <= `LOAD;
									end
								else
									begin
										// Inits cache setting (driver write) and set state to SET
										DRIVER_ADDRESS <= cache_address;
										DRIVER_WDATA   <= cache_data;
										DRIVER_RW      <= 1'b1;
										state          <= `SET;
									end
							end

						if(RW == 1'b0) // Reading in cache
							begin
								case (word_address)
									2'b00 : RDATA <= cache_data[31:0];
									2'b01 : RDATA <= cache_data[63:32];
									2'b10 : RDATA <= cache_data[95:64];
									2'b11 : RDATA <= cache_data[127:96];
								endcase
							end
						else // Writing in cache
							begin
								case (word_address)
									2'b00 : cache_data[31:0]   <= word_data;
									2'b01 : cache_data[63:32]  <= word_data;
									2'b10 : cache_data[95:64]  <= word_data;
									2'b11 : cache_data[127:96] <= word_data;
								endcase
								cache_modified <= 1'b1;
							end
					end

				`SET :
					begin
						// Inits cache loading (driver read) and set state to LOAD
						cache_address  <= ADDRESS[31: 6];
						DRIVER_ADDRESS <= ADDRESS[31: 6];
						DRIVER_RW      <= 1'b0;
						state          <= `LOAD;
					end

				`LOAD :
					begin
						// Reads the new cache value from the driver and set state to READY
						cache_data <= DRIVER_RDATA;
						state      <= `READY;
					end

				default : state <= `READY;
			endcase
		end
	end

	// The memory is pending (not usable) when the state is not equal to READY
	assign PENDING = (state != `READY);
endmodule
