`define NORMAL 2'b00
`define BEQ    2'b01
`define JMP    2'b10
`define BNE    2'b11

module program_counter(
	input  wire clk,
	input  wire clk_en,
	input  wire rst,
	input  wire [1:0]  pcsel,
	input  wire [31:0] pc_in,
	input  wire [15:0] offset,
	input  wire [31:0] address,
	output reg  [31:0] pc_out,
	output reg  [31:0] pc_next
);
	wire [31:0] offset_32;
	assign offset_32 = (offset[15] == 1'b0) ? {16'h0000, offset} * 32'd4 : {16'hffff, offset} * 32'd4;
	wire [31:0] reg_val;
	assign reg_val = address;

	always @(posedge(clk)) begin
		if(rst) begin
			pc_out  <= 32'b0;
			pc_next <= 32'd4;
		end 
		
		if(clk_en) begin
			case(pcsel)
				`NORMAL : begin 
					pc_out  <= pc_in;
					pc_next <= pc_in + 32'd4;
				end
				
				`BEQ    : begin 
					if (reg_val == 32'b0) begin
						pc_out  <= pc_in + offset_32;
						pc_next <= pc_in + offset_32 + 32'd4;
					end else begin
						pc_out  <= pc_in;
						pc_next <= pc_in + 32'd4;
					end
				end
					
				`JMP   : begin
					pc_out  <= address;
					pc_next <= address + 32'd4;
				end
				
				`BNE    : 
					begin
						if (reg_val != 32'b0) begin
							pc_out  <= pc_in + offset_32;
							pc_next <= pc_in + offset_32 + 32'd4;
						end else begin
							pc_out  <= pc_in;
							pc_next <= pc_in + 32'd4;
						end
					end
			endcase		
		end
	end
endmodule
