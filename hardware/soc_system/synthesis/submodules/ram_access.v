`define S_IDDLE          4'b0000
`define S_SIMPLE_WRITE   4'b0001
`define S_SIMPLE_READ    4'b0010
`define S_WRITE_ADDRESS  4'b0011
`define S_WRITE_DATA     4'b0100
`define S_WRITE_RESPONSE 4'b0101
`define S_READ_ADDRESS   4'b0110
`define S_READ_DATA      4'b0111
`define S_RESET          4'b1000

`define READ  1'b0
`define WRITE 1'b1

`define ACP_BASE_ADDRESS 32'h80000000

module ram_access(
    // AXI general signals
    input wire ACLK,
    input wire ARESETn,

    // AXI Read Address Channel
    output reg  [31:0] ARADDR,       
    output reg  [2:0]  ARPROT,
    output reg  ARVALID, 
    input  wire ARREADY, 
    output reg  [3:0] ARCACHE,
    output reg  ARUSER,
    
    // AXI Read Data Channel
    input  wire [63:0] RDATA, 
    input  wire RVALID,
    output reg  RREADY,

    // AXI Write Address Channel
    output reg  [31:0] AWADDR,       
    output reg  [2:0]  AWPROT, 
    output reg  AWVALID, 
    input  wire AWREADY, 
    output reg  [3:0] AWCACHE,
    output reg  AWUSER,
    
    // AXI Write Data Channel
    output reg  [63:0] WDATA,
    output reg  WVALID,
    input  wire WREADY,
    output reg  WLAST,
    
    // AXI Write Response Channel
    input  wire BVALID,
    output reg  BREADY,

    // External ports
    input  wire RW,
    input  wire [31:0] ADDRESS,
    input  wire [31:0] IN_DATA,
    output reg  [31:0] OUT_DATA,
    output reg  ACK // Acknowledgement
);
    reg [2:0]  state;
    reg [30:0] cache_base;
    reg n_coherent;
    reg loaded; // Used to make sure that the cache takes the first line in memory
    reg located;
     
    reg [31:0] lines [1:0]; 

    always @(posedge(ACLK)) begin
        AWPROT <= 3'b000;
        ARPROT <= 3'b000;
          
        if(ARESETn) begin
            // Sets all AXI signals and ACK to 0
            AWADDR  <= 32'd0;
            AWVALID <= 1'b0;
            AWCACHE <= 4'b0000;
            AWUSER  <= 1'b0;
            WVALID  <= 1'b0;
            WDATA   <= 32'd0;
            BREADY  <= 1'b0;
            ARADDR  <= 32'd0;
            ARVALID <= 1'b0;
            ARCACHE <= 4'b0000;
            ARUSER  <= 1'b0;
            RREADY  <= 2'b0;
            ACK     <= 1'b0;
            state   <= `S_RESET;
        end else begin
            located = (ADDRESS[31:1] == cache_base);
                
            case (state)
                `S_IDDLE: begin
                    ACK <= 1'b0;
                    
                    if ((RW == `WRITE) && located && loaded) begin
                        state <= `S_SIMPLE_WRITE;
                    end else if ((RW == `READ) && located && loaded) begin
                        state <= `S_SIMPLE_READ;
                    end else if (!loaded || (!n_coherent && !located)) begin
                        // Maps the address and aligns it on 64 bits data words
                        ARADDR  <= `ACP_BASE_ADDRESS + ADDRESS & 32'hfffffffe;
                        ARVALID <= 1'b1;
                        ARCACHE <= 4'b1111;
                        ARUSER  <= 1'b1;
                        ACK     <= 1'b0;
                        state <= `S_READ_ADDRESS;
                    end else if (n_coherent && !located && loaded) begin
                        // Maps the address and aligns it on 64 bits data words
                        AWADDR  <= `ACP_BASE_ADDRESS + {cache_base, 1'b0};
                        AWVALID <= 1'b1;
                        AWCACHE <= 4'b1111;
                        AWUSER  <= 1'b1;
                        ACK     <= 1'b0;
                        state <= `S_WRITE_ADDRESS;
                    end
                end 
                
                `S_SIMPLE_WRITE: begin
                    // Writes in
                    lines[ADDRESS[0]] <= IN_DATA;
                    n_coherent <= 1'b1;
                    ACK   <= 1'b1;
                    state <= `S_IDDLE;
                end
                
                `S_SIMPLE_READ: begin
                    // Reads in
                    OUT_DATA <= lines[ADDRESS[0]];
                    ACK      <= 1'b1;
                    state    <= `S_IDDLE;
                end
                
                `S_WRITE_ADDRESS: begin
                    if (AWREADY) begin
                        // Sets all signals to low
                        AWADDR  <= 32'd0;
                        AWVALID <= 1'b0;
                        AWCACHE <= 4'b0000;
                        AWUSER  <= 1'b0;
                        // Moves to next state
                        WVALID  <= 1'b1;
                        WDATA   <= {lines[1], lines[0]};
                        WLAST   <= 1'b1;
                        state   <= `S_WRITE_DATA;
                    end
                end
                
                `S_WRITE_DATA: begin
                    if (WREADY) begin
                        // Sets all signals to low
                        WVALID <= 1'b0;
                        WDATA  <= 32'd0;
                        WLAST  <= 1'b0;
                        // Moves to next state
                        BREADY <= 1'b1;
                        state  <= `S_WRITE_RESPONSE;
                    end
                end
                
                `S_WRITE_RESPONSE: begin
                    if (BVALID) begin
                        // Sets all signals to low
                        BREADY <= 1'b0;
                        // Moves to next state
                        // Maps the address and aligns it on 64 bits data words
                        ARADDR     <= `ACP_BASE_ADDRESS + ADDRESS & 32'hfffffffe;
                        ARVALID    <= 1'b1;
                        ARCACHE    <= 4'b1111;
                        ARUSER     <= 1'b1;
                        n_coherent <= 1'b0;
                        state      <= `S_READ_ADDRESS;
                    end
                end
                    
                `S_READ_ADDRESS: begin
                    if (ARREADY) begin
                        // Sets all signals to low
                        ARADDR  <= 32'd0;
                        ARVALID <= 1'b0;
                        ARCACHE <= 4'b0000;
                        ARUSER  <= 1'b0;
                        // Moves to next state
                        RREADY  <= 1'b1;
                        state   <= `S_READ_DATA;
                    end
                end
                
                `S_READ_DATA: begin
                    if (RVALID) begin
                        // Sets all signals to low
                        RREADY <= 1'b0;
                        // Captures data
                        lines[0]   <= RDATA[31:0];
                        lines[1]   <= RDATA[61:32];
                        cache_base <= ADDRESS[31:1];
                        loaded     <= 1'b1;
                        // Moves to next state
                        state <= `S_IDDLE;
                    end
                end
                
                default: begin // Reset
                    state <= `S_IDDLE;
                end
            endcase
        end
    end
endmodule 