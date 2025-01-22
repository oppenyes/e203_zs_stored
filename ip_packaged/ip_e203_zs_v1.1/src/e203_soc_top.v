 /*
 Copyright 2018-2020 Nuclei System Technology, Inc.
                                                                         
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
                                                                         
     http:                                                          //www.apache.org/licenses/LICENSE-2.0                          
                                                                         
  Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */
                                                                         
                                                                         
    `include "e203_defines.v"
module e203_soc_top(

    // This clock should comes from the crystal pad generated high speed clock (16MHz)
    input                                    hfextclk                      ,
    output                                   hfxoscen                      ,// The signal to enable the crystal pad generated clock

  // This clock should comes from the crystal pad generated low speed clock (32.768KHz)
    input                                    lfextclk                      ,
    output                                   lfxoscen                      ,// The signal to enable the crystal pad generated clock


  // The JTAG TCK is input, need to be pull-up
    input                                    io_pads_jtag_TCK_i_ival       ,

  // The JTAG TMS is input, need to be pull-up
    input                                    io_pads_jtag_TMS_i_ival       ,

  // The JTAG TDI is input, need to be pull-up
    input                                    io_pads_jtag_TDI_i_ival       ,

  // The JTAG TDO is output have enable
    output                                   io_pads_jtag_TDO_o_oval       ,
    output                                   io_pads_jtag_TDO_o_oe         ,

  // The GPIO are all bidir pad have enables
    input              [32-1: 0]             io_pads_gpioA_i_ival          ,
    output             [32-1: 0]             io_pads_gpioA_o_oval          ,
    output             [32-1: 0]             io_pads_gpioA_o_oe            ,

    input              [32-1: 0]             io_pads_gpioB_i_ival          ,
    output             [32-1: 0]             io_pads_gpioB_o_oval          ,
    output             [32-1: 0]             io_pads_gpioB_o_oe            ,

  //QSPI0 SCK and CS is output without enable
    output                                   io_pads_qspi0_sck_o_oval      ,
    output                                   io_pads_qspi0_cs_0_o_oval     ,

  //QSPI0 DQ is bidir I/O with enable, and need pull-up enable
    input                                    io_pads_qspi0_dq_0_i_ival     ,
    output                                   io_pads_qspi0_dq_0_o_oval     ,
    output                                   io_pads_qspi0_dq_0_o_oe       ,
    input                                    io_pads_qspi0_dq_1_i_ival     ,
    output                                   io_pads_qspi0_dq_1_o_oval     ,
    output                                   io_pads_qspi0_dq_1_o_oe       ,
    input                                    io_pads_qspi0_dq_2_i_ival     ,
    output                                   io_pads_qspi0_dq_2_o_oval     ,
    output                                   io_pads_qspi0_dq_2_o_oe       ,
    input                                    io_pads_qspi0_dq_3_i_ival     ,
    output                                   io_pads_qspi0_dq_3_o_oval     ,
    output                                   io_pads_qspi0_dq_3_o_oe       ,
  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////
  // AXI Read Address Channel
    output                                   expl_axi_arvalid              ,// AXI address valid
    input                                    expl_axi_arready              ,// AXI address ready
    output             [`E203_ADDR_SIZE-1: 0]expl_axi_araddr               ,// AXI address
    output             [   3: 0]             expl_axi_arcache              ,// AXI cache
    output             [   2: 0]             expl_axi_arprot               ,// AXI protection
    output             [   1: 0]             expl_axi_arlock               ,// AXI lock
    output             [   1: 0]             expl_axi_arburst              ,// AXI burst type
    output             [   3: 0]             expl_axi_arlen                ,// AXI burst length
    output             [   2: 0]             expl_axi_arsize               ,// AXI burst size
    
    // AXI Write Address Channel
    output                                   expl_axi_awvalid              ,// AXI write address valid
    input                                    expl_axi_awready              ,// AXI write address ready
    output             [`E203_ADDR_SIZE-1: 0]expl_axi_awaddr               ,// AXI write address
    output             [   3: 0]             expl_axi_awcache              ,// AXI write cache
    output             [   2: 0]             expl_axi_awprot               ,// AXI write protection
    output             [   1: 0]             expl_axi_awlock               ,// AXI write lock
    output             [   1: 0]             expl_axi_awburst              ,// AXI write burst type
    output             [   3: 0]             expl_axi_awlen                ,// AXI write burst length
    output             [   2: 0]             expl_axi_awsize               ,// AXI write burst size

    // AXI Read Data Channel
    input                                    expl_axi_rvalid               ,// AXI read valid
    output                                   expl_axi_rready               ,// AXI read ready
    input              [`E203_XLEN-1: 0]     expl_axi_rdata                ,// AXI read data
    input              [   1: 0]             expl_axi_rresp                ,// AXI read response
    input                                    expl_axi_rlast                ,// AXI read last

    // AXI Write Data Channel
    output                                    expl_axi_wvalid               ,// AXI write valid
    input                                   expl_axi_wready               ,// AXI write ready
    output              [`E203_XLEN-1: 0]     expl_axi_wdata                ,// AXI write data
    output              [(`E203_XLEN/8)-1: 0] expl_axi_wstrb                ,// AXI write strobe
    output                                    expl_axi_wlast                ,// AXI write last
    // AXI Write Response Channel
    input                                    expl_axi_bvalid               ,// AXI write response valid
    output                                   expl_axi_bready               ,// AXI write response ready
    input              [   1: 0]             expl_axi_bresp                ,// AXI write response
  // Erst is input need to be pull-up by default
    input                                    io_pads_aon_erst_n_i_ival     ,

  // dbgmode are inputs need to be pull-up by default
    input                                    io_pads_dbgmode0_n_i_ival     ,
    input                                    io_pads_dbgmode1_n_i_ival     ,
    input                                    io_pads_dbgmode2_n_i_ival     ,

  // BootRom is input need to be pull-up by default
    input                                    io_pads_bootrom_n_i_ival      ,


  // dwakeup is input need to be pull-up by default
    input                                    io_pads_aon_pmu_dwakeup_n_i_ival,

      // PMU output is just output without enable
    output                                   io_pads_aon_pmu_padrst_o_oval ,
    output                                   io_pads_aon_pmu_vddpaden_o_oval 
);


 
    wire                                     sysper_icb_cmd_valid          ;
    wire                                     sysper_icb_cmd_ready          ;

    wire                                     sysfio_icb_cmd_valid          ;
    wire                                     sysfio_icb_cmd_ready          ;

    wire                                     sysmem_icb_cmd_valid          ;
    wire                                     sysmem_icb_cmd_ready          ;

 e203_subsys_top u_e203_subsys_top(
    .core_mhartid                            (1'b0                         ),
  



  `ifdef E203_HAS_ITCM_EXTITF                                       //{
    .ext2itcm_icb_cmd_valid                  (1'b0                         ),
    .ext2itcm_icb_cmd_ready                  (                             ),
    .ext2itcm_icb_cmd_addr                   (`E203_ITCM_ADDR_WIDTH'b0     ),
    .ext2itcm_icb_cmd_read                   (1'b0                         ),
    .ext2itcm_icb_cmd_wdata                  (32'b0                        ),
    .ext2itcm_icb_cmd_wmask                  (4'b0                         ),
    
    .ext2itcm_icb_rsp_valid                  (                             ),
    .ext2itcm_icb_rsp_ready                  (1'b0                         ),
    .ext2itcm_icb_rsp_err                    (                             ),
    .ext2itcm_icb_rsp_rdata                  (                             ),
  `endif                                                            //}

  `ifdef E203_HAS_DTCM_EXTITF                                       //{
    .ext2dtcm_icb_cmd_valid                  (1'b0                         ),
    .ext2dtcm_icb_cmd_ready                  (                             ),
    .ext2dtcm_icb_cmd_addr                   (`E203_DTCM_ADDR_WIDTH'b0     ),
    .ext2dtcm_icb_cmd_read                   (1'b0                         ),
    .ext2dtcm_icb_cmd_wdata                  (32'b0                        ),
    .ext2dtcm_icb_cmd_wmask                  (4'b0                         ),
    
    .ext2dtcm_icb_rsp_valid                  (                             ),
    .ext2dtcm_icb_rsp_ready                  (1'b0                         ),
    .ext2dtcm_icb_rsp_err                    (                             ),
    .ext2dtcm_icb_rsp_rdata                  (                             ),
  `endif                                                            //}

    .sysper_icb_cmd_valid                    (sysper_icb_cmd_valid         ),
    .sysper_icb_cmd_ready                    (sysper_icb_cmd_ready         ),
    .sysper_icb_cmd_read                     (                             ),
    .sysper_icb_cmd_addr                     (                             ),
    .sysper_icb_cmd_wdata                    (                             ),
    .sysper_icb_cmd_wmask                    (                             ),
  
    .sysper_icb_rsp_valid                    (sysper_icb_cmd_valid         ),
    .sysper_icb_rsp_ready                    (sysper_icb_cmd_ready         ),
    .sysper_icb_rsp_err                      (1'b0                         ),
    .sysper_icb_rsp_rdata                    (32'b0                        ),


    .sysfio_icb_cmd_valid                    (sysfio_icb_cmd_valid         ),
    .sysfio_icb_cmd_ready                    (sysfio_icb_cmd_ready         ),
    .sysfio_icb_cmd_read                     (                             ),
    .sysfio_icb_cmd_addr                     (                             ),
    .sysfio_icb_cmd_wdata                    (                             ),
    .sysfio_icb_cmd_wmask                    (                             ),
   
    .sysfio_icb_rsp_valid                    (sysfio_icb_cmd_valid         ),
    .sysfio_icb_rsp_ready                    (sysfio_icb_cmd_ready         ),
    .sysfio_icb_rsp_err                      (1'b0                         ),
    .sysfio_icb_rsp_rdata                    (32'b0                        ),

    .sysmem_icb_cmd_valid                    (sysmem_icb_cmd_valid         ),
    .sysmem_icb_cmd_ready                    (sysmem_icb_cmd_ready         ),
    .sysmem_icb_cmd_read                     (                             ),
    .sysmem_icb_cmd_addr                     (                             ),
    .sysmem_icb_cmd_wdata                    (                             ),
    .sysmem_icb_cmd_wmask                    (                             ),

    .sysmem_icb_rsp_valid                    (sysmem_icb_cmd_valid         ),
    .sysmem_icb_rsp_ready                    (sysmem_icb_cmd_ready         ),
    .sysmem_icb_rsp_err                      (1'b0                         ),
    .sysmem_icb_rsp_rdata                    (32'b0                        ),

    .io_pads_jtag_TCK_i_ival                 (io_pads_jtag_TCK_i_ival      ),
    .io_pads_jtag_TCK_o_oval                 (                             ),
    .io_pads_jtag_TCK_o_oe                   (                             ),
    .io_pads_jtag_TCK_o_ie                   (                             ),
    .io_pads_jtag_TCK_o_pue                  (                             ),
    .io_pads_jtag_TCK_o_ds                   (                             ),

    .io_pads_jtag_TMS_i_ival                 (io_pads_jtag_TMS_i_ival      ),
    .io_pads_jtag_TMS_o_oval                 (                             ),
    .io_pads_jtag_TMS_o_oe                   (                             ),
    .io_pads_jtag_TMS_o_ie                   (                             ),
    .io_pads_jtag_TMS_o_pue                  (                             ),
    .io_pads_jtag_TMS_o_ds                   (                             ),

    .io_pads_jtag_TDI_i_ival                 (io_pads_jtag_TDI_i_ival      ),
    .io_pads_jtag_TDI_o_oval                 (                             ),
    .io_pads_jtag_TDI_o_oe                   (                             ),
    .io_pads_jtag_TDI_o_ie                   (                             ),
    .io_pads_jtag_TDI_o_pue                  (                             ),
    .io_pads_jtag_TDI_o_ds                   (                             ),

    .io_pads_jtag_TDO_i_ival                 (1'b1                         ),
    .io_pads_jtag_TDO_o_oval                 (io_pads_jtag_TDO_o_oval      ),
    .io_pads_jtag_TDO_o_oe                   (io_pads_jtag_TDO_o_oe        ),
    .io_pads_jtag_TDO_o_ie                   (                             ),
    .io_pads_jtag_TDO_o_pue                  (                             ),
    .io_pads_jtag_TDO_o_ds                   (                             ),

    .io_pads_jtag_TRST_n_i_ival              (1'b1                         ),
    .io_pads_jtag_TRST_n_o_oval              (                             ),
    .io_pads_jtag_TRST_n_o_oe                (                             ),
    .io_pads_jtag_TRST_n_o_ie                (                             ),
    .io_pads_jtag_TRST_n_o_pue               (                             ),
    .io_pads_jtag_TRST_n_o_ds                (                             ),

    .test_mode                               (1'b0                         ),
    .test_iso_override                       (1'b0                         ),

    .io_pads_gpioA_i_ival                    (io_pads_gpioA_i_ival         ),
    .io_pads_gpioA_o_oval                    (io_pads_gpioA_o_oval         ),
    .io_pads_gpioA_o_oe                      (io_pads_gpioA_o_oe           ),

    .io_pads_gpioB_i_ival                    (io_pads_gpioB_i_ival         ),
    .io_pads_gpioB_o_oval                    (io_pads_gpioB_o_oval         ),
    .io_pads_gpioB_o_oe                      (io_pads_gpioB_o_oe           ),

    .io_pads_qspi0_sck_i_ival                (1'b1                         ),
    .io_pads_qspi0_sck_o_oval                (io_pads_qspi0_sck_o_oval     ),
    .io_pads_qspi0_sck_o_oe                  (                             ),
    .io_pads_qspi0_dq_0_i_ival               (io_pads_qspi0_dq_0_i_ival    ),
    .io_pads_qspi0_dq_0_o_oval               (io_pads_qspi0_dq_0_o_oval    ),
    .io_pads_qspi0_dq_0_o_oe                 (io_pads_qspi0_dq_0_o_oe      ),
    .io_pads_qspi0_dq_1_i_ival               (io_pads_qspi0_dq_1_i_ival    ),
    .io_pads_qspi0_dq_1_o_oval               (io_pads_qspi0_dq_1_o_oval    ),
    .io_pads_qspi0_dq_1_o_oe                 (io_pads_qspi0_dq_1_o_oe      ),
    .io_pads_qspi0_dq_2_i_ival               (io_pads_qspi0_dq_2_i_ival    ),
    .io_pads_qspi0_dq_2_o_oval               (io_pads_qspi0_dq_2_o_oval    ),
    .io_pads_qspi0_dq_2_o_oe                 (io_pads_qspi0_dq_2_o_oe      ),
    .io_pads_qspi0_dq_3_i_ival               (io_pads_qspi0_dq_3_i_ival    ),
    .io_pads_qspi0_dq_3_o_oval               (io_pads_qspi0_dq_3_o_oval    ),
    .io_pads_qspi0_dq_3_o_oe                 (io_pads_qspi0_dq_3_o_oe      ),
    .io_pads_qspi0_cs_0_i_ival               (1'b1                         ),
    .io_pads_qspi0_cs_0_o_oval               (io_pads_qspi0_cs_0_o_oval    ),
    .io_pads_qspi0_cs_0_o_oe                 (                             ),
//////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////
  // AXI Read Address Channel
    .expl_axi_arvalid                        (expl_axi_arvalid             ),// AXI address valid
    .expl_axi_arready                        (expl_axi_arready             ),// AXI address ready
    .expl_axi_araddr                         (expl_axi_araddr              ),// AXI address
    .expl_axi_arcache                        (expl_axi_arcache             ),// AXI cache
    .expl_axi_arprot                         (expl_axi_arprot              ),// AXI protection
    .expl_axi_arlock                         (expl_axi_arlock              ),// AXI lock
    .expl_axi_arburst                        (expl_axi_arburst             ),// AXI burst type
    .expl_axi_arlen                          (expl_axi_arlen               ),// AXI burst length
    .expl_axi_arsize                         (expl_axi_arsize              ),// AXI burst size
    // AXI Write Address Channel
    .expl_axi_awvalid                        (expl_axi_awvalid             ),// AXI write address valid
    .expl_axi_awready                        (expl_axi_awready             ),// AXI write address ready
    .expl_axi_awaddr                         (expl_axi_awaddr              ),// AXI write address
    .expl_axi_awcache                        (expl_axi_awcache             ),// AXI write cache
    .expl_axi_awprot                         (expl_axi_awprot              ),// AXI write protection
    .expl_axi_awlock                         (expl_axi_awlock              ),// AXI write lock
    .expl_axi_awburst                        (expl_axi_awburst             ),// AXI write burst type
    .expl_axi_awlen                          (expl_axi_awlen               ),// AXI write burst length
    .expl_axi_awsize                         (expl_axi_awsize              ),// AXI write burst size
    // AXI Read Data Channel
    .expl_axi_rvalid                         (expl_axi_rvalid              ),// AXI read valid
    .expl_axi_rready                         (expl_axi_rready              ),// AXI read ready
    .expl_axi_rdata                          (expl_axi_rdata               ),// AXI read data
    .expl_axi_rresp                          (expl_axi_rresp               ),// AXI read response
    .expl_axi_rlast                          (expl_axi_rlast               ),// AXI read last
    // AXI Write Data Channel
    .expl_axi_wvalid                         (expl_axi_wvalid              ),// AXI write valid
    .expl_axi_wready                         (expl_axi_wready              ),// AXI write ready
    .expl_axi_wdata                          (expl_axi_wdata               ),// AXI write data
    .expl_axi_wstrb                          (expl_axi_wstrb               ),// AXI write strobe
    .expl_axi_wlast                          (expl_axi_wlast               ),// AXI write last
    // AXI Write Response Channel
    .expl_axi_bvalid                         (expl_axi_bvalid              ),// AXI write response valid
    .expl_axi_bready                         (expl_axi_bready              ),// AXI write response ready
    .expl_axi_bresp                          (expl_axi_bresp               ),// AXI write response
    .hfextclk                                (hfextclk                     ),
    .hfxoscen                                (hfxoscen                     ),
    .lfextclk                                (lfextclk                     ),
    .lfxoscen                                (lfxoscen                     ),

    .io_pads_aon_erst_n_i_ival               (io_pads_aon_erst_n_i_ival    ),
    .io_pads_aon_erst_n_o_oval               (                             ),
    .io_pads_aon_erst_n_o_oe                 (                             ),
    .io_pads_aon_erst_n_o_ie                 (                             ),
    .io_pads_aon_erst_n_o_pue                (                             ),
    .io_pads_aon_erst_n_o_ds                 (                             ),
    .io_pads_aon_pmu_dwakeup_n_i_ival        (io_pads_aon_pmu_dwakeup_n_i_ival),
    .io_pads_aon_pmu_dwakeup_n_o_oval        (                             ),
    .io_pads_aon_pmu_dwakeup_n_o_oe          (                             ),
    .io_pads_aon_pmu_dwakeup_n_o_ie          (                             ),
    .io_pads_aon_pmu_dwakeup_n_o_pue         (                             ),
    .io_pads_aon_pmu_dwakeup_n_o_ds          (                             ),
    .io_pads_aon_pmu_vddpaden_i_ival         (1'b1                         ),
    .io_pads_aon_pmu_vddpaden_o_oval         (io_pads_aon_pmu_vddpaden_o_oval),
    .io_pads_aon_pmu_vddpaden_o_oe           (                             ),
    .io_pads_aon_pmu_vddpaden_o_ie           (                             ),
    .io_pads_aon_pmu_vddpaden_o_pue          (                             ),
    .io_pads_aon_pmu_vddpaden_o_ds           (                             ),

  
    .io_pads_aon_pmu_padrst_i_ival           (1'b1                         ),
    .io_pads_aon_pmu_padrst_o_oval           (io_pads_aon_pmu_padrst_o_oval),
    .io_pads_aon_pmu_padrst_o_oe             (                             ),
    .io_pads_aon_pmu_padrst_o_ie             (                             ),
    .io_pads_aon_pmu_padrst_o_pue            (                             ),
    .io_pads_aon_pmu_padrst_o_ds             (                             ),

    .io_pads_bootrom_n_i_ival                (io_pads_bootrom_n_i_ival     ),
    .io_pads_bootrom_n_o_oval                (                             ),
    .io_pads_bootrom_n_o_oe                  (                             ),
    .io_pads_bootrom_n_o_ie                  (                             ),
    .io_pads_bootrom_n_o_pue                 (                             ),
    .io_pads_bootrom_n_o_ds                  (                             ),

    .io_pads_dbgmode0_n_i_ival               (io_pads_dbgmode0_n_i_ival    ),

    .io_pads_dbgmode1_n_i_ival               (io_pads_dbgmode1_n_i_ival    ),

    .io_pads_dbgmode2_n_i_ival               (io_pads_dbgmode2_n_i_ival    ) 


  );


endmodule
