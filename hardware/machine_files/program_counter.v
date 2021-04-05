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
	output reg  [31:0] pc_out
);

	always @(posedge(clk)) begin
		if(rst) begin
			pc_out <= 32'b0;
		end 
		
		if(clk_en) begin
			case(pcsel)
				`NORMAL : pc_out <= pc_in + 32'd1;
				
				`BEQ    : 
					begin 
						if (address == 32'b0) begin
							pc_out <= pc_in + 32'd1 + {16'b0, offset};
						end else begin
							pc_out <= pc_in + 32'd1;
						end
					end
					
				`JMP   : pc_out <= address;
				
				`BNE    : 
					begin
						if (address != 32'b0) begin
							pc_out <= pc_in + 32'd1 + {16'b0, offset};
						end else begin
							pc_out <= pc_in + 32'd1;
						end
					end
			endcase		
		end
	end
endmodule
