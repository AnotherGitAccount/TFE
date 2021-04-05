module register_file(
	CLK,
	CLK_EN,
	READ_ADDRESS1,
	READ_ADDRESS2,
	WRITE_ADDRESS,
	WRITE_ENABLE,
	WRITE_DATA,
	READ_DATA1,
	READ_DATA2,
	leds
);

input CLK;
input [1:0]  CLK_EN;
input [4:0]  READ_ADDRESS1;
input [4:0]  READ_ADDRESS2;
input [4:0]  WRITE_ADDRESS;
input 		 WRITE_ENABLE;
input [31:0] WRITE_DATA;

output [31:0] READ_DATA1;
output [31:0] READ_DATA2;

output reg [6:0] leds;

register_file_bank port0(
	.clock(CLK),
	.clk_en(CLK_EN[1] | CLK_EN[0]),
	.data(WRITE_DATA),
	.rdaddress(READ_ADDRESS1),
	.wraddress(WRITE_ADDRESS),
	.wren(WRITE_ENABLE & CLK_EN[1]),
	.q(READ_DATA1)
);

register_file_bank port1(
	.clock(CLK),
	.clk_en(CLK_EN[1] | CLK_EN[0]),
	.data(WRITE_DATA),
	.rdaddress(READ_ADDRESS2),
	.wraddress(WRITE_ADDRESS),
	.wren(WRITE_ENABLE & CLK_EN[1]),
	.q(READ_DATA2)
);

always @(posedge(CLK)) begin
	if((CLK_EN[1] == 1'b1) && (WRITE_ADDRESS == 5'b00011) && (WRITE_ENABLE == 1'b1)) begin
		leds <= WRITE_DATA[6:0];
	end
end

endmodule 