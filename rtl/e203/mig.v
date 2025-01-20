  mig_7series_0 u_mig_7series_0 (
    // Memory interface ports
    .ddr3_addr                      (ddr3_addr),  // output [13:0]		ddr3_addr
    .ddr3_ba                        (ddr3_ba),  // output [2:0]		ddr3_ba
    .ddr3_cas_n                     (ddr3_cas_n),  // output			ddr3_cas_n
    .ddr3_ck_n                      (ddr3_ck_n),  // output [0:0]		ddr3_ck_n
    .ddr3_ck_p                      (ddr3_ck_p),  // output [0:0]		ddr3_ck_p
    .ddr3_cke                       (ddr3_cke),  // output [0:0]		ddr3_cke
    .ddr3_ras_n                     (ddr3_ras_n),  // output			ddr3_ras_n
    .ddr3_reset_n                   (ddr3_reset_n),  // output			ddr3_reset_n
    .ddr3_we_n                      (ddr3_we_n),  // output			ddr3_we_n
    .ddr3_dq                        (ddr3_dq),  // inout [31:0]		ddr3_dq
    .ddr3_dqs_n                     (ddr3_dqs_n),  // inout [3:0]		ddr3_dqs_n
    .ddr3_dqs_p                     (ddr3_dqs_p),  // inout [3:0]		ddr3_dqs_p
    .init_calib_complete            (init_calib_complete),  // output			init_calib_complete
	  .ddr3_cs_n                      (ddr3_cs_n),  // output [0:0]		ddr3_cs_n
    .ddr3_dm                        (ddr3_dm),  // output [3:0]		ddr3_dm
    .ddr3_odt                       (ddr3_odt),  // output [0:0]		ddr3_odt
    // Application interface ports
    .ui_clk                         (ui_clk),  // output			ui_clk
    .ui_clk_sync_rst                (ui_clk_sync_rst),  // output			ui_clk_sync_rst
    .mmcm_locked                    (mmcm_locked),  // output			mmcm_locked
    .aresetn                        (aresetn),  // input			aresetn
    .app_sr_req                     (app_sr_req),  // input			app_sr_req
    .app_ref_req                    (app_ref_req),  // input			app_ref_req
    .app_zq_req                     (app_zq_req),  // input			app_zq_req
    .app_sr_active                  (app_sr_active),  // output			app_sr_active
    .app_ref_ack                    (app_ref_ack),  // output			app_ref_ack
    .app_zq_ack                     (app_zq_ack),  // output			app_zq_ack
    // Slave Interface Write Address Ports
    .s_axi_awid                     (expl_axi_awid),  // input [3:0]			s_axi_awid
    .s_axi_awaddr                   (expl_axi_awaddr),  // input [28:0]			s_axi_awaddr
    .s_axi_awlen                    (expl_axi_awlen),  // input [7:0]			s_axi_awlen
    .s_axi_awsize                   (expl_axi_awsize),  // input [2:0]			s_axi_awsize
    .s_axi_awburst                  (expl_axi_awburst),  // input [1:0]			s_axi_awburst
    .s_axi_awlock                   (expl_axi_awlock),  // input [0:0]			s_axi_awlock
    .s_axi_awcache                  (expl_axi_awcache),  // input [3:0]			s_axi_awcache
    .s_axi_awprot                   (expl_axi_awprot),  // input [2:0]			s_axi_awprot
    .s_axi_awqos                    (expl_axi_awqos),  // input [3:0]			s_axi_awqos
    .s_axi_awvalid                  (expl_axi_awvalid),  // input			s_axi_awvalid
    .s_axi_awready                  (expl_axi_awready),  // output			s_axi_awready
    // Slave Interface Write Data Ports
    .s_axi_wdata                    (expl_axi_wdata),  // input [31:0]			s_axi_wdata
    .s_axi_wstrb                    (expl_axi_wstrb),  // input [3:0]			s_axi_wstrb
    .s_axi_wlast                    (expl_axi_wlast),  // input			s_axi_wlast
    .s_axi_wvalid                   (expl_axi_wvalid),  // input			s_axi_wvalid
    .s_axi_wready                   (expl_axi_wready),  // output			s_axi_wready
    // Slave Interface Write Response Ports
    .s_axi_bid                      (expl_axi_bid),  // output [3:0]			s_axi_bid
    .s_axi_bresp                    (expl_axi_bresp),  // output [1:0]			s_axi_bresp
    .s_axi_bvalid                   (expl_axi_bvalid),  // output			s_axi_bvalid
    .s_axi_bready                   (expl_axi_bready),  // input			s_axi_bready
    // Slave Interface Read Address Ports
    .s_axi_arid                     (expl_axi_arid),  // input [3:0]			s_axi_arid
    .s_axi_araddr                   (expl_axi_araddr),  // input [28:0]			s_axi_araddr
    .s_axi_arlen                    (expl_axi_arlen),  // input [7:0]			s_axi_arlen
    .s_axi_arsize                   (expl_axi_arsize),  // input [2:0]			s_axi_arsize
    .s_axi_arburst                  (expl_axi_arburst),  // input [1:0]			s_axi_arburst
    .s_axi_arlock                   (expl_axi_arlock),  // input [0:0]			s_axi_arlock
    .s_axi_arcache                  (expl_axi_arcache),  // input [3:0]			s_axi_arcache
    .s_axi_arprot                   (expl_axi_arprot),  // input [2:0]			s_axi_arprot
    .s_axi_arqos                    (expl_axi_arqos),  // input [3:0]			s_axi_arqos
    .s_axi_arvalid                  (expl_axi_arvalid),  // input			s_axi_arvalid
    .s_axi_arready                  (expl_axi_arready),  // output			s_axi_arready
    // Slave Interface Read Data Ports
    .s_axi_rid                      (expl_axi_rid),  // output [3:0]			s_axi_rid
    .s_axi_rdata                    (expl_axi_rdata),  // output [31:0]			s_axi_rdata
    .s_axi_rresp                    (expl_axi_rresp),  // output [1:0]			s_axi_rresp
    .s_axi_rlast                    (expl_axi_rlast),  // output			s_axi_rlast
    .s_axi_rvalid                   (expl_axi_rvalid),  // output			s_axi_rvalid
    .s_axi_rready                   (expl_axi_rready),  // input			s_axi_rready
    // System Clock Ports
    .sys_clk_i                       (clk_200m),//MIG IP核输入时钟

    // Reference Clock Ports
    .clk_ref_i                      (clk_200m),//ddr3参考时钟
    .sys_rst                        (rst_n) // input sys_rst
    );
