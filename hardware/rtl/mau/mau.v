module mau(
	clk,
	bus_acknowledge_im,                  
	bus_irq_im,                          
	bus_address_im,                     
	bus_bus_enable_im,                   
	bus_byte_enable_im,                  
	bus_rw_im,                          
	bus_write_data_im,                   
	bus_read_data_im,
	address_im,
	read_data_im,
	write_data_im,
	wren_im,
	bus_acknowledge_dm,                  
	bus_irq_dm,                          
	bus_address_dm,                     
	bus_bus_enable_dm,                   
	bus_byte_enable_dm,                  
	bus_rw_dm,                          
	bus_write_data_dm,                   
	bus_read_data_dm,
	address_dm,
	read_data_dm,
	write_data_dm,
	wren_dm,
	bus_acknowledge_rf,                  
	bus_irq_rf,                          
	bus_address_rf,                     
	bus_bus_enable_rf,                   
	bus_byte_enable_rf,                  
	bus_rw_rf,                          
	bus_write_data_rf,                   
	bus_read_data_rf,
	address_rf,
	read_data_rf,
	write_data_rf,
	wren_rf,
	bus_acknowledge_io,                  
	bus_irq_io,                          
	bus_address_io,                     
	bus_bus_enable_io,                   
	bus_byte_enable_io,                  
	bus_rw_io,                          
	bus_write_data_io,                   
	bus_read_data_io,
	address_io,
	read_data_io,
	write_data_io,
	wren_io,
	bus_acknowledge_mask,                  
	bus_irq_mask,                          
	bus_address_mask,                     
	bus_bus_enable_mask,                   
	bus_byte_enable_mask,                  
	bus_rw_mask,                          
	bus_write_data_mask,                   
	bus_read_data_mask,
	address_mask,
	read_data_mask,
	write_data_mask,
	wren_mask
);

	input  wire 		  clk;
	output wire          bus_acknowledge_im;                  
	output wire         bus_irq_im;                          
	input  wire [31:0]  bus_address_im;                     
	input  wire         bus_bus_enable_im;                   
	input  wire [3:0]   bus_byte_enable_im;                  
	input  wire         bus_rw_im;                          
	input  wire [31:0]  bus_write_data_im;                   
	output wire [31:0]  bus_read_data_im;
	output wire [17:0]  address_im;
	input  wire [31:0]  read_data_im;
	output wire [31:0]  write_data_im;
	output wire         wren_im;
	output wire         bus_acknowledge_dm;                  
	output wire         bus_irq_dm;                          
	input  wire [17:0]  bus_address_dm;                     
	input  wire         bus_bus_enable_dm;                   
	input  wire [3:0]   bus_byte_enable_dm;                  
	input  wire         bus_rw_dm;                          
	input  wire [31:0]  bus_write_data_dm;                   
	output wire [31:0]  bus_read_data_dm;
	output wire [31:0]  address_dm;
	input  wire [31:0]  read_data_dm;
	output wire [31:0]  write_data_dm;
	output wire         wren_dm;
	output wire         bus_acknowledge_rf;                  
	output wire         bus_irq_rf;                          
	input  wire [17:0]  bus_address_rf;                     
	input  wire         bus_bus_enable_rf;                   
	input  wire [3:0]   bus_byte_enable_rf;                  
	input  wire         bus_rw_rf;                          
	input  wire [31:0]  bus_write_data_rf;                   
	output wire [31:0]  bus_read_data_rf;
	output wire [31:0]  address_rf;
	input  wire [31:0]  read_data_rf;
	output wire [31:0]  write_data_rf;
	output wire         wren_rf;
	output wire         bus_acknowledge_io;                  
	output wire         bus_irq_io;                          
	input  wire [17:0]  bus_address_io;                     
	input  wire         bus_bus_enable_io;                   
	input  wire [3:0]   bus_byte_enable_io;                  
	input  wire         bus_rw_io;                          
	input  wire [31:0]  bus_write_data_io;                   
	output wire [31:0]  bus_read_data_io;
	output wire [31:0]  address_io;
	input  wire [31:0]  read_data_io;
	output wire [31:0]  write_data_io;
	output wire         wren_io;
	output wire         bus_acknowledge_mask;                  
	output wire         bus_irq_mask;                          
	input  wire [11:0]  bus_address_mask;                     
	input  wire         bus_bus_enable_mask;                   
	input  wire [15:0]  bus_byte_enable_mask;                  
	input  wire         bus_rw_mask;                          
	input  wire [127:0] bus_write_data_mask;                   
	output wire [127:0] bus_read_data_mask;
	output wire [7:0]   address_mask;
	input  wire [127:0] read_data_mask;
	output wire [127:0] write_data_mask;
	output wire         wren_mask;
	
	memory_access_32 im_memory_access(
		.clk(clk),
		.bus_acknowledge(bus_acknowledge_im),                  
		.bus_irq(bus_irq_im),                          
		.bus_address(bus_address_im[17:2]),                     
		.bus_bus_enable(bus_bus_enable_im),                   
		.bus_byte_enable(bus_byte_enable_im),                  
		.bus_rw(bus_rw_im),                          
		.bus_write_data(bus_write_data_im),                   
		.bus_read_data(bus_read_data_im),
		.address(address_im),
		.read_data(read_data_im),
		.write_data(write_data_im),
		.byte_en(/* Not used */),
		.wren(wren_im)
	);
	
	memory_access_32 dm_memory_access(
		.clk(clk),
		.bus_acknowledge(bus_acknowledge_dm),                  
		.bus_irq(bus_irq_dm),                          
		.bus_address(bus_address_dm[17:2]),                     
		.bus_bus_enable(bus_bus_enable_dm),                   
		.bus_byte_enable(bus_byte_enable_dm),                  
		.bus_rw(bus_rw_dm),                          
		.bus_write_data(bus_write_data_dm),                   
		.bus_read_data(bus_read_data_dm),
		.address(address_dm),
		.read_data(read_data_dm),
		.write_data(write_data_dm),
		.byte_en(/* Not used */),
		.wren(wren_dm)
	);
	
	memory_access_32 rf_memory_access(
		.clk(clk),
		.bus_acknowledge(bus_acknowledge_rf),                  
		.bus_irq(bus_irq_rf),                          
		.bus_address(bus_address_rf[17:2]),                     
		.bus_bus_enable(bus_bus_enable_rf),                   
		.bus_byte_enable(bus_byte_enable_rf),                  
		.bus_rw(bus_rw_rf),                          
		.bus_write_data(bus_write_data_rf),                   
		.bus_read_data(bus_read_data_rf),
		.address(address_rf),
		.read_data(read_data_rf),
		.write_data(write_data_rf),
		.byte_en(/* Not used */),
		.wren(wren_rf)
	);
	
	memory_access_32 io_memory_access(
		.clk(clk),
		.bus_acknowledge(bus_acknowledge_io),                  
		.bus_irq(bus_irq_io),                          
		.bus_address(bus_address_io[17:2]),                     
		.bus_bus_enable(bus_bus_enable_io),                   
		.bus_byte_enable(bus_byte_enable_io),                  
		.bus_rw(bus_rw_io),                          
		.bus_write_data(bus_write_data_io),                   
		.bus_read_data(bus_read_data_io),
		.address(address_io),
		.read_data(read_data_io),
		.write_data(write_data_io),
		.byte_en(/* Not used */),
		.wren(wren_io)
	);

	memory_access_128 mask_memory_access(
		.clk(clk),
		.bus_acknowledge(bus_acknowledge_mask),                  
		.bus_irq(bus_irq_mask),                          
		.bus_address(bus_address_mask[11:4]),                     
		.bus_bus_enable(bus_bus_enable_mask),                   
		.bus_byte_enable(bus_byte_enable_mask),                  
		.bus_rw(bus_rw_mask),                          
		.bus_write_data(bus_write_data_mask),                   
		.bus_read_data(bus_read_data_mask),
		.address(address_mask),
		.read_data(read_data_mask),
		.write_data(write_data_mask),
		.byte_en(/* Not used */),
		.wren(wren_mask)
	);

endmodule 