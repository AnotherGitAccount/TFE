// soc_system_tb.v

// Generated using ACDS version 16.0 211

`timescale 1 ps / 1 ps
module soc_system_tb (
	);

	wire         soc_system_inst_clk_bfm_clk_clk;                                   // soc_system_inst_clk_bfm:clk -> [soc_system_inst:clk_clk, soc_system_inst_access_bfm:clk, soc_system_inst_hps_0_f2h_cold_reset_req_bfm:clk, soc_system_inst_hps_0_f2h_debug_reset_req_bfm:clk, soc_system_inst_hps_0_f2h_warm_reset_req_bfm:clk, soc_system_inst_reset_bfm:clk]
	wire         soc_system_inst_access_acknowledgement;                            // soc_system_inst:access_acknowledgement -> soc_system_inst_access_bfm:sig_acknowledgement
	wire  [31:0] soc_system_inst_access_bfm_conduit_address;                        // soc_system_inst_access_bfm:sig_address -> soc_system_inst:access_address
	wire   [0:0] soc_system_inst_access_bfm_conduit_rw;                             // soc_system_inst_access_bfm:sig_rw -> soc_system_inst:access_rw
	wire  [31:0] soc_system_inst_access_data_out;                                   // soc_system_inst:access_data_out -> soc_system_inst_access_bfm:sig_data_out
	wire  [31:0] soc_system_inst_access_bfm_conduit_data_in;                        // soc_system_inst_access_bfm:sig_data_in -> soc_system_inst:access_data_in
	wire   [1:0] soc_system_inst_button_pio_external_connection_bfm_conduit_export; // soc_system_inst_button_pio_external_connection_bfm:sig_export -> soc_system_inst:button_pio_external_connection_export
	wire   [3:0] soc_system_inst_dipsw_pio_external_connection_bfm_conduit_export;  // soc_system_inst_dipsw_pio_external_connection_bfm:sig_export -> soc_system_inst:dipsw_pio_external_connection_export
	wire  [27:0] soc_system_inst_hps_0_f2h_stm_hw_events_bfm_conduit_stm_hwevents;  // soc_system_inst_hps_0_f2h_stm_hw_events_bfm:sig_stm_hwevents -> soc_system_inst:hps_0_f2h_stm_hw_events_stm_hwevents
	wire         soc_system_inst_hps_0_hps_io_hps_io_gpio_inst_gpio35;              // [] -> [soc_system_inst:hps_0_hps_io_hps_io_gpio_inst_GPIO35, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_gpio_inst_GPIO35]
	wire         soc_system_inst_hps_0_hps_io_hps_io_spim1_inst_mosi;               // soc_system_inst:hps_0_hps_io_hps_io_spim1_inst_MOSI -> soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_spim1_inst_MOSI
	wire   [0:0] soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_spim1_inst_miso;   // soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_spim1_inst_MISO -> soc_system_inst:hps_0_hps_io_hps_io_spim1_inst_MISO
	wire         soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_mdio;               // [] -> [soc_system_inst:hps_0_hps_io_hps_io_emac1_inst_MDIO, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_emac1_inst_MDIO]
	wire         soc_system_inst_hps_0_hps_io_hps_io_gpio_inst_gpio54;              // [] -> [soc_system_inst:hps_0_hps_io_hps_io_gpio_inst_GPIO54, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_gpio_inst_GPIO54]
	wire         soc_system_inst_hps_0_hps_io_hps_io_gpio_inst_gpio53;              // [] -> [soc_system_inst:hps_0_hps_io_hps_io_gpio_inst_GPIO53, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_gpio_inst_GPIO53]
	wire         soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_tx_clk;             // soc_system_inst:hps_0_hps_io_hps_io_emac1_inst_TX_CLK -> soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_emac1_inst_TX_CLK
	wire         soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_stp;                 // soc_system_inst:hps_0_hps_io_hps_io_usb1_inst_STP -> soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_usb1_inst_STP
	wire         soc_system_inst_hps_0_hps_io_hps_io_i2c0_inst_scl;                 // [] -> [soc_system_inst:hps_0_hps_io_hps_io_i2c0_inst_SCL, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_i2c0_inst_SCL]
	wire         soc_system_inst_hps_0_hps_io_hps_io_sdio_inst_d3;                  // [] -> [soc_system_inst:hps_0_hps_io_hps_io_sdio_inst_D3, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_sdio_inst_D3]
	wire         soc_system_inst_hps_0_hps_io_hps_io_sdio_inst_d2;                  // [] -> [soc_system_inst:hps_0_hps_io_hps_io_sdio_inst_D2, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_sdio_inst_D2]
	wire   [0:0] soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_emac1_inst_rxd3;   // soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_emac1_inst_RXD3 -> soc_system_inst:hps_0_hps_io_hps_io_emac1_inst_RXD3
	wire         soc_system_inst_hps_0_hps_io_hps_io_sdio_inst_d1;                  // [] -> [soc_system_inst:hps_0_hps_io_hps_io_sdio_inst_D1, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_sdio_inst_D1]
	wire         soc_system_inst_hps_0_hps_io_hps_io_sdio_inst_clk;                 // soc_system_inst:hps_0_hps_io_hps_io_sdio_inst_CLK -> soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_sdio_inst_CLK
	wire   [0:0] soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_emac1_inst_rxd2;   // soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_emac1_inst_RXD2 -> soc_system_inst:hps_0_hps_io_hps_io_emac1_inst_RXD2
	wire         soc_system_inst_hps_0_hps_io_hps_io_sdio_inst_d0;                  // [] -> [soc_system_inst:hps_0_hps_io_hps_io_sdio_inst_D0, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_sdio_inst_D0]
	wire         soc_system_inst_hps_0_hps_io_hps_io_spim1_inst_clk;                // soc_system_inst:hps_0_hps_io_hps_io_spim1_inst_CLK -> soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_spim1_inst_CLK
	wire         soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_txd2;               // soc_system_inst:hps_0_hps_io_hps_io_emac1_inst_TXD2 -> soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_emac1_inst_TXD2
	wire         soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_txd3;               // soc_system_inst:hps_0_hps_io_hps_io_emac1_inst_TXD3 -> soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_emac1_inst_TXD3
	wire         soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_txd0;               // soc_system_inst:hps_0_hps_io_hps_io_emac1_inst_TXD0 -> soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_emac1_inst_TXD0
	wire   [0:0] soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_emac1_inst_rxd1;   // soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_emac1_inst_RXD1 -> soc_system_inst:hps_0_hps_io_hps_io_emac1_inst_RXD1
	wire         soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_txd1;               // soc_system_inst:hps_0_hps_io_hps_io_emac1_inst_TXD1 -> soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_emac1_inst_TXD1
	wire   [0:0] soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_emac1_inst_rxd0;   // soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_emac1_inst_RXD0 -> soc_system_inst:hps_0_hps_io_hps_io_emac1_inst_RXD0
	wire         soc_system_inst_hps_0_hps_io_hps_io_gpio_inst_gpio09;              // [] -> [soc_system_inst:hps_0_hps_io_hps_io_gpio_inst_GPIO09, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_gpio_inst_GPIO09]
	wire         soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_mdc;                // soc_system_inst:hps_0_hps_io_hps_io_emac1_inst_MDC -> soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_emac1_inst_MDC
	wire         soc_system_inst_hps_0_hps_io_hps_io_i2c0_inst_sda;                 // [] -> [soc_system_inst:hps_0_hps_io_hps_io_i2c0_inst_SDA, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_i2c0_inst_SDA]
	wire   [0:0] soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_emac1_inst_rx_clk; // soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_emac1_inst_RX_CLK -> soc_system_inst:hps_0_hps_io_hps_io_emac1_inst_RX_CLK
	wire         soc_system_inst_hps_0_hps_io_hps_io_sdio_inst_cmd;                 // [] -> [soc_system_inst:hps_0_hps_io_hps_io_sdio_inst_CMD, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_sdio_inst_CMD]
	wire   [0:0] soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_usb1_inst_dir;     // soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_usb1_inst_DIR -> soc_system_inst:hps_0_hps_io_hps_io_usb1_inst_DIR
	wire   [0:0] soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_emac1_inst_rx_ctl; // soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_emac1_inst_RX_CTL -> soc_system_inst:hps_0_hps_io_hps_io_emac1_inst_RX_CTL
	wire         soc_system_inst_hps_0_hps_io_hps_io_gpio_inst_gpio40;              // [] -> [soc_system_inst:hps_0_hps_io_hps_io_gpio_inst_GPIO40, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_gpio_inst_GPIO40]
	wire         soc_system_inst_hps_0_hps_io_hps_io_gpio_inst_gpio61;              // [] -> [soc_system_inst:hps_0_hps_io_hps_io_gpio_inst_GPIO61, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_gpio_inst_GPIO61]
	wire         soc_system_inst_hps_0_hps_io_hps_io_i2c1_inst_scl;                 // [] -> [soc_system_inst:hps_0_hps_io_hps_io_i2c1_inst_SCL, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_i2c1_inst_SCL]
	wire         soc_system_inst_hps_0_hps_io_hps_io_i2c1_inst_sda;                 // [] -> [soc_system_inst:hps_0_hps_io_hps_io_i2c1_inst_SDA, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_i2c1_inst_SDA]
	wire   [0:0] soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_usb1_inst_clk;     // soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_usb1_inst_CLK -> soc_system_inst:hps_0_hps_io_hps_io_usb1_inst_CLK
	wire         soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d4;                  // [] -> [soc_system_inst:hps_0_hps_io_hps_io_usb1_inst_D4, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_usb1_inst_D4]
	wire         soc_system_inst_hps_0_hps_io_hps_io_uart0_inst_tx;                 // soc_system_inst:hps_0_hps_io_hps_io_uart0_inst_TX -> soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_uart0_inst_TX
	wire         soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_tx_ctl;             // soc_system_inst:hps_0_hps_io_hps_io_emac1_inst_TX_CTL -> soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_emac1_inst_TX_CTL
	wire         soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d5;                  // [] -> [soc_system_inst:hps_0_hps_io_hps_io_usb1_inst_D5, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_usb1_inst_D5]
	wire         soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d6;                  // [] -> [soc_system_inst:hps_0_hps_io_hps_io_usb1_inst_D6, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_usb1_inst_D6]
	wire         soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d7;                  // [] -> [soc_system_inst:hps_0_hps_io_hps_io_usb1_inst_D7, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_usb1_inst_D7]
	wire   [0:0] soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_usb1_inst_nxt;     // soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_usb1_inst_NXT -> soc_system_inst:hps_0_hps_io_hps_io_usb1_inst_NXT
	wire         soc_system_inst_hps_0_hps_io_hps_io_spim1_inst_ss0;                // soc_system_inst:hps_0_hps_io_hps_io_spim1_inst_SS0 -> soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_spim1_inst_SS0
	wire         soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d0;                  // [] -> [soc_system_inst:hps_0_hps_io_hps_io_usb1_inst_D0, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_usb1_inst_D0]
	wire         soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d1;                  // [] -> [soc_system_inst:hps_0_hps_io_hps_io_usb1_inst_D1, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_usb1_inst_D1]
	wire         soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d2;                  // [] -> [soc_system_inst:hps_0_hps_io_hps_io_usb1_inst_D2, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_usb1_inst_D2]
	wire   [0:0] soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_uart0_inst_rx;     // soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_uart0_inst_RX -> soc_system_inst:hps_0_hps_io_hps_io_uart0_inst_RX
	wire         soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d3;                  // [] -> [soc_system_inst:hps_0_hps_io_hps_io_usb1_inst_D3, soc_system_inst_hps_0_hps_io_bfm:sig_hps_io_usb1_inst_D3]
	wire   [0:0] soc_system_inst_memory_bfm_conduit_oct_rzqin;                      // soc_system_inst_memory_bfm:sig_oct_rzqin -> soc_system_inst:memory_oct_rzqin
	wire         soc_system_inst_memory_mem_cas_n;                                  // soc_system_inst:memory_mem_cas_n -> soc_system_inst_memory_bfm:sig_mem_cas_n
	wire         soc_system_inst_memory_mem_reset_n;                                // soc_system_inst:memory_mem_reset_n -> soc_system_inst_memory_bfm:sig_mem_reset_n
	wire   [2:0] soc_system_inst_memory_mem_ba;                                     // soc_system_inst:memory_mem_ba -> soc_system_inst_memory_bfm:sig_mem_ba
	wire         soc_system_inst_memory_mem_we_n;                                   // soc_system_inst:memory_mem_we_n -> soc_system_inst_memory_bfm:sig_mem_we_n
	wire         soc_system_inst_memory_mem_ck;                                     // soc_system_inst:memory_mem_ck -> soc_system_inst_memory_bfm:sig_mem_ck
	wire   [3:0] soc_system_inst_memory_mem_dqs;                                    // [] -> [soc_system_inst:memory_mem_dqs, soc_system_inst_memory_bfm:sig_mem_dqs]
	wire   [3:0] soc_system_inst_memory_mem_dm;                                     // soc_system_inst:memory_mem_dm -> soc_system_inst_memory_bfm:sig_mem_dm
	wire  [31:0] soc_system_inst_memory_mem_dq;                                     // [] -> [soc_system_inst:memory_mem_dq, soc_system_inst_memory_bfm:sig_mem_dq]
	wire         soc_system_inst_memory_mem_cs_n;                                   // soc_system_inst:memory_mem_cs_n -> soc_system_inst_memory_bfm:sig_mem_cs_n
	wire  [14:0] soc_system_inst_memory_mem_a;                                      // soc_system_inst:memory_mem_a -> soc_system_inst_memory_bfm:sig_mem_a
	wire         soc_system_inst_memory_mem_ras_n;                                  // soc_system_inst:memory_mem_ras_n -> soc_system_inst_memory_bfm:sig_mem_ras_n
	wire   [3:0] soc_system_inst_memory_mem_dqs_n;                                  // [] -> [soc_system_inst:memory_mem_dqs_n, soc_system_inst_memory_bfm:sig_mem_dqs_n]
	wire         soc_system_inst_memory_mem_odt;                                    // soc_system_inst:memory_mem_odt -> soc_system_inst_memory_bfm:sig_mem_odt
	wire         soc_system_inst_memory_mem_ck_n;                                   // soc_system_inst:memory_mem_ck_n -> soc_system_inst_memory_bfm:sig_mem_ck_n
	wire         soc_system_inst_memory_mem_cke;                                    // soc_system_inst:memory_mem_cke -> soc_system_inst_memory_bfm:sig_mem_cke
	wire         soc_system_inst_hps_0_f2h_cold_reset_req_bfm_reset_reset;          // soc_system_inst_hps_0_f2h_cold_reset_req_bfm:reset -> soc_system_inst:hps_0_f2h_cold_reset_req_reset_n
	wire         soc_system_inst_hps_0_f2h_debug_reset_req_bfm_reset_reset;         // soc_system_inst_hps_0_f2h_debug_reset_req_bfm:reset -> soc_system_inst:hps_0_f2h_debug_reset_req_reset_n
	wire         soc_system_inst_hps_0_f2h_warm_reset_req_bfm_reset_reset;          // soc_system_inst_hps_0_f2h_warm_reset_req_bfm:reset -> soc_system_inst:hps_0_f2h_warm_reset_req_reset_n
	wire         soc_system_inst_reset_bfm_reset_reset;                             // soc_system_inst_reset_bfm:reset -> soc_system_inst:reset_reset_n

	soc_system soc_system_inst (
		.access_rw                             (soc_system_inst_access_bfm_conduit_rw),                             //                         access.rw
		.access_address                        (soc_system_inst_access_bfm_conduit_address),                        //                               .address
		.access_data_in                        (soc_system_inst_access_bfm_conduit_data_in),                        //                               .data_in
		.access_data_out                       (soc_system_inst_access_data_out),                                   //                               .data_out
		.access_acknowledgement                (soc_system_inst_access_acknowledgement),                            //                               .acknowledgement
		.button_pio_external_connection_export (soc_system_inst_button_pio_external_connection_bfm_conduit_export), // button_pio_external_connection.export
		.clk_clk                               (soc_system_inst_clk_bfm_clk_clk),                                   //                            clk.clk
		.dipsw_pio_external_connection_export  (soc_system_inst_dipsw_pio_external_connection_bfm_conduit_export),  //  dipsw_pio_external_connection.export
		.hps_0_f2h_cold_reset_req_reset_n      (soc_system_inst_hps_0_f2h_cold_reset_req_bfm_reset_reset),          //       hps_0_f2h_cold_reset_req.reset_n
		.hps_0_f2h_debug_reset_req_reset_n     (soc_system_inst_hps_0_f2h_debug_reset_req_bfm_reset_reset),         //      hps_0_f2h_debug_reset_req.reset_n
		.hps_0_f2h_stm_hw_events_stm_hwevents  (soc_system_inst_hps_0_f2h_stm_hw_events_bfm_conduit_stm_hwevents),  //        hps_0_f2h_stm_hw_events.stm_hwevents
		.hps_0_f2h_warm_reset_req_reset_n      (soc_system_inst_hps_0_f2h_warm_reset_req_bfm_reset_reset),          //       hps_0_f2h_warm_reset_req.reset_n
		.hps_0_h2f_reset_reset_n               (),                                                                  //                hps_0_h2f_reset.reset_n
		.hps_0_hps_io_hps_io_emac1_inst_TX_CLK (soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_tx_clk),             //                   hps_0_hps_io.hps_io_emac1_inst_TX_CLK
		.hps_0_hps_io_hps_io_emac1_inst_TXD0   (soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_txd0),               //                               .hps_io_emac1_inst_TXD0
		.hps_0_hps_io_hps_io_emac1_inst_TXD1   (soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_txd1),               //                               .hps_io_emac1_inst_TXD1
		.hps_0_hps_io_hps_io_emac1_inst_TXD2   (soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_txd2),               //                               .hps_io_emac1_inst_TXD2
		.hps_0_hps_io_hps_io_emac1_inst_TXD3   (soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_txd3),               //                               .hps_io_emac1_inst_TXD3
		.hps_0_hps_io_hps_io_emac1_inst_RXD0   (soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_emac1_inst_rxd0),   //                               .hps_io_emac1_inst_RXD0
		.hps_0_hps_io_hps_io_emac1_inst_MDIO   (soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_mdio),               //                               .hps_io_emac1_inst_MDIO
		.hps_0_hps_io_hps_io_emac1_inst_MDC    (soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_mdc),                //                               .hps_io_emac1_inst_MDC
		.hps_0_hps_io_hps_io_emac1_inst_RX_CTL (soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_emac1_inst_rx_ctl), //                               .hps_io_emac1_inst_RX_CTL
		.hps_0_hps_io_hps_io_emac1_inst_TX_CTL (soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_tx_ctl),             //                               .hps_io_emac1_inst_TX_CTL
		.hps_0_hps_io_hps_io_emac1_inst_RX_CLK (soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_emac1_inst_rx_clk), //                               .hps_io_emac1_inst_RX_CLK
		.hps_0_hps_io_hps_io_emac1_inst_RXD1   (soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_emac1_inst_rxd1),   //                               .hps_io_emac1_inst_RXD1
		.hps_0_hps_io_hps_io_emac1_inst_RXD2   (soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_emac1_inst_rxd2),   //                               .hps_io_emac1_inst_RXD2
		.hps_0_hps_io_hps_io_emac1_inst_RXD3   (soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_emac1_inst_rxd3),   //                               .hps_io_emac1_inst_RXD3
		.hps_0_hps_io_hps_io_sdio_inst_CMD     (soc_system_inst_hps_0_hps_io_hps_io_sdio_inst_cmd),                 //                               .hps_io_sdio_inst_CMD
		.hps_0_hps_io_hps_io_sdio_inst_D0      (soc_system_inst_hps_0_hps_io_hps_io_sdio_inst_d0),                  //                               .hps_io_sdio_inst_D0
		.hps_0_hps_io_hps_io_sdio_inst_D1      (soc_system_inst_hps_0_hps_io_hps_io_sdio_inst_d1),                  //                               .hps_io_sdio_inst_D1
		.hps_0_hps_io_hps_io_sdio_inst_CLK     (soc_system_inst_hps_0_hps_io_hps_io_sdio_inst_clk),                 //                               .hps_io_sdio_inst_CLK
		.hps_0_hps_io_hps_io_sdio_inst_D2      (soc_system_inst_hps_0_hps_io_hps_io_sdio_inst_d2),                  //                               .hps_io_sdio_inst_D2
		.hps_0_hps_io_hps_io_sdio_inst_D3      (soc_system_inst_hps_0_hps_io_hps_io_sdio_inst_d3),                  //                               .hps_io_sdio_inst_D3
		.hps_0_hps_io_hps_io_usb1_inst_D0      (soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d0),                  //                               .hps_io_usb1_inst_D0
		.hps_0_hps_io_hps_io_usb1_inst_D1      (soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d1),                  //                               .hps_io_usb1_inst_D1
		.hps_0_hps_io_hps_io_usb1_inst_D2      (soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d2),                  //                               .hps_io_usb1_inst_D2
		.hps_0_hps_io_hps_io_usb1_inst_D3      (soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d3),                  //                               .hps_io_usb1_inst_D3
		.hps_0_hps_io_hps_io_usb1_inst_D4      (soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d4),                  //                               .hps_io_usb1_inst_D4
		.hps_0_hps_io_hps_io_usb1_inst_D5      (soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d5),                  //                               .hps_io_usb1_inst_D5
		.hps_0_hps_io_hps_io_usb1_inst_D6      (soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d6),                  //                               .hps_io_usb1_inst_D6
		.hps_0_hps_io_hps_io_usb1_inst_D7      (soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d7),                  //                               .hps_io_usb1_inst_D7
		.hps_0_hps_io_hps_io_usb1_inst_CLK     (soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_usb1_inst_clk),     //                               .hps_io_usb1_inst_CLK
		.hps_0_hps_io_hps_io_usb1_inst_STP     (soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_stp),                 //                               .hps_io_usb1_inst_STP
		.hps_0_hps_io_hps_io_usb1_inst_DIR     (soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_usb1_inst_dir),     //                               .hps_io_usb1_inst_DIR
		.hps_0_hps_io_hps_io_usb1_inst_NXT     (soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_usb1_inst_nxt),     //                               .hps_io_usb1_inst_NXT
		.hps_0_hps_io_hps_io_spim1_inst_CLK    (soc_system_inst_hps_0_hps_io_hps_io_spim1_inst_clk),                //                               .hps_io_spim1_inst_CLK
		.hps_0_hps_io_hps_io_spim1_inst_MOSI   (soc_system_inst_hps_0_hps_io_hps_io_spim1_inst_mosi),               //                               .hps_io_spim1_inst_MOSI
		.hps_0_hps_io_hps_io_spim1_inst_MISO   (soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_spim1_inst_miso),   //                               .hps_io_spim1_inst_MISO
		.hps_0_hps_io_hps_io_spim1_inst_SS0    (soc_system_inst_hps_0_hps_io_hps_io_spim1_inst_ss0),                //                               .hps_io_spim1_inst_SS0
		.hps_0_hps_io_hps_io_uart0_inst_RX     (soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_uart0_inst_rx),     //                               .hps_io_uart0_inst_RX
		.hps_0_hps_io_hps_io_uart0_inst_TX     (soc_system_inst_hps_0_hps_io_hps_io_uart0_inst_tx),                 //                               .hps_io_uart0_inst_TX
		.hps_0_hps_io_hps_io_i2c0_inst_SDA     (soc_system_inst_hps_0_hps_io_hps_io_i2c0_inst_sda),                 //                               .hps_io_i2c0_inst_SDA
		.hps_0_hps_io_hps_io_i2c0_inst_SCL     (soc_system_inst_hps_0_hps_io_hps_io_i2c0_inst_scl),                 //                               .hps_io_i2c0_inst_SCL
		.hps_0_hps_io_hps_io_i2c1_inst_SDA     (soc_system_inst_hps_0_hps_io_hps_io_i2c1_inst_sda),                 //                               .hps_io_i2c1_inst_SDA
		.hps_0_hps_io_hps_io_i2c1_inst_SCL     (soc_system_inst_hps_0_hps_io_hps_io_i2c1_inst_scl),                 //                               .hps_io_i2c1_inst_SCL
		.hps_0_hps_io_hps_io_gpio_inst_GPIO09  (soc_system_inst_hps_0_hps_io_hps_io_gpio_inst_gpio09),              //                               .hps_io_gpio_inst_GPIO09
		.hps_0_hps_io_hps_io_gpio_inst_GPIO35  (soc_system_inst_hps_0_hps_io_hps_io_gpio_inst_gpio35),              //                               .hps_io_gpio_inst_GPIO35
		.hps_0_hps_io_hps_io_gpio_inst_GPIO40  (soc_system_inst_hps_0_hps_io_hps_io_gpio_inst_gpio40),              //                               .hps_io_gpio_inst_GPIO40
		.hps_0_hps_io_hps_io_gpio_inst_GPIO53  (soc_system_inst_hps_0_hps_io_hps_io_gpio_inst_gpio53),              //                               .hps_io_gpio_inst_GPIO53
		.hps_0_hps_io_hps_io_gpio_inst_GPIO54  (soc_system_inst_hps_0_hps_io_hps_io_gpio_inst_gpio54),              //                               .hps_io_gpio_inst_GPIO54
		.hps_0_hps_io_hps_io_gpio_inst_GPIO61  (soc_system_inst_hps_0_hps_io_hps_io_gpio_inst_gpio61),              //                               .hps_io_gpio_inst_GPIO61
		.memory_mem_a                          (soc_system_inst_memory_mem_a),                                      //                         memory.mem_a
		.memory_mem_ba                         (soc_system_inst_memory_mem_ba),                                     //                               .mem_ba
		.memory_mem_ck                         (soc_system_inst_memory_mem_ck),                                     //                               .mem_ck
		.memory_mem_ck_n                       (soc_system_inst_memory_mem_ck_n),                                   //                               .mem_ck_n
		.memory_mem_cke                        (soc_system_inst_memory_mem_cke),                                    //                               .mem_cke
		.memory_mem_cs_n                       (soc_system_inst_memory_mem_cs_n),                                   //                               .mem_cs_n
		.memory_mem_ras_n                      (soc_system_inst_memory_mem_ras_n),                                  //                               .mem_ras_n
		.memory_mem_cas_n                      (soc_system_inst_memory_mem_cas_n),                                  //                               .mem_cas_n
		.memory_mem_we_n                       (soc_system_inst_memory_mem_we_n),                                   //                               .mem_we_n
		.memory_mem_reset_n                    (soc_system_inst_memory_mem_reset_n),                                //                               .mem_reset_n
		.memory_mem_dq                         (soc_system_inst_memory_mem_dq),                                     //                               .mem_dq
		.memory_mem_dqs                        (soc_system_inst_memory_mem_dqs),                                    //                               .mem_dqs
		.memory_mem_dqs_n                      (soc_system_inst_memory_mem_dqs_n),                                  //                               .mem_dqs_n
		.memory_mem_odt                        (soc_system_inst_memory_mem_odt),                                    //                               .mem_odt
		.memory_mem_dm                         (soc_system_inst_memory_mem_dm),                                     //                               .mem_dm
		.memory_oct_rzqin                      (soc_system_inst_memory_bfm_conduit_oct_rzqin),                      //                               .oct_rzqin
		.reset_reset_n                         (soc_system_inst_reset_bfm_reset_reset)                              //                          reset.reset_n
	);

	altera_conduit_bfm soc_system_inst_access_bfm (
		.clk                 (soc_system_inst_clk_bfm_clk_clk),            //     clk.clk
		.sig_rw              (soc_system_inst_access_bfm_conduit_rw),      // conduit.rw
		.sig_address         (soc_system_inst_access_bfm_conduit_address), //        .address
		.sig_data_in         (soc_system_inst_access_bfm_conduit_data_in), //        .data_in
		.sig_data_out        (soc_system_inst_access_data_out),            //        .data_out
		.sig_acknowledgement (soc_system_inst_access_acknowledgement),     //        .acknowledgement
		.reset               (1'b0)                                        // (terminated)
	);

	altera_conduit_bfm_0002 soc_system_inst_button_pio_external_connection_bfm (
		.sig_export (soc_system_inst_button_pio_external_connection_bfm_conduit_export)  // conduit.export
	);

	altera_avalon_clock_source #(
		.CLOCK_RATE (50000000),
		.CLOCK_UNIT (1)
	) soc_system_inst_clk_bfm (
		.clk (soc_system_inst_clk_bfm_clk_clk)  // clk.clk
	);

	altera_conduit_bfm_0003 soc_system_inst_dipsw_pio_external_connection_bfm (
		.sig_export (soc_system_inst_dipsw_pio_external_connection_bfm_conduit_export)  // conduit.export
	);

	altera_avalon_reset_source #(
		.ASSERT_HIGH_RESET    (0),
		.INITIAL_RESET_CYCLES (50)
	) soc_system_inst_hps_0_f2h_cold_reset_req_bfm (
		.reset (soc_system_inst_hps_0_f2h_cold_reset_req_bfm_reset_reset), // reset.reset_n
		.clk   (soc_system_inst_clk_bfm_clk_clk)                           //   clk.clk
	);

	altera_avalon_reset_source #(
		.ASSERT_HIGH_RESET    (0),
		.INITIAL_RESET_CYCLES (50)
	) soc_system_inst_hps_0_f2h_debug_reset_req_bfm (
		.reset (soc_system_inst_hps_0_f2h_debug_reset_req_bfm_reset_reset), // reset.reset_n
		.clk   (soc_system_inst_clk_bfm_clk_clk)                            //   clk.clk
	);

	altera_conduit_bfm_0004 soc_system_inst_hps_0_f2h_stm_hw_events_bfm (
		.sig_stm_hwevents (soc_system_inst_hps_0_f2h_stm_hw_events_bfm_conduit_stm_hwevents)  // conduit.stm_hwevents
	);

	altera_avalon_reset_source #(
		.ASSERT_HIGH_RESET    (0),
		.INITIAL_RESET_CYCLES (50)
	) soc_system_inst_hps_0_f2h_warm_reset_req_bfm (
		.reset (soc_system_inst_hps_0_f2h_warm_reset_req_bfm_reset_reset), // reset.reset_n
		.clk   (soc_system_inst_clk_bfm_clk_clk)                           //   clk.clk
	);

	altera_conduit_bfm_0005 soc_system_inst_hps_0_hps_io_bfm (
		.sig_hps_io_emac1_inst_TX_CLK (soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_tx_clk),             // conduit.hps_io_emac1_inst_TX_CLK
		.sig_hps_io_emac1_inst_TXD0   (soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_txd0),               //        .hps_io_emac1_inst_TXD0
		.sig_hps_io_emac1_inst_TXD1   (soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_txd1),               //        .hps_io_emac1_inst_TXD1
		.sig_hps_io_emac1_inst_TXD2   (soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_txd2),               //        .hps_io_emac1_inst_TXD2
		.sig_hps_io_emac1_inst_TXD3   (soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_txd3),               //        .hps_io_emac1_inst_TXD3
		.sig_hps_io_emac1_inst_RXD0   (soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_emac1_inst_rxd0),   //        .hps_io_emac1_inst_RXD0
		.sig_hps_io_emac1_inst_MDIO   (soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_mdio),               //        .hps_io_emac1_inst_MDIO
		.sig_hps_io_emac1_inst_MDC    (soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_mdc),                //        .hps_io_emac1_inst_MDC
		.sig_hps_io_emac1_inst_RX_CTL (soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_emac1_inst_rx_ctl), //        .hps_io_emac1_inst_RX_CTL
		.sig_hps_io_emac1_inst_TX_CTL (soc_system_inst_hps_0_hps_io_hps_io_emac1_inst_tx_ctl),             //        .hps_io_emac1_inst_TX_CTL
		.sig_hps_io_emac1_inst_RX_CLK (soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_emac1_inst_rx_clk), //        .hps_io_emac1_inst_RX_CLK
		.sig_hps_io_emac1_inst_RXD1   (soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_emac1_inst_rxd1),   //        .hps_io_emac1_inst_RXD1
		.sig_hps_io_emac1_inst_RXD2   (soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_emac1_inst_rxd2),   //        .hps_io_emac1_inst_RXD2
		.sig_hps_io_emac1_inst_RXD3   (soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_emac1_inst_rxd3),   //        .hps_io_emac1_inst_RXD3
		.sig_hps_io_sdio_inst_CMD     (soc_system_inst_hps_0_hps_io_hps_io_sdio_inst_cmd),                 //        .hps_io_sdio_inst_CMD
		.sig_hps_io_sdio_inst_D0      (soc_system_inst_hps_0_hps_io_hps_io_sdio_inst_d0),                  //        .hps_io_sdio_inst_D0
		.sig_hps_io_sdio_inst_D1      (soc_system_inst_hps_0_hps_io_hps_io_sdio_inst_d1),                  //        .hps_io_sdio_inst_D1
		.sig_hps_io_sdio_inst_CLK     (soc_system_inst_hps_0_hps_io_hps_io_sdio_inst_clk),                 //        .hps_io_sdio_inst_CLK
		.sig_hps_io_sdio_inst_D2      (soc_system_inst_hps_0_hps_io_hps_io_sdio_inst_d2),                  //        .hps_io_sdio_inst_D2
		.sig_hps_io_sdio_inst_D3      (soc_system_inst_hps_0_hps_io_hps_io_sdio_inst_d3),                  //        .hps_io_sdio_inst_D3
		.sig_hps_io_usb1_inst_D0      (soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d0),                  //        .hps_io_usb1_inst_D0
		.sig_hps_io_usb1_inst_D1      (soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d1),                  //        .hps_io_usb1_inst_D1
		.sig_hps_io_usb1_inst_D2      (soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d2),                  //        .hps_io_usb1_inst_D2
		.sig_hps_io_usb1_inst_D3      (soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d3),                  //        .hps_io_usb1_inst_D3
		.sig_hps_io_usb1_inst_D4      (soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d4),                  //        .hps_io_usb1_inst_D4
		.sig_hps_io_usb1_inst_D5      (soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d5),                  //        .hps_io_usb1_inst_D5
		.sig_hps_io_usb1_inst_D6      (soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d6),                  //        .hps_io_usb1_inst_D6
		.sig_hps_io_usb1_inst_D7      (soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_d7),                  //        .hps_io_usb1_inst_D7
		.sig_hps_io_usb1_inst_CLK     (soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_usb1_inst_clk),     //        .hps_io_usb1_inst_CLK
		.sig_hps_io_usb1_inst_STP     (soc_system_inst_hps_0_hps_io_hps_io_usb1_inst_stp),                 //        .hps_io_usb1_inst_STP
		.sig_hps_io_usb1_inst_DIR     (soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_usb1_inst_dir),     //        .hps_io_usb1_inst_DIR
		.sig_hps_io_usb1_inst_NXT     (soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_usb1_inst_nxt),     //        .hps_io_usb1_inst_NXT
		.sig_hps_io_spim1_inst_CLK    (soc_system_inst_hps_0_hps_io_hps_io_spim1_inst_clk),                //        .hps_io_spim1_inst_CLK
		.sig_hps_io_spim1_inst_MOSI   (soc_system_inst_hps_0_hps_io_hps_io_spim1_inst_mosi),               //        .hps_io_spim1_inst_MOSI
		.sig_hps_io_spim1_inst_MISO   (soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_spim1_inst_miso),   //        .hps_io_spim1_inst_MISO
		.sig_hps_io_spim1_inst_SS0    (soc_system_inst_hps_0_hps_io_hps_io_spim1_inst_ss0),                //        .hps_io_spim1_inst_SS0
		.sig_hps_io_uart0_inst_RX     (soc_system_inst_hps_0_hps_io_bfm_conduit_hps_io_uart0_inst_rx),     //        .hps_io_uart0_inst_RX
		.sig_hps_io_uart0_inst_TX     (soc_system_inst_hps_0_hps_io_hps_io_uart0_inst_tx),                 //        .hps_io_uart0_inst_TX
		.sig_hps_io_i2c0_inst_SDA     (soc_system_inst_hps_0_hps_io_hps_io_i2c0_inst_sda),                 //        .hps_io_i2c0_inst_SDA
		.sig_hps_io_i2c0_inst_SCL     (soc_system_inst_hps_0_hps_io_hps_io_i2c0_inst_scl),                 //        .hps_io_i2c0_inst_SCL
		.sig_hps_io_i2c1_inst_SDA     (soc_system_inst_hps_0_hps_io_hps_io_i2c1_inst_sda),                 //        .hps_io_i2c1_inst_SDA
		.sig_hps_io_i2c1_inst_SCL     (soc_system_inst_hps_0_hps_io_hps_io_i2c1_inst_scl),                 //        .hps_io_i2c1_inst_SCL
		.sig_hps_io_gpio_inst_GPIO09  (soc_system_inst_hps_0_hps_io_hps_io_gpio_inst_gpio09),              //        .hps_io_gpio_inst_GPIO09
		.sig_hps_io_gpio_inst_GPIO35  (soc_system_inst_hps_0_hps_io_hps_io_gpio_inst_gpio35),              //        .hps_io_gpio_inst_GPIO35
		.sig_hps_io_gpio_inst_GPIO40  (soc_system_inst_hps_0_hps_io_hps_io_gpio_inst_gpio40),              //        .hps_io_gpio_inst_GPIO40
		.sig_hps_io_gpio_inst_GPIO53  (soc_system_inst_hps_0_hps_io_hps_io_gpio_inst_gpio53),              //        .hps_io_gpio_inst_GPIO53
		.sig_hps_io_gpio_inst_GPIO54  (soc_system_inst_hps_0_hps_io_hps_io_gpio_inst_gpio54),              //        .hps_io_gpio_inst_GPIO54
		.sig_hps_io_gpio_inst_GPIO61  (soc_system_inst_hps_0_hps_io_hps_io_gpio_inst_gpio61)               //        .hps_io_gpio_inst_GPIO61
	);

	altera_conduit_bfm_0006 soc_system_inst_memory_bfm (
		.sig_mem_a       (soc_system_inst_memory_mem_a),                 // conduit.mem_a
		.sig_mem_ba      (soc_system_inst_memory_mem_ba),                //        .mem_ba
		.sig_mem_ck      (soc_system_inst_memory_mem_ck),                //        .mem_ck
		.sig_mem_ck_n    (soc_system_inst_memory_mem_ck_n),              //        .mem_ck_n
		.sig_mem_cke     (soc_system_inst_memory_mem_cke),               //        .mem_cke
		.sig_mem_cs_n    (soc_system_inst_memory_mem_cs_n),              //        .mem_cs_n
		.sig_mem_ras_n   (soc_system_inst_memory_mem_ras_n),             //        .mem_ras_n
		.sig_mem_cas_n   (soc_system_inst_memory_mem_cas_n),             //        .mem_cas_n
		.sig_mem_we_n    (soc_system_inst_memory_mem_we_n),              //        .mem_we_n
		.sig_mem_reset_n (soc_system_inst_memory_mem_reset_n),           //        .mem_reset_n
		.sig_mem_dq      (soc_system_inst_memory_mem_dq),                //        .mem_dq
		.sig_mem_dqs     (soc_system_inst_memory_mem_dqs),               //        .mem_dqs
		.sig_mem_dqs_n   (soc_system_inst_memory_mem_dqs_n),             //        .mem_dqs_n
		.sig_mem_odt     (soc_system_inst_memory_mem_odt),               //        .mem_odt
		.sig_mem_dm      (soc_system_inst_memory_mem_dm),                //        .mem_dm
		.sig_oct_rzqin   (soc_system_inst_memory_bfm_conduit_oct_rzqin)  //        .oct_rzqin
	);

	altera_avalon_reset_source #(
		.ASSERT_HIGH_RESET    (0),
		.INITIAL_RESET_CYCLES (50)
	) soc_system_inst_reset_bfm (
		.reset (soc_system_inst_reset_bfm_reset_reset), // reset.reset_n
		.clk   (soc_system_inst_clk_bfm_clk_clk)        //   clk.clk
	);

endmodule