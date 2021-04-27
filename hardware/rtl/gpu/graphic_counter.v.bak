`define BLK_H_START 4
`define BLK_H_END   76
`define BLK_V_START 3
`define BLK_V_END   57
`define OFF_MAX     7

`define HW  800 // Horizontal total width
`define VW  525 // Vertical total width

module graphic_counter(                                    
  input				  clk,
  output reg [9:0]  cnt_h,
  output reg [9:0]  cnt_v,
  output reg [6:0]  blk_x,
  output reg [5:0]  blk_y,
  output reg [2:0]  off_x,
  output reg [2:0]  off_y
);

	initial begin 
		cnt_h <= 10'b0;
		cnt_v <= 10'b0;
		blk_x <= 7'b0;
		blk_y <= 6'b0;
		off_x <= 3'b0;
		off_y <= 3'b0;
	end 

	always @(posedge clk) begin
		if (cnt_h == `HW - 1) begin
			cnt_h <= 10'b0;
			off_x <= 3'b0;
			blk_x <= 7'b0;
			
			if (cnt_v == `VW - 1) begin
				cnt_v <= 10'b0;
				off_y <= 3'b0;
				blk_y <= 6'b0;
			end else begin
				cnt_v <= cnt_v + 10'b1;
				
				if (off_y == `OFF_MAX) begin
					off_y <= 3'b0;
					blk_y <= blk_y + 6'b1;
 				end else begin
					off_y <= off_y + 3'b1;
				end 
			end 
		end else begin
			cnt_h <= cnt_h + 10'b1;
			
			if(off_x == `OFF_MAX) begin
				off_x <= 3'b0;
				blk_x <= blk_x + 7'b1;
			end else begin
				off_x <= off_x + 3'b1;
			end 
		end 
	end
	
endmodule
