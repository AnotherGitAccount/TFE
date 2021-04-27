`define ST_STOPPED  2'b00
`define ST_STARTING 2'b01
`define ST_STOPPING 2'b10
`define ST_STARTED  2'b11

module ctrlu(
	clk,
	hps_cmd,
	cpu_halt,
	state,
	alive
);

	input  wire       clk;
	input  wire       hps_cmd;
	input  wire 		cpu_halt;
	output reg  [1:0] state;
	output reg        alive;

	always @(posedge(clk)) begin 
		case(state)
			`ST_STOPPED: begin
				if(hps_cmd == 1'b1) begin
					state   <= `ST_STARTING;
				end
			end
			
			`ST_STARTING: begin
				if(hps_cmd == 1'b0) begin
					state    <= `ST_STARTED;
					alive		<= 1'b1;
				end
			end
			
			`ST_STOPPING: begin
				if(hps_cmd == 1'b0) begin
					state   <= `ST_STOPPED;
				end
			end
			
			`ST_STARTED: begin
				if(hps_cmd == 1'b1) begin
					state   <= `ST_STOPPING;
					alive   <= 1'b0;
				end else if(cpu_halt == 1'b1) begin
					state   <= `ST_STOPPED;
					alive   <= 1'b0;
				end
			end
		endcase
	end 

endmodule 