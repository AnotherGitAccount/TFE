`define IDDLE     3'b000
`define PENDING_W 3'b001
`define WRITE     3'b010
`define PENDING_R 3'b011
`define READ      3'b100
`define RESET     3'b101
`define RESET_W   3'b110
`define RESET_R   3'b111

`define V_INVALID 2'b00
`define V_CLEAN   2'b10
`define V_DIRTY   2'b11

`define RW_READ  1'b0
`define RW_WRITE 1'b1

module test_memoire(
	input wire clk,
	input wire rst,
	input wire as_read,
	input wire as_write,
	input wire [31:0] as_writedata,
	output reg [31:0] as_readdata,
	output reg as_waitrequest,
	
	input wire inc,
	input wire clear,
	output reg [31:0] data
);

	reg [31:0] cnt;
	reg [31:0] control;
	reg [26:0] address;
	reg [1:0]  validity;
	reg [2:0]  state;
	reg prev_inc;
	
	always @(posedge(clk)) begin
		if(prev_inc) begin
			cnt <= cnt + 1;
		end
		if (rst) begin
			as_waitrequest <= 1'b1;
			
			case (state)
				`IDDLE: 		state <= `RESET;
				`PENDING_W,
				`WRITE: 		state <= `RESET_W;
				`PENDING_R,
				`READ:		state <= `RESET_R;
			endcase
		end else begin
			case (state) 
				`IDDLE: begin
					as_waitrequest <= 1'b1;
					
					if(validity == `V_INVALID) begin
						control <= {4'b0, `RW_READ, address};
						state   <= `PENDING_R;
					end else begin
						// To be sure that only one operation executes
						// when I press inc...
						if(inc && prev_inc) begin
							prev_inc <= 1'b0;
						end
					
						if(!inc && !prev_inc) begin
							prev_inc <= 1'b1;
							address <= address + 27'd4;
							
							if(validity == `V_DIRTY) begin
								control <= {4'b0, `RW_WRITE, address};
								state   <= `PENDING_W;
							end else begin
								control <= {4'b0, `RW_READ, address + 27'd4};
								state   <= `PENDING_R;
							end
						end else if(!clear) begin
						   data     <= 32'b0;
							validity <= `V_DIRTY; 
						end
					end
				end
				
				`PENDING_W: begin
					if(as_read && as_waitrequest) begin
						as_waitrequest <= 1'b0;
						as_readdata    <= control;
						state 			<= `WRITE;
					end else begin
						as_waitrequest <= 1'b1;
					end
				end
				
				`WRITE: begin
					if(as_read && as_waitrequest) begin
						as_waitrequest <= 1'b0;
						as_readdata    <= data;
						control        <= {4'b0, `RW_READ, address};
						state          <= `PENDING_R;
					end else begin
						as_waitrequest <= 1'b1;
					end
				end
				
				`PENDING_R: begin
					if(as_read && as_waitrequest) begin
						as_waitrequest <= 1'b0;
						as_readdata    <= control;
						state				<= `READ;
					end else begin
						as_waitrequest <= 1'b1;
					end
				end
				
				`READ: begin
					if(as_write && as_waitrequest) begin
						as_waitrequest <= 1'b0;
						data 				<= as_writedata;
						validity			<= `V_CLEAN;
						state				<= `IDDLE;
					end else begin
						as_waitrequest <= 1'b1;
					end
				end
				
				`RESET:   state <= `IDDLE;
				`RESET_W: state <= `PENDING_W;
				`RESET_R: state <= `PENDING_R;
			endcase
		end
	end

endmodule

