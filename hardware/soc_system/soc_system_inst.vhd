	component soc_system is
		port (
			clk_clk                               : in    std_logic                      := 'X';             -- clk
			dm_bus_acknowledge                    : in    std_logic                      := 'X';             -- acknowledge
			dm_bus_irq                            : in    std_logic                      := 'X';             -- irq
			dm_bus_address                        : out   std_logic_vector(17 downto 0);                     -- address
			dm_bus_bus_enable                     : out   std_logic;                                         -- bus_enable
			dm_bus_byte_enable                    : out   std_logic_vector(3 downto 0);                      -- byte_enable
			dm_bus_rw                             : out   std_logic;                                         -- rw
			dm_bus_write_data                     : out   std_logic_vector(31 downto 0);                     -- write_data
			dm_bus_read_data                      : in    std_logic_vector(31 downto 0)  := (others => 'X'); -- read_data
			hps_0_f2h_cold_reset_req_reset_n      : in    std_logic                      := 'X';             -- reset_n
			hps_0_f2h_debug_reset_req_reset_n     : in    std_logic                      := 'X';             -- reset_n
			hps_0_f2h_stm_hw_events_stm_hwevents  : in    std_logic_vector(27 downto 0)  := (others => 'X'); -- stm_hwevents
			hps_0_f2h_warm_reset_req_reset_n      : in    std_logic                      := 'X';             -- reset_n
			hps_0_h2f_reset_reset_n               : out   std_logic;                                         -- reset_n
			hps_0_hps_io_hps_io_emac1_inst_TX_CLK : out   std_logic;                                         -- hps_io_emac1_inst_TX_CLK
			hps_0_hps_io_hps_io_emac1_inst_TXD0   : out   std_logic;                                         -- hps_io_emac1_inst_TXD0
			hps_0_hps_io_hps_io_emac1_inst_TXD1   : out   std_logic;                                         -- hps_io_emac1_inst_TXD1
			hps_0_hps_io_hps_io_emac1_inst_TXD2   : out   std_logic;                                         -- hps_io_emac1_inst_TXD2
			hps_0_hps_io_hps_io_emac1_inst_TXD3   : out   std_logic;                                         -- hps_io_emac1_inst_TXD3
			hps_0_hps_io_hps_io_emac1_inst_RXD0   : in    std_logic                      := 'X';             -- hps_io_emac1_inst_RXD0
			hps_0_hps_io_hps_io_emac1_inst_MDIO   : inout std_logic                      := 'X';             -- hps_io_emac1_inst_MDIO
			hps_0_hps_io_hps_io_emac1_inst_MDC    : out   std_logic;                                         -- hps_io_emac1_inst_MDC
			hps_0_hps_io_hps_io_emac1_inst_RX_CTL : in    std_logic                      := 'X';             -- hps_io_emac1_inst_RX_CTL
			hps_0_hps_io_hps_io_emac1_inst_TX_CTL : out   std_logic;                                         -- hps_io_emac1_inst_TX_CTL
			hps_0_hps_io_hps_io_emac1_inst_RX_CLK : in    std_logic                      := 'X';             -- hps_io_emac1_inst_RX_CLK
			hps_0_hps_io_hps_io_emac1_inst_RXD1   : in    std_logic                      := 'X';             -- hps_io_emac1_inst_RXD1
			hps_0_hps_io_hps_io_emac1_inst_RXD2   : in    std_logic                      := 'X';             -- hps_io_emac1_inst_RXD2
			hps_0_hps_io_hps_io_emac1_inst_RXD3   : in    std_logic                      := 'X';             -- hps_io_emac1_inst_RXD3
			hps_0_hps_io_hps_io_sdio_inst_CMD     : inout std_logic                      := 'X';             -- hps_io_sdio_inst_CMD
			hps_0_hps_io_hps_io_sdio_inst_D0      : inout std_logic                      := 'X';             -- hps_io_sdio_inst_D0
			hps_0_hps_io_hps_io_sdio_inst_D1      : inout std_logic                      := 'X';             -- hps_io_sdio_inst_D1
			hps_0_hps_io_hps_io_sdio_inst_CLK     : out   std_logic;                                         -- hps_io_sdio_inst_CLK
			hps_0_hps_io_hps_io_sdio_inst_D2      : inout std_logic                      := 'X';             -- hps_io_sdio_inst_D2
			hps_0_hps_io_hps_io_sdio_inst_D3      : inout std_logic                      := 'X';             -- hps_io_sdio_inst_D3
			hps_0_hps_io_hps_io_usb1_inst_D0      : inout std_logic                      := 'X';             -- hps_io_usb1_inst_D0
			hps_0_hps_io_hps_io_usb1_inst_D1      : inout std_logic                      := 'X';             -- hps_io_usb1_inst_D1
			hps_0_hps_io_hps_io_usb1_inst_D2      : inout std_logic                      := 'X';             -- hps_io_usb1_inst_D2
			hps_0_hps_io_hps_io_usb1_inst_D3      : inout std_logic                      := 'X';             -- hps_io_usb1_inst_D3
			hps_0_hps_io_hps_io_usb1_inst_D4      : inout std_logic                      := 'X';             -- hps_io_usb1_inst_D4
			hps_0_hps_io_hps_io_usb1_inst_D5      : inout std_logic                      := 'X';             -- hps_io_usb1_inst_D5
			hps_0_hps_io_hps_io_usb1_inst_D6      : inout std_logic                      := 'X';             -- hps_io_usb1_inst_D6
			hps_0_hps_io_hps_io_usb1_inst_D7      : inout std_logic                      := 'X';             -- hps_io_usb1_inst_D7
			hps_0_hps_io_hps_io_usb1_inst_CLK     : in    std_logic                      := 'X';             -- hps_io_usb1_inst_CLK
			hps_0_hps_io_hps_io_usb1_inst_STP     : out   std_logic;                                         -- hps_io_usb1_inst_STP
			hps_0_hps_io_hps_io_usb1_inst_DIR     : in    std_logic                      := 'X';             -- hps_io_usb1_inst_DIR
			hps_0_hps_io_hps_io_usb1_inst_NXT     : in    std_logic                      := 'X';             -- hps_io_usb1_inst_NXT
			hps_0_hps_io_hps_io_spim1_inst_CLK    : out   std_logic;                                         -- hps_io_spim1_inst_CLK
			hps_0_hps_io_hps_io_spim1_inst_MOSI   : out   std_logic;                                         -- hps_io_spim1_inst_MOSI
			hps_0_hps_io_hps_io_spim1_inst_MISO   : in    std_logic                      := 'X';             -- hps_io_spim1_inst_MISO
			hps_0_hps_io_hps_io_spim1_inst_SS0    : out   std_logic;                                         -- hps_io_spim1_inst_SS0
			hps_0_hps_io_hps_io_uart0_inst_RX     : in    std_logic                      := 'X';             -- hps_io_uart0_inst_RX
			hps_0_hps_io_hps_io_uart0_inst_TX     : out   std_logic;                                         -- hps_io_uart0_inst_TX
			hps_0_hps_io_hps_io_i2c0_inst_SDA     : inout std_logic                      := 'X';             -- hps_io_i2c0_inst_SDA
			hps_0_hps_io_hps_io_i2c0_inst_SCL     : inout std_logic                      := 'X';             -- hps_io_i2c0_inst_SCL
			hps_0_hps_io_hps_io_i2c1_inst_SDA     : inout std_logic                      := 'X';             -- hps_io_i2c1_inst_SDA
			hps_0_hps_io_hps_io_i2c1_inst_SCL     : inout std_logic                      := 'X';             -- hps_io_i2c1_inst_SCL
			hps_0_hps_io_hps_io_gpio_inst_GPIO09  : inout std_logic                      := 'X';             -- hps_io_gpio_inst_GPIO09
			hps_0_hps_io_hps_io_gpio_inst_GPIO35  : inout std_logic                      := 'X';             -- hps_io_gpio_inst_GPIO35
			hps_0_hps_io_hps_io_gpio_inst_GPIO40  : inout std_logic                      := 'X';             -- hps_io_gpio_inst_GPIO40
			hps_0_hps_io_hps_io_gpio_inst_GPIO53  : inout std_logic                      := 'X';             -- hps_io_gpio_inst_GPIO53
			hps_0_hps_io_hps_io_gpio_inst_GPIO54  : inout std_logic                      := 'X';             -- hps_io_gpio_inst_GPIO54
			hps_0_hps_io_hps_io_gpio_inst_GPIO61  : inout std_logic                      := 'X';             -- hps_io_gpio_inst_GPIO61
			im_bus_acknowledge                    : in    std_logic                      := 'X';             -- acknowledge
			im_bus_irq                            : in    std_logic                      := 'X';             -- irq
			im_bus_address                        : out   std_logic_vector(17 downto 0);                     -- address
			im_bus_bus_enable                     : out   std_logic;                                         -- bus_enable
			im_bus_byte_enable                    : out   std_logic_vector(3 downto 0);                      -- byte_enable
			im_bus_rw                             : out   std_logic;                                         -- rw
			im_bus_write_data                     : out   std_logic_vector(31 downto 0);                     -- write_data
			im_bus_read_data                      : in    std_logic_vector(31 downto 0)  := (others => 'X'); -- read_data
			io_bus_acknowledge                    : in    std_logic                      := 'X';             -- acknowledge
			io_bus_irq                            : in    std_logic                      := 'X';             -- irq
			io_bus_address                        : out   std_logic_vector(17 downto 0);                     -- address
			io_bus_bus_enable                     : out   std_logic;                                         -- bus_enable
			io_bus_byte_enable                    : out   std_logic_vector(3 downto 0);                      -- byte_enable
			io_bus_rw                             : out   std_logic;                                         -- rw
			io_bus_write_data                     : out   std_logic_vector(31 downto 0);                     -- write_data
			io_bus_read_data                      : in    std_logic_vector(31 downto 0)  := (others => 'X'); -- read_data
			mask_bus_acknowledge                  : in    std_logic                      := 'X';             -- acknowledge
			mask_bus_irq                          : in    std_logic                      := 'X';             -- irq
			mask_bus_address                      : out   std_logic_vector(11 downto 0);                     -- address
			mask_bus_bus_enable                   : out   std_logic;                                         -- bus_enable
			mask_bus_byte_enable                  : out   std_logic_vector(15 downto 0);                     -- byte_enable
			mask_bus_rw                           : out   std_logic;                                         -- rw
			mask_bus_write_data                   : out   std_logic_vector(127 downto 0);                    -- write_data
			mask_bus_read_data                    : in    std_logic_vector(127 downto 0) := (others => 'X'); -- read_data
			memory_mem_a                          : out   std_logic_vector(14 downto 0);                     -- mem_a
			memory_mem_ba                         : out   std_logic_vector(2 downto 0);                      -- mem_ba
			memory_mem_ck                         : out   std_logic;                                         -- mem_ck
			memory_mem_ck_n                       : out   std_logic;                                         -- mem_ck_n
			memory_mem_cke                        : out   std_logic;                                         -- mem_cke
			memory_mem_cs_n                       : out   std_logic;                                         -- mem_cs_n
			memory_mem_ras_n                      : out   std_logic;                                         -- mem_ras_n
			memory_mem_cas_n                      : out   std_logic;                                         -- mem_cas_n
			memory_mem_we_n                       : out   std_logic;                                         -- mem_we_n
			memory_mem_reset_n                    : out   std_logic;                                         -- mem_reset_n
			memory_mem_dq                         : inout std_logic_vector(31 downto 0)  := (others => 'X'); -- mem_dq
			memory_mem_dqs                        : inout std_logic_vector(3 downto 0)   := (others => 'X'); -- mem_dqs
			memory_mem_dqs_n                      : inout std_logic_vector(3 downto 0)   := (others => 'X'); -- mem_dqs_n
			memory_mem_odt                        : out   std_logic;                                         -- mem_odt
			memory_mem_dm                         : out   std_logic_vector(3 downto 0);                      -- mem_dm
			memory_oct_rzqin                      : in    std_logic                      := 'X';             -- oct_rzqin
			power_in_port                         : in    std_logic                      := 'X';             -- in_port
			power_out_port                        : out   std_logic;                                         -- out_port
			reset_reset_n                         : in    std_logic                      := 'X';             -- reset_n
			rf_bus_acknowledge                    : in    std_logic                      := 'X';             -- acknowledge
			rf_bus_irq                            : in    std_logic                      := 'X';             -- irq
			rf_bus_address                        : out   std_logic_vector(17 downto 0);                     -- address
			rf_bus_bus_enable                     : out   std_logic;                                         -- bus_enable
			rf_bus_byte_enable                    : out   std_logic_vector(3 downto 0);                      -- byte_enable
			rf_bus_rw                             : out   std_logic;                                         -- rw
			rf_bus_write_data                     : out   std_logic_vector(31 downto 0);                     -- write_data
			rf_bus_read_data                      : in    std_logic_vector(31 downto 0)  := (others => 'X')  -- read_data
		);
	end component soc_system;

	u0 : component soc_system
		port map (
			clk_clk                               => CONNECTED_TO_clk_clk,                               --                       clk.clk
			dm_bus_acknowledge                    => CONNECTED_TO_dm_bus_acknowledge,                    --                    dm_bus.acknowledge
			dm_bus_irq                            => CONNECTED_TO_dm_bus_irq,                            --                          .irq
			dm_bus_address                        => CONNECTED_TO_dm_bus_address,                        --                          .address
			dm_bus_bus_enable                     => CONNECTED_TO_dm_bus_bus_enable,                     --                          .bus_enable
			dm_bus_byte_enable                    => CONNECTED_TO_dm_bus_byte_enable,                    --                          .byte_enable
			dm_bus_rw                             => CONNECTED_TO_dm_bus_rw,                             --                          .rw
			dm_bus_write_data                     => CONNECTED_TO_dm_bus_write_data,                     --                          .write_data
			dm_bus_read_data                      => CONNECTED_TO_dm_bus_read_data,                      --                          .read_data
			hps_0_f2h_cold_reset_req_reset_n      => CONNECTED_TO_hps_0_f2h_cold_reset_req_reset_n,      --  hps_0_f2h_cold_reset_req.reset_n
			hps_0_f2h_debug_reset_req_reset_n     => CONNECTED_TO_hps_0_f2h_debug_reset_req_reset_n,     -- hps_0_f2h_debug_reset_req.reset_n
			hps_0_f2h_stm_hw_events_stm_hwevents  => CONNECTED_TO_hps_0_f2h_stm_hw_events_stm_hwevents,  --   hps_0_f2h_stm_hw_events.stm_hwevents
			hps_0_f2h_warm_reset_req_reset_n      => CONNECTED_TO_hps_0_f2h_warm_reset_req_reset_n,      --  hps_0_f2h_warm_reset_req.reset_n
			hps_0_h2f_reset_reset_n               => CONNECTED_TO_hps_0_h2f_reset_reset_n,               --           hps_0_h2f_reset.reset_n
			hps_0_hps_io_hps_io_emac1_inst_TX_CLK => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_TX_CLK, --              hps_0_hps_io.hps_io_emac1_inst_TX_CLK
			hps_0_hps_io_hps_io_emac1_inst_TXD0   => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_TXD0,   --                          .hps_io_emac1_inst_TXD0
			hps_0_hps_io_hps_io_emac1_inst_TXD1   => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_TXD1,   --                          .hps_io_emac1_inst_TXD1
			hps_0_hps_io_hps_io_emac1_inst_TXD2   => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_TXD2,   --                          .hps_io_emac1_inst_TXD2
			hps_0_hps_io_hps_io_emac1_inst_TXD3   => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_TXD3,   --                          .hps_io_emac1_inst_TXD3
			hps_0_hps_io_hps_io_emac1_inst_RXD0   => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_RXD0,   --                          .hps_io_emac1_inst_RXD0
			hps_0_hps_io_hps_io_emac1_inst_MDIO   => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_MDIO,   --                          .hps_io_emac1_inst_MDIO
			hps_0_hps_io_hps_io_emac1_inst_MDC    => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_MDC,    --                          .hps_io_emac1_inst_MDC
			hps_0_hps_io_hps_io_emac1_inst_RX_CTL => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_RX_CTL, --                          .hps_io_emac1_inst_RX_CTL
			hps_0_hps_io_hps_io_emac1_inst_TX_CTL => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_TX_CTL, --                          .hps_io_emac1_inst_TX_CTL
			hps_0_hps_io_hps_io_emac1_inst_RX_CLK => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_RX_CLK, --                          .hps_io_emac1_inst_RX_CLK
			hps_0_hps_io_hps_io_emac1_inst_RXD1   => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_RXD1,   --                          .hps_io_emac1_inst_RXD1
			hps_0_hps_io_hps_io_emac1_inst_RXD2   => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_RXD2,   --                          .hps_io_emac1_inst_RXD2
			hps_0_hps_io_hps_io_emac1_inst_RXD3   => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_RXD3,   --                          .hps_io_emac1_inst_RXD3
			hps_0_hps_io_hps_io_sdio_inst_CMD     => CONNECTED_TO_hps_0_hps_io_hps_io_sdio_inst_CMD,     --                          .hps_io_sdio_inst_CMD
			hps_0_hps_io_hps_io_sdio_inst_D0      => CONNECTED_TO_hps_0_hps_io_hps_io_sdio_inst_D0,      --                          .hps_io_sdio_inst_D0
			hps_0_hps_io_hps_io_sdio_inst_D1      => CONNECTED_TO_hps_0_hps_io_hps_io_sdio_inst_D1,      --                          .hps_io_sdio_inst_D1
			hps_0_hps_io_hps_io_sdio_inst_CLK     => CONNECTED_TO_hps_0_hps_io_hps_io_sdio_inst_CLK,     --                          .hps_io_sdio_inst_CLK
			hps_0_hps_io_hps_io_sdio_inst_D2      => CONNECTED_TO_hps_0_hps_io_hps_io_sdio_inst_D2,      --                          .hps_io_sdio_inst_D2
			hps_0_hps_io_hps_io_sdio_inst_D3      => CONNECTED_TO_hps_0_hps_io_hps_io_sdio_inst_D3,      --                          .hps_io_sdio_inst_D3
			hps_0_hps_io_hps_io_usb1_inst_D0      => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D0,      --                          .hps_io_usb1_inst_D0
			hps_0_hps_io_hps_io_usb1_inst_D1      => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D1,      --                          .hps_io_usb1_inst_D1
			hps_0_hps_io_hps_io_usb1_inst_D2      => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D2,      --                          .hps_io_usb1_inst_D2
			hps_0_hps_io_hps_io_usb1_inst_D3      => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D3,      --                          .hps_io_usb1_inst_D3
			hps_0_hps_io_hps_io_usb1_inst_D4      => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D4,      --                          .hps_io_usb1_inst_D4
			hps_0_hps_io_hps_io_usb1_inst_D5      => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D5,      --                          .hps_io_usb1_inst_D5
			hps_0_hps_io_hps_io_usb1_inst_D6      => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D6,      --                          .hps_io_usb1_inst_D6
			hps_0_hps_io_hps_io_usb1_inst_D7      => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D7,      --                          .hps_io_usb1_inst_D7
			hps_0_hps_io_hps_io_usb1_inst_CLK     => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_CLK,     --                          .hps_io_usb1_inst_CLK
			hps_0_hps_io_hps_io_usb1_inst_STP     => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_STP,     --                          .hps_io_usb1_inst_STP
			hps_0_hps_io_hps_io_usb1_inst_DIR     => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_DIR,     --                          .hps_io_usb1_inst_DIR
			hps_0_hps_io_hps_io_usb1_inst_NXT     => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_NXT,     --                          .hps_io_usb1_inst_NXT
			hps_0_hps_io_hps_io_spim1_inst_CLK    => CONNECTED_TO_hps_0_hps_io_hps_io_spim1_inst_CLK,    --                          .hps_io_spim1_inst_CLK
			hps_0_hps_io_hps_io_spim1_inst_MOSI   => CONNECTED_TO_hps_0_hps_io_hps_io_spim1_inst_MOSI,   --                          .hps_io_spim1_inst_MOSI
			hps_0_hps_io_hps_io_spim1_inst_MISO   => CONNECTED_TO_hps_0_hps_io_hps_io_spim1_inst_MISO,   --                          .hps_io_spim1_inst_MISO
			hps_0_hps_io_hps_io_spim1_inst_SS0    => CONNECTED_TO_hps_0_hps_io_hps_io_spim1_inst_SS0,    --                          .hps_io_spim1_inst_SS0
			hps_0_hps_io_hps_io_uart0_inst_RX     => CONNECTED_TO_hps_0_hps_io_hps_io_uart0_inst_RX,     --                          .hps_io_uart0_inst_RX
			hps_0_hps_io_hps_io_uart0_inst_TX     => CONNECTED_TO_hps_0_hps_io_hps_io_uart0_inst_TX,     --                          .hps_io_uart0_inst_TX
			hps_0_hps_io_hps_io_i2c0_inst_SDA     => CONNECTED_TO_hps_0_hps_io_hps_io_i2c0_inst_SDA,     --                          .hps_io_i2c0_inst_SDA
			hps_0_hps_io_hps_io_i2c0_inst_SCL     => CONNECTED_TO_hps_0_hps_io_hps_io_i2c0_inst_SCL,     --                          .hps_io_i2c0_inst_SCL
			hps_0_hps_io_hps_io_i2c1_inst_SDA     => CONNECTED_TO_hps_0_hps_io_hps_io_i2c1_inst_SDA,     --                          .hps_io_i2c1_inst_SDA
			hps_0_hps_io_hps_io_i2c1_inst_SCL     => CONNECTED_TO_hps_0_hps_io_hps_io_i2c1_inst_SCL,     --                          .hps_io_i2c1_inst_SCL
			hps_0_hps_io_hps_io_gpio_inst_GPIO09  => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO09,  --                          .hps_io_gpio_inst_GPIO09
			hps_0_hps_io_hps_io_gpio_inst_GPIO35  => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO35,  --                          .hps_io_gpio_inst_GPIO35
			hps_0_hps_io_hps_io_gpio_inst_GPIO40  => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO40,  --                          .hps_io_gpio_inst_GPIO40
			hps_0_hps_io_hps_io_gpio_inst_GPIO53  => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO53,  --                          .hps_io_gpio_inst_GPIO53
			hps_0_hps_io_hps_io_gpio_inst_GPIO54  => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO54,  --                          .hps_io_gpio_inst_GPIO54
			hps_0_hps_io_hps_io_gpio_inst_GPIO61  => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO61,  --                          .hps_io_gpio_inst_GPIO61
			im_bus_acknowledge                    => CONNECTED_TO_im_bus_acknowledge,                    --                    im_bus.acknowledge
			im_bus_irq                            => CONNECTED_TO_im_bus_irq,                            --                          .irq
			im_bus_address                        => CONNECTED_TO_im_bus_address,                        --                          .address
			im_bus_bus_enable                     => CONNECTED_TO_im_bus_bus_enable,                     --                          .bus_enable
			im_bus_byte_enable                    => CONNECTED_TO_im_bus_byte_enable,                    --                          .byte_enable
			im_bus_rw                             => CONNECTED_TO_im_bus_rw,                             --                          .rw
			im_bus_write_data                     => CONNECTED_TO_im_bus_write_data,                     --                          .write_data
			im_bus_read_data                      => CONNECTED_TO_im_bus_read_data,                      --                          .read_data
			io_bus_acknowledge                    => CONNECTED_TO_io_bus_acknowledge,                    --                    io_bus.acknowledge
			io_bus_irq                            => CONNECTED_TO_io_bus_irq,                            --                          .irq
			io_bus_address                        => CONNECTED_TO_io_bus_address,                        --                          .address
			io_bus_bus_enable                     => CONNECTED_TO_io_bus_bus_enable,                     --                          .bus_enable
			io_bus_byte_enable                    => CONNECTED_TO_io_bus_byte_enable,                    --                          .byte_enable
			io_bus_rw                             => CONNECTED_TO_io_bus_rw,                             --                          .rw
			io_bus_write_data                     => CONNECTED_TO_io_bus_write_data,                     --                          .write_data
			io_bus_read_data                      => CONNECTED_TO_io_bus_read_data,                      --                          .read_data
			mask_bus_acknowledge                  => CONNECTED_TO_mask_bus_acknowledge,                  --                  mask_bus.acknowledge
			mask_bus_irq                          => CONNECTED_TO_mask_bus_irq,                          --                          .irq
			mask_bus_address                      => CONNECTED_TO_mask_bus_address,                      --                          .address
			mask_bus_bus_enable                   => CONNECTED_TO_mask_bus_bus_enable,                   --                          .bus_enable
			mask_bus_byte_enable                  => CONNECTED_TO_mask_bus_byte_enable,                  --                          .byte_enable
			mask_bus_rw                           => CONNECTED_TO_mask_bus_rw,                           --                          .rw
			mask_bus_write_data                   => CONNECTED_TO_mask_bus_write_data,                   --                          .write_data
			mask_bus_read_data                    => CONNECTED_TO_mask_bus_read_data,                    --                          .read_data
			memory_mem_a                          => CONNECTED_TO_memory_mem_a,                          --                    memory.mem_a
			memory_mem_ba                         => CONNECTED_TO_memory_mem_ba,                         --                          .mem_ba
			memory_mem_ck                         => CONNECTED_TO_memory_mem_ck,                         --                          .mem_ck
			memory_mem_ck_n                       => CONNECTED_TO_memory_mem_ck_n,                       --                          .mem_ck_n
			memory_mem_cke                        => CONNECTED_TO_memory_mem_cke,                        --                          .mem_cke
			memory_mem_cs_n                       => CONNECTED_TO_memory_mem_cs_n,                       --                          .mem_cs_n
			memory_mem_ras_n                      => CONNECTED_TO_memory_mem_ras_n,                      --                          .mem_ras_n
			memory_mem_cas_n                      => CONNECTED_TO_memory_mem_cas_n,                      --                          .mem_cas_n
			memory_mem_we_n                       => CONNECTED_TO_memory_mem_we_n,                       --                          .mem_we_n
			memory_mem_reset_n                    => CONNECTED_TO_memory_mem_reset_n,                    --                          .mem_reset_n
			memory_mem_dq                         => CONNECTED_TO_memory_mem_dq,                         --                          .mem_dq
			memory_mem_dqs                        => CONNECTED_TO_memory_mem_dqs,                        --                          .mem_dqs
			memory_mem_dqs_n                      => CONNECTED_TO_memory_mem_dqs_n,                      --                          .mem_dqs_n
			memory_mem_odt                        => CONNECTED_TO_memory_mem_odt,                        --                          .mem_odt
			memory_mem_dm                         => CONNECTED_TO_memory_mem_dm,                         --                          .mem_dm
			memory_oct_rzqin                      => CONNECTED_TO_memory_oct_rzqin,                      --                          .oct_rzqin
			power_in_port                         => CONNECTED_TO_power_in_port,                         --                     power.in_port
			power_out_port                        => CONNECTED_TO_power_out_port,                        --                          .out_port
			reset_reset_n                         => CONNECTED_TO_reset_reset_n,                         --                     reset.reset_n
			rf_bus_acknowledge                    => CONNECTED_TO_rf_bus_acknowledge,                    --                    rf_bus.acknowledge
			rf_bus_irq                            => CONNECTED_TO_rf_bus_irq,                            --                          .irq
			rf_bus_address                        => CONNECTED_TO_rf_bus_address,                        --                          .address
			rf_bus_bus_enable                     => CONNECTED_TO_rf_bus_bus_enable,                     --                          .bus_enable
			rf_bus_byte_enable                    => CONNECTED_TO_rf_bus_byte_enable,                    --                          .byte_enable
			rf_bus_rw                             => CONNECTED_TO_rf_bus_rw,                             --                          .rw
			rf_bus_write_data                     => CONNECTED_TO_rf_bus_write_data,                     --                          .write_data
			rf_bus_read_data                      => CONNECTED_TO_rf_bus_read_data                       --                          .read_data
		);

