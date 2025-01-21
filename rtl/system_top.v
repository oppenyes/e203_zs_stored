`timescale 1ns/1ps    
`include "e203_defines.v"
module system_top
(
  input wire CLK100MHZ,//GCLK-W19
  input wire CLK32768KHZ,//RTC_CLK-Y18

  input wire fpga_rst,//FPGA_RESET-T6
  input wire mcu_rst,//MCU_RESET-P20


  // Dedicated QSPI interface
  output wire qspi0_cs,
  output wire qspi0_sck,
  inout wire [3:0] qspi0_dq,
                           
  //gpioA
  inout wire [31:0] gpioA,//GPIOA00~GPIOA31

  //gpioB
  inout wire [31:0] gpioB,//GPIOB00~GPIOB31

  // JD (used for JTAG connection)
  inout wire mcu_TDO,//MCU_TDO-N17
  inout wire mcu_TCK,//MCU_TCK-P15 
  inout wire mcu_TDI,//MCU_TDI-T18
  inout wire mcu_TMS,//MCU_TMS-P17

  //pmu_wakeup

  inout wire pmu_paden,  //PMU_VDDPADEN-U15
  inout wire pmu_padrst, //PMU_VADDPARST_V15
  inout wire mcu_wakeup  //MCU_WAKE-N15
);    

    wire                                     expl_axi_arvalid              ;
    wire                                     expl_axi_arready              ;
    wire               [`E203_ADDR_SIZE-1: 0]expl_axi_araddr               ;
    wire               [   3: 0]             expl_axi_arcache              ;
    wire               [   2: 0]             expl_axi_arprot               ;
    wire               [   1: 0]             expl_axi_arlock               ;
    wire               [   1: 0]             expl_axi_arburst              ;
    wire               [   3: 0]             expl_axi_arlen                ;
    wire               [   2: 0]             expl_axi_arsize               ;

    wire                                     expl_axi_awvalid              ;
    wire                                     expl_axi_awready              ;
    wire               [`E203_ADDR_SIZE-1: 0]expl_axi_awaddr               ;
    wire               [   3: 0]             expl_axi_awcache              ;
    wire               [   2: 0]             expl_axi_awprot               ;
    wire               [   1: 0]             expl_axi_awlock               ;
    wire               [   1: 0]             expl_axi_awburst              ;
    wire               [   3: 0]             expl_axi_awlen                ;
    wire               [   2: 0]             expl_axi_awsize               ;

    wire                                     expl_axi_rvalid               ;
    wire                                     expl_axi_rready               ;
    wire               [`E203_XLEN-1: 0]     expl_axi_rdata                ;
    wire               [   1: 0]             expl_axi_rresp                ;
    wire                                     expl_axi_rlast                ;

    wire                                     expl_axi_wvalid               ;
    wire                                     expl_axi_wready               ;
    wire               [`E203_XLEN-1: 0]     expl_axi_wdata                ;
    wire               [(`E203_XLEN/8)-1: 0] expl_axi_wstrb                ;
    wire                                     expl_axi_wlast                ;

    wire                                     expl_axi_bvalid               ;
    wire                                     expl_axi_bready               ;
    wire               [   1: 0]             expl_axi_bresp                ;
  // wire clk_out1;
  wire mmcm_locked;

  // wire ck_rst;

  //=================================================
  // Clock & Reset
  // wire clk_8388;
  wire clk_16M;
  


  mmcm ip_mmcm
  (
    .resetn(fpga_rst & mcu_rst),
    .clk_in1(CLK100MHZ),
    
    .clk_out2(clk_16M), // 16 MHz, this clock we set to 16MHz 
    .locked(mmcm_locked)
  );

  // assign ck_rst = fpga_rst & mcu_rst;

  
e203_zs u_e203_zs(
    .clk_16M                            (clk_16M                   ), // GCLK-W19
    .CLK32768KHZ                        (CLK32768KHZ               ), // RTC_CLK-Y18
    .fpga_rst                           (fpga_rst                  ), // FPGA_RESET-T6
    .mcu_rst                            (mcu_rst                   ), // MCU_RESET-P20
  // Dedicated QSPI interface
    .qspi0_cs                           (qspi0_cs                  ),
    .qspi0_sck                          (qspi0_sck                 ),
    .qspi0_dq                           (qspi0_dq                  ),
  //gpioA
    .gpioA                              (gpioA                     ), // GPIOA00~GPIOA31
  //gpioB
    .gpioB                              (gpioB                     ), // GPIOB00~GPIOB31
  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////
  // AXI Read Address Channel
    .expl_axi_arvalid                   (expl_axi_arvalid          ), // AXI address valid
    .expl_axi_arready                   (expl_axi_arready          ), // AXI address ready
    .expl_axi_araddr                    (expl_axi_araddr           ), // AXI address
    .expl_axi_arcache                   (expl_axi_arcache          ), // AXI cache
    .expl_axi_arprot                    (expl_axi_arprot           ), // AXI protection
    .expl_axi_arlock                    (expl_axi_arlock           ), // AXI lock
    .expl_axi_arburst                   (expl_axi_arburst          ), // AXI burst type
    .expl_axi_arlen                     (expl_axi_arlen            ), // AXI burst length
    .expl_axi_arsize                    (expl_axi_arsize           ), // AXI burst size
    // AXI Write Address Channel
    .expl_axi_awvalid                   (expl_axi_awvalid          ), // AXI write address valid
    .expl_axi_awready                   (expl_axi_awready          ), // AXI write address ready
    .expl_axi_awaddr                    (expl_axi_awaddr           ), // AXI write address
    .expl_axi_awcache                   (expl_axi_awcache          ), // AXI write cache
    .expl_axi_awprot                    (expl_axi_awprot           ), // AXI write protection
    .expl_axi_awlock                    (expl_axi_awlock           ), // AXI write lock
    .expl_axi_awburst                   (expl_axi_awburst          ), // AXI write burst type
    .expl_axi_awlen                     (expl_axi_awlen            ), // AXI write burst length
    .expl_axi_awsize                    (expl_axi_awsize           ), // AXI write burst size
    // AXI Read Data Channel
    .expl_axi_rvalid                    (expl_axi_rvalid           ), // AXI read valid
    .expl_axi_rready                    (expl_axi_rready           ), // AXI read ready
    .expl_axi_rdata                     (expl_axi_rdata            ), // AXI read data
    .expl_axi_rresp                     (expl_axi_rresp            ), // AXI read response
    .expl_axi_rlast                     (expl_axi_rlast            ), // AXI read last
    // AXI Write Data Channel
    .expl_axi_wvalid                    (expl_axi_wvalid           ), // AXI write valid
    .expl_axi_wready                    (expl_axi_wready           ), // AXI write ready
    .expl_axi_wdata                     (expl_axi_wdata            ), // AXI write data
    .expl_axi_wstrb                     (expl_axi_wstrb            ), // AXI write strobe
    .expl_axi_wlast                     (expl_axi_wlast            ), // AXI write last
    // AXI Write Response Channel
    .expl_axi_bvalid                    (expl_axi_bvalid           ), // AXI write response valid
    .expl_axi_bready                    (expl_axi_bready           ), // AXI write response ready
    .expl_axi_bresp                     (expl_axi_bresp            ), // AXI write response
  // JD (used for JTAG connection)
    .mcu_TDO                            (mcu_TDO                   ), // MCU_TDO-N17
    .mcu_TCK                            (mcu_TCK                   ), // MCU_TCK-P15
    .mcu_TDI                            (mcu_TDI                   ), // MCU_TDI-T18
    .mcu_TMS                            (mcu_TMS                   ), // MCU_TMS-P17
  //pmu_wakeup
    .pmu_paden                          (pmu_paden                 ), // PMU_VDDPADEN-U15
    .pmu_padrst                         (pmu_padrst                ), // PMU_VADDPARST_V15
    .mcu_wakeup                         (mcu_wakeup                ) // MCU_WAKE-N15
);
endmodule