`define OFF_MAX    3'd7 // MAX max offset

`define HW  11'd1088 // Horizontal total width
`define VW  10'd517 // Vertical total width
`define MIN_BLK_X 8'd17
`define MIN_BLK_Y 6'd3
`define LEN_BLK_X 8'd72
`define LEN_BLK_Y 6'd54

module graphic_counter(                                    
  input				    clk,
  output reg  [10:0]  cnt_h,
  output reg  [9:0]   cnt_v,
  output reg  [6:0]   blk_x,
  output reg  [5:0]   blk_y,
  output reg  [2:0]   off_x,
  output reg  [2:0]   off_y,
  output wire 	 	    in_mem
);

	reg [7:0] blk_x_cnt;
	reg [5:0] blk_y_cnt;
	
	assign in_mem = (blk_x_cnt >= `MIN_BLK_X) & (blk_y_cnt >= `MIN_BLK_Y) & (blk_x_cnt < `MIN_BLK_X + `LEN_BLK_X) & (blk_y_cnt < `MIN_BLK_Y + `LEN_BLK_Y);

	always @(posedge clk) begin
		if (cnt_h == `HW - 1) begin
			cnt_h <= 11'b0;
			off_x <= 3'b0;
			blk_x_cnt <= 8'b0;
			blk_x <= 7'b0;
			
			if (cnt_v == `VW - 1) begin
				cnt_v <= 10'b0;
				off_y <= 3'b0;
				blk_y_cnt <= 6'b0;
				blk_y <= 6'b0;
			end else begin
				cnt_v <= cnt_v + 10'b1;
				
				if (off_y == `OFF_MAX) begin
					off_y <= 3'b0;
					blk_y_cnt <= blk_y_cnt + 6'b1;
					if(blk_y_cnt >= `MIN_BLK_Y) begin
						blk_y <= blk_y + 6'b1;
					end
 				end else begin
					off_y <= off_y + 3'b1;
				end 
			end 
		end else begin
			cnt_h <= cnt_h + 11'b1;
			
			if(off_x == `OFF_MAX) begin
				off_x <= 3'b0;
				blk_x_cnt <= blk_x_cnt + 8'b1;
				if(blk_x_cnt >= `MIN_BLK_X) begin
					blk_x <= blk_x + 7'b1;
				end
			end else begin
				off_x <= off_x + 3'b1;
			end 
		end
	end
	
endmodule
