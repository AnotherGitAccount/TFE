`define IDH 0   // In display horizontal 
`define IDV 0   // In display vertical
`define ODH 848 // Out of display horizontal 
`define ODV 480 // Out of display vertical
`define HFP 16  // Horizontal front porch
`define HS  112 // Horizontal sync
`define VFP 6	 // Vertical front porch
`define VS  8   // Vertical sync
`define HBP 112 // Horizontal back porch
`define VBP 23  // Vertical back porch

module synchronizer(
	input  wire        clk,
	input  wire [10:0] cnt_h,
	input  wire [9:0]  cnt_v,
	output reg         sync_h,
	output reg         sync_v,
	output reg         disp_en     
);

	reg h_disp_band;
	reg v_disp_band;
	reg h_sync_band;
	reg v_sync_band;

	always @(posedge clk) begin
		case(cnt_h) 
			`IDH:	      		 h_disp_band = 1;
			`ODH:              h_disp_band = 0;
			`ODH + `HFP:       h_sync_band = 0;
			`ODH + `HFP + `HS: h_sync_band = 1;
		endcase
		
		case(cnt_v) 
			`IDV:					 v_disp_band = 1;
			`ODV:              v_disp_band = 0;
			`ODV + `VFP:       v_sync_band = 0;
			`ODV + `VFP + `VS: v_sync_band = 1;
		endcase
		
		sync_h <= h_sync_band;
		sync_v <= v_sync_band;
		disp_en <= (h_disp_band & v_disp_band);
	end
endmodule
