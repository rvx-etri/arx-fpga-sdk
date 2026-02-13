// ****************************************************************************
// ****************************************************************************
// Copyright SoC Design Research Group, All rights reserved.
// Electronics and Telecommunications Research Institute (ETRI)
// 
// THESE DOCUMENTS CONTAIN CONFIDENTIAL INFORMATION AND KNOWLEDGE
// WHICH IS THE PROPERTY OF ETRI. NO PART OF THIS PUBLICATION IS
// TO BE USED FOR ANY OTHER PURPOSE, AND THESE ARE NOT TO BE
// REPRODUCED, COPIED, DISCLOSED, TRANSMITTED, STORED IN A RETRIEVAL
// SYSTEM OR TRANSLATED INTO ANY OTHER HUMAN OR COMPUTER LANGUAGE,
// IN ANY FORM, BY ANY MEANS, IN WHOLE OR IN PART, WITHOUT THE
// COMPLETE PRIOR WRITTEN PERMISSION OF ETRI.
// ****************************************************************************
// 2026-02-13
// Kyuseung Han (han@etri.re.kr)
// ****************************************************************************
// ****************************************************************************

`include "ervp_platform_controller_memorymap_offset.vh"
`include "ervp_external_peri_group_memorymap_offset.vh"
`include "memorymap_info.vh"
`include "dca_matrix_lsu_inst.vh"
`include "ervp_global.vh"
`include "platform_info.vh"
`include "munoc_network_include.vh"

module ARX_NPU_MC_RTL
(
	boot_mode,
	clk_system,
	clk_dca_core,
	clk_core,
	clk_system_external,
	clk_system_debug,
	clk_local_access,
	clk_process_000,
	clk_process_001,
	clk_process_002,
	clk_process_003,
	clk_dram_if,
	clk_dram_sys,
	clk_dram_ref,
	clk_noc,
	gclk_system,
	gclk_dca_core,
	gclk_core,
	gclk_system_external,
	gclk_system_debug,
	gclk_local_access,
	gclk_process_000,
	gclk_process_001,
	gclk_process_002,
	gclk_process_003,
	gclk_noc,
	tick_1us,
	tick_62d5ms,
	tick_gpio,
	spi_common_sclk,
	spi_common_sdq0,
	external_rstnn,
	global_rstnn,
	global_rstpp,
	rstnn_seqeunce,
	rstpp_seqeunce,
	rstnn_user,
	rstpp_user,
	led_list,
	i_system_ddr_clk_ref,
	i_system_ddr_clk_sys,
	i_system_ddr_rstnn_sys,
	i_system_ddr_clk_dram_if,
	i_system_ddr_rstnn_dram_if,
	i_system_ddr_initialized,
	i_pll0_external_rstnn,
	i_pll0_clk_system,
	i_pll0_clk_dram_sys,
	i_pll0_clk_dram_ref,
	i_system_sram_clk,
	i_system_sram_rstnn,
	pjtag_rtck,
	pjtag_rtrstnn,
	pjtag_rtms,
	pjtag_rtdi,
	pjtag_rtdo,
	printf_tx,
	printf_rx,
	spi_flash_sclk,
	spi_flash_scs,
	spi_flash_sdq0,
	spi_flash_sdq1,
	i_system_ddr_sxawready,
	i_system_ddr_sxawvalid,
	i_system_ddr_sxawaddr,
	i_system_ddr_sxawid,
	i_system_ddr_sxawlen,
	i_system_ddr_sxawsize,
	i_system_ddr_sxawburst,
	i_system_ddr_sxwready,
	i_system_ddr_sxwvalid,
	i_system_ddr_sxwid,
	i_system_ddr_sxwdata,
	i_system_ddr_sxwstrb,
	i_system_ddr_sxwlast,
	i_system_ddr_sxbready,
	i_system_ddr_sxbvalid,
	i_system_ddr_sxbid,
	i_system_ddr_sxbresp,
	i_system_ddr_sxarready,
	i_system_ddr_sxarvalid,
	i_system_ddr_sxaraddr,
	i_system_ddr_sxarid,
	i_system_ddr_sxarlen,
	i_system_ddr_sxarsize,
	i_system_ddr_sxarburst,
	i_system_ddr_sxrready,
	i_system_ddr_sxrvalid,
	i_system_ddr_sxrid,
	i_system_ddr_sxrdata,
	i_system_ddr_sxrlast,
	i_system_ddr_sxrresp,
	i_system_sram_sxawready,
	i_system_sram_sxawvalid,
	i_system_sram_sxawaddr,
	i_system_sram_sxawid,
	i_system_sram_sxawlen,
	i_system_sram_sxawsize,
	i_system_sram_sxawburst,
	i_system_sram_sxwready,
	i_system_sram_sxwvalid,
	i_system_sram_sxwid,
	i_system_sram_sxwdata,
	i_system_sram_sxwstrb,
	i_system_sram_sxwlast,
	i_system_sram_sxbready,
	i_system_sram_sxbvalid,
	i_system_sram_sxbid,
	i_system_sram_sxbresp,
	i_system_sram_sxarready,
	i_system_sram_sxarvalid,
	i_system_sram_sxaraddr,
	i_system_sram_sxarid,
	i_system_sram_sxarlen,
	i_system_sram_sxarsize,
	i_system_sram_sxarburst,
	i_system_sram_sxrready,
	i_system_sram_sxrvalid,
	i_system_sram_sxrid,
	i_system_sram_sxrdata,
	i_system_sram_sxrlast,
	i_system_sram_sxrresp
);

parameter BW_FNI_PHIT = `MAX_BW_FNI_PHIT;
parameter BW_BNI_PHIT = `MAX_BW_BNI_PHIT;

input wire [(`BW_BOOT_MODE)-1:0] boot_mode;
output wire clk_system;
output wire clk_dca_core;
output wire clk_core;
output wire clk_system_external;
output wire clk_system_debug;
output wire clk_local_access;
output wire clk_process_000;
output wire clk_process_001;
output wire clk_process_002;
output wire clk_process_003;
output wire clk_dram_if;
output wire clk_dram_sys;
output wire clk_dram_ref;
output wire clk_noc;
output wire gclk_system;
output wire gclk_dca_core;
output wire gclk_core;
output wire gclk_system_external;
output wire gclk_system_debug;
output wire gclk_local_access;
output wire gclk_process_000;
output wire gclk_process_001;
output wire gclk_process_002;
output wire gclk_process_003;
output wire gclk_noc;
output wire tick_1us;
output wire tick_62d5ms;
output wire tick_gpio;
output wire spi_common_sclk;
output wire spi_common_sdq0;
input wire external_rstnn;
output wire global_rstnn;
output wire global_rstpp;
output wire [(10)-1:0] rstnn_seqeunce;
output wire [(10)-1:0] rstpp_seqeunce;
output wire rstnn_user;
output wire rstpp_user;
output wire [((1)*(1))-1:0] led_list;
output wire i_system_ddr_clk_ref;
output wire i_system_ddr_clk_sys;
output wire i_system_ddr_rstnn_sys;
input wire i_system_ddr_clk_dram_if;
output wire i_system_ddr_rstnn_dram_if;
input wire i_system_ddr_initialized;
output wire i_pll0_external_rstnn;
input wire i_pll0_clk_system;
input wire i_pll0_clk_dram_sys;
input wire i_pll0_clk_dram_ref;
output wire i_system_sram_clk;
output wire i_system_sram_rstnn;
input wire pjtag_rtck;
input wire pjtag_rtrstnn;
input wire pjtag_rtms;
input wire pjtag_rtdi;
output wire pjtag_rtdo;
output wire printf_tx;
input wire printf_rx;
output wire spi_flash_sclk;
output wire spi_flash_scs;
output wire spi_flash_sdq0;
input wire spi_flash_sdq1;
input wire i_system_ddr_sxawready;
output wire i_system_ddr_sxawvalid;
output wire [(32)-1:0] i_system_ddr_sxawaddr;
output wire [(16)-1:0] i_system_ddr_sxawid;
output wire [(8)-1:0] i_system_ddr_sxawlen;
output wire [(3)-1:0] i_system_ddr_sxawsize;
output wire [(2)-1:0] i_system_ddr_sxawburst;
input wire i_system_ddr_sxwready;
output wire i_system_ddr_sxwvalid;
output wire [(16)-1:0] i_system_ddr_sxwid;
output wire [(32)-1:0] i_system_ddr_sxwdata;
output wire [(32/8)-1:0] i_system_ddr_sxwstrb;
output wire i_system_ddr_sxwlast;
output wire i_system_ddr_sxbready;
input wire i_system_ddr_sxbvalid;
input wire [(16)-1:0] i_system_ddr_sxbid;
input wire [(2)-1:0] i_system_ddr_sxbresp;
input wire i_system_ddr_sxarready;
output wire i_system_ddr_sxarvalid;
output wire [(32)-1:0] i_system_ddr_sxaraddr;
output wire [(16)-1:0] i_system_ddr_sxarid;
output wire [(8)-1:0] i_system_ddr_sxarlen;
output wire [(3)-1:0] i_system_ddr_sxarsize;
output wire [(2)-1:0] i_system_ddr_sxarburst;
output wire i_system_ddr_sxrready;
input wire i_system_ddr_sxrvalid;
input wire [(16)-1:0] i_system_ddr_sxrid;
input wire [(32)-1:0] i_system_ddr_sxrdata;
input wire i_system_ddr_sxrlast;
input wire [(2)-1:0] i_system_ddr_sxrresp;
input wire i_system_sram_sxawready;
output wire i_system_sram_sxawvalid;
output wire [(32)-1:0] i_system_sram_sxawaddr;
output wire [(`REQUIRED_BW_OF_SLAVE_TID)-1:0] i_system_sram_sxawid;
output wire [(8)-1:0] i_system_sram_sxawlen;
output wire [(3)-1:0] i_system_sram_sxawsize;
output wire [(2)-1:0] i_system_sram_sxawburst;
input wire i_system_sram_sxwready;
output wire i_system_sram_sxwvalid;
output wire [(`REQUIRED_BW_OF_SLAVE_TID)-1:0] i_system_sram_sxwid;
output wire [(32)-1:0] i_system_sram_sxwdata;
output wire [(32/8)-1:0] i_system_sram_sxwstrb;
output wire i_system_sram_sxwlast;
output wire i_system_sram_sxbready;
input wire i_system_sram_sxbvalid;
input wire [(`REQUIRED_BW_OF_SLAVE_TID)-1:0] i_system_sram_sxbid;
input wire [(2)-1:0] i_system_sram_sxbresp;
input wire i_system_sram_sxarready;
output wire i_system_sram_sxarvalid;
output wire [(32)-1:0] i_system_sram_sxaraddr;
output wire [(`REQUIRED_BW_OF_SLAVE_TID)-1:0] i_system_sram_sxarid;
output wire [(8)-1:0] i_system_sram_sxarlen;
output wire [(3)-1:0] i_system_sram_sxarsize;
output wire [(2)-1:0] i_system_sram_sxarburst;
output wire i_system_sram_sxrready;
input wire i_system_sram_sxrvalid;
input wire [(`REQUIRED_BW_OF_SLAVE_TID)-1:0] i_system_sram_sxrid;
input wire [(32)-1:0] i_system_sram_sxrdata;
input wire i_system_sram_sxrlast;
input wire [(2)-1:0] i_system_sram_sxrresp;


`include "dca_lsu_util.vb"

wire autoname_104;
wire rstnn_noc;
wire i_main_core_clk;
wire i_main_core_rstnn;
wire [(32)-1:0] i_main_core_interrupt_vector;
wire i_main_core_interrupt_out;
wire i_main_core_sxawready;
wire i_main_core_sxawvalid;
wire [(32)-1:0] i_main_core_sxawaddr;
wire [(4)-1:0] i_main_core_sxawid;
wire [(8)-1:0] i_main_core_sxawlen;
wire [(3)-1:0] i_main_core_sxawsize;
wire [(2)-1:0] i_main_core_sxawburst;
wire i_main_core_sxwready;
wire i_main_core_sxwvalid;
wire [(4)-1:0] i_main_core_sxwid;
wire [(32)-1:0] i_main_core_sxwdata;
wire [(32/8)-1:0] i_main_core_sxwstrb;
wire i_main_core_sxwlast;
wire i_main_core_sxbready;
wire i_main_core_sxbvalid;
wire [(4)-1:0] i_main_core_sxbid;
wire [(2)-1:0] i_main_core_sxbresp;
wire i_main_core_sxarready;
wire i_main_core_sxarvalid;
wire [(32)-1:0] i_main_core_sxaraddr;
wire [(4)-1:0] i_main_core_sxarid;
wire [(8)-1:0] i_main_core_sxarlen;
wire [(3)-1:0] i_main_core_sxarsize;
wire [(2)-1:0] i_main_core_sxarburst;
wire i_main_core_sxrready;
wire i_main_core_sxrvalid;
wire [(4)-1:0] i_main_core_sxrid;
wire [(32)-1:0] i_main_core_sxrdata;
wire i_main_core_sxrlast;
wire [(2)-1:0] i_main_core_sxrresp;
wire [(32)-1:0] i_main_core_spc;
wire [(32)-1:0] i_main_core_sinst;
wire i_dca_matrix_conv00_clk;
wire i_dca_matrix_conv00_rstnn;
wire [(1)-1:0] i_dca_matrix_conv00_control_rmx_core_config;
wire [(32)-1:0] i_dca_matrix_conv00_control_rmx_core_status;
wire i_dca_matrix_conv00_control_rmx_clear_request;
wire i_dca_matrix_conv00_control_rmx_clear_finish;
wire i_dca_matrix_conv00_control_rmx_log_fifo_wready;
wire i_dca_matrix_conv00_control_rmx_log_fifo_wrequest;
wire [(32)-1:0] i_dca_matrix_conv00_control_rmx_log_fifo_wdata;
wire i_dca_matrix_conv00_control_rmx_inst_fifo_rready;
wire [(512)-1:0] i_dca_matrix_conv00_control_rmx_inst_fifo_rdata;
wire i_dca_matrix_conv00_control_rmx_inst_fifo_rrequest;
wire i_dca_matrix_conv00_control_rmx_operation_finish;
wire i_dca_matrix_conv00_control_rmx_input_fifo_rready;
wire [(32)-1:0] i_dca_matrix_conv00_control_rmx_input_fifo_rdata;
wire i_dca_matrix_conv00_control_rmx_input_fifo_rrequest;
wire i_dca_matrix_conv00_control_rmx_output_fifo_wready;
wire i_dca_matrix_conv00_control_rmx_output_fifo_wrequest;
wire [(32)-1:0] i_dca_matrix_conv00_control_rmx_output_fifo_wdata;
wire i_dca_matrix_conv00_mi_sinst_wvalid;
wire [(`BW_DCA_MATRIX_LSU_INST)-1:0] i_dca_matrix_conv00_mi_sinst_wdata;
wire i_dca_matrix_conv00_mi_sinst_wready;
wire i_dca_matrix_conv00_mi_sinst_decode_finish;
wire i_dca_matrix_conv00_mi_sinst_execute_finish;
wire i_dca_matrix_conv00_mi_sinst_busy;
wire i_dca_matrix_conv00_mi_sload_tensor_row_wvalid;
wire i_dca_matrix_conv00_mi_sload_tensor_row_wlast;
wire [(32*22)-1:0] i_dca_matrix_conv00_mi_sload_tensor_row_wdata;
wire i_dca_matrix_conv00_mi_sload_tensor_row_wready;
wire i_dca_matrix_conv00_mi_sstore_tensor_row_rvalid;
wire i_dca_matrix_conv00_mi_sstore_tensor_row_rlast;
wire i_dca_matrix_conv00_mi_sstore_tensor_row_rready;
wire [(32*22)-1:0] i_dca_matrix_conv00_mi_sstore_tensor_row_rdata;
wire i_dca_matrix_conv00_mk_sinst_wvalid;
wire [(`BW_DCA_MATRIX_LSU_INST)-1:0] i_dca_matrix_conv00_mk_sinst_wdata;
wire i_dca_matrix_conv00_mk_sinst_wready;
wire i_dca_matrix_conv00_mk_sinst_decode_finish;
wire i_dca_matrix_conv00_mk_sinst_execute_finish;
wire i_dca_matrix_conv00_mk_sinst_busy;
wire i_dca_matrix_conv00_mk_sload_tensor_row_wvalid;
wire i_dca_matrix_conv00_mk_sload_tensor_row_wlast;
wire [(32*7)-1:0] i_dca_matrix_conv00_mk_sload_tensor_row_wdata;
wire i_dca_matrix_conv00_mk_sload_tensor_row_wready;
wire i_dca_matrix_conv00_mk_sstore_tensor_row_rvalid;
wire i_dca_matrix_conv00_mk_sstore_tensor_row_rlast;
wire i_dca_matrix_conv00_mk_sstore_tensor_row_rready;
wire [(32*7)-1:0] i_dca_matrix_conv00_mk_sstore_tensor_row_rdata;
wire i_dca_matrix_conv00_mo_sinst_wvalid;
wire [(`BW_DCA_MATRIX_LSU_INST)-1:0] i_dca_matrix_conv00_mo_sinst_wdata;
wire i_dca_matrix_conv00_mo_sinst_wready;
wire i_dca_matrix_conv00_mo_sinst_decode_finish;
wire i_dca_matrix_conv00_mo_sinst_execute_finish;
wire i_dca_matrix_conv00_mo_sinst_busy;
wire i_dca_matrix_conv00_mo_sload_tensor_row_wvalid;
wire i_dca_matrix_conv00_mo_sload_tensor_row_wlast;
wire [(32*16)-1:0] i_dca_matrix_conv00_mo_sload_tensor_row_wdata;
wire i_dca_matrix_conv00_mo_sload_tensor_row_wready;
wire i_dca_matrix_conv00_mo_sstore_tensor_row_rvalid;
wire i_dca_matrix_conv00_mo_sstore_tensor_row_rlast;
wire i_dca_matrix_conv00_mo_sstore_tensor_row_rready;
wire [(32*16)-1:0] i_dca_matrix_conv00_mo_sstore_tensor_row_rdata;
wire i_dca_matrix_mac00_clk;
wire i_dca_matrix_mac00_rstnn;
wire [(1)-1:0] i_dca_matrix_mac00_control_rmx_core_config;
wire [(32)-1:0] i_dca_matrix_mac00_control_rmx_core_status;
wire i_dca_matrix_mac00_control_rmx_clear_request;
wire i_dca_matrix_mac00_control_rmx_clear_finish;
wire i_dca_matrix_mac00_control_rmx_log_fifo_wready;
wire i_dca_matrix_mac00_control_rmx_log_fifo_wrequest;
wire [(32)-1:0] i_dca_matrix_mac00_control_rmx_log_fifo_wdata;
wire i_dca_matrix_mac00_control_rmx_inst_fifo_rready;
wire [(512)-1:0] i_dca_matrix_mac00_control_rmx_inst_fifo_rdata;
wire i_dca_matrix_mac00_control_rmx_inst_fifo_rrequest;
wire i_dca_matrix_mac00_control_rmx_operation_finish;
wire i_dca_matrix_mac00_control_rmx_input_fifo_rready;
wire [(32)-1:0] i_dca_matrix_mac00_control_rmx_input_fifo_rdata;
wire i_dca_matrix_mac00_control_rmx_input_fifo_rrequest;
wire i_dca_matrix_mac00_control_rmx_output_fifo_wready;
wire i_dca_matrix_mac00_control_rmx_output_fifo_wrequest;
wire [(32)-1:0] i_dca_matrix_mac00_control_rmx_output_fifo_wdata;
wire i_dca_matrix_mac00_ma_sinst_wvalid;
wire [(`BW_DCA_MATRIX_LSU_INST)-1:0] i_dca_matrix_mac00_ma_sinst_wdata;
wire i_dca_matrix_mac00_ma_sinst_wready;
wire i_dca_matrix_mac00_ma_sinst_decode_finish;
wire i_dca_matrix_mac00_ma_sinst_execute_finish;
wire i_dca_matrix_mac00_ma_sinst_busy;
wire i_dca_matrix_mac00_ma_sload_tensor_row_wvalid;
wire i_dca_matrix_mac00_ma_sload_tensor_row_wlast;
wire [(32*8)-1:0] i_dca_matrix_mac00_ma_sload_tensor_row_wdata;
wire i_dca_matrix_mac00_ma_sload_tensor_row_wready;
wire i_dca_matrix_mac00_ma_sstore_tensor_row_rvalid;
wire i_dca_matrix_mac00_ma_sstore_tensor_row_rlast;
wire i_dca_matrix_mac00_ma_sstore_tensor_row_rready;
wire [(32*8)-1:0] i_dca_matrix_mac00_ma_sstore_tensor_row_rdata;
wire i_dca_matrix_mac00_mb_sinst_wvalid;
wire [(`BW_DCA_MATRIX_LSU_INST)-1:0] i_dca_matrix_mac00_mb_sinst_wdata;
wire i_dca_matrix_mac00_mb_sinst_wready;
wire i_dca_matrix_mac00_mb_sinst_decode_finish;
wire i_dca_matrix_mac00_mb_sinst_execute_finish;
wire i_dca_matrix_mac00_mb_sinst_busy;
wire i_dca_matrix_mac00_mb_sload_tensor_row_wvalid;
wire i_dca_matrix_mac00_mb_sload_tensor_row_wlast;
wire [(32*8)-1:0] i_dca_matrix_mac00_mb_sload_tensor_row_wdata;
wire i_dca_matrix_mac00_mb_sload_tensor_row_wready;
wire i_dca_matrix_mac00_mb_sstore_tensor_row_rvalid;
wire i_dca_matrix_mac00_mb_sstore_tensor_row_rlast;
wire i_dca_matrix_mac00_mb_sstore_tensor_row_rready;
wire [(32*8)-1:0] i_dca_matrix_mac00_mb_sstore_tensor_row_rdata;
wire i_dca_matrix_mac00_mc_sinst_wvalid;
wire [(`BW_DCA_MATRIX_LSU_INST)-1:0] i_dca_matrix_mac00_mc_sinst_wdata;
wire i_dca_matrix_mac00_mc_sinst_wready;
wire i_dca_matrix_mac00_mc_sinst_decode_finish;
wire i_dca_matrix_mac00_mc_sinst_execute_finish;
wire i_dca_matrix_mac00_mc_sinst_busy;
wire i_dca_matrix_mac00_mc_sload_tensor_row_wvalid;
wire i_dca_matrix_mac00_mc_sload_tensor_row_wlast;
wire [(32*8)-1:0] i_dca_matrix_mac00_mc_sload_tensor_row_wdata;
wire i_dca_matrix_mac00_mc_sload_tensor_row_wready;
wire i_dca_matrix_mac00_mc_sstore_tensor_row_rvalid;
wire i_dca_matrix_mac00_mc_sstore_tensor_row_rlast;
wire i_dca_matrix_mac00_mc_sstore_tensor_row_rready;
wire [(32*8)-1:0] i_dca_matrix_mac00_mc_sstore_tensor_row_rdata;
wire i_led_clk;
wire i_led_tick_62d5ms;
wire i_led_rstnn;
wire i_led_app_finished;
wire [((1)*(1))-1:0] i_led_led_list;
wire i_sub_core_001_clk;
wire i_sub_core_001_rstnn;
wire [(32)-1:0] i_sub_core_001_interrupt_vector;
wire i_sub_core_001_interrupt_out;
wire i_sub_core_001_sxawready;
wire i_sub_core_001_sxawvalid;
wire [(32)-1:0] i_sub_core_001_sxawaddr;
wire [(4)-1:0] i_sub_core_001_sxawid;
wire [(8)-1:0] i_sub_core_001_sxawlen;
wire [(3)-1:0] i_sub_core_001_sxawsize;
wire [(2)-1:0] i_sub_core_001_sxawburst;
wire i_sub_core_001_sxwready;
wire i_sub_core_001_sxwvalid;
wire [(4)-1:0] i_sub_core_001_sxwid;
wire [(32)-1:0] i_sub_core_001_sxwdata;
wire [(32/8)-1:0] i_sub_core_001_sxwstrb;
wire i_sub_core_001_sxwlast;
wire i_sub_core_001_sxbready;
wire i_sub_core_001_sxbvalid;
wire [(4)-1:0] i_sub_core_001_sxbid;
wire [(2)-1:0] i_sub_core_001_sxbresp;
wire i_sub_core_001_sxarready;
wire i_sub_core_001_sxarvalid;
wire [(32)-1:0] i_sub_core_001_sxaraddr;
wire [(4)-1:0] i_sub_core_001_sxarid;
wire [(8)-1:0] i_sub_core_001_sxarlen;
wire [(3)-1:0] i_sub_core_001_sxarsize;
wire [(2)-1:0] i_sub_core_001_sxarburst;
wire i_sub_core_001_sxrready;
wire i_sub_core_001_sxrvalid;
wire [(4)-1:0] i_sub_core_001_sxrid;
wire [(32)-1:0] i_sub_core_001_sxrdata;
wire i_sub_core_001_sxrlast;
wire [(2)-1:0] i_sub_core_001_sxrresp;
wire [(32)-1:0] i_sub_core_001_spc;
wire [(32)-1:0] i_sub_core_001_sinst;
wire i_sub_core_002_clk;
wire i_sub_core_002_rstnn;
wire [(32)-1:0] i_sub_core_002_interrupt_vector;
wire i_sub_core_002_interrupt_out;
wire i_sub_core_002_sxawready;
wire i_sub_core_002_sxawvalid;
wire [(32)-1:0] i_sub_core_002_sxawaddr;
wire [(4)-1:0] i_sub_core_002_sxawid;
wire [(8)-1:0] i_sub_core_002_sxawlen;
wire [(3)-1:0] i_sub_core_002_sxawsize;
wire [(2)-1:0] i_sub_core_002_sxawburst;
wire i_sub_core_002_sxwready;
wire i_sub_core_002_sxwvalid;
wire [(4)-1:0] i_sub_core_002_sxwid;
wire [(32)-1:0] i_sub_core_002_sxwdata;
wire [(32/8)-1:0] i_sub_core_002_sxwstrb;
wire i_sub_core_002_sxwlast;
wire i_sub_core_002_sxbready;
wire i_sub_core_002_sxbvalid;
wire [(4)-1:0] i_sub_core_002_sxbid;
wire [(2)-1:0] i_sub_core_002_sxbresp;
wire i_sub_core_002_sxarready;
wire i_sub_core_002_sxarvalid;
wire [(32)-1:0] i_sub_core_002_sxaraddr;
wire [(4)-1:0] i_sub_core_002_sxarid;
wire [(8)-1:0] i_sub_core_002_sxarlen;
wire [(3)-1:0] i_sub_core_002_sxarsize;
wire [(2)-1:0] i_sub_core_002_sxarburst;
wire i_sub_core_002_sxrready;
wire i_sub_core_002_sxrvalid;
wire [(4)-1:0] i_sub_core_002_sxrid;
wire [(32)-1:0] i_sub_core_002_sxrdata;
wire i_sub_core_002_sxrlast;
wire [(2)-1:0] i_sub_core_002_sxrresp;
wire [(32)-1:0] i_sub_core_002_spc;
wire [(32)-1:0] i_sub_core_002_sinst;
wire i_sub_core_003_clk;
wire i_sub_core_003_rstnn;
wire [(32)-1:0] i_sub_core_003_interrupt_vector;
wire i_sub_core_003_interrupt_out;
wire i_sub_core_003_sxawready;
wire i_sub_core_003_sxawvalid;
wire [(32)-1:0] i_sub_core_003_sxawaddr;
wire [(4)-1:0] i_sub_core_003_sxawid;
wire [(8)-1:0] i_sub_core_003_sxawlen;
wire [(3)-1:0] i_sub_core_003_sxawsize;
wire [(2)-1:0] i_sub_core_003_sxawburst;
wire i_sub_core_003_sxwready;
wire i_sub_core_003_sxwvalid;
wire [(4)-1:0] i_sub_core_003_sxwid;
wire [(32)-1:0] i_sub_core_003_sxwdata;
wire [(32/8)-1:0] i_sub_core_003_sxwstrb;
wire i_sub_core_003_sxwlast;
wire i_sub_core_003_sxbready;
wire i_sub_core_003_sxbvalid;
wire [(4)-1:0] i_sub_core_003_sxbid;
wire [(2)-1:0] i_sub_core_003_sxbresp;
wire i_sub_core_003_sxarready;
wire i_sub_core_003_sxarvalid;
wire [(32)-1:0] i_sub_core_003_sxaraddr;
wire [(4)-1:0] i_sub_core_003_sxarid;
wire [(8)-1:0] i_sub_core_003_sxarlen;
wire [(3)-1:0] i_sub_core_003_sxarsize;
wire [(2)-1:0] i_sub_core_003_sxarburst;
wire i_sub_core_003_sxrready;
wire i_sub_core_003_sxrvalid;
wire [(4)-1:0] i_sub_core_003_sxrid;
wire [(32)-1:0] i_sub_core_003_sxrdata;
wire i_sub_core_003_sxrlast;
wire [(2)-1:0] i_sub_core_003_sxrresp;
wire [(32)-1:0] i_sub_core_003_spc;
wire [(32)-1:0] i_sub_core_003_sinst;
wire common_peri_group_clk;
wire common_peri_group_rstnn;
wire [(5)-1:0] common_peri_group_lock_status_list;
wire [(32)-1:0] common_peri_group_thread_status_list;
wire [(64)-1:0] common_peri_group_real_clock;
wire [(1)-1:0] common_peri_group_global_tag_list;
wire [(11)-1:0] common_peri_group_system_tick_config;
wire [(11)-1:0] common_peri_group_core_tick_config;
wire common_peri_group_rpsel;
wire common_peri_group_rpenable;
wire common_peri_group_rpwrite;
wire [(32)-1:0] common_peri_group_rpaddr;
wire [(32)-1:0] common_peri_group_rpwdata;
wire common_peri_group_rpready;
wire [(32)-1:0] common_peri_group_rprdata;
wire common_peri_group_rpslverr;
wire autoname_103_clk;
wire autoname_103_rstnn;
wire [(11)-1:0] autoname_103_tick_config;
wire autoname_103_tick_1us;
wire autoname_103_tick_62d5ms;
wire autoname_105_clk;
wire autoname_105_rstnn;
wire autoname_105_tick_1us;
wire [(64)-1:0] autoname_105_real_clock;
wire external_peri_group_clk;
wire external_peri_group_rstnn;
wire external_peri_group_tick_1us;
wire external_peri_group_tick_gpio;
wire [(32)-1:0] external_peri_group_uart_interrupts;
wire external_peri_group_spi_interrupt;
wire [(32)-1:0] external_peri_group_i2c_interrupts;
wire [(32)-1:0] external_peri_group_gpio_interrupts;
wire external_peri_group_wifi_interrupt;
wire external_peri_group_spi_common_sclk;
wire external_peri_group_spi_common_sdq0;
wire external_peri_group_rpsel;
wire external_peri_group_rpenable;
wire external_peri_group_rpwrite;
wire [(32)-1:0] external_peri_group_rpaddr;
wire [(32)-1:0] external_peri_group_rpwdata;
wire external_peri_group_rpready;
wire [(32)-1:0] external_peri_group_rprdata;
wire external_peri_group_rpslverr;
wire [((1)*(1))-1:0] external_peri_group_uart_stx_list;
wire [((1)*(1))-1:0] external_peri_group_uart_srx_list;
wire [((1)*(1))-1:0] external_peri_group_spi_sclk_list;
wire [((1)*(1))-1:0] external_peri_group_spi_scs_list;
wire [((1)*(1))-1:0] external_peri_group_spi_sdq0_list;
wire [((1)*(1))-1:0] external_peri_group_spi_sdq1_list;
wire [(1)-1:0] external_peri_group_oled_sdcsel_oe;
wire [(1)-1:0] external_peri_group_oled_sdcsel_oval;
wire [(1)-1:0] external_peri_group_oled_sdcsel_ival;
wire [(1)-1:0] external_peri_group_oled_srstnn_oe;
wire [(1)-1:0] external_peri_group_oled_srstnn_oval;
wire [(1)-1:0] external_peri_group_oled_srstnn_ival;
wire [(1)-1:0] external_peri_group_oled_svbat_oe;
wire [(1)-1:0] external_peri_group_oled_svbat_oval;
wire [(1)-1:0] external_peri_group_oled_svbat_ival;
wire [(1)-1:0] external_peri_group_oled_svdd_oe;
wire [(1)-1:0] external_peri_group_oled_svdd_oval;
wire [(1)-1:0] external_peri_group_oled_svdd_ival;
wire external_peri_group_wifi_sitr;
wire external_peri_group_wifi_srstnn;
wire external_peri_group_wifi_swp;
wire external_peri_group_wifi_shibernate;
wire core_peri_group_clk;
wire core_peri_group_rstnn;
wire core_peri_group_tick_1us;
wire core_peri_group_delay_notice;
wire core_peri_group_plic_interrupt;
wire [(5)-1:0] core_peri_group_lock_status_list;
wire [(1)-1:0] core_peri_group_global_tag_list;
wire [(32)-1:0] core_peri_group_thread_status_list;
wire [(32)-1:0] core_peri_group_core_interrupt_vector;
wire core_peri_group_allows_holds;
wire core_peri_group_rpsel;
wire core_peri_group_rpenable;
wire core_peri_group_rpwrite;
wire [(32)-1:0] core_peri_group_rpaddr;
wire [(32)-1:0] core_peri_group_rpwdata;
wire core_peri_group_rpready;
wire [(32)-1:0] core_peri_group_rprdata;
wire core_peri_group_rpslverr;
wire core_peri_group_tcu_spsel;
wire core_peri_group_tcu_spenable;
wire core_peri_group_tcu_spwrite;
wire [(32)-1:0] core_peri_group_tcu_spaddr;
wire [(32)-1:0] core_peri_group_tcu_spwdata;
wire core_peri_group_tcu_spready;
wire [(32)-1:0] core_peri_group_tcu_sprdata;
wire core_peri_group_tcu_spslverr;
wire core_peri_group_florian_spsel;
wire core_peri_group_florian_spenable;
wire core_peri_group_florian_spwrite;
wire [(32)-1:0] core_peri_group_florian_spaddr;
wire [(32)-1:0] core_peri_group_florian_spwdata;
wire core_peri_group_florian_spready;
wire [(32)-1:0] core_peri_group_florian_sprdata;
wire core_peri_group_florian_spslverr;
wire autoname_106_clk;
wire autoname_106_rstnn;
wire autoname_106_tick_1us;
wire autoname_106_delay_notice;
wire autoname_106_plic_interrupt;
wire [(5)-1:0] autoname_106_lock_status_list;
wire [(1)-1:0] autoname_106_global_tag_list;
wire [(32)-1:0] autoname_106_thread_status_list;
wire [(32)-1:0] autoname_106_core_interrupt_vector;
wire autoname_106_allows_holds;
wire autoname_106_rpsel;
wire autoname_106_rpenable;
wire autoname_106_rpwrite;
wire [(32)-1:0] autoname_106_rpaddr;
wire [(32)-1:0] autoname_106_rpwdata;
wire autoname_106_rpready;
wire [(32)-1:0] autoname_106_rprdata;
wire autoname_106_rpslverr;
wire autoname_106_tcu_spsel;
wire autoname_106_tcu_spenable;
wire autoname_106_tcu_spwrite;
wire [(32)-1:0] autoname_106_tcu_spaddr;
wire [(32)-1:0] autoname_106_tcu_spwdata;
wire autoname_106_tcu_spready;
wire [(32)-1:0] autoname_106_tcu_sprdata;
wire autoname_106_tcu_spslverr;
wire autoname_106_florian_spsel;
wire autoname_106_florian_spenable;
wire autoname_106_florian_spwrite;
wire [(32)-1:0] autoname_106_florian_spaddr;
wire [(32)-1:0] autoname_106_florian_spwdata;
wire autoname_106_florian_spready;
wire [(32)-1:0] autoname_106_florian_sprdata;
wire autoname_106_florian_spslverr;
wire autoname_107_clk;
wire autoname_107_rstnn;
wire autoname_107_tick_1us;
wire autoname_107_delay_notice;
wire autoname_107_plic_interrupt;
wire [(5)-1:0] autoname_107_lock_status_list;
wire [(1)-1:0] autoname_107_global_tag_list;
wire [(32)-1:0] autoname_107_thread_status_list;
wire [(32)-1:0] autoname_107_core_interrupt_vector;
wire autoname_107_allows_holds;
wire autoname_107_rpsel;
wire autoname_107_rpenable;
wire autoname_107_rpwrite;
wire [(32)-1:0] autoname_107_rpaddr;
wire [(32)-1:0] autoname_107_rpwdata;
wire autoname_107_rpready;
wire [(32)-1:0] autoname_107_rprdata;
wire autoname_107_rpslverr;
wire autoname_107_tcu_spsel;
wire autoname_107_tcu_spenable;
wire autoname_107_tcu_spwrite;
wire [(32)-1:0] autoname_107_tcu_spaddr;
wire [(32)-1:0] autoname_107_tcu_spwdata;
wire autoname_107_tcu_spready;
wire [(32)-1:0] autoname_107_tcu_sprdata;
wire autoname_107_tcu_spslverr;
wire autoname_107_florian_spsel;
wire autoname_107_florian_spenable;
wire autoname_107_florian_spwrite;
wire [(32)-1:0] autoname_107_florian_spaddr;
wire [(32)-1:0] autoname_107_florian_spwdata;
wire autoname_107_florian_spready;
wire [(32)-1:0] autoname_107_florian_sprdata;
wire autoname_107_florian_spslverr;
wire autoname_108_clk;
wire autoname_108_rstnn;
wire autoname_108_tick_1us;
wire autoname_108_delay_notice;
wire autoname_108_plic_interrupt;
wire [(5)-1:0] autoname_108_lock_status_list;
wire [(1)-1:0] autoname_108_global_tag_list;
wire [(32)-1:0] autoname_108_thread_status_list;
wire [(32)-1:0] autoname_108_core_interrupt_vector;
wire autoname_108_allows_holds;
wire autoname_108_rpsel;
wire autoname_108_rpenable;
wire autoname_108_rpwrite;
wire [(32)-1:0] autoname_108_rpaddr;
wire [(32)-1:0] autoname_108_rpwdata;
wire autoname_108_rpready;
wire [(32)-1:0] autoname_108_rprdata;
wire autoname_108_rpslverr;
wire autoname_108_tcu_spsel;
wire autoname_108_tcu_spenable;
wire autoname_108_tcu_spwrite;
wire [(32)-1:0] autoname_108_tcu_spaddr;
wire [(32)-1:0] autoname_108_tcu_spwdata;
wire autoname_108_tcu_spready;
wire [(32)-1:0] autoname_108_tcu_sprdata;
wire autoname_108_tcu_spslverr;
wire autoname_108_florian_spsel;
wire autoname_108_florian_spenable;
wire autoname_108_florian_spwrite;
wire [(32)-1:0] autoname_108_florian_spaddr;
wire [(32)-1:0] autoname_108_florian_spwdata;
wire autoname_108_florian_spready;
wire [(32)-1:0] autoname_108_florian_sprdata;
wire autoname_108_florian_spslverr;
wire platform_controller_clk;
wire platform_controller_external_rstnn;
wire platform_controller_global_rstnn;
wire platform_controller_global_rstpp;
wire [(10)-1:0] platform_controller_rstnn_seqeunce;
wire [(10)-1:0] platform_controller_rstpp_seqeunce;
wire [(`BW_BOOT_MODE)-1:0] platform_controller_boot_mode;
wire platform_controller_jtag_select;
wire platform_controller_initialized;
wire platform_controller_app_finished;
wire platform_controller_rstnn;
wire platform_controller_shready;
wire [(32)-1:0] platform_controller_shaddr;
wire [(3)-1:0] platform_controller_shburst;
wire platform_controller_shmasterlock;
wire [(4)-1:0] platform_controller_shprot;
wire [(3)-1:0] platform_controller_shsize;
wire [(2)-1:0] platform_controller_shtrans;
wire platform_controller_shwrite;
wire [(32)-1:0] platform_controller_shwdata;
wire [(32)-1:0] platform_controller_shrdata;
wire platform_controller_shresp;
wire platform_controller_rpsel;
wire platform_controller_rpenable;
wire platform_controller_rpwrite;
wire [(32)-1:0] platform_controller_rpaddr;
wire [(32)-1:0] platform_controller_rpwdata;
wire platform_controller_rpready;
wire [(32)-1:0] platform_controller_rprdata;
wire platform_controller_rpslverr;
wire platform_controller_pjtag_rtck;
wire platform_controller_pjtag_rtrstnn;
wire platform_controller_pjtag_rtms;
wire platform_controller_pjtag_rtdi;
wire platform_controller_pjtag_rtdo;
wire platform_controller_noc_debug_spsel;
wire platform_controller_noc_debug_spenable;
wire platform_controller_noc_debug_spwrite;
wire [(32)-1:0] platform_controller_noc_debug_spaddr;
wire [(32)-1:0] platform_controller_noc_debug_spwdata;
wire platform_controller_noc_debug_spready;
wire [(32)-1:0] platform_controller_noc_debug_sprdata;
wire platform_controller_noc_debug_spslverr;
wire [((32)*(4))-1:0] platform_controller_rpc_list;
wire [((32)*(4))-1:0] platform_controller_rinst_list;
wire default_slave_clk_network;
wire default_slave_rstnn_network;
wire default_slave_clk_debug;
wire default_slave_rstnn_debug;
wire default_slave_comm_disable;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] default_slave_rfni_link;
wire default_slave_rfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] default_slave_rbni_link;
wire default_slave_rbni_ready;
wire default_slave_debug_rpsel;
wire default_slave_debug_rpenable;
wire default_slave_debug_rpwrite;
wire [(32)-1:0] default_slave_debug_rpaddr;
wire [(32)-1:0] default_slave_debug_rpwdata;
wire default_slave_debug_rpready;
wire [(32)-1:0] default_slave_debug_rprdata;
wire default_slave_debug_rpslverr;
wire [(`BW_SVRING_LINK)-1:0] default_slave_svri_rlink;
wire default_slave_svri_rack;
wire [(`BW_SVRING_LINK)-1:0] default_slave_svri_slink;
wire default_slave_svri_sack;
wire i_dca_matrix_conv00_control_mmiox1_interface_clk_mmio;
wire i_dca_matrix_conv00_control_mmiox1_interface_rstnn_mmio;
wire [(32)-1:0] i_dca_matrix_conv00_control_mmiox1_interface_interrupt_list;
wire i_dca_matrix_conv00_control_mmiox1_interface_clk_acc;
wire i_dca_matrix_conv00_control_mmiox1_interface_rstnn_acc;
wire i_dca_matrix_conv00_control_mmiox1_interface_mmio_rpsel;
wire i_dca_matrix_conv00_control_mmiox1_interface_mmio_rpenable;
wire i_dca_matrix_conv00_control_mmiox1_interface_mmio_rpwrite;
wire [(32)-1:0] i_dca_matrix_conv00_control_mmiox1_interface_mmio_rpaddr;
wire [(32)-1:0] i_dca_matrix_conv00_control_mmiox1_interface_mmio_rpwdata;
wire i_dca_matrix_conv00_control_mmiox1_interface_mmio_rpready;
wire [(32)-1:0] i_dca_matrix_conv00_control_mmiox1_interface_mmio_rprdata;
wire i_dca_matrix_conv00_control_mmiox1_interface_mmio_rpslverr;
wire [(1)-1:0] i_dca_matrix_conv00_control_mmiox1_interface_smx_core_config;
wire [(32)-1:0] i_dca_matrix_conv00_control_mmiox1_interface_smx_core_status;
wire i_dca_matrix_conv00_control_mmiox1_interface_smx_clear_request;
wire i_dca_matrix_conv00_control_mmiox1_interface_smx_clear_finish;
wire i_dca_matrix_conv00_control_mmiox1_interface_smx_log_fifo_wready;
wire i_dca_matrix_conv00_control_mmiox1_interface_smx_log_fifo_wrequest;
wire [(32)-1:0] i_dca_matrix_conv00_control_mmiox1_interface_smx_log_fifo_wdata;
wire i_dca_matrix_conv00_control_mmiox1_interface_smx_inst_fifo_rready;
wire [(512)-1:0] i_dca_matrix_conv00_control_mmiox1_interface_smx_inst_fifo_rdata;
wire i_dca_matrix_conv00_control_mmiox1_interface_smx_inst_fifo_rrequest;
wire i_dca_matrix_conv00_control_mmiox1_interface_smx_operation_finish;
wire i_dca_matrix_conv00_control_mmiox1_interface_smx_input_fifo_rready;
wire [(32)-1:0] i_dca_matrix_conv00_control_mmiox1_interface_smx_input_fifo_rdata;
wire i_dca_matrix_conv00_control_mmiox1_interface_smx_input_fifo_rrequest;
wire i_dca_matrix_conv00_control_mmiox1_interface_smx_output_fifo_wready;
wire i_dca_matrix_conv00_control_mmiox1_interface_smx_output_fifo_wrequest;
wire [(32)-1:0] i_dca_matrix_conv00_control_mmiox1_interface_smx_output_fifo_wdata;
wire i_dca_matrix_mac00_control_mmiox1_interface_clk_mmio;
wire i_dca_matrix_mac00_control_mmiox1_interface_rstnn_mmio;
wire [(32)-1:0] i_dca_matrix_mac00_control_mmiox1_interface_interrupt_list;
wire i_dca_matrix_mac00_control_mmiox1_interface_clk_acc;
wire i_dca_matrix_mac00_control_mmiox1_interface_rstnn_acc;
wire i_dca_matrix_mac00_control_mmiox1_interface_mmio_rpsel;
wire i_dca_matrix_mac00_control_mmiox1_interface_mmio_rpenable;
wire i_dca_matrix_mac00_control_mmiox1_interface_mmio_rpwrite;
wire [(32)-1:0] i_dca_matrix_mac00_control_mmiox1_interface_mmio_rpaddr;
wire [(32)-1:0] i_dca_matrix_mac00_control_mmiox1_interface_mmio_rpwdata;
wire i_dca_matrix_mac00_control_mmiox1_interface_mmio_rpready;
wire [(32)-1:0] i_dca_matrix_mac00_control_mmiox1_interface_mmio_rprdata;
wire i_dca_matrix_mac00_control_mmiox1_interface_mmio_rpslverr;
wire [(1)-1:0] i_dca_matrix_mac00_control_mmiox1_interface_smx_core_config;
wire [(32)-1:0] i_dca_matrix_mac00_control_mmiox1_interface_smx_core_status;
wire i_dca_matrix_mac00_control_mmiox1_interface_smx_clear_request;
wire i_dca_matrix_mac00_control_mmiox1_interface_smx_clear_finish;
wire i_dca_matrix_mac00_control_mmiox1_interface_smx_log_fifo_wready;
wire i_dca_matrix_mac00_control_mmiox1_interface_smx_log_fifo_wrequest;
wire [(32)-1:0] i_dca_matrix_mac00_control_mmiox1_interface_smx_log_fifo_wdata;
wire i_dca_matrix_mac00_control_mmiox1_interface_smx_inst_fifo_rready;
wire [(512)-1:0] i_dca_matrix_mac00_control_mmiox1_interface_smx_inst_fifo_rdata;
wire i_dca_matrix_mac00_control_mmiox1_interface_smx_inst_fifo_rrequest;
wire i_dca_matrix_mac00_control_mmiox1_interface_smx_operation_finish;
wire i_dca_matrix_mac00_control_mmiox1_interface_smx_input_fifo_rready;
wire [(32)-1:0] i_dca_matrix_mac00_control_mmiox1_interface_smx_input_fifo_rdata;
wire i_dca_matrix_mac00_control_mmiox1_interface_smx_input_fifo_rrequest;
wire i_dca_matrix_mac00_control_mmiox1_interface_smx_output_fifo_wready;
wire i_dca_matrix_mac00_control_mmiox1_interface_smx_output_fifo_wrequest;
wire [(32)-1:0] i_dca_matrix_mac00_control_mmiox1_interface_smx_output_fifo_wdata;
wire i_dca_matrix_conv00_mi_mlsu_clk;
wire i_dca_matrix_conv00_mi_mlsu_rstnn;
wire i_dca_matrix_conv00_mi_mlsu_rinst_wvalid;
wire [(`BW_DCA_MATRIX_LSU_INST)-1:0] i_dca_matrix_conv00_mi_mlsu_rinst_wdata;
wire i_dca_matrix_conv00_mi_mlsu_rinst_wready;
wire i_dca_matrix_conv00_mi_mlsu_rinst_decode_finish;
wire i_dca_matrix_conv00_mi_mlsu_rinst_execute_finish;
wire i_dca_matrix_conv00_mi_mlsu_rinst_busy;
wire i_dca_matrix_conv00_mi_mlsu_rload_tensor_row_wvalid;
wire i_dca_matrix_conv00_mi_mlsu_rload_tensor_row_wlast;
wire [(32*22)-1:0] i_dca_matrix_conv00_mi_mlsu_rload_tensor_row_wdata;
wire i_dca_matrix_conv00_mi_mlsu_rload_tensor_row_wready;
wire i_dca_matrix_conv00_mi_mlsu_rstore_tensor_row_rvalid;
wire i_dca_matrix_conv00_mi_mlsu_rstore_tensor_row_rlast;
wire i_dca_matrix_conv00_mi_mlsu_rstore_tensor_row_rready;
wire [(32*22)-1:0] i_dca_matrix_conv00_mi_mlsu_rstore_tensor_row_rdata;
wire [(2)-1:0] i_dca_matrix_conv00_mi_mlsu_slxqdready;
wire i_dca_matrix_conv00_mi_mlsu_slxqvalid;
wire i_dca_matrix_conv00_mi_mlsu_slxqlast;
wire i_dca_matrix_conv00_mi_mlsu_slxqwrite;
wire [(8)-1:0] i_dca_matrix_conv00_mi_mlsu_slxqlen;
wire [(3)-1:0] i_dca_matrix_conv00_mi_mlsu_slxqsize;
wire [(2)-1:0] i_dca_matrix_conv00_mi_mlsu_slxqburst;
wire [(128/8)-1:0] i_dca_matrix_conv00_mi_mlsu_slxqwstrb;
wire [(128)-1:0] i_dca_matrix_conv00_mi_mlsu_slxqwdata;
wire [(32)-1:0] i_dca_matrix_conv00_mi_mlsu_slxqaddr;
wire [(1)-1:0] i_dca_matrix_conv00_mi_mlsu_slxqburden;
wire [(2)-1:0] i_dca_matrix_conv00_mi_mlsu_slxydready;
wire i_dca_matrix_conv00_mi_mlsu_slxyvalid;
wire i_dca_matrix_conv00_mi_mlsu_slxylast;
wire i_dca_matrix_conv00_mi_mlsu_slxywreply;
wire [(2)-1:0] i_dca_matrix_conv00_mi_mlsu_slxyresp;
wire [(128)-1:0] i_dca_matrix_conv00_mi_mlsu_slxyrdata;
wire [(1)-1:0] i_dca_matrix_conv00_mi_mlsu_slxyburden;
wire i_dca_matrix_conv00_mk_mlsu_clk;
wire i_dca_matrix_conv00_mk_mlsu_rstnn;
wire i_dca_matrix_conv00_mk_mlsu_rinst_wvalid;
wire [(`BW_DCA_MATRIX_LSU_INST)-1:0] i_dca_matrix_conv00_mk_mlsu_rinst_wdata;
wire i_dca_matrix_conv00_mk_mlsu_rinst_wready;
wire i_dca_matrix_conv00_mk_mlsu_rinst_decode_finish;
wire i_dca_matrix_conv00_mk_mlsu_rinst_execute_finish;
wire i_dca_matrix_conv00_mk_mlsu_rinst_busy;
wire i_dca_matrix_conv00_mk_mlsu_rload_tensor_row_wvalid;
wire i_dca_matrix_conv00_mk_mlsu_rload_tensor_row_wlast;
wire [(32*7)-1:0] i_dca_matrix_conv00_mk_mlsu_rload_tensor_row_wdata;
wire i_dca_matrix_conv00_mk_mlsu_rload_tensor_row_wready;
wire i_dca_matrix_conv00_mk_mlsu_rstore_tensor_row_rvalid;
wire i_dca_matrix_conv00_mk_mlsu_rstore_tensor_row_rlast;
wire i_dca_matrix_conv00_mk_mlsu_rstore_tensor_row_rready;
wire [(32*7)-1:0] i_dca_matrix_conv00_mk_mlsu_rstore_tensor_row_rdata;
wire [(2)-1:0] i_dca_matrix_conv00_mk_mlsu_slxqdready;
wire i_dca_matrix_conv00_mk_mlsu_slxqvalid;
wire i_dca_matrix_conv00_mk_mlsu_slxqlast;
wire i_dca_matrix_conv00_mk_mlsu_slxqwrite;
wire [(8)-1:0] i_dca_matrix_conv00_mk_mlsu_slxqlen;
wire [(3)-1:0] i_dca_matrix_conv00_mk_mlsu_slxqsize;
wire [(2)-1:0] i_dca_matrix_conv00_mk_mlsu_slxqburst;
wire [(128/8)-1:0] i_dca_matrix_conv00_mk_mlsu_slxqwstrb;
wire [(128)-1:0] i_dca_matrix_conv00_mk_mlsu_slxqwdata;
wire [(32)-1:0] i_dca_matrix_conv00_mk_mlsu_slxqaddr;
wire [(1)-1:0] i_dca_matrix_conv00_mk_mlsu_slxqburden;
wire [(2)-1:0] i_dca_matrix_conv00_mk_mlsu_slxydready;
wire i_dca_matrix_conv00_mk_mlsu_slxyvalid;
wire i_dca_matrix_conv00_mk_mlsu_slxylast;
wire i_dca_matrix_conv00_mk_mlsu_slxywreply;
wire [(2)-1:0] i_dca_matrix_conv00_mk_mlsu_slxyresp;
wire [(128)-1:0] i_dca_matrix_conv00_mk_mlsu_slxyrdata;
wire [(1)-1:0] i_dca_matrix_conv00_mk_mlsu_slxyburden;
wire i_dca_matrix_conv00_mo_mlsu_clk;
wire i_dca_matrix_conv00_mo_mlsu_rstnn;
wire i_dca_matrix_conv00_mo_mlsu_rinst_wvalid;
wire [(`BW_DCA_MATRIX_LSU_INST)-1:0] i_dca_matrix_conv00_mo_mlsu_rinst_wdata;
wire i_dca_matrix_conv00_mo_mlsu_rinst_wready;
wire i_dca_matrix_conv00_mo_mlsu_rinst_decode_finish;
wire i_dca_matrix_conv00_mo_mlsu_rinst_execute_finish;
wire i_dca_matrix_conv00_mo_mlsu_rinst_busy;
wire i_dca_matrix_conv00_mo_mlsu_rload_tensor_row_wvalid;
wire i_dca_matrix_conv00_mo_mlsu_rload_tensor_row_wlast;
wire [(32*16)-1:0] i_dca_matrix_conv00_mo_mlsu_rload_tensor_row_wdata;
wire i_dca_matrix_conv00_mo_mlsu_rload_tensor_row_wready;
wire i_dca_matrix_conv00_mo_mlsu_rstore_tensor_row_rvalid;
wire i_dca_matrix_conv00_mo_mlsu_rstore_tensor_row_rlast;
wire i_dca_matrix_conv00_mo_mlsu_rstore_tensor_row_rready;
wire [(32*16)-1:0] i_dca_matrix_conv00_mo_mlsu_rstore_tensor_row_rdata;
wire [(2)-1:0] i_dca_matrix_conv00_mo_mlsu_slxqdready;
wire i_dca_matrix_conv00_mo_mlsu_slxqvalid;
wire i_dca_matrix_conv00_mo_mlsu_slxqlast;
wire i_dca_matrix_conv00_mo_mlsu_slxqwrite;
wire [(8)-1:0] i_dca_matrix_conv00_mo_mlsu_slxqlen;
wire [(3)-1:0] i_dca_matrix_conv00_mo_mlsu_slxqsize;
wire [(2)-1:0] i_dca_matrix_conv00_mo_mlsu_slxqburst;
wire [(128/8)-1:0] i_dca_matrix_conv00_mo_mlsu_slxqwstrb;
wire [(128)-1:0] i_dca_matrix_conv00_mo_mlsu_slxqwdata;
wire [(32)-1:0] i_dca_matrix_conv00_mo_mlsu_slxqaddr;
wire [(1)-1:0] i_dca_matrix_conv00_mo_mlsu_slxqburden;
wire [(2)-1:0] i_dca_matrix_conv00_mo_mlsu_slxydready;
wire i_dca_matrix_conv00_mo_mlsu_slxyvalid;
wire i_dca_matrix_conv00_mo_mlsu_slxylast;
wire i_dca_matrix_conv00_mo_mlsu_slxywreply;
wire [(2)-1:0] i_dca_matrix_conv00_mo_mlsu_slxyresp;
wire [(128)-1:0] i_dca_matrix_conv00_mo_mlsu_slxyrdata;
wire [(1)-1:0] i_dca_matrix_conv00_mo_mlsu_slxyburden;
wire i_dca_matrix_mac00_ma_mlsu_clk;
wire i_dca_matrix_mac00_ma_mlsu_rstnn;
wire i_dca_matrix_mac00_ma_mlsu_rinst_wvalid;
wire [(`BW_DCA_MATRIX_LSU_INST)-1:0] i_dca_matrix_mac00_ma_mlsu_rinst_wdata;
wire i_dca_matrix_mac00_ma_mlsu_rinst_wready;
wire i_dca_matrix_mac00_ma_mlsu_rinst_decode_finish;
wire i_dca_matrix_mac00_ma_mlsu_rinst_execute_finish;
wire i_dca_matrix_mac00_ma_mlsu_rinst_busy;
wire i_dca_matrix_mac00_ma_mlsu_rload_tensor_row_wvalid;
wire i_dca_matrix_mac00_ma_mlsu_rload_tensor_row_wlast;
wire [(32*8)-1:0] i_dca_matrix_mac00_ma_mlsu_rload_tensor_row_wdata;
wire i_dca_matrix_mac00_ma_mlsu_rload_tensor_row_wready;
wire i_dca_matrix_mac00_ma_mlsu_rstore_tensor_row_rvalid;
wire i_dca_matrix_mac00_ma_mlsu_rstore_tensor_row_rlast;
wire i_dca_matrix_mac00_ma_mlsu_rstore_tensor_row_rready;
wire [(32*8)-1:0] i_dca_matrix_mac00_ma_mlsu_rstore_tensor_row_rdata;
wire [(2)-1:0] i_dca_matrix_mac00_ma_mlsu_slxqdready;
wire i_dca_matrix_mac00_ma_mlsu_slxqvalid;
wire i_dca_matrix_mac00_ma_mlsu_slxqlast;
wire i_dca_matrix_mac00_ma_mlsu_slxqwrite;
wire [(8)-1:0] i_dca_matrix_mac00_ma_mlsu_slxqlen;
wire [(3)-1:0] i_dca_matrix_mac00_ma_mlsu_slxqsize;
wire [(2)-1:0] i_dca_matrix_mac00_ma_mlsu_slxqburst;
wire [(128/8)-1:0] i_dca_matrix_mac00_ma_mlsu_slxqwstrb;
wire [(128)-1:0] i_dca_matrix_mac00_ma_mlsu_slxqwdata;
wire [(32)-1:0] i_dca_matrix_mac00_ma_mlsu_slxqaddr;
wire [(1)-1:0] i_dca_matrix_mac00_ma_mlsu_slxqburden;
wire [(2)-1:0] i_dca_matrix_mac00_ma_mlsu_slxydready;
wire i_dca_matrix_mac00_ma_mlsu_slxyvalid;
wire i_dca_matrix_mac00_ma_mlsu_slxylast;
wire i_dca_matrix_mac00_ma_mlsu_slxywreply;
wire [(2)-1:0] i_dca_matrix_mac00_ma_mlsu_slxyresp;
wire [(128)-1:0] i_dca_matrix_mac00_ma_mlsu_slxyrdata;
wire [(1)-1:0] i_dca_matrix_mac00_ma_mlsu_slxyburden;
wire i_dca_matrix_mac00_mb_mlsu_clk;
wire i_dca_matrix_mac00_mb_mlsu_rstnn;
wire i_dca_matrix_mac00_mb_mlsu_rinst_wvalid;
wire [(`BW_DCA_MATRIX_LSU_INST)-1:0] i_dca_matrix_mac00_mb_mlsu_rinst_wdata;
wire i_dca_matrix_mac00_mb_mlsu_rinst_wready;
wire i_dca_matrix_mac00_mb_mlsu_rinst_decode_finish;
wire i_dca_matrix_mac00_mb_mlsu_rinst_execute_finish;
wire i_dca_matrix_mac00_mb_mlsu_rinst_busy;
wire i_dca_matrix_mac00_mb_mlsu_rload_tensor_row_wvalid;
wire i_dca_matrix_mac00_mb_mlsu_rload_tensor_row_wlast;
wire [(32*8)-1:0] i_dca_matrix_mac00_mb_mlsu_rload_tensor_row_wdata;
wire i_dca_matrix_mac00_mb_mlsu_rload_tensor_row_wready;
wire i_dca_matrix_mac00_mb_mlsu_rstore_tensor_row_rvalid;
wire i_dca_matrix_mac00_mb_mlsu_rstore_tensor_row_rlast;
wire i_dca_matrix_mac00_mb_mlsu_rstore_tensor_row_rready;
wire [(32*8)-1:0] i_dca_matrix_mac00_mb_mlsu_rstore_tensor_row_rdata;
wire [(2)-1:0] i_dca_matrix_mac00_mb_mlsu_slxqdready;
wire i_dca_matrix_mac00_mb_mlsu_slxqvalid;
wire i_dca_matrix_mac00_mb_mlsu_slxqlast;
wire i_dca_matrix_mac00_mb_mlsu_slxqwrite;
wire [(8)-1:0] i_dca_matrix_mac00_mb_mlsu_slxqlen;
wire [(3)-1:0] i_dca_matrix_mac00_mb_mlsu_slxqsize;
wire [(2)-1:0] i_dca_matrix_mac00_mb_mlsu_slxqburst;
wire [(128/8)-1:0] i_dca_matrix_mac00_mb_mlsu_slxqwstrb;
wire [(128)-1:0] i_dca_matrix_mac00_mb_mlsu_slxqwdata;
wire [(32)-1:0] i_dca_matrix_mac00_mb_mlsu_slxqaddr;
wire [(1)-1:0] i_dca_matrix_mac00_mb_mlsu_slxqburden;
wire [(2)-1:0] i_dca_matrix_mac00_mb_mlsu_slxydready;
wire i_dca_matrix_mac00_mb_mlsu_slxyvalid;
wire i_dca_matrix_mac00_mb_mlsu_slxylast;
wire i_dca_matrix_mac00_mb_mlsu_slxywreply;
wire [(2)-1:0] i_dca_matrix_mac00_mb_mlsu_slxyresp;
wire [(128)-1:0] i_dca_matrix_mac00_mb_mlsu_slxyrdata;
wire [(1)-1:0] i_dca_matrix_mac00_mb_mlsu_slxyburden;
wire i_dca_matrix_mac00_mc_mlsu_clk;
wire i_dca_matrix_mac00_mc_mlsu_rstnn;
wire i_dca_matrix_mac00_mc_mlsu_rinst_wvalid;
wire [(`BW_DCA_MATRIX_LSU_INST)-1:0] i_dca_matrix_mac00_mc_mlsu_rinst_wdata;
wire i_dca_matrix_mac00_mc_mlsu_rinst_wready;
wire i_dca_matrix_mac00_mc_mlsu_rinst_decode_finish;
wire i_dca_matrix_mac00_mc_mlsu_rinst_execute_finish;
wire i_dca_matrix_mac00_mc_mlsu_rinst_busy;
wire i_dca_matrix_mac00_mc_mlsu_rload_tensor_row_wvalid;
wire i_dca_matrix_mac00_mc_mlsu_rload_tensor_row_wlast;
wire [(32*8)-1:0] i_dca_matrix_mac00_mc_mlsu_rload_tensor_row_wdata;
wire i_dca_matrix_mac00_mc_mlsu_rload_tensor_row_wready;
wire i_dca_matrix_mac00_mc_mlsu_rstore_tensor_row_rvalid;
wire i_dca_matrix_mac00_mc_mlsu_rstore_tensor_row_rlast;
wire i_dca_matrix_mac00_mc_mlsu_rstore_tensor_row_rready;
wire [(32*8)-1:0] i_dca_matrix_mac00_mc_mlsu_rstore_tensor_row_rdata;
wire [(2)-1:0] i_dca_matrix_mac00_mc_mlsu_slxqdready;
wire i_dca_matrix_mac00_mc_mlsu_slxqvalid;
wire i_dca_matrix_mac00_mc_mlsu_slxqlast;
wire i_dca_matrix_mac00_mc_mlsu_slxqwrite;
wire [(8)-1:0] i_dca_matrix_mac00_mc_mlsu_slxqlen;
wire [(3)-1:0] i_dca_matrix_mac00_mc_mlsu_slxqsize;
wire [(2)-1:0] i_dca_matrix_mac00_mc_mlsu_slxqburst;
wire [(128/8)-1:0] i_dca_matrix_mac00_mc_mlsu_slxqwstrb;
wire [(128)-1:0] i_dca_matrix_mac00_mc_mlsu_slxqwdata;
wire [(32)-1:0] i_dca_matrix_mac00_mc_mlsu_slxqaddr;
wire [(1)-1:0] i_dca_matrix_mac00_mc_mlsu_slxqburden;
wire [(2)-1:0] i_dca_matrix_mac00_mc_mlsu_slxydready;
wire i_dca_matrix_mac00_mc_mlsu_slxyvalid;
wire i_dca_matrix_mac00_mc_mlsu_slxylast;
wire i_dca_matrix_mac00_mc_mlsu_slxywreply;
wire [(2)-1:0] i_dca_matrix_mac00_mc_mlsu_slxyresp;
wire [(128)-1:0] i_dca_matrix_mac00_mc_mlsu_slxyrdata;
wire [(1)-1:0] i_dca_matrix_mac00_mc_mlsu_slxyburden;
wire i_inter_router_fifo00_clk;
wire i_inter_router_fifo00_rstnn;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_inter_router_fifo00_rfni_link;
wire i_inter_router_fifo00_rfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_inter_router_fifo00_rbni_link;
wire i_inter_router_fifo00_rbni_ready;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_inter_router_fifo00_sfni_link;
wire i_inter_router_fifo00_sfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_inter_router_fifo00_sbni_link;
wire i_inter_router_fifo00_sbni_ready;
wire i_inter_router_fifo01_clk;
wire i_inter_router_fifo01_rstnn;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_inter_router_fifo01_rfni_link;
wire i_inter_router_fifo01_rfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_inter_router_fifo01_rbni_link;
wire i_inter_router_fifo01_rbni_ready;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_inter_router_fifo01_sfni_link;
wire i_inter_router_fifo01_sfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_inter_router_fifo01_sbni_link;
wire i_inter_router_fifo01_sbni_ready;
wire i_inter_router_fifo02_clk;
wire i_inter_router_fifo02_rstnn;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_inter_router_fifo02_rfni_link;
wire i_inter_router_fifo02_rfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_inter_router_fifo02_rbni_link;
wire i_inter_router_fifo02_rbni_ready;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_inter_router_fifo02_sfni_link;
wire i_inter_router_fifo02_sfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_inter_router_fifo02_sbni_link;
wire i_inter_router_fifo02_sbni_ready;
wire i_mnim_i_main_core_no_name_clk_network;
wire i_mnim_i_main_core_no_name_rstnn_network;
wire i_mnim_i_main_core_no_name_clk_master;
wire i_mnim_i_main_core_no_name_rstnn_master;
wire i_mnim_i_main_core_no_name_comm_disable;
wire i_mnim_i_main_core_no_name_local_allows_holds;
wire i_mnim_i_main_core_no_name_rxawready;
wire i_mnim_i_main_core_no_name_rxawvalid;
wire [(32)-1:0] i_mnim_i_main_core_no_name_rxawaddr;
wire [(4)-1:0] i_mnim_i_main_core_no_name_rxawid;
wire [(8)-1:0] i_mnim_i_main_core_no_name_rxawlen;
wire [(3)-1:0] i_mnim_i_main_core_no_name_rxawsize;
wire [(2)-1:0] i_mnim_i_main_core_no_name_rxawburst;
wire i_mnim_i_main_core_no_name_rxwready;
wire i_mnim_i_main_core_no_name_rxwvalid;
wire [(4)-1:0] i_mnim_i_main_core_no_name_rxwid;
wire [(32)-1:0] i_mnim_i_main_core_no_name_rxwdata;
wire [(32/8)-1:0] i_mnim_i_main_core_no_name_rxwstrb;
wire i_mnim_i_main_core_no_name_rxwlast;
wire i_mnim_i_main_core_no_name_rxbready;
wire i_mnim_i_main_core_no_name_rxbvalid;
wire [(4)-1:0] i_mnim_i_main_core_no_name_rxbid;
wire [(2)-1:0] i_mnim_i_main_core_no_name_rxbresp;
wire i_mnim_i_main_core_no_name_rxarready;
wire i_mnim_i_main_core_no_name_rxarvalid;
wire [(32)-1:0] i_mnim_i_main_core_no_name_rxaraddr;
wire [(4)-1:0] i_mnim_i_main_core_no_name_rxarid;
wire [(8)-1:0] i_mnim_i_main_core_no_name_rxarlen;
wire [(3)-1:0] i_mnim_i_main_core_no_name_rxarsize;
wire [(2)-1:0] i_mnim_i_main_core_no_name_rxarburst;
wire i_mnim_i_main_core_no_name_rxrready;
wire i_mnim_i_main_core_no_name_rxrvalid;
wire [(4)-1:0] i_mnim_i_main_core_no_name_rxrid;
wire [(32)-1:0] i_mnim_i_main_core_no_name_rxrdata;
wire i_mnim_i_main_core_no_name_rxrlast;
wire [(2)-1:0] i_mnim_i_main_core_no_name_rxrresp;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_mnim_i_main_core_no_name_sfni_link;
wire i_mnim_i_main_core_no_name_sfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_mnim_i_main_core_no_name_sbni_link;
wire i_mnim_i_main_core_no_name_sbni_ready;
wire [(`BW_SVRING_LINK)-1:0] i_mnim_i_main_core_no_name_svri_rlink;
wire i_mnim_i_main_core_no_name_svri_rack;
wire [(`BW_SVRING_LINK)-1:0] i_mnim_i_main_core_no_name_svri_slink;
wire i_mnim_i_main_core_no_name_svri_sack;
wire i_mnim_i_main_core_no_name_local_spsel;
wire i_mnim_i_main_core_no_name_local_spenable;
wire i_mnim_i_main_core_no_name_local_spwrite;
wire [(32)-1:0] i_mnim_i_main_core_no_name_local_spaddr;
wire [(32)-1:0] i_mnim_i_main_core_no_name_local_spwdata;
wire i_mnim_i_main_core_no_name_local_spready;
wire [(32)-1:0] i_mnim_i_main_core_no_name_local_sprdata;
wire i_mnim_i_main_core_no_name_local_spslverr;
wire i_mnim_i_sub_core_001_no_name_clk_network;
wire i_mnim_i_sub_core_001_no_name_rstnn_network;
wire i_mnim_i_sub_core_001_no_name_clk_master;
wire i_mnim_i_sub_core_001_no_name_rstnn_master;
wire i_mnim_i_sub_core_001_no_name_comm_disable;
wire i_mnim_i_sub_core_001_no_name_local_allows_holds;
wire i_mnim_i_sub_core_001_no_name_rxawready;
wire i_mnim_i_sub_core_001_no_name_rxawvalid;
wire [(32)-1:0] i_mnim_i_sub_core_001_no_name_rxawaddr;
wire [(4)-1:0] i_mnim_i_sub_core_001_no_name_rxawid;
wire [(8)-1:0] i_mnim_i_sub_core_001_no_name_rxawlen;
wire [(3)-1:0] i_mnim_i_sub_core_001_no_name_rxawsize;
wire [(2)-1:0] i_mnim_i_sub_core_001_no_name_rxawburst;
wire i_mnim_i_sub_core_001_no_name_rxwready;
wire i_mnim_i_sub_core_001_no_name_rxwvalid;
wire [(4)-1:0] i_mnim_i_sub_core_001_no_name_rxwid;
wire [(32)-1:0] i_mnim_i_sub_core_001_no_name_rxwdata;
wire [(32/8)-1:0] i_mnim_i_sub_core_001_no_name_rxwstrb;
wire i_mnim_i_sub_core_001_no_name_rxwlast;
wire i_mnim_i_sub_core_001_no_name_rxbready;
wire i_mnim_i_sub_core_001_no_name_rxbvalid;
wire [(4)-1:0] i_mnim_i_sub_core_001_no_name_rxbid;
wire [(2)-1:0] i_mnim_i_sub_core_001_no_name_rxbresp;
wire i_mnim_i_sub_core_001_no_name_rxarready;
wire i_mnim_i_sub_core_001_no_name_rxarvalid;
wire [(32)-1:0] i_mnim_i_sub_core_001_no_name_rxaraddr;
wire [(4)-1:0] i_mnim_i_sub_core_001_no_name_rxarid;
wire [(8)-1:0] i_mnim_i_sub_core_001_no_name_rxarlen;
wire [(3)-1:0] i_mnim_i_sub_core_001_no_name_rxarsize;
wire [(2)-1:0] i_mnim_i_sub_core_001_no_name_rxarburst;
wire i_mnim_i_sub_core_001_no_name_rxrready;
wire i_mnim_i_sub_core_001_no_name_rxrvalid;
wire [(4)-1:0] i_mnim_i_sub_core_001_no_name_rxrid;
wire [(32)-1:0] i_mnim_i_sub_core_001_no_name_rxrdata;
wire i_mnim_i_sub_core_001_no_name_rxrlast;
wire [(2)-1:0] i_mnim_i_sub_core_001_no_name_rxrresp;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_mnim_i_sub_core_001_no_name_sfni_link;
wire i_mnim_i_sub_core_001_no_name_sfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_mnim_i_sub_core_001_no_name_sbni_link;
wire i_mnim_i_sub_core_001_no_name_sbni_ready;
wire [(`BW_SVRING_LINK)-1:0] i_mnim_i_sub_core_001_no_name_svri_rlink;
wire i_mnim_i_sub_core_001_no_name_svri_rack;
wire [(`BW_SVRING_LINK)-1:0] i_mnim_i_sub_core_001_no_name_svri_slink;
wire i_mnim_i_sub_core_001_no_name_svri_sack;
wire i_mnim_i_sub_core_001_no_name_local_spsel;
wire i_mnim_i_sub_core_001_no_name_local_spenable;
wire i_mnim_i_sub_core_001_no_name_local_spwrite;
wire [(32)-1:0] i_mnim_i_sub_core_001_no_name_local_spaddr;
wire [(32)-1:0] i_mnim_i_sub_core_001_no_name_local_spwdata;
wire i_mnim_i_sub_core_001_no_name_local_spready;
wire [(32)-1:0] i_mnim_i_sub_core_001_no_name_local_sprdata;
wire i_mnim_i_sub_core_001_no_name_local_spslverr;
wire i_mnim_i_sub_core_002_no_name_clk_network;
wire i_mnim_i_sub_core_002_no_name_rstnn_network;
wire i_mnim_i_sub_core_002_no_name_clk_master;
wire i_mnim_i_sub_core_002_no_name_rstnn_master;
wire i_mnim_i_sub_core_002_no_name_comm_disable;
wire i_mnim_i_sub_core_002_no_name_local_allows_holds;
wire i_mnim_i_sub_core_002_no_name_rxawready;
wire i_mnim_i_sub_core_002_no_name_rxawvalid;
wire [(32)-1:0] i_mnim_i_sub_core_002_no_name_rxawaddr;
wire [(4)-1:0] i_mnim_i_sub_core_002_no_name_rxawid;
wire [(8)-1:0] i_mnim_i_sub_core_002_no_name_rxawlen;
wire [(3)-1:0] i_mnim_i_sub_core_002_no_name_rxawsize;
wire [(2)-1:0] i_mnim_i_sub_core_002_no_name_rxawburst;
wire i_mnim_i_sub_core_002_no_name_rxwready;
wire i_mnim_i_sub_core_002_no_name_rxwvalid;
wire [(4)-1:0] i_mnim_i_sub_core_002_no_name_rxwid;
wire [(32)-1:0] i_mnim_i_sub_core_002_no_name_rxwdata;
wire [(32/8)-1:0] i_mnim_i_sub_core_002_no_name_rxwstrb;
wire i_mnim_i_sub_core_002_no_name_rxwlast;
wire i_mnim_i_sub_core_002_no_name_rxbready;
wire i_mnim_i_sub_core_002_no_name_rxbvalid;
wire [(4)-1:0] i_mnim_i_sub_core_002_no_name_rxbid;
wire [(2)-1:0] i_mnim_i_sub_core_002_no_name_rxbresp;
wire i_mnim_i_sub_core_002_no_name_rxarready;
wire i_mnim_i_sub_core_002_no_name_rxarvalid;
wire [(32)-1:0] i_mnim_i_sub_core_002_no_name_rxaraddr;
wire [(4)-1:0] i_mnim_i_sub_core_002_no_name_rxarid;
wire [(8)-1:0] i_mnim_i_sub_core_002_no_name_rxarlen;
wire [(3)-1:0] i_mnim_i_sub_core_002_no_name_rxarsize;
wire [(2)-1:0] i_mnim_i_sub_core_002_no_name_rxarburst;
wire i_mnim_i_sub_core_002_no_name_rxrready;
wire i_mnim_i_sub_core_002_no_name_rxrvalid;
wire [(4)-1:0] i_mnim_i_sub_core_002_no_name_rxrid;
wire [(32)-1:0] i_mnim_i_sub_core_002_no_name_rxrdata;
wire i_mnim_i_sub_core_002_no_name_rxrlast;
wire [(2)-1:0] i_mnim_i_sub_core_002_no_name_rxrresp;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_mnim_i_sub_core_002_no_name_sfni_link;
wire i_mnim_i_sub_core_002_no_name_sfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_mnim_i_sub_core_002_no_name_sbni_link;
wire i_mnim_i_sub_core_002_no_name_sbni_ready;
wire [(`BW_SVRING_LINK)-1:0] i_mnim_i_sub_core_002_no_name_svri_rlink;
wire i_mnim_i_sub_core_002_no_name_svri_rack;
wire [(`BW_SVRING_LINK)-1:0] i_mnim_i_sub_core_002_no_name_svri_slink;
wire i_mnim_i_sub_core_002_no_name_svri_sack;
wire i_mnim_i_sub_core_002_no_name_local_spsel;
wire i_mnim_i_sub_core_002_no_name_local_spenable;
wire i_mnim_i_sub_core_002_no_name_local_spwrite;
wire [(32)-1:0] i_mnim_i_sub_core_002_no_name_local_spaddr;
wire [(32)-1:0] i_mnim_i_sub_core_002_no_name_local_spwdata;
wire i_mnim_i_sub_core_002_no_name_local_spready;
wire [(32)-1:0] i_mnim_i_sub_core_002_no_name_local_sprdata;
wire i_mnim_i_sub_core_002_no_name_local_spslverr;
wire i_mnim_i_sub_core_003_no_name_clk_network;
wire i_mnim_i_sub_core_003_no_name_rstnn_network;
wire i_mnim_i_sub_core_003_no_name_clk_master;
wire i_mnim_i_sub_core_003_no_name_rstnn_master;
wire i_mnim_i_sub_core_003_no_name_comm_disable;
wire i_mnim_i_sub_core_003_no_name_local_allows_holds;
wire i_mnim_i_sub_core_003_no_name_rxawready;
wire i_mnim_i_sub_core_003_no_name_rxawvalid;
wire [(32)-1:0] i_mnim_i_sub_core_003_no_name_rxawaddr;
wire [(4)-1:0] i_mnim_i_sub_core_003_no_name_rxawid;
wire [(8)-1:0] i_mnim_i_sub_core_003_no_name_rxawlen;
wire [(3)-1:0] i_mnim_i_sub_core_003_no_name_rxawsize;
wire [(2)-1:0] i_mnim_i_sub_core_003_no_name_rxawburst;
wire i_mnim_i_sub_core_003_no_name_rxwready;
wire i_mnim_i_sub_core_003_no_name_rxwvalid;
wire [(4)-1:0] i_mnim_i_sub_core_003_no_name_rxwid;
wire [(32)-1:0] i_mnim_i_sub_core_003_no_name_rxwdata;
wire [(32/8)-1:0] i_mnim_i_sub_core_003_no_name_rxwstrb;
wire i_mnim_i_sub_core_003_no_name_rxwlast;
wire i_mnim_i_sub_core_003_no_name_rxbready;
wire i_mnim_i_sub_core_003_no_name_rxbvalid;
wire [(4)-1:0] i_mnim_i_sub_core_003_no_name_rxbid;
wire [(2)-1:0] i_mnim_i_sub_core_003_no_name_rxbresp;
wire i_mnim_i_sub_core_003_no_name_rxarready;
wire i_mnim_i_sub_core_003_no_name_rxarvalid;
wire [(32)-1:0] i_mnim_i_sub_core_003_no_name_rxaraddr;
wire [(4)-1:0] i_mnim_i_sub_core_003_no_name_rxarid;
wire [(8)-1:0] i_mnim_i_sub_core_003_no_name_rxarlen;
wire [(3)-1:0] i_mnim_i_sub_core_003_no_name_rxarsize;
wire [(2)-1:0] i_mnim_i_sub_core_003_no_name_rxarburst;
wire i_mnim_i_sub_core_003_no_name_rxrready;
wire i_mnim_i_sub_core_003_no_name_rxrvalid;
wire [(4)-1:0] i_mnim_i_sub_core_003_no_name_rxrid;
wire [(32)-1:0] i_mnim_i_sub_core_003_no_name_rxrdata;
wire i_mnim_i_sub_core_003_no_name_rxrlast;
wire [(2)-1:0] i_mnim_i_sub_core_003_no_name_rxrresp;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_mnim_i_sub_core_003_no_name_sfni_link;
wire i_mnim_i_sub_core_003_no_name_sfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_mnim_i_sub_core_003_no_name_sbni_link;
wire i_mnim_i_sub_core_003_no_name_sbni_ready;
wire [(`BW_SVRING_LINK)-1:0] i_mnim_i_sub_core_003_no_name_svri_rlink;
wire i_mnim_i_sub_core_003_no_name_svri_rack;
wire [(`BW_SVRING_LINK)-1:0] i_mnim_i_sub_core_003_no_name_svri_slink;
wire i_mnim_i_sub_core_003_no_name_svri_sack;
wire i_mnim_i_sub_core_003_no_name_local_spsel;
wire i_mnim_i_sub_core_003_no_name_local_spenable;
wire i_mnim_i_sub_core_003_no_name_local_spwrite;
wire [(32)-1:0] i_mnim_i_sub_core_003_no_name_local_spaddr;
wire [(32)-1:0] i_mnim_i_sub_core_003_no_name_local_spwdata;
wire i_mnim_i_sub_core_003_no_name_local_spready;
wire [(32)-1:0] i_mnim_i_sub_core_003_no_name_local_sprdata;
wire i_mnim_i_sub_core_003_no_name_local_spslverr;
wire i_snim_i_system_sram_no_name_clk;
wire i_snim_i_system_sram_no_name_rstnn;
wire i_snim_i_system_sram_no_name_comm_disable;
wire i_snim_i_system_sram_no_name_sxawready;
wire i_snim_i_system_sram_no_name_sxawvalid;
wire [(32)-1:0] i_snim_i_system_sram_no_name_sxawaddr;
wire [(`REQUIRED_BW_OF_SLAVE_TID)-1:0] i_snim_i_system_sram_no_name_sxawid;
wire [(8)-1:0] i_snim_i_system_sram_no_name_sxawlen;
wire [(3)-1:0] i_snim_i_system_sram_no_name_sxawsize;
wire [(2)-1:0] i_snim_i_system_sram_no_name_sxawburst;
wire i_snim_i_system_sram_no_name_sxwready;
wire i_snim_i_system_sram_no_name_sxwvalid;
wire [(`REQUIRED_BW_OF_SLAVE_TID)-1:0] i_snim_i_system_sram_no_name_sxwid;
wire [(32)-1:0] i_snim_i_system_sram_no_name_sxwdata;
wire [(32/8)-1:0] i_snim_i_system_sram_no_name_sxwstrb;
wire i_snim_i_system_sram_no_name_sxwlast;
wire i_snim_i_system_sram_no_name_sxbready;
wire i_snim_i_system_sram_no_name_sxbvalid;
wire [(`REQUIRED_BW_OF_SLAVE_TID)-1:0] i_snim_i_system_sram_no_name_sxbid;
wire [(2)-1:0] i_snim_i_system_sram_no_name_sxbresp;
wire i_snim_i_system_sram_no_name_sxarready;
wire i_snim_i_system_sram_no_name_sxarvalid;
wire [(32)-1:0] i_snim_i_system_sram_no_name_sxaraddr;
wire [(`REQUIRED_BW_OF_SLAVE_TID)-1:0] i_snim_i_system_sram_no_name_sxarid;
wire [(8)-1:0] i_snim_i_system_sram_no_name_sxarlen;
wire [(3)-1:0] i_snim_i_system_sram_no_name_sxarsize;
wire [(2)-1:0] i_snim_i_system_sram_no_name_sxarburst;
wire i_snim_i_system_sram_no_name_sxrready;
wire i_snim_i_system_sram_no_name_sxrvalid;
wire [(`REQUIRED_BW_OF_SLAVE_TID)-1:0] i_snim_i_system_sram_no_name_sxrid;
wire [(32)-1:0] i_snim_i_system_sram_no_name_sxrdata;
wire i_snim_i_system_sram_no_name_sxrlast;
wire [(2)-1:0] i_snim_i_system_sram_no_name_sxrresp;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_snim_i_system_sram_no_name_rfni_link;
wire i_snim_i_system_sram_no_name_rfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_snim_i_system_sram_no_name_rbni_link;
wire i_snim_i_system_sram_no_name_rbni_ready;
wire [(`BW_SVRING_LINK)-1:0] i_snim_i_system_sram_no_name_svri_rlink;
wire i_snim_i_system_sram_no_name_svri_rack;
wire [(`BW_SVRING_LINK)-1:0] i_snim_i_system_sram_no_name_svri_slink;
wire i_snim_i_system_sram_no_name_svri_sack;
wire i_snim_common_peri_group_no_name_clk_network;
wire i_snim_common_peri_group_no_name_rstnn_network;
wire i_snim_common_peri_group_no_name_clk_slave;
wire i_snim_common_peri_group_no_name_rstnn_slave;
wire i_snim_common_peri_group_no_name_comm_disable;
wire i_snim_common_peri_group_no_name_spsel;
wire i_snim_common_peri_group_no_name_spenable;
wire i_snim_common_peri_group_no_name_spwrite;
wire [(32)-1:0] i_snim_common_peri_group_no_name_spaddr;
wire [(32)-1:0] i_snim_common_peri_group_no_name_spwdata;
wire i_snim_common_peri_group_no_name_spready;
wire [(32)-1:0] i_snim_common_peri_group_no_name_sprdata;
wire i_snim_common_peri_group_no_name_spslverr;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_snim_common_peri_group_no_name_rfni_link;
wire i_snim_common_peri_group_no_name_rfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_snim_common_peri_group_no_name_rbni_link;
wire i_snim_common_peri_group_no_name_rbni_ready;
wire [(`BW_SVRING_LINK)-1:0] i_snim_common_peri_group_no_name_svri_rlink;
wire i_snim_common_peri_group_no_name_svri_rack;
wire [(`BW_SVRING_LINK)-1:0] i_snim_common_peri_group_no_name_svri_slink;
wire i_snim_common_peri_group_no_name_svri_sack;
wire i_snim_external_peri_group_no_name_clk_network;
wire i_snim_external_peri_group_no_name_rstnn_network;
wire i_snim_external_peri_group_no_name_clk_slave;
wire i_snim_external_peri_group_no_name_rstnn_slave;
wire i_snim_external_peri_group_no_name_comm_disable;
wire i_snim_external_peri_group_no_name_spsel;
wire i_snim_external_peri_group_no_name_spenable;
wire i_snim_external_peri_group_no_name_spwrite;
wire [(32)-1:0] i_snim_external_peri_group_no_name_spaddr;
wire [(32)-1:0] i_snim_external_peri_group_no_name_spwdata;
wire i_snim_external_peri_group_no_name_spready;
wire [(32)-1:0] i_snim_external_peri_group_no_name_sprdata;
wire i_snim_external_peri_group_no_name_spslverr;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_snim_external_peri_group_no_name_rfni_link;
wire i_snim_external_peri_group_no_name_rfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_snim_external_peri_group_no_name_rbni_link;
wire i_snim_external_peri_group_no_name_rbni_ready;
wire [(`BW_SVRING_LINK)-1:0] i_snim_external_peri_group_no_name_svri_rlink;
wire i_snim_external_peri_group_no_name_svri_rack;
wire [(`BW_SVRING_LINK)-1:0] i_snim_external_peri_group_no_name_svri_slink;
wire i_snim_external_peri_group_no_name_svri_sack;
wire i_snim_platform_controller_no_name_clk_network;
wire i_snim_platform_controller_no_name_rstnn_network;
wire i_snim_platform_controller_no_name_clk_slave;
wire i_snim_platform_controller_no_name_rstnn_slave;
wire i_snim_platform_controller_no_name_comm_disable;
wire i_snim_platform_controller_no_name_spsel;
wire i_snim_platform_controller_no_name_spenable;
wire i_snim_platform_controller_no_name_spwrite;
wire [(32)-1:0] i_snim_platform_controller_no_name_spaddr;
wire [(32)-1:0] i_snim_platform_controller_no_name_spwdata;
wire i_snim_platform_controller_no_name_spready;
wire [(32)-1:0] i_snim_platform_controller_no_name_sprdata;
wire i_snim_platform_controller_no_name_spslverr;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_snim_platform_controller_no_name_rfni_link;
wire i_snim_platform_controller_no_name_rfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_snim_platform_controller_no_name_rbni_link;
wire i_snim_platform_controller_no_name_rbni_ready;
wire [(`BW_SVRING_LINK)-1:0] i_snim_platform_controller_no_name_svri_rlink;
wire i_snim_platform_controller_no_name_svri_rack;
wire [(`BW_SVRING_LINK)-1:0] i_snim_platform_controller_no_name_svri_slink;
wire i_snim_platform_controller_no_name_svri_sack;
wire i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_clk_network;
wire i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_rstnn_network;
wire i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_clk_slave;
wire i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_rstnn_slave;
wire i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_comm_disable;
wire i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_spsel;
wire i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_spenable;
wire i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_spwrite;
wire [(32)-1:0] i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_spaddr;
wire [(32)-1:0] i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_spwdata;
wire i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_spready;
wire [(32)-1:0] i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_sprdata;
wire i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_spslverr;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_rfni_link;
wire i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_rfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_rbni_link;
wire i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_rbni_ready;
wire [(`BW_SVRING_LINK)-1:0] i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_svri_rlink;
wire i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_svri_rack;
wire [(`BW_SVRING_LINK)-1:0] i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_svri_slink;
wire i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_svri_sack;
wire i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_clk_network;
wire i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_rstnn_network;
wire i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_clk_slave;
wire i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_rstnn_slave;
wire i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_comm_disable;
wire i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_spsel;
wire i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_spenable;
wire i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_spwrite;
wire [(32)-1:0] i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_spaddr;
wire [(32)-1:0] i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_spwdata;
wire i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_spready;
wire [(32)-1:0] i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_sprdata;
wire i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_spslverr;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_rfni_link;
wire i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_rfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_rbni_link;
wire i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_rbni_ready;
wire [(`BW_SVRING_LINK)-1:0] i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_svri_rlink;
wire i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_svri_rack;
wire [(`BW_SVRING_LINK)-1:0] i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_svri_slink;
wire i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_svri_sack;
wire i_mnim_platform_controller_master_clk_network;
wire i_mnim_platform_controller_master_rstnn_network;
wire i_mnim_platform_controller_master_clk_master;
wire i_mnim_platform_controller_master_rstnn_master;
wire i_mnim_platform_controller_master_comm_disable;
wire i_mnim_platform_controller_master_rhready;
wire [(32)-1:0] i_mnim_platform_controller_master_rhaddr;
wire [(3)-1:0] i_mnim_platform_controller_master_rhburst;
wire i_mnim_platform_controller_master_rhmasterlock;
wire [(4)-1:0] i_mnim_platform_controller_master_rhprot;
wire [(3)-1:0] i_mnim_platform_controller_master_rhsize;
wire [(2)-1:0] i_mnim_platform_controller_master_rhtrans;
wire i_mnim_platform_controller_master_rhwrite;
wire [(32)-1:0] i_mnim_platform_controller_master_rhwdata;
wire [(32)-1:0] i_mnim_platform_controller_master_rhrdata;
wire i_mnim_platform_controller_master_rhresp;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_mnim_platform_controller_master_sfni_link;
wire i_mnim_platform_controller_master_sfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_mnim_platform_controller_master_sbni_link;
wire i_mnim_platform_controller_master_sbni_ready;
wire [(`BW_SVRING_LINK)-1:0] i_mnim_platform_controller_master_svri_rlink;
wire i_mnim_platform_controller_master_svri_rack;
wire [(`BW_SVRING_LINK)-1:0] i_mnim_platform_controller_master_svri_slink;
wire i_mnim_platform_controller_master_svri_sack;
wire i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_clk_network;
wire i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rstnn_network;
wire i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_clk_master;
wire i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rstnn_master;
wire i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_comm_disable;
wire [(2)-1:0] i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqdready;
wire i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqvalid;
wire i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqlast;
wire i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqwrite;
wire [(8)-1:0] i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqlen;
wire [(3)-1:0] i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqsize;
wire [(2)-1:0] i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqburst;
wire [(128/8)-1:0] i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqwstrb;
wire [(128)-1:0] i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqwdata;
wire [(32)-1:0] i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqaddr;
wire [(1)-1:0] i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqburden;
wire [(2)-1:0] i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxydready;
wire i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxyvalid;
wire i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxylast;
wire i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxywreply;
wire [(2)-1:0] i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxyresp;
wire [(128)-1:0] i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxyrdata;
wire [(1)-1:0] i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxyburden;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_sfni_link;
wire i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_sfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_sbni_link;
wire i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_sbni_ready;
wire [(`BW_SVRING_LINK)-1:0] i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_svri_rlink;
wire i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_svri_rack;
wire [(`BW_SVRING_LINK)-1:0] i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_svri_slink;
wire i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_svri_sack;
wire i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_clk_network;
wire i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rstnn_network;
wire i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_clk_master;
wire i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rstnn_master;
wire i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_comm_disable;
wire [(2)-1:0] i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqdready;
wire i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqvalid;
wire i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqlast;
wire i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqwrite;
wire [(8)-1:0] i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqlen;
wire [(3)-1:0] i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqsize;
wire [(2)-1:0] i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqburst;
wire [(128/8)-1:0] i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqwstrb;
wire [(128)-1:0] i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqwdata;
wire [(32)-1:0] i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqaddr;
wire [(1)-1:0] i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqburden;
wire [(2)-1:0] i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxydready;
wire i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxyvalid;
wire i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxylast;
wire i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxywreply;
wire [(2)-1:0] i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxyresp;
wire [(128)-1:0] i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxyrdata;
wire [(1)-1:0] i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxyburden;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_sfni_link;
wire i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_sfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_sbni_link;
wire i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_sbni_ready;
wire [(`BW_SVRING_LINK)-1:0] i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_svri_rlink;
wire i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_svri_rack;
wire [(`BW_SVRING_LINK)-1:0] i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_svri_slink;
wire i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_svri_sack;
wire i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_clk_network;
wire i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rstnn_network;
wire i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_clk_master;
wire i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rstnn_master;
wire i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_comm_disable;
wire [(2)-1:0] i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqdready;
wire i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqvalid;
wire i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqlast;
wire i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqwrite;
wire [(8)-1:0] i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqlen;
wire [(3)-1:0] i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqsize;
wire [(2)-1:0] i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqburst;
wire [(128/8)-1:0] i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqwstrb;
wire [(128)-1:0] i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqwdata;
wire [(32)-1:0] i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqaddr;
wire [(1)-1:0] i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqburden;
wire [(2)-1:0] i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxydready;
wire i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxyvalid;
wire i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxylast;
wire i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxywreply;
wire [(2)-1:0] i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxyresp;
wire [(128)-1:0] i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxyrdata;
wire [(1)-1:0] i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxyburden;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_sfni_link;
wire i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_sfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_sbni_link;
wire i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_sbni_ready;
wire [(`BW_SVRING_LINK)-1:0] i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_svri_rlink;
wire i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_svri_rack;
wire [(`BW_SVRING_LINK)-1:0] i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_svri_slink;
wire i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_svri_sack;
wire i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_clk_network;
wire i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rstnn_network;
wire i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_clk_master;
wire i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rstnn_master;
wire i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_comm_disable;
wire [(2)-1:0] i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqdready;
wire i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqvalid;
wire i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqlast;
wire i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqwrite;
wire [(8)-1:0] i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqlen;
wire [(3)-1:0] i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqsize;
wire [(2)-1:0] i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqburst;
wire [(128/8)-1:0] i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqwstrb;
wire [(128)-1:0] i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqwdata;
wire [(32)-1:0] i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqaddr;
wire [(1)-1:0] i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqburden;
wire [(2)-1:0] i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxydready;
wire i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxyvalid;
wire i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxylast;
wire i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxywreply;
wire [(2)-1:0] i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxyresp;
wire [(128)-1:0] i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxyrdata;
wire [(1)-1:0] i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxyburden;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_sfni_link;
wire i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_sfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_sbni_link;
wire i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_sbni_ready;
wire [(`BW_SVRING_LINK)-1:0] i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_svri_rlink;
wire i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_svri_rack;
wire [(`BW_SVRING_LINK)-1:0] i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_svri_slink;
wire i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_svri_sack;
wire i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_clk_network;
wire i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rstnn_network;
wire i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_clk_master;
wire i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rstnn_master;
wire i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_comm_disable;
wire [(2)-1:0] i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqdready;
wire i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqvalid;
wire i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqlast;
wire i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqwrite;
wire [(8)-1:0] i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqlen;
wire [(3)-1:0] i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqsize;
wire [(2)-1:0] i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqburst;
wire [(128/8)-1:0] i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqwstrb;
wire [(128)-1:0] i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqwdata;
wire [(32)-1:0] i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqaddr;
wire [(1)-1:0] i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqburden;
wire [(2)-1:0] i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxydready;
wire i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxyvalid;
wire i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxylast;
wire i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxywreply;
wire [(2)-1:0] i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxyresp;
wire [(128)-1:0] i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxyrdata;
wire [(1)-1:0] i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxyburden;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_sfni_link;
wire i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_sfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_sbni_link;
wire i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_sbni_ready;
wire [(`BW_SVRING_LINK)-1:0] i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_svri_rlink;
wire i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_svri_rack;
wire [(`BW_SVRING_LINK)-1:0] i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_svri_slink;
wire i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_svri_sack;
wire i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_clk_network;
wire i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rstnn_network;
wire i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_clk_master;
wire i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rstnn_master;
wire i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_comm_disable;
wire [(2)-1:0] i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqdready;
wire i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqvalid;
wire i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqlast;
wire i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqwrite;
wire [(8)-1:0] i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqlen;
wire [(3)-1:0] i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqsize;
wire [(2)-1:0] i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqburst;
wire [(128/8)-1:0] i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqwstrb;
wire [(128)-1:0] i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqwdata;
wire [(32)-1:0] i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqaddr;
wire [(1)-1:0] i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqburden;
wire [(2)-1:0] i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxydready;
wire i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxyvalid;
wire i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxylast;
wire i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxywreply;
wire [(2)-1:0] i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxyresp;
wire [(128)-1:0] i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxyrdata;
wire [(1)-1:0] i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxyburden;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_sfni_link;
wire i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_sfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_sbni_link;
wire i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_sbni_ready;
wire [(`BW_SVRING_LINK)-1:0] i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_svri_rlink;
wire i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_svri_rack;
wire [(`BW_SVRING_LINK)-1:0] i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_svri_slink;
wire i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_svri_sack;
wire i_snim_i_system_ddr_no_name_clk;
wire i_snim_i_system_ddr_no_name_rstnn;
wire i_snim_i_system_ddr_no_name_comm_disable;
wire i_snim_i_system_ddr_no_name_sxawready;
wire i_snim_i_system_ddr_no_name_sxawvalid;
wire [(32)-1:0] i_snim_i_system_ddr_no_name_sxawaddr;
wire [(16)-1:0] i_snim_i_system_ddr_no_name_sxawid;
wire [(8)-1:0] i_snim_i_system_ddr_no_name_sxawlen;
wire [(3)-1:0] i_snim_i_system_ddr_no_name_sxawsize;
wire [(2)-1:0] i_snim_i_system_ddr_no_name_sxawburst;
wire i_snim_i_system_ddr_no_name_sxwready;
wire i_snim_i_system_ddr_no_name_sxwvalid;
wire [(16)-1:0] i_snim_i_system_ddr_no_name_sxwid;
wire [(32)-1:0] i_snim_i_system_ddr_no_name_sxwdata;
wire [(32/8)-1:0] i_snim_i_system_ddr_no_name_sxwstrb;
wire i_snim_i_system_ddr_no_name_sxwlast;
wire i_snim_i_system_ddr_no_name_sxbready;
wire i_snim_i_system_ddr_no_name_sxbvalid;
wire [(16)-1:0] i_snim_i_system_ddr_no_name_sxbid;
wire [(2)-1:0] i_snim_i_system_ddr_no_name_sxbresp;
wire i_snim_i_system_ddr_no_name_sxarready;
wire i_snim_i_system_ddr_no_name_sxarvalid;
wire [(32)-1:0] i_snim_i_system_ddr_no_name_sxaraddr;
wire [(16)-1:0] i_snim_i_system_ddr_no_name_sxarid;
wire [(8)-1:0] i_snim_i_system_ddr_no_name_sxarlen;
wire [(3)-1:0] i_snim_i_system_ddr_no_name_sxarsize;
wire [(2)-1:0] i_snim_i_system_ddr_no_name_sxarburst;
wire i_snim_i_system_ddr_no_name_sxrready;
wire i_snim_i_system_ddr_no_name_sxrvalid;
wire [(16)-1:0] i_snim_i_system_ddr_no_name_sxrid;
wire [(32)-1:0] i_snim_i_system_ddr_no_name_sxrdata;
wire i_snim_i_system_ddr_no_name_sxrlast;
wire [(2)-1:0] i_snim_i_system_ddr_no_name_sxrresp;
wire [(`BW_FNI_LINK(BW_FNI_PHIT))-1:0] i_snim_i_system_ddr_no_name_rfni_link;
wire i_snim_i_system_ddr_no_name_rfni_ready;
wire [(`BW_BNI_LINK(BW_BNI_PHIT))-1:0] i_snim_i_system_ddr_no_name_rbni_link;
wire i_snim_i_system_ddr_no_name_rbni_ready;
wire [(`BW_SVRING_LINK)-1:0] i_snim_i_system_ddr_no_name_svri_rlink;
wire i_snim_i_system_ddr_no_name_svri_rack;
wire [(`BW_SVRING_LINK)-1:0] i_snim_i_system_ddr_no_name_svri_slink;
wire i_snim_i_system_ddr_no_name_svri_sack;
wire i_router00_clk;
wire i_router00_rstnn;
wire [((`BW_FNI_LINK(BW_FNI_PHIT))*(4))-1:0] i_router00_rfni_link_list;
wire [((1)*(4))-1:0] i_router00_rfni_ready_list;
wire [((`BW_BNI_LINK(BW_BNI_PHIT))*(4))-1:0] i_router00_rbni_link_list;
wire [((1)*(4))-1:0] i_router00_rbni_ready_list;
wire [((`BW_FNI_LINK(BW_FNI_PHIT))*(2))-1:0] i_router00_sfni_link_list;
wire [((1)*(2))-1:0] i_router00_sfni_ready_list;
wire [((`BW_BNI_LINK(BW_BNI_PHIT))*(2))-1:0] i_router00_sbni_link_list;
wire [((1)*(2))-1:0] i_router00_sbni_ready_list;
wire i_system_router_clk;
wire i_system_router_rstnn;
wire [((`BW_FNI_LINK(BW_FNI_PHIT))*(2))-1:0] i_system_router_rfni_link_list;
wire [((1)*(2))-1:0] i_system_router_rfni_ready_list;
wire [((`BW_BNI_LINK(BW_BNI_PHIT))*(2))-1:0] i_system_router_rbni_link_list;
wire [((1)*(2))-1:0] i_system_router_rbni_ready_list;
wire [((`BW_FNI_LINK(BW_FNI_PHIT))*(7))-1:0] i_system_router_sfni_link_list;
wire [((1)*(7))-1:0] i_system_router_sfni_ready_list;
wire [((`BW_BNI_LINK(BW_BNI_PHIT))*(7))-1:0] i_system_router_sbni_link_list;
wire [((1)*(7))-1:0] i_system_router_sbni_ready_list;
wire i_user_router_clk;
wire i_user_router_rstnn;
wire [((`BW_FNI_LINK(BW_FNI_PHIT))*(8))-1:0] i_user_router_rfni_link_list;
wire [((1)*(8))-1:0] i_user_router_rfni_ready_list;
wire [((`BW_BNI_LINK(BW_BNI_PHIT))*(8))-1:0] i_user_router_rbni_link_list;
wire [((1)*(8))-1:0] i_user_router_rbni_ready_list;
wire [((`BW_FNI_LINK(BW_FNI_PHIT))*(2))-1:0] i_user_router_sfni_link_list;
wire [((1)*(2))-1:0] i_user_router_sfni_ready_list;
wire [((`BW_BNI_LINK(BW_BNI_PHIT))*(2))-1:0] i_user_router_sbni_link_list;
wire [((1)*(2))-1:0] i_user_router_sbni_ready_list;

RVC_ROCKET_OPT
#(
	.ENABLE_INTERRUPTS(1),
	.NUM_INTERRUPTS(32)
)
i_main_core
(
	.clk(i_main_core_clk),
	.rstnn(i_main_core_rstnn),
	.interrupt_vector(i_main_core_interrupt_vector),
	.interrupt_out(i_main_core_interrupt_out),
	.sxawready(i_main_core_sxawready),
	.sxawvalid(i_main_core_sxawvalid),
	.sxawaddr(i_main_core_sxawaddr),
	.sxawid(i_main_core_sxawid),
	.sxawlen(i_main_core_sxawlen),
	.sxawsize(i_main_core_sxawsize),
	.sxawburst(i_main_core_sxawburst),
	.sxwready(i_main_core_sxwready),
	.sxwvalid(i_main_core_sxwvalid),
	.sxwid(i_main_core_sxwid),
	.sxwdata(i_main_core_sxwdata),
	.sxwstrb(i_main_core_sxwstrb),
	.sxwlast(i_main_core_sxwlast),
	.sxbready(i_main_core_sxbready),
	.sxbvalid(i_main_core_sxbvalid),
	.sxbid(i_main_core_sxbid),
	.sxbresp(i_main_core_sxbresp),
	.sxarready(i_main_core_sxarready),
	.sxarvalid(i_main_core_sxarvalid),
	.sxaraddr(i_main_core_sxaraddr),
	.sxarid(i_main_core_sxarid),
	.sxarlen(i_main_core_sxarlen),
	.sxarsize(i_main_core_sxarsize),
	.sxarburst(i_main_core_sxarburst),
	.sxrready(i_main_core_sxrready),
	.sxrvalid(i_main_core_sxrvalid),
	.sxrid(i_main_core_sxrid),
	.sxrdata(i_main_core_sxrdata),
	.sxrlast(i_main_core_sxrlast),
	.sxrresp(i_main_core_sxrresp),
	.spc(i_main_core_spc),
	.sinst(i_main_core_sinst)
);

DCA_MATRIX_CONV2D_MMIOX_MLSU
#(
	.INPUT_MATRIX_SIZE(22),
	.KERNEL_MATRIX_SIZE(7),
	.OUTPUT_MATRIX_SIZE(16),
	.TENSOR_PARA(32)
)
i_dca_matrix_conv00
(
	.clk(i_dca_matrix_conv00_clk),
	.rstnn(i_dca_matrix_conv00_rstnn),
	.control_rmx_core_config(i_dca_matrix_conv00_control_rmx_core_config),
	.control_rmx_core_status(i_dca_matrix_conv00_control_rmx_core_status),
	.control_rmx_clear_request(i_dca_matrix_conv00_control_rmx_clear_request),
	.control_rmx_clear_finish(i_dca_matrix_conv00_control_rmx_clear_finish),
	.control_rmx_log_fifo_wready(i_dca_matrix_conv00_control_rmx_log_fifo_wready),
	.control_rmx_log_fifo_wrequest(i_dca_matrix_conv00_control_rmx_log_fifo_wrequest),
	.control_rmx_log_fifo_wdata(i_dca_matrix_conv00_control_rmx_log_fifo_wdata),
	.control_rmx_inst_fifo_rready(i_dca_matrix_conv00_control_rmx_inst_fifo_rready),
	.control_rmx_inst_fifo_rdata(i_dca_matrix_conv00_control_rmx_inst_fifo_rdata),
	.control_rmx_inst_fifo_rrequest(i_dca_matrix_conv00_control_rmx_inst_fifo_rrequest),
	.control_rmx_operation_finish(i_dca_matrix_conv00_control_rmx_operation_finish),
	.control_rmx_input_fifo_rready(i_dca_matrix_conv00_control_rmx_input_fifo_rready),
	.control_rmx_input_fifo_rdata(i_dca_matrix_conv00_control_rmx_input_fifo_rdata),
	.control_rmx_input_fifo_rrequest(i_dca_matrix_conv00_control_rmx_input_fifo_rrequest),
	.control_rmx_output_fifo_wready(i_dca_matrix_conv00_control_rmx_output_fifo_wready),
	.control_rmx_output_fifo_wrequest(i_dca_matrix_conv00_control_rmx_output_fifo_wrequest),
	.control_rmx_output_fifo_wdata(i_dca_matrix_conv00_control_rmx_output_fifo_wdata),
	.mi_sinst_wvalid(i_dca_matrix_conv00_mi_sinst_wvalid),
	.mi_sinst_wdata(i_dca_matrix_conv00_mi_sinst_wdata),
	.mi_sinst_wready(i_dca_matrix_conv00_mi_sinst_wready),
	.mi_sinst_decode_finish(i_dca_matrix_conv00_mi_sinst_decode_finish),
	.mi_sinst_execute_finish(i_dca_matrix_conv00_mi_sinst_execute_finish),
	.mi_sinst_busy(i_dca_matrix_conv00_mi_sinst_busy),
	.mi_sload_tensor_row_wvalid(i_dca_matrix_conv00_mi_sload_tensor_row_wvalid),
	.mi_sload_tensor_row_wlast(i_dca_matrix_conv00_mi_sload_tensor_row_wlast),
	.mi_sload_tensor_row_wdata(i_dca_matrix_conv00_mi_sload_tensor_row_wdata),
	.mi_sload_tensor_row_wready(i_dca_matrix_conv00_mi_sload_tensor_row_wready),
	.mi_sstore_tensor_row_rvalid(i_dca_matrix_conv00_mi_sstore_tensor_row_rvalid),
	.mi_sstore_tensor_row_rlast(i_dca_matrix_conv00_mi_sstore_tensor_row_rlast),
	.mi_sstore_tensor_row_rready(i_dca_matrix_conv00_mi_sstore_tensor_row_rready),
	.mi_sstore_tensor_row_rdata(i_dca_matrix_conv00_mi_sstore_tensor_row_rdata),
	.mk_sinst_wvalid(i_dca_matrix_conv00_mk_sinst_wvalid),
	.mk_sinst_wdata(i_dca_matrix_conv00_mk_sinst_wdata),
	.mk_sinst_wready(i_dca_matrix_conv00_mk_sinst_wready),
	.mk_sinst_decode_finish(i_dca_matrix_conv00_mk_sinst_decode_finish),
	.mk_sinst_execute_finish(i_dca_matrix_conv00_mk_sinst_execute_finish),
	.mk_sinst_busy(i_dca_matrix_conv00_mk_sinst_busy),
	.mk_sload_tensor_row_wvalid(i_dca_matrix_conv00_mk_sload_tensor_row_wvalid),
	.mk_sload_tensor_row_wlast(i_dca_matrix_conv00_mk_sload_tensor_row_wlast),
	.mk_sload_tensor_row_wdata(i_dca_matrix_conv00_mk_sload_tensor_row_wdata),
	.mk_sload_tensor_row_wready(i_dca_matrix_conv00_mk_sload_tensor_row_wready),
	.mk_sstore_tensor_row_rvalid(i_dca_matrix_conv00_mk_sstore_tensor_row_rvalid),
	.mk_sstore_tensor_row_rlast(i_dca_matrix_conv00_mk_sstore_tensor_row_rlast),
	.mk_sstore_tensor_row_rready(i_dca_matrix_conv00_mk_sstore_tensor_row_rready),
	.mk_sstore_tensor_row_rdata(i_dca_matrix_conv00_mk_sstore_tensor_row_rdata),
	.mo_sinst_wvalid(i_dca_matrix_conv00_mo_sinst_wvalid),
	.mo_sinst_wdata(i_dca_matrix_conv00_mo_sinst_wdata),
	.mo_sinst_wready(i_dca_matrix_conv00_mo_sinst_wready),
	.mo_sinst_decode_finish(i_dca_matrix_conv00_mo_sinst_decode_finish),
	.mo_sinst_execute_finish(i_dca_matrix_conv00_mo_sinst_execute_finish),
	.mo_sinst_busy(i_dca_matrix_conv00_mo_sinst_busy),
	.mo_sload_tensor_row_wvalid(i_dca_matrix_conv00_mo_sload_tensor_row_wvalid),
	.mo_sload_tensor_row_wlast(i_dca_matrix_conv00_mo_sload_tensor_row_wlast),
	.mo_sload_tensor_row_wdata(i_dca_matrix_conv00_mo_sload_tensor_row_wdata),
	.mo_sload_tensor_row_wready(i_dca_matrix_conv00_mo_sload_tensor_row_wready),
	.mo_sstore_tensor_row_rvalid(i_dca_matrix_conv00_mo_sstore_tensor_row_rvalid),
	.mo_sstore_tensor_row_rlast(i_dca_matrix_conv00_mo_sstore_tensor_row_rlast),
	.mo_sstore_tensor_row_rready(i_dca_matrix_conv00_mo_sstore_tensor_row_rready),
	.mo_sstore_tensor_row_rdata(i_dca_matrix_conv00_mo_sstore_tensor_row_rdata)
);

DCA_MATRIX_MAC_MMIOX_MLSU
#(
	.TENSOR_PARA(32),
	.MATRIX_SIZE_PARA(8)
)
i_dca_matrix_mac00
(
	.clk(i_dca_matrix_mac00_clk),
	.rstnn(i_dca_matrix_mac00_rstnn),
	.control_rmx_core_config(i_dca_matrix_mac00_control_rmx_core_config),
	.control_rmx_core_status(i_dca_matrix_mac00_control_rmx_core_status),
	.control_rmx_clear_request(i_dca_matrix_mac00_control_rmx_clear_request),
	.control_rmx_clear_finish(i_dca_matrix_mac00_control_rmx_clear_finish),
	.control_rmx_log_fifo_wready(i_dca_matrix_mac00_control_rmx_log_fifo_wready),
	.control_rmx_log_fifo_wrequest(i_dca_matrix_mac00_control_rmx_log_fifo_wrequest),
	.control_rmx_log_fifo_wdata(i_dca_matrix_mac00_control_rmx_log_fifo_wdata),
	.control_rmx_inst_fifo_rready(i_dca_matrix_mac00_control_rmx_inst_fifo_rready),
	.control_rmx_inst_fifo_rdata(i_dca_matrix_mac00_control_rmx_inst_fifo_rdata),
	.control_rmx_inst_fifo_rrequest(i_dca_matrix_mac00_control_rmx_inst_fifo_rrequest),
	.control_rmx_operation_finish(i_dca_matrix_mac00_control_rmx_operation_finish),
	.control_rmx_input_fifo_rready(i_dca_matrix_mac00_control_rmx_input_fifo_rready),
	.control_rmx_input_fifo_rdata(i_dca_matrix_mac00_control_rmx_input_fifo_rdata),
	.control_rmx_input_fifo_rrequest(i_dca_matrix_mac00_control_rmx_input_fifo_rrequest),
	.control_rmx_output_fifo_wready(i_dca_matrix_mac00_control_rmx_output_fifo_wready),
	.control_rmx_output_fifo_wrequest(i_dca_matrix_mac00_control_rmx_output_fifo_wrequest),
	.control_rmx_output_fifo_wdata(i_dca_matrix_mac00_control_rmx_output_fifo_wdata),
	.ma_sinst_wvalid(i_dca_matrix_mac00_ma_sinst_wvalid),
	.ma_sinst_wdata(i_dca_matrix_mac00_ma_sinst_wdata),
	.ma_sinst_wready(i_dca_matrix_mac00_ma_sinst_wready),
	.ma_sinst_decode_finish(i_dca_matrix_mac00_ma_sinst_decode_finish),
	.ma_sinst_execute_finish(i_dca_matrix_mac00_ma_sinst_execute_finish),
	.ma_sinst_busy(i_dca_matrix_mac00_ma_sinst_busy),
	.ma_sload_tensor_row_wvalid(i_dca_matrix_mac00_ma_sload_tensor_row_wvalid),
	.ma_sload_tensor_row_wlast(i_dca_matrix_mac00_ma_sload_tensor_row_wlast),
	.ma_sload_tensor_row_wdata(i_dca_matrix_mac00_ma_sload_tensor_row_wdata),
	.ma_sload_tensor_row_wready(i_dca_matrix_mac00_ma_sload_tensor_row_wready),
	.ma_sstore_tensor_row_rvalid(i_dca_matrix_mac00_ma_sstore_tensor_row_rvalid),
	.ma_sstore_tensor_row_rlast(i_dca_matrix_mac00_ma_sstore_tensor_row_rlast),
	.ma_sstore_tensor_row_rready(i_dca_matrix_mac00_ma_sstore_tensor_row_rready),
	.ma_sstore_tensor_row_rdata(i_dca_matrix_mac00_ma_sstore_tensor_row_rdata),
	.mb_sinst_wvalid(i_dca_matrix_mac00_mb_sinst_wvalid),
	.mb_sinst_wdata(i_dca_matrix_mac00_mb_sinst_wdata),
	.mb_sinst_wready(i_dca_matrix_mac00_mb_sinst_wready),
	.mb_sinst_decode_finish(i_dca_matrix_mac00_mb_sinst_decode_finish),
	.mb_sinst_execute_finish(i_dca_matrix_mac00_mb_sinst_execute_finish),
	.mb_sinst_busy(i_dca_matrix_mac00_mb_sinst_busy),
	.mb_sload_tensor_row_wvalid(i_dca_matrix_mac00_mb_sload_tensor_row_wvalid),
	.mb_sload_tensor_row_wlast(i_dca_matrix_mac00_mb_sload_tensor_row_wlast),
	.mb_sload_tensor_row_wdata(i_dca_matrix_mac00_mb_sload_tensor_row_wdata),
	.mb_sload_tensor_row_wready(i_dca_matrix_mac00_mb_sload_tensor_row_wready),
	.mb_sstore_tensor_row_rvalid(i_dca_matrix_mac00_mb_sstore_tensor_row_rvalid),
	.mb_sstore_tensor_row_rlast(i_dca_matrix_mac00_mb_sstore_tensor_row_rlast),
	.mb_sstore_tensor_row_rready(i_dca_matrix_mac00_mb_sstore_tensor_row_rready),
	.mb_sstore_tensor_row_rdata(i_dca_matrix_mac00_mb_sstore_tensor_row_rdata),
	.mc_sinst_wvalid(i_dca_matrix_mac00_mc_sinst_wvalid),
	.mc_sinst_wdata(i_dca_matrix_mac00_mc_sinst_wdata),
	.mc_sinst_wready(i_dca_matrix_mac00_mc_sinst_wready),
	.mc_sinst_decode_finish(i_dca_matrix_mac00_mc_sinst_decode_finish),
	.mc_sinst_execute_finish(i_dca_matrix_mac00_mc_sinst_execute_finish),
	.mc_sinst_busy(i_dca_matrix_mac00_mc_sinst_busy),
	.mc_sload_tensor_row_wvalid(i_dca_matrix_mac00_mc_sload_tensor_row_wvalid),
	.mc_sload_tensor_row_wlast(i_dca_matrix_mac00_mc_sload_tensor_row_wlast),
	.mc_sload_tensor_row_wdata(i_dca_matrix_mac00_mc_sload_tensor_row_wdata),
	.mc_sload_tensor_row_wready(i_dca_matrix_mac00_mc_sload_tensor_row_wready),
	.mc_sstore_tensor_row_rvalid(i_dca_matrix_mac00_mc_sstore_tensor_row_rvalid),
	.mc_sstore_tensor_row_rlast(i_dca_matrix_mac00_mc_sstore_tensor_row_rlast),
	.mc_sstore_tensor_row_rready(i_dca_matrix_mac00_mc_sstore_tensor_row_rready),
	.mc_sstore_tensor_row_rdata(i_dca_matrix_mac00_mc_sstore_tensor_row_rdata)
);

ERVP_LED_CHECKER
#(
	.NUM_LED(1)
)
i_led
(
	.clk(i_led_clk),
	.tick_62d5ms(i_led_tick_62d5ms),
	.rstnn(i_led_rstnn),
	.app_finished(i_led_app_finished),
	.led_list(i_led_led_list)
);

RVC_ROCKET_OPT
#(
	.ENABLE_INTERRUPTS(1),
	.NUM_INTERRUPTS(32)
)
i_sub_core_001
(
	.clk(i_sub_core_001_clk),
	.rstnn(i_sub_core_001_rstnn),
	.interrupt_vector(i_sub_core_001_interrupt_vector),
	.interrupt_out(i_sub_core_001_interrupt_out),
	.sxawready(i_sub_core_001_sxawready),
	.sxawvalid(i_sub_core_001_sxawvalid),
	.sxawaddr(i_sub_core_001_sxawaddr),
	.sxawid(i_sub_core_001_sxawid),
	.sxawlen(i_sub_core_001_sxawlen),
	.sxawsize(i_sub_core_001_sxawsize),
	.sxawburst(i_sub_core_001_sxawburst),
	.sxwready(i_sub_core_001_sxwready),
	.sxwvalid(i_sub_core_001_sxwvalid),
	.sxwid(i_sub_core_001_sxwid),
	.sxwdata(i_sub_core_001_sxwdata),
	.sxwstrb(i_sub_core_001_sxwstrb),
	.sxwlast(i_sub_core_001_sxwlast),
	.sxbready(i_sub_core_001_sxbready),
	.sxbvalid(i_sub_core_001_sxbvalid),
	.sxbid(i_sub_core_001_sxbid),
	.sxbresp(i_sub_core_001_sxbresp),
	.sxarready(i_sub_core_001_sxarready),
	.sxarvalid(i_sub_core_001_sxarvalid),
	.sxaraddr(i_sub_core_001_sxaraddr),
	.sxarid(i_sub_core_001_sxarid),
	.sxarlen(i_sub_core_001_sxarlen),
	.sxarsize(i_sub_core_001_sxarsize),
	.sxarburst(i_sub_core_001_sxarburst),
	.sxrready(i_sub_core_001_sxrready),
	.sxrvalid(i_sub_core_001_sxrvalid),
	.sxrid(i_sub_core_001_sxrid),
	.sxrdata(i_sub_core_001_sxrdata),
	.sxrlast(i_sub_core_001_sxrlast),
	.sxrresp(i_sub_core_001_sxrresp),
	.spc(i_sub_core_001_spc),
	.sinst(i_sub_core_001_sinst)
);

RVC_ROCKET_OPT
#(
	.ENABLE_INTERRUPTS(1),
	.NUM_INTERRUPTS(32)
)
i_sub_core_002
(
	.clk(i_sub_core_002_clk),
	.rstnn(i_sub_core_002_rstnn),
	.interrupt_vector(i_sub_core_002_interrupt_vector),
	.interrupt_out(i_sub_core_002_interrupt_out),
	.sxawready(i_sub_core_002_sxawready),
	.sxawvalid(i_sub_core_002_sxawvalid),
	.sxawaddr(i_sub_core_002_sxawaddr),
	.sxawid(i_sub_core_002_sxawid),
	.sxawlen(i_sub_core_002_sxawlen),
	.sxawsize(i_sub_core_002_sxawsize),
	.sxawburst(i_sub_core_002_sxawburst),
	.sxwready(i_sub_core_002_sxwready),
	.sxwvalid(i_sub_core_002_sxwvalid),
	.sxwid(i_sub_core_002_sxwid),
	.sxwdata(i_sub_core_002_sxwdata),
	.sxwstrb(i_sub_core_002_sxwstrb),
	.sxwlast(i_sub_core_002_sxwlast),
	.sxbready(i_sub_core_002_sxbready),
	.sxbvalid(i_sub_core_002_sxbvalid),
	.sxbid(i_sub_core_002_sxbid),
	.sxbresp(i_sub_core_002_sxbresp),
	.sxarready(i_sub_core_002_sxarready),
	.sxarvalid(i_sub_core_002_sxarvalid),
	.sxaraddr(i_sub_core_002_sxaraddr),
	.sxarid(i_sub_core_002_sxarid),
	.sxarlen(i_sub_core_002_sxarlen),
	.sxarsize(i_sub_core_002_sxarsize),
	.sxarburst(i_sub_core_002_sxarburst),
	.sxrready(i_sub_core_002_sxrready),
	.sxrvalid(i_sub_core_002_sxrvalid),
	.sxrid(i_sub_core_002_sxrid),
	.sxrdata(i_sub_core_002_sxrdata),
	.sxrlast(i_sub_core_002_sxrlast),
	.sxrresp(i_sub_core_002_sxrresp),
	.spc(i_sub_core_002_spc),
	.sinst(i_sub_core_002_sinst)
);

RVC_ROCKET_OPT
#(
	.ENABLE_INTERRUPTS(1),
	.NUM_INTERRUPTS(32)
)
i_sub_core_003
(
	.clk(i_sub_core_003_clk),
	.rstnn(i_sub_core_003_rstnn),
	.interrupt_vector(i_sub_core_003_interrupt_vector),
	.interrupt_out(i_sub_core_003_interrupt_out),
	.sxawready(i_sub_core_003_sxawready),
	.sxawvalid(i_sub_core_003_sxawvalid),
	.sxawaddr(i_sub_core_003_sxawaddr),
	.sxawid(i_sub_core_003_sxawid),
	.sxawlen(i_sub_core_003_sxawlen),
	.sxawsize(i_sub_core_003_sxawsize),
	.sxawburst(i_sub_core_003_sxawburst),
	.sxwready(i_sub_core_003_sxwready),
	.sxwvalid(i_sub_core_003_sxwvalid),
	.sxwid(i_sub_core_003_sxwid),
	.sxwdata(i_sub_core_003_sxwdata),
	.sxwstrb(i_sub_core_003_sxwstrb),
	.sxwlast(i_sub_core_003_sxwlast),
	.sxbready(i_sub_core_003_sxbready),
	.sxbvalid(i_sub_core_003_sxbvalid),
	.sxbid(i_sub_core_003_sxbid),
	.sxbresp(i_sub_core_003_sxbresp),
	.sxarready(i_sub_core_003_sxarready),
	.sxarvalid(i_sub_core_003_sxarvalid),
	.sxaraddr(i_sub_core_003_sxaraddr),
	.sxarid(i_sub_core_003_sxarid),
	.sxarlen(i_sub_core_003_sxarlen),
	.sxarsize(i_sub_core_003_sxarsize),
	.sxarburst(i_sub_core_003_sxarburst),
	.sxrready(i_sub_core_003_sxrready),
	.sxrvalid(i_sub_core_003_sxrvalid),
	.sxrid(i_sub_core_003_sxrid),
	.sxrdata(i_sub_core_003_sxrdata),
	.sxrlast(i_sub_core_003_sxrlast),
	.sxrresp(i_sub_core_003_sxrresp),
	.spc(i_sub_core_003_spc),
	.sinst(i_sub_core_003_sinst)
);

ERVP_COMMON_PERI_GROUP
#(
	.BW_ADDR(32),
	.BW_DATA(32),
	.NUM_LOCK(5),
	.NUM_GLOBAL_TAG(1),
	.NUM_AUTO_ID(1)
)
common_peri_group
(
	.clk(common_peri_group_clk),
	.rstnn(common_peri_group_rstnn),
	.lock_status_list(common_peri_group_lock_status_list),
	.thread_status_list(common_peri_group_thread_status_list),
	.real_clock(common_peri_group_real_clock),
	.global_tag_list(common_peri_group_global_tag_list),
	.system_tick_config(common_peri_group_system_tick_config),
	.core_tick_config(common_peri_group_core_tick_config),
	.rpsel(common_peri_group_rpsel),
	.rpenable(common_peri_group_rpenable),
	.rpwrite(common_peri_group_rpwrite),
	.rpaddr(common_peri_group_rpaddr),
	.rpwdata(common_peri_group_rpwdata),
	.rpready(common_peri_group_rpready),
	.rprdata(common_peri_group_rprdata),
	.rpslverr(common_peri_group_rpslverr)
);

ERVP_TICK_GENERATOR
autoname_103
(
	.clk(autoname_103_clk),
	.rstnn(autoname_103_rstnn),
	.tick_config(autoname_103_tick_config),
	.tick_1us(autoname_103_tick_1us),
	.tick_62d5ms(autoname_103_tick_62d5ms)
);

ERVP_REAL_CLOCK
autoname_105
(
	.clk(autoname_105_clk),
	.rstnn(autoname_105_rstnn),
	.tick_1us(autoname_105_tick_1us),
	.real_clock(autoname_105_real_clock)
);

ERVP_EXTERNAL_PERI_GROUP
#(
	.BW_ADDR(32),
	.BW_DATA(32),
	.NUM_UART(1),
	.NUM_SPI(1),
	.NUM_I2C(0),
	.NUM_GPIO(0),
	.NUM_AIOIF(0)
)
external_peri_group
(
	.clk(external_peri_group_clk),
	.rstnn(external_peri_group_rstnn),
	.tick_1us(external_peri_group_tick_1us),
	.tick_gpio(external_peri_group_tick_gpio),
	.uart_interrupts(external_peri_group_uart_interrupts),
	.spi_interrupt(external_peri_group_spi_interrupt),
	.i2c_interrupts(external_peri_group_i2c_interrupts),
	.gpio_interrupts(external_peri_group_gpio_interrupts),
	.wifi_interrupt(external_peri_group_wifi_interrupt),
	.spi_common_sclk(external_peri_group_spi_common_sclk),
	.spi_common_sdq0(external_peri_group_spi_common_sdq0),
	.rpsel(external_peri_group_rpsel),
	.rpenable(external_peri_group_rpenable),
	.rpwrite(external_peri_group_rpwrite),
	.rpaddr(external_peri_group_rpaddr),
	.rpwdata(external_peri_group_rpwdata),
	.rpready(external_peri_group_rpready),
	.rprdata(external_peri_group_rprdata),
	.rpslverr(external_peri_group_rpslverr),
	.uart_stx_list(external_peri_group_uart_stx_list),
	.uart_srx_list(external_peri_group_uart_srx_list),
	.spi_sclk_list(external_peri_group_spi_sclk_list),
	.spi_scs_list(external_peri_group_spi_scs_list),
	.spi_sdq0_list(external_peri_group_spi_sdq0_list),
	.spi_sdq1_list(external_peri_group_spi_sdq1_list),
	.oled_sdcsel_oe(external_peri_group_oled_sdcsel_oe),
	.oled_sdcsel_oval(external_peri_group_oled_sdcsel_oval),
	.oled_sdcsel_ival(external_peri_group_oled_sdcsel_ival),
	.oled_srstnn_oe(external_peri_group_oled_srstnn_oe),
	.oled_srstnn_oval(external_peri_group_oled_srstnn_oval),
	.oled_srstnn_ival(external_peri_group_oled_srstnn_ival),
	.oled_svbat_oe(external_peri_group_oled_svbat_oe),
	.oled_svbat_oval(external_peri_group_oled_svbat_oval),
	.oled_svbat_ival(external_peri_group_oled_svbat_ival),
	.oled_svdd_oe(external_peri_group_oled_svdd_oe),
	.oled_svdd_oval(external_peri_group_oled_svdd_oval),
	.oled_svdd_ival(external_peri_group_oled_svdd_ival),
	.wifi_sitr(external_peri_group_wifi_sitr),
	.wifi_srstnn(external_peri_group_wifi_srstnn),
	.wifi_swp(external_peri_group_wifi_swp),
	.wifi_shibernate(external_peri_group_wifi_shibernate)
);

ERVP_CORE_PERI_GROUP
#(
	.BW_ADDR(32),
	.BW_DATA(32),
	.PROCESS_ID(0),
	.NUM_LOCK(5),
	.NUM_GLOBAL_TAG(1)
)
core_peri_group
(
	.clk(core_peri_group_clk),
	.rstnn(core_peri_group_rstnn),
	.tick_1us(core_peri_group_tick_1us),
	.delay_notice(core_peri_group_delay_notice),
	.plic_interrupt(core_peri_group_plic_interrupt),
	.lock_status_list(core_peri_group_lock_status_list),
	.global_tag_list(core_peri_group_global_tag_list),
	.thread_status_list(core_peri_group_thread_status_list),
	.core_interrupt_vector(core_peri_group_core_interrupt_vector),
	.allows_holds(core_peri_group_allows_holds),
	.rpsel(core_peri_group_rpsel),
	.rpenable(core_peri_group_rpenable),
	.rpwrite(core_peri_group_rpwrite),
	.rpaddr(core_peri_group_rpaddr),
	.rpwdata(core_peri_group_rpwdata),
	.rpready(core_peri_group_rpready),
	.rprdata(core_peri_group_rprdata),
	.rpslverr(core_peri_group_rpslverr),
	.tcu_spsel(core_peri_group_tcu_spsel),
	.tcu_spenable(core_peri_group_tcu_spenable),
	.tcu_spwrite(core_peri_group_tcu_spwrite),
	.tcu_spaddr(core_peri_group_tcu_spaddr),
	.tcu_spwdata(core_peri_group_tcu_spwdata),
	.tcu_spready(core_peri_group_tcu_spready),
	.tcu_sprdata(core_peri_group_tcu_sprdata),
	.tcu_spslverr(core_peri_group_tcu_spslverr),
	.florian_spsel(core_peri_group_florian_spsel),
	.florian_spenable(core_peri_group_florian_spenable),
	.florian_spwrite(core_peri_group_florian_spwrite),
	.florian_spaddr(core_peri_group_florian_spaddr),
	.florian_spwdata(core_peri_group_florian_spwdata),
	.florian_spready(core_peri_group_florian_spready),
	.florian_sprdata(core_peri_group_florian_sprdata),
	.florian_spslverr(core_peri_group_florian_spslverr)
);

ERVP_CORE_PERI_GROUP
#(
	.BW_ADDR(32),
	.BW_DATA(32),
	.PROCESS_ID(1),
	.NUM_LOCK(5),
	.NUM_GLOBAL_TAG(1)
)
autoname_106
(
	.clk(autoname_106_clk),
	.rstnn(autoname_106_rstnn),
	.tick_1us(autoname_106_tick_1us),
	.delay_notice(autoname_106_delay_notice),
	.plic_interrupt(autoname_106_plic_interrupt),
	.lock_status_list(autoname_106_lock_status_list),
	.global_tag_list(autoname_106_global_tag_list),
	.thread_status_list(autoname_106_thread_status_list),
	.core_interrupt_vector(autoname_106_core_interrupt_vector),
	.allows_holds(autoname_106_allows_holds),
	.rpsel(autoname_106_rpsel),
	.rpenable(autoname_106_rpenable),
	.rpwrite(autoname_106_rpwrite),
	.rpaddr(autoname_106_rpaddr),
	.rpwdata(autoname_106_rpwdata),
	.rpready(autoname_106_rpready),
	.rprdata(autoname_106_rprdata),
	.rpslverr(autoname_106_rpslverr),
	.tcu_spsel(autoname_106_tcu_spsel),
	.tcu_spenable(autoname_106_tcu_spenable),
	.tcu_spwrite(autoname_106_tcu_spwrite),
	.tcu_spaddr(autoname_106_tcu_spaddr),
	.tcu_spwdata(autoname_106_tcu_spwdata),
	.tcu_spready(autoname_106_tcu_spready),
	.tcu_sprdata(autoname_106_tcu_sprdata),
	.tcu_spslverr(autoname_106_tcu_spslverr),
	.florian_spsel(autoname_106_florian_spsel),
	.florian_spenable(autoname_106_florian_spenable),
	.florian_spwrite(autoname_106_florian_spwrite),
	.florian_spaddr(autoname_106_florian_spaddr),
	.florian_spwdata(autoname_106_florian_spwdata),
	.florian_spready(autoname_106_florian_spready),
	.florian_sprdata(autoname_106_florian_sprdata),
	.florian_spslverr(autoname_106_florian_spslverr)
);

ERVP_CORE_PERI_GROUP
#(
	.BW_ADDR(32),
	.BW_DATA(32),
	.PROCESS_ID(2),
	.NUM_LOCK(5),
	.NUM_GLOBAL_TAG(1)
)
autoname_107
(
	.clk(autoname_107_clk),
	.rstnn(autoname_107_rstnn),
	.tick_1us(autoname_107_tick_1us),
	.delay_notice(autoname_107_delay_notice),
	.plic_interrupt(autoname_107_plic_interrupt),
	.lock_status_list(autoname_107_lock_status_list),
	.global_tag_list(autoname_107_global_tag_list),
	.thread_status_list(autoname_107_thread_status_list),
	.core_interrupt_vector(autoname_107_core_interrupt_vector),
	.allows_holds(autoname_107_allows_holds),
	.rpsel(autoname_107_rpsel),
	.rpenable(autoname_107_rpenable),
	.rpwrite(autoname_107_rpwrite),
	.rpaddr(autoname_107_rpaddr),
	.rpwdata(autoname_107_rpwdata),
	.rpready(autoname_107_rpready),
	.rprdata(autoname_107_rprdata),
	.rpslverr(autoname_107_rpslverr),
	.tcu_spsel(autoname_107_tcu_spsel),
	.tcu_spenable(autoname_107_tcu_spenable),
	.tcu_spwrite(autoname_107_tcu_spwrite),
	.tcu_spaddr(autoname_107_tcu_spaddr),
	.tcu_spwdata(autoname_107_tcu_spwdata),
	.tcu_spready(autoname_107_tcu_spready),
	.tcu_sprdata(autoname_107_tcu_sprdata),
	.tcu_spslverr(autoname_107_tcu_spslverr),
	.florian_spsel(autoname_107_florian_spsel),
	.florian_spenable(autoname_107_florian_spenable),
	.florian_spwrite(autoname_107_florian_spwrite),
	.florian_spaddr(autoname_107_florian_spaddr),
	.florian_spwdata(autoname_107_florian_spwdata),
	.florian_spready(autoname_107_florian_spready),
	.florian_sprdata(autoname_107_florian_sprdata),
	.florian_spslverr(autoname_107_florian_spslverr)
);

ERVP_CORE_PERI_GROUP
#(
	.BW_ADDR(32),
	.BW_DATA(32),
	.PROCESS_ID(3),
	.NUM_LOCK(5),
	.NUM_GLOBAL_TAG(1)
)
autoname_108
(
	.clk(autoname_108_clk),
	.rstnn(autoname_108_rstnn),
	.tick_1us(autoname_108_tick_1us),
	.delay_notice(autoname_108_delay_notice),
	.plic_interrupt(autoname_108_plic_interrupt),
	.lock_status_list(autoname_108_lock_status_list),
	.global_tag_list(autoname_108_global_tag_list),
	.thread_status_list(autoname_108_thread_status_list),
	.core_interrupt_vector(autoname_108_core_interrupt_vector),
	.allows_holds(autoname_108_allows_holds),
	.rpsel(autoname_108_rpsel),
	.rpenable(autoname_108_rpenable),
	.rpwrite(autoname_108_rpwrite),
	.rpaddr(autoname_108_rpaddr),
	.rpwdata(autoname_108_rpwdata),
	.rpready(autoname_108_rpready),
	.rprdata(autoname_108_rprdata),
	.rpslverr(autoname_108_rpslverr),
	.tcu_spsel(autoname_108_tcu_spsel),
	.tcu_spenable(autoname_108_tcu_spenable),
	.tcu_spwrite(autoname_108_tcu_spwrite),
	.tcu_spaddr(autoname_108_tcu_spaddr),
	.tcu_spwdata(autoname_108_tcu_spwdata),
	.tcu_spready(autoname_108_tcu_spready),
	.tcu_sprdata(autoname_108_tcu_sprdata),
	.tcu_spslverr(autoname_108_tcu_spslverr),
	.florian_spsel(autoname_108_florian_spsel),
	.florian_spenable(autoname_108_florian_spenable),
	.florian_spwrite(autoname_108_florian_spwrite),
	.florian_spaddr(autoname_108_florian_spaddr),
	.florian_spwdata(autoname_108_florian_spwdata),
	.florian_spready(autoname_108_florian_spready),
	.florian_sprdata(autoname_108_florian_sprdata),
	.florian_spslverr(autoname_108_florian_spslverr)
);

ERVP_PLATFORM_CONTROLLER
#(
	.BW_ADDR(32),
	.NUM_CORE(4),
	.NUM_RESET(10),
	.NUM_AUTO_RESET(5)
)
platform_controller
(
	.clk(platform_controller_clk),
	.external_rstnn(platform_controller_external_rstnn),
	.global_rstnn(platform_controller_global_rstnn),
	.global_rstpp(platform_controller_global_rstpp),
	.rstnn_seqeunce(platform_controller_rstnn_seqeunce),
	.rstpp_seqeunce(platform_controller_rstpp_seqeunce),
	.boot_mode(platform_controller_boot_mode),
	.jtag_select(platform_controller_jtag_select),
	.initialized(platform_controller_initialized),
	.app_finished(platform_controller_app_finished),
	.rstnn(platform_controller_rstnn),
	.shready(platform_controller_shready),
	.shaddr(platform_controller_shaddr),
	.shburst(platform_controller_shburst),
	.shmasterlock(platform_controller_shmasterlock),
	.shprot(platform_controller_shprot),
	.shsize(platform_controller_shsize),
	.shtrans(platform_controller_shtrans),
	.shwrite(platform_controller_shwrite),
	.shwdata(platform_controller_shwdata),
	.shrdata(platform_controller_shrdata),
	.shresp(platform_controller_shresp),
	.rpsel(platform_controller_rpsel),
	.rpenable(platform_controller_rpenable),
	.rpwrite(platform_controller_rpwrite),
	.rpaddr(platform_controller_rpaddr),
	.rpwdata(platform_controller_rpwdata),
	.rpready(platform_controller_rpready),
	.rprdata(platform_controller_rprdata),
	.rpslverr(platform_controller_rpslverr),
	.pjtag_rtck(platform_controller_pjtag_rtck),
	.pjtag_rtrstnn(platform_controller_pjtag_rtrstnn),
	.pjtag_rtms(platform_controller_pjtag_rtms),
	.pjtag_rtdi(platform_controller_pjtag_rtdi),
	.pjtag_rtdo(platform_controller_pjtag_rtdo),
	.noc_debug_spsel(platform_controller_noc_debug_spsel),
	.noc_debug_spenable(platform_controller_noc_debug_spenable),
	.noc_debug_spwrite(platform_controller_noc_debug_spwrite),
	.noc_debug_spaddr(platform_controller_noc_debug_spaddr),
	.noc_debug_spwdata(platform_controller_noc_debug_spwdata),
	.noc_debug_spready(platform_controller_noc_debug_spready),
	.noc_debug_sprdata(platform_controller_noc_debug_sprdata),
	.noc_debug_spslverr(platform_controller_noc_debug_spslverr),
	.rpc_list(platform_controller_rpc_list),
	.rinst_list(platform_controller_rinst_list)
);

MUNOC_DEFAULT_SNIM
#(
	.NODE_ID(`NODE_ID_DEFAULT_SLAVE),
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT),
	.BW_PLATFORM_ADDR(32),
	.USE_SW_INTERFACE(1),
	.USE_JTAG_INTERFACE(1),
	.NOC_CONTROLLER_BASEADDR(`NOC_CONTROLLER_BASEADDR)
)
default_slave
(
	.clk_network(default_slave_clk_network),
	.rstnn_network(default_slave_rstnn_network),
	.clk_debug(default_slave_clk_debug),
	.rstnn_debug(default_slave_rstnn_debug),
	.comm_disable(default_slave_comm_disable),
	.rfni_link(default_slave_rfni_link),
	.rfni_ready(default_slave_rfni_ready),
	.rbni_link(default_slave_rbni_link),
	.rbni_ready(default_slave_rbni_ready),
	.debug_rpsel(default_slave_debug_rpsel),
	.debug_rpenable(default_slave_debug_rpenable),
	.debug_rpwrite(default_slave_debug_rpwrite),
	.debug_rpaddr(default_slave_debug_rpaddr),
	.debug_rpwdata(default_slave_debug_rpwdata),
	.debug_rpready(default_slave_debug_rpready),
	.debug_rprdata(default_slave_debug_rprdata),
	.debug_rpslverr(default_slave_debug_rpslverr),
	.svri_rlink(default_slave_svri_rlink),
	.svri_rack(default_slave_svri_rack),
	.svri_slink(default_slave_svri_slink),
	.svri_sack(default_slave_svri_sack)
);

ERVP_MMIOX1_INTERFACE
#(
	.BW_CONFIG(1),
	.BW_INST(512),
	.LOG_FIFO_DEPTH(0),
	.INPUT_FIFO_DEPTH(0),
	.OUTPUT_FIFO_DEPTH(0)
)
i_dca_matrix_conv00_control_mmiox1_interface
(
	.clk_mmio(i_dca_matrix_conv00_control_mmiox1_interface_clk_mmio),
	.rstnn_mmio(i_dca_matrix_conv00_control_mmiox1_interface_rstnn_mmio),
	.interrupt_list(i_dca_matrix_conv00_control_mmiox1_interface_interrupt_list),
	.clk_acc(i_dca_matrix_conv00_control_mmiox1_interface_clk_acc),
	.rstnn_acc(i_dca_matrix_conv00_control_mmiox1_interface_rstnn_acc),
	.mmio_rpsel(i_dca_matrix_conv00_control_mmiox1_interface_mmio_rpsel),
	.mmio_rpenable(i_dca_matrix_conv00_control_mmiox1_interface_mmio_rpenable),
	.mmio_rpwrite(i_dca_matrix_conv00_control_mmiox1_interface_mmio_rpwrite),
	.mmio_rpaddr(i_dca_matrix_conv00_control_mmiox1_interface_mmio_rpaddr),
	.mmio_rpwdata(i_dca_matrix_conv00_control_mmiox1_interface_mmio_rpwdata),
	.mmio_rpready(i_dca_matrix_conv00_control_mmiox1_interface_mmio_rpready),
	.mmio_rprdata(i_dca_matrix_conv00_control_mmiox1_interface_mmio_rprdata),
	.mmio_rpslverr(i_dca_matrix_conv00_control_mmiox1_interface_mmio_rpslverr),
	.smx_core_config(i_dca_matrix_conv00_control_mmiox1_interface_smx_core_config),
	.smx_core_status(i_dca_matrix_conv00_control_mmiox1_interface_smx_core_status),
	.smx_clear_request(i_dca_matrix_conv00_control_mmiox1_interface_smx_clear_request),
	.smx_clear_finish(i_dca_matrix_conv00_control_mmiox1_interface_smx_clear_finish),
	.smx_log_fifo_wready(i_dca_matrix_conv00_control_mmiox1_interface_smx_log_fifo_wready),
	.smx_log_fifo_wrequest(i_dca_matrix_conv00_control_mmiox1_interface_smx_log_fifo_wrequest),
	.smx_log_fifo_wdata(i_dca_matrix_conv00_control_mmiox1_interface_smx_log_fifo_wdata),
	.smx_inst_fifo_rready(i_dca_matrix_conv00_control_mmiox1_interface_smx_inst_fifo_rready),
	.smx_inst_fifo_rdata(i_dca_matrix_conv00_control_mmiox1_interface_smx_inst_fifo_rdata),
	.smx_inst_fifo_rrequest(i_dca_matrix_conv00_control_mmiox1_interface_smx_inst_fifo_rrequest),
	.smx_operation_finish(i_dca_matrix_conv00_control_mmiox1_interface_smx_operation_finish),
	.smx_input_fifo_rready(i_dca_matrix_conv00_control_mmiox1_interface_smx_input_fifo_rready),
	.smx_input_fifo_rdata(i_dca_matrix_conv00_control_mmiox1_interface_smx_input_fifo_rdata),
	.smx_input_fifo_rrequest(i_dca_matrix_conv00_control_mmiox1_interface_smx_input_fifo_rrequest),
	.smx_output_fifo_wready(i_dca_matrix_conv00_control_mmiox1_interface_smx_output_fifo_wready),
	.smx_output_fifo_wrequest(i_dca_matrix_conv00_control_mmiox1_interface_smx_output_fifo_wrequest),
	.smx_output_fifo_wdata(i_dca_matrix_conv00_control_mmiox1_interface_smx_output_fifo_wdata)
);

ERVP_MMIOX1_INTERFACE
#(
	.BW_CONFIG(1),
	.BW_INST(512),
	.LOG_FIFO_DEPTH(0),
	.INPUT_FIFO_DEPTH(0),
	.OUTPUT_FIFO_DEPTH(0)
)
i_dca_matrix_mac00_control_mmiox1_interface
(
	.clk_mmio(i_dca_matrix_mac00_control_mmiox1_interface_clk_mmio),
	.rstnn_mmio(i_dca_matrix_mac00_control_mmiox1_interface_rstnn_mmio),
	.interrupt_list(i_dca_matrix_mac00_control_mmiox1_interface_interrupt_list),
	.clk_acc(i_dca_matrix_mac00_control_mmiox1_interface_clk_acc),
	.rstnn_acc(i_dca_matrix_mac00_control_mmiox1_interface_rstnn_acc),
	.mmio_rpsel(i_dca_matrix_mac00_control_mmiox1_interface_mmio_rpsel),
	.mmio_rpenable(i_dca_matrix_mac00_control_mmiox1_interface_mmio_rpenable),
	.mmio_rpwrite(i_dca_matrix_mac00_control_mmiox1_interface_mmio_rpwrite),
	.mmio_rpaddr(i_dca_matrix_mac00_control_mmiox1_interface_mmio_rpaddr),
	.mmio_rpwdata(i_dca_matrix_mac00_control_mmiox1_interface_mmio_rpwdata),
	.mmio_rpready(i_dca_matrix_mac00_control_mmiox1_interface_mmio_rpready),
	.mmio_rprdata(i_dca_matrix_mac00_control_mmiox1_interface_mmio_rprdata),
	.mmio_rpslverr(i_dca_matrix_mac00_control_mmiox1_interface_mmio_rpslverr),
	.smx_core_config(i_dca_matrix_mac00_control_mmiox1_interface_smx_core_config),
	.smx_core_status(i_dca_matrix_mac00_control_mmiox1_interface_smx_core_status),
	.smx_clear_request(i_dca_matrix_mac00_control_mmiox1_interface_smx_clear_request),
	.smx_clear_finish(i_dca_matrix_mac00_control_mmiox1_interface_smx_clear_finish),
	.smx_log_fifo_wready(i_dca_matrix_mac00_control_mmiox1_interface_smx_log_fifo_wready),
	.smx_log_fifo_wrequest(i_dca_matrix_mac00_control_mmiox1_interface_smx_log_fifo_wrequest),
	.smx_log_fifo_wdata(i_dca_matrix_mac00_control_mmiox1_interface_smx_log_fifo_wdata),
	.smx_inst_fifo_rready(i_dca_matrix_mac00_control_mmiox1_interface_smx_inst_fifo_rready),
	.smx_inst_fifo_rdata(i_dca_matrix_mac00_control_mmiox1_interface_smx_inst_fifo_rdata),
	.smx_inst_fifo_rrequest(i_dca_matrix_mac00_control_mmiox1_interface_smx_inst_fifo_rrequest),
	.smx_operation_finish(i_dca_matrix_mac00_control_mmiox1_interface_smx_operation_finish),
	.smx_input_fifo_rready(i_dca_matrix_mac00_control_mmiox1_interface_smx_input_fifo_rready),
	.smx_input_fifo_rdata(i_dca_matrix_mac00_control_mmiox1_interface_smx_input_fifo_rdata),
	.smx_input_fifo_rrequest(i_dca_matrix_mac00_control_mmiox1_interface_smx_input_fifo_rrequest),
	.smx_output_fifo_wready(i_dca_matrix_mac00_control_mmiox1_interface_smx_output_fifo_wready),
	.smx_output_fifo_wrequest(i_dca_matrix_mac00_control_mmiox1_interface_smx_output_fifo_wrequest),
	.smx_output_fifo_wdata(i_dca_matrix_mac00_control_mmiox1_interface_smx_output_fifo_wdata)
);

ERVP_MATRIX_LSU
#(
	.BW_AXI_DATA(128),
	.LSU_PARA(MAKE_LSU_READ_ONLY(0)),
	.BW_TENSOR_SCALAR(32),
	.MATRIX_NUM_COL(22)
)
i_dca_matrix_conv00_mi_mlsu
(
	.clk(i_dca_matrix_conv00_mi_mlsu_clk),
	.rstnn(i_dca_matrix_conv00_mi_mlsu_rstnn),
	.rinst_wvalid(i_dca_matrix_conv00_mi_mlsu_rinst_wvalid),
	.rinst_wdata(i_dca_matrix_conv00_mi_mlsu_rinst_wdata),
	.rinst_wready(i_dca_matrix_conv00_mi_mlsu_rinst_wready),
	.rinst_decode_finish(i_dca_matrix_conv00_mi_mlsu_rinst_decode_finish),
	.rinst_execute_finish(i_dca_matrix_conv00_mi_mlsu_rinst_execute_finish),
	.rinst_busy(i_dca_matrix_conv00_mi_mlsu_rinst_busy),
	.rload_tensor_row_wvalid(i_dca_matrix_conv00_mi_mlsu_rload_tensor_row_wvalid),
	.rload_tensor_row_wlast(i_dca_matrix_conv00_mi_mlsu_rload_tensor_row_wlast),
	.rload_tensor_row_wdata(i_dca_matrix_conv00_mi_mlsu_rload_tensor_row_wdata),
	.rload_tensor_row_wready(i_dca_matrix_conv00_mi_mlsu_rload_tensor_row_wready),
	.rstore_tensor_row_rvalid(i_dca_matrix_conv00_mi_mlsu_rstore_tensor_row_rvalid),
	.rstore_tensor_row_rlast(i_dca_matrix_conv00_mi_mlsu_rstore_tensor_row_rlast),
	.rstore_tensor_row_rready(i_dca_matrix_conv00_mi_mlsu_rstore_tensor_row_rready),
	.rstore_tensor_row_rdata(i_dca_matrix_conv00_mi_mlsu_rstore_tensor_row_rdata),
	.slxqdready(i_dca_matrix_conv00_mi_mlsu_slxqdready),
	.slxqvalid(i_dca_matrix_conv00_mi_mlsu_slxqvalid),
	.slxqlast(i_dca_matrix_conv00_mi_mlsu_slxqlast),
	.slxqwrite(i_dca_matrix_conv00_mi_mlsu_slxqwrite),
	.slxqlen(i_dca_matrix_conv00_mi_mlsu_slxqlen),
	.slxqsize(i_dca_matrix_conv00_mi_mlsu_slxqsize),
	.slxqburst(i_dca_matrix_conv00_mi_mlsu_slxqburst),
	.slxqwstrb(i_dca_matrix_conv00_mi_mlsu_slxqwstrb),
	.slxqwdata(i_dca_matrix_conv00_mi_mlsu_slxqwdata),
	.slxqaddr(i_dca_matrix_conv00_mi_mlsu_slxqaddr),
	.slxqburden(i_dca_matrix_conv00_mi_mlsu_slxqburden),
	.slxydready(i_dca_matrix_conv00_mi_mlsu_slxydready),
	.slxyvalid(i_dca_matrix_conv00_mi_mlsu_slxyvalid),
	.slxylast(i_dca_matrix_conv00_mi_mlsu_slxylast),
	.slxywreply(i_dca_matrix_conv00_mi_mlsu_slxywreply),
	.slxyresp(i_dca_matrix_conv00_mi_mlsu_slxyresp),
	.slxyrdata(i_dca_matrix_conv00_mi_mlsu_slxyrdata),
	.slxyburden(i_dca_matrix_conv00_mi_mlsu_slxyburden)
);

ERVP_MATRIX_LSU
#(
	.BW_AXI_DATA(128),
	.LSU_PARA(MAKE_LSU_READ_ONLY(0)),
	.BW_TENSOR_SCALAR(32),
	.MATRIX_NUM_COL(7)
)
i_dca_matrix_conv00_mk_mlsu
(
	.clk(i_dca_matrix_conv00_mk_mlsu_clk),
	.rstnn(i_dca_matrix_conv00_mk_mlsu_rstnn),
	.rinst_wvalid(i_dca_matrix_conv00_mk_mlsu_rinst_wvalid),
	.rinst_wdata(i_dca_matrix_conv00_mk_mlsu_rinst_wdata),
	.rinst_wready(i_dca_matrix_conv00_mk_mlsu_rinst_wready),
	.rinst_decode_finish(i_dca_matrix_conv00_mk_mlsu_rinst_decode_finish),
	.rinst_execute_finish(i_dca_matrix_conv00_mk_mlsu_rinst_execute_finish),
	.rinst_busy(i_dca_matrix_conv00_mk_mlsu_rinst_busy),
	.rload_tensor_row_wvalid(i_dca_matrix_conv00_mk_mlsu_rload_tensor_row_wvalid),
	.rload_tensor_row_wlast(i_dca_matrix_conv00_mk_mlsu_rload_tensor_row_wlast),
	.rload_tensor_row_wdata(i_dca_matrix_conv00_mk_mlsu_rload_tensor_row_wdata),
	.rload_tensor_row_wready(i_dca_matrix_conv00_mk_mlsu_rload_tensor_row_wready),
	.rstore_tensor_row_rvalid(i_dca_matrix_conv00_mk_mlsu_rstore_tensor_row_rvalid),
	.rstore_tensor_row_rlast(i_dca_matrix_conv00_mk_mlsu_rstore_tensor_row_rlast),
	.rstore_tensor_row_rready(i_dca_matrix_conv00_mk_mlsu_rstore_tensor_row_rready),
	.rstore_tensor_row_rdata(i_dca_matrix_conv00_mk_mlsu_rstore_tensor_row_rdata),
	.slxqdready(i_dca_matrix_conv00_mk_mlsu_slxqdready),
	.slxqvalid(i_dca_matrix_conv00_mk_mlsu_slxqvalid),
	.slxqlast(i_dca_matrix_conv00_mk_mlsu_slxqlast),
	.slxqwrite(i_dca_matrix_conv00_mk_mlsu_slxqwrite),
	.slxqlen(i_dca_matrix_conv00_mk_mlsu_slxqlen),
	.slxqsize(i_dca_matrix_conv00_mk_mlsu_slxqsize),
	.slxqburst(i_dca_matrix_conv00_mk_mlsu_slxqburst),
	.slxqwstrb(i_dca_matrix_conv00_mk_mlsu_slxqwstrb),
	.slxqwdata(i_dca_matrix_conv00_mk_mlsu_slxqwdata),
	.slxqaddr(i_dca_matrix_conv00_mk_mlsu_slxqaddr),
	.slxqburden(i_dca_matrix_conv00_mk_mlsu_slxqburden),
	.slxydready(i_dca_matrix_conv00_mk_mlsu_slxydready),
	.slxyvalid(i_dca_matrix_conv00_mk_mlsu_slxyvalid),
	.slxylast(i_dca_matrix_conv00_mk_mlsu_slxylast),
	.slxywreply(i_dca_matrix_conv00_mk_mlsu_slxywreply),
	.slxyresp(i_dca_matrix_conv00_mk_mlsu_slxyresp),
	.slxyrdata(i_dca_matrix_conv00_mk_mlsu_slxyrdata),
	.slxyburden(i_dca_matrix_conv00_mk_mlsu_slxyburden)
);

ERVP_MATRIX_LSU
#(
	.BW_AXI_DATA(128),
	.LSU_PARA(MAKE_LSU_WRITE_ONLY(0)),
	.BW_TENSOR_SCALAR(32),
	.MATRIX_NUM_COL(16)
)
i_dca_matrix_conv00_mo_mlsu
(
	.clk(i_dca_matrix_conv00_mo_mlsu_clk),
	.rstnn(i_dca_matrix_conv00_mo_mlsu_rstnn),
	.rinst_wvalid(i_dca_matrix_conv00_mo_mlsu_rinst_wvalid),
	.rinst_wdata(i_dca_matrix_conv00_mo_mlsu_rinst_wdata),
	.rinst_wready(i_dca_matrix_conv00_mo_mlsu_rinst_wready),
	.rinst_decode_finish(i_dca_matrix_conv00_mo_mlsu_rinst_decode_finish),
	.rinst_execute_finish(i_dca_matrix_conv00_mo_mlsu_rinst_execute_finish),
	.rinst_busy(i_dca_matrix_conv00_mo_mlsu_rinst_busy),
	.rload_tensor_row_wvalid(i_dca_matrix_conv00_mo_mlsu_rload_tensor_row_wvalid),
	.rload_tensor_row_wlast(i_dca_matrix_conv00_mo_mlsu_rload_tensor_row_wlast),
	.rload_tensor_row_wdata(i_dca_matrix_conv00_mo_mlsu_rload_tensor_row_wdata),
	.rload_tensor_row_wready(i_dca_matrix_conv00_mo_mlsu_rload_tensor_row_wready),
	.rstore_tensor_row_rvalid(i_dca_matrix_conv00_mo_mlsu_rstore_tensor_row_rvalid),
	.rstore_tensor_row_rlast(i_dca_matrix_conv00_mo_mlsu_rstore_tensor_row_rlast),
	.rstore_tensor_row_rready(i_dca_matrix_conv00_mo_mlsu_rstore_tensor_row_rready),
	.rstore_tensor_row_rdata(i_dca_matrix_conv00_mo_mlsu_rstore_tensor_row_rdata),
	.slxqdready(i_dca_matrix_conv00_mo_mlsu_slxqdready),
	.slxqvalid(i_dca_matrix_conv00_mo_mlsu_slxqvalid),
	.slxqlast(i_dca_matrix_conv00_mo_mlsu_slxqlast),
	.slxqwrite(i_dca_matrix_conv00_mo_mlsu_slxqwrite),
	.slxqlen(i_dca_matrix_conv00_mo_mlsu_slxqlen),
	.slxqsize(i_dca_matrix_conv00_mo_mlsu_slxqsize),
	.slxqburst(i_dca_matrix_conv00_mo_mlsu_slxqburst),
	.slxqwstrb(i_dca_matrix_conv00_mo_mlsu_slxqwstrb),
	.slxqwdata(i_dca_matrix_conv00_mo_mlsu_slxqwdata),
	.slxqaddr(i_dca_matrix_conv00_mo_mlsu_slxqaddr),
	.slxqburden(i_dca_matrix_conv00_mo_mlsu_slxqburden),
	.slxydready(i_dca_matrix_conv00_mo_mlsu_slxydready),
	.slxyvalid(i_dca_matrix_conv00_mo_mlsu_slxyvalid),
	.slxylast(i_dca_matrix_conv00_mo_mlsu_slxylast),
	.slxywreply(i_dca_matrix_conv00_mo_mlsu_slxywreply),
	.slxyresp(i_dca_matrix_conv00_mo_mlsu_slxyresp),
	.slxyrdata(i_dca_matrix_conv00_mo_mlsu_slxyrdata),
	.slxyburden(i_dca_matrix_conv00_mo_mlsu_slxyburden)
);

ERVP_MATRIX_LSU
#(
	.BW_AXI_DATA(128),
	.LSU_PARA(MAKE_LSU_READ_ONLY(0)),
	.BW_TENSOR_SCALAR(32),
	.MATRIX_NUM_COL(8)
)
i_dca_matrix_mac00_ma_mlsu
(
	.clk(i_dca_matrix_mac00_ma_mlsu_clk),
	.rstnn(i_dca_matrix_mac00_ma_mlsu_rstnn),
	.rinst_wvalid(i_dca_matrix_mac00_ma_mlsu_rinst_wvalid),
	.rinst_wdata(i_dca_matrix_mac00_ma_mlsu_rinst_wdata),
	.rinst_wready(i_dca_matrix_mac00_ma_mlsu_rinst_wready),
	.rinst_decode_finish(i_dca_matrix_mac00_ma_mlsu_rinst_decode_finish),
	.rinst_execute_finish(i_dca_matrix_mac00_ma_mlsu_rinst_execute_finish),
	.rinst_busy(i_dca_matrix_mac00_ma_mlsu_rinst_busy),
	.rload_tensor_row_wvalid(i_dca_matrix_mac00_ma_mlsu_rload_tensor_row_wvalid),
	.rload_tensor_row_wlast(i_dca_matrix_mac00_ma_mlsu_rload_tensor_row_wlast),
	.rload_tensor_row_wdata(i_dca_matrix_mac00_ma_mlsu_rload_tensor_row_wdata),
	.rload_tensor_row_wready(i_dca_matrix_mac00_ma_mlsu_rload_tensor_row_wready),
	.rstore_tensor_row_rvalid(i_dca_matrix_mac00_ma_mlsu_rstore_tensor_row_rvalid),
	.rstore_tensor_row_rlast(i_dca_matrix_mac00_ma_mlsu_rstore_tensor_row_rlast),
	.rstore_tensor_row_rready(i_dca_matrix_mac00_ma_mlsu_rstore_tensor_row_rready),
	.rstore_tensor_row_rdata(i_dca_matrix_mac00_ma_mlsu_rstore_tensor_row_rdata),
	.slxqdready(i_dca_matrix_mac00_ma_mlsu_slxqdready),
	.slxqvalid(i_dca_matrix_mac00_ma_mlsu_slxqvalid),
	.slxqlast(i_dca_matrix_mac00_ma_mlsu_slxqlast),
	.slxqwrite(i_dca_matrix_mac00_ma_mlsu_slxqwrite),
	.slxqlen(i_dca_matrix_mac00_ma_mlsu_slxqlen),
	.slxqsize(i_dca_matrix_mac00_ma_mlsu_slxqsize),
	.slxqburst(i_dca_matrix_mac00_ma_mlsu_slxqburst),
	.slxqwstrb(i_dca_matrix_mac00_ma_mlsu_slxqwstrb),
	.slxqwdata(i_dca_matrix_mac00_ma_mlsu_slxqwdata),
	.slxqaddr(i_dca_matrix_mac00_ma_mlsu_slxqaddr),
	.slxqburden(i_dca_matrix_mac00_ma_mlsu_slxqburden),
	.slxydready(i_dca_matrix_mac00_ma_mlsu_slxydready),
	.slxyvalid(i_dca_matrix_mac00_ma_mlsu_slxyvalid),
	.slxylast(i_dca_matrix_mac00_ma_mlsu_slxylast),
	.slxywreply(i_dca_matrix_mac00_ma_mlsu_slxywreply),
	.slxyresp(i_dca_matrix_mac00_ma_mlsu_slxyresp),
	.slxyrdata(i_dca_matrix_mac00_ma_mlsu_slxyrdata),
	.slxyburden(i_dca_matrix_mac00_ma_mlsu_slxyburden)
);

ERVP_MATRIX_LSU
#(
	.BW_AXI_DATA(128),
	.LSU_PARA(MAKE_LSU_READ_ONLY(0)),
	.BW_TENSOR_SCALAR(32),
	.MATRIX_NUM_COL(8)
)
i_dca_matrix_mac00_mb_mlsu
(
	.clk(i_dca_matrix_mac00_mb_mlsu_clk),
	.rstnn(i_dca_matrix_mac00_mb_mlsu_rstnn),
	.rinst_wvalid(i_dca_matrix_mac00_mb_mlsu_rinst_wvalid),
	.rinst_wdata(i_dca_matrix_mac00_mb_mlsu_rinst_wdata),
	.rinst_wready(i_dca_matrix_mac00_mb_mlsu_rinst_wready),
	.rinst_decode_finish(i_dca_matrix_mac00_mb_mlsu_rinst_decode_finish),
	.rinst_execute_finish(i_dca_matrix_mac00_mb_mlsu_rinst_execute_finish),
	.rinst_busy(i_dca_matrix_mac00_mb_mlsu_rinst_busy),
	.rload_tensor_row_wvalid(i_dca_matrix_mac00_mb_mlsu_rload_tensor_row_wvalid),
	.rload_tensor_row_wlast(i_dca_matrix_mac00_mb_mlsu_rload_tensor_row_wlast),
	.rload_tensor_row_wdata(i_dca_matrix_mac00_mb_mlsu_rload_tensor_row_wdata),
	.rload_tensor_row_wready(i_dca_matrix_mac00_mb_mlsu_rload_tensor_row_wready),
	.rstore_tensor_row_rvalid(i_dca_matrix_mac00_mb_mlsu_rstore_tensor_row_rvalid),
	.rstore_tensor_row_rlast(i_dca_matrix_mac00_mb_mlsu_rstore_tensor_row_rlast),
	.rstore_tensor_row_rready(i_dca_matrix_mac00_mb_mlsu_rstore_tensor_row_rready),
	.rstore_tensor_row_rdata(i_dca_matrix_mac00_mb_mlsu_rstore_tensor_row_rdata),
	.slxqdready(i_dca_matrix_mac00_mb_mlsu_slxqdready),
	.slxqvalid(i_dca_matrix_mac00_mb_mlsu_slxqvalid),
	.slxqlast(i_dca_matrix_mac00_mb_mlsu_slxqlast),
	.slxqwrite(i_dca_matrix_mac00_mb_mlsu_slxqwrite),
	.slxqlen(i_dca_matrix_mac00_mb_mlsu_slxqlen),
	.slxqsize(i_dca_matrix_mac00_mb_mlsu_slxqsize),
	.slxqburst(i_dca_matrix_mac00_mb_mlsu_slxqburst),
	.slxqwstrb(i_dca_matrix_mac00_mb_mlsu_slxqwstrb),
	.slxqwdata(i_dca_matrix_mac00_mb_mlsu_slxqwdata),
	.slxqaddr(i_dca_matrix_mac00_mb_mlsu_slxqaddr),
	.slxqburden(i_dca_matrix_mac00_mb_mlsu_slxqburden),
	.slxydready(i_dca_matrix_mac00_mb_mlsu_slxydready),
	.slxyvalid(i_dca_matrix_mac00_mb_mlsu_slxyvalid),
	.slxylast(i_dca_matrix_mac00_mb_mlsu_slxylast),
	.slxywreply(i_dca_matrix_mac00_mb_mlsu_slxywreply),
	.slxyresp(i_dca_matrix_mac00_mb_mlsu_slxyresp),
	.slxyrdata(i_dca_matrix_mac00_mb_mlsu_slxyrdata),
	.slxyburden(i_dca_matrix_mac00_mb_mlsu_slxyburden)
);

ERVP_MATRIX_LSU
#(
	.BW_AXI_DATA(128),
	.BW_TENSOR_SCALAR(32),
	.MATRIX_NUM_COL(8)
)
i_dca_matrix_mac00_mc_mlsu
(
	.clk(i_dca_matrix_mac00_mc_mlsu_clk),
	.rstnn(i_dca_matrix_mac00_mc_mlsu_rstnn),
	.rinst_wvalid(i_dca_matrix_mac00_mc_mlsu_rinst_wvalid),
	.rinst_wdata(i_dca_matrix_mac00_mc_mlsu_rinst_wdata),
	.rinst_wready(i_dca_matrix_mac00_mc_mlsu_rinst_wready),
	.rinst_decode_finish(i_dca_matrix_mac00_mc_mlsu_rinst_decode_finish),
	.rinst_execute_finish(i_dca_matrix_mac00_mc_mlsu_rinst_execute_finish),
	.rinst_busy(i_dca_matrix_mac00_mc_mlsu_rinst_busy),
	.rload_tensor_row_wvalid(i_dca_matrix_mac00_mc_mlsu_rload_tensor_row_wvalid),
	.rload_tensor_row_wlast(i_dca_matrix_mac00_mc_mlsu_rload_tensor_row_wlast),
	.rload_tensor_row_wdata(i_dca_matrix_mac00_mc_mlsu_rload_tensor_row_wdata),
	.rload_tensor_row_wready(i_dca_matrix_mac00_mc_mlsu_rload_tensor_row_wready),
	.rstore_tensor_row_rvalid(i_dca_matrix_mac00_mc_mlsu_rstore_tensor_row_rvalid),
	.rstore_tensor_row_rlast(i_dca_matrix_mac00_mc_mlsu_rstore_tensor_row_rlast),
	.rstore_tensor_row_rready(i_dca_matrix_mac00_mc_mlsu_rstore_tensor_row_rready),
	.rstore_tensor_row_rdata(i_dca_matrix_mac00_mc_mlsu_rstore_tensor_row_rdata),
	.slxqdready(i_dca_matrix_mac00_mc_mlsu_slxqdready),
	.slxqvalid(i_dca_matrix_mac00_mc_mlsu_slxqvalid),
	.slxqlast(i_dca_matrix_mac00_mc_mlsu_slxqlast),
	.slxqwrite(i_dca_matrix_mac00_mc_mlsu_slxqwrite),
	.slxqlen(i_dca_matrix_mac00_mc_mlsu_slxqlen),
	.slxqsize(i_dca_matrix_mac00_mc_mlsu_slxqsize),
	.slxqburst(i_dca_matrix_mac00_mc_mlsu_slxqburst),
	.slxqwstrb(i_dca_matrix_mac00_mc_mlsu_slxqwstrb),
	.slxqwdata(i_dca_matrix_mac00_mc_mlsu_slxqwdata),
	.slxqaddr(i_dca_matrix_mac00_mc_mlsu_slxqaddr),
	.slxqburden(i_dca_matrix_mac00_mc_mlsu_slxqburden),
	.slxydready(i_dca_matrix_mac00_mc_mlsu_slxydready),
	.slxyvalid(i_dca_matrix_mac00_mc_mlsu_slxyvalid),
	.slxylast(i_dca_matrix_mac00_mc_mlsu_slxylast),
	.slxywreply(i_dca_matrix_mac00_mc_mlsu_slxywreply),
	.slxyresp(i_dca_matrix_mac00_mc_mlsu_slxyresp),
	.slxyrdata(i_dca_matrix_mac00_mc_mlsu_slxyrdata),
	.slxyburden(i_dca_matrix_mac00_mc_mlsu_slxyburden)
);

MUNOC_INTER_ROUTER_FIFO
#(
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT)
)
i_inter_router_fifo00
(
	.clk(i_inter_router_fifo00_clk),
	.rstnn(i_inter_router_fifo00_rstnn),
	.rfni_link(i_inter_router_fifo00_rfni_link),
	.rfni_ready(i_inter_router_fifo00_rfni_ready),
	.rbni_link(i_inter_router_fifo00_rbni_link),
	.rbni_ready(i_inter_router_fifo00_rbni_ready),
	.sfni_link(i_inter_router_fifo00_sfni_link),
	.sfni_ready(i_inter_router_fifo00_sfni_ready),
	.sbni_link(i_inter_router_fifo00_sbni_link),
	.sbni_ready(i_inter_router_fifo00_sbni_ready)
);

MUNOC_INTER_ROUTER_FIFO
#(
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT)
)
i_inter_router_fifo01
(
	.clk(i_inter_router_fifo01_clk),
	.rstnn(i_inter_router_fifo01_rstnn),
	.rfni_link(i_inter_router_fifo01_rfni_link),
	.rfni_ready(i_inter_router_fifo01_rfni_ready),
	.rbni_link(i_inter_router_fifo01_rbni_link),
	.rbni_ready(i_inter_router_fifo01_rbni_ready),
	.sfni_link(i_inter_router_fifo01_sfni_link),
	.sfni_ready(i_inter_router_fifo01_sfni_ready),
	.sbni_link(i_inter_router_fifo01_sbni_link),
	.sbni_ready(i_inter_router_fifo01_sbni_ready)
);

MUNOC_INTER_ROUTER_FIFO
#(
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT)
)
i_inter_router_fifo02
(
	.clk(i_inter_router_fifo02_clk),
	.rstnn(i_inter_router_fifo02_rstnn),
	.rfni_link(i_inter_router_fifo02_rfni_link),
	.rfni_ready(i_inter_router_fifo02_rfni_ready),
	.rbni_link(i_inter_router_fifo02_rbni_link),
	.rbni_ready(i_inter_router_fifo02_rbni_ready),
	.sfni_link(i_inter_router_fifo02_sfni_link),
	.sfni_ready(i_inter_router_fifo02_sfni_ready),
	.sbni_link(i_inter_router_fifo02_sbni_link),
	.sbni_ready(i_inter_router_fifo02_sbni_ready)
);

MUNOC_AXI_MASTER_NETWORK_INTERFACE_MODULE_ASYNCH
#(
	.NODE_ID(`NODE_ID_I_MNIM_I_MAIN_CORE_NO_NAME),
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT),
	.BW_PLATFORM_ADDR(32),
	.BW_NODE_DATA(32),
	.LOCAL_ENABLE(1),
	.LOCAL_UPPER_ADDR(4'h F),
	.NAME("i_main_core_no_name"),
	.BW_AXI_MASTER_TID(4)
)
i_mnim_i_main_core_no_name
(
	.clk_network(i_mnim_i_main_core_no_name_clk_network),
	.rstnn_network(i_mnim_i_main_core_no_name_rstnn_network),
	.clk_master(i_mnim_i_main_core_no_name_clk_master),
	.rstnn_master(i_mnim_i_main_core_no_name_rstnn_master),
	.comm_disable(i_mnim_i_main_core_no_name_comm_disable),
	.local_allows_holds(i_mnim_i_main_core_no_name_local_allows_holds),
	.rxawready(i_mnim_i_main_core_no_name_rxawready),
	.rxawvalid(i_mnim_i_main_core_no_name_rxawvalid),
	.rxawaddr(i_mnim_i_main_core_no_name_rxawaddr),
	.rxawid(i_mnim_i_main_core_no_name_rxawid),
	.rxawlen(i_mnim_i_main_core_no_name_rxawlen),
	.rxawsize(i_mnim_i_main_core_no_name_rxawsize),
	.rxawburst(i_mnim_i_main_core_no_name_rxawburst),
	.rxwready(i_mnim_i_main_core_no_name_rxwready),
	.rxwvalid(i_mnim_i_main_core_no_name_rxwvalid),
	.rxwid(i_mnim_i_main_core_no_name_rxwid),
	.rxwdata(i_mnim_i_main_core_no_name_rxwdata),
	.rxwstrb(i_mnim_i_main_core_no_name_rxwstrb),
	.rxwlast(i_mnim_i_main_core_no_name_rxwlast),
	.rxbready(i_mnim_i_main_core_no_name_rxbready),
	.rxbvalid(i_mnim_i_main_core_no_name_rxbvalid),
	.rxbid(i_mnim_i_main_core_no_name_rxbid),
	.rxbresp(i_mnim_i_main_core_no_name_rxbresp),
	.rxarready(i_mnim_i_main_core_no_name_rxarready),
	.rxarvalid(i_mnim_i_main_core_no_name_rxarvalid),
	.rxaraddr(i_mnim_i_main_core_no_name_rxaraddr),
	.rxarid(i_mnim_i_main_core_no_name_rxarid),
	.rxarlen(i_mnim_i_main_core_no_name_rxarlen),
	.rxarsize(i_mnim_i_main_core_no_name_rxarsize),
	.rxarburst(i_mnim_i_main_core_no_name_rxarburst),
	.rxrready(i_mnim_i_main_core_no_name_rxrready),
	.rxrvalid(i_mnim_i_main_core_no_name_rxrvalid),
	.rxrid(i_mnim_i_main_core_no_name_rxrid),
	.rxrdata(i_mnim_i_main_core_no_name_rxrdata),
	.rxrlast(i_mnim_i_main_core_no_name_rxrlast),
	.rxrresp(i_mnim_i_main_core_no_name_rxrresp),
	.sfni_link(i_mnim_i_main_core_no_name_sfni_link),
	.sfni_ready(i_mnim_i_main_core_no_name_sfni_ready),
	.sbni_link(i_mnim_i_main_core_no_name_sbni_link),
	.sbni_ready(i_mnim_i_main_core_no_name_sbni_ready),
	.svri_rlink(i_mnim_i_main_core_no_name_svri_rlink),
	.svri_rack(i_mnim_i_main_core_no_name_svri_rack),
	.svri_slink(i_mnim_i_main_core_no_name_svri_slink),
	.svri_sack(i_mnim_i_main_core_no_name_svri_sack),
	.local_spsel(i_mnim_i_main_core_no_name_local_spsel),
	.local_spenable(i_mnim_i_main_core_no_name_local_spenable),
	.local_spwrite(i_mnim_i_main_core_no_name_local_spwrite),
	.local_spaddr(i_mnim_i_main_core_no_name_local_spaddr),
	.local_spwdata(i_mnim_i_main_core_no_name_local_spwdata),
	.local_spready(i_mnim_i_main_core_no_name_local_spready),
	.local_sprdata(i_mnim_i_main_core_no_name_local_sprdata),
	.local_spslverr(i_mnim_i_main_core_no_name_local_spslverr)
);

MUNOC_AXI_MASTER_NETWORK_INTERFACE_MODULE_ASYNCH
#(
	.NODE_ID(`NODE_ID_I_MNIM_I_SUB_CORE_001_NO_NAME),
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT),
	.BW_PLATFORM_ADDR(32),
	.BW_NODE_DATA(32),
	.LOCAL_ENABLE(1),
	.LOCAL_UPPER_ADDR(4'h F),
	.NAME("i_sub_core_001_no_name"),
	.BW_AXI_MASTER_TID(4)
)
i_mnim_i_sub_core_001_no_name
(
	.clk_network(i_mnim_i_sub_core_001_no_name_clk_network),
	.rstnn_network(i_mnim_i_sub_core_001_no_name_rstnn_network),
	.clk_master(i_mnim_i_sub_core_001_no_name_clk_master),
	.rstnn_master(i_mnim_i_sub_core_001_no_name_rstnn_master),
	.comm_disable(i_mnim_i_sub_core_001_no_name_comm_disable),
	.local_allows_holds(i_mnim_i_sub_core_001_no_name_local_allows_holds),
	.rxawready(i_mnim_i_sub_core_001_no_name_rxawready),
	.rxawvalid(i_mnim_i_sub_core_001_no_name_rxawvalid),
	.rxawaddr(i_mnim_i_sub_core_001_no_name_rxawaddr),
	.rxawid(i_mnim_i_sub_core_001_no_name_rxawid),
	.rxawlen(i_mnim_i_sub_core_001_no_name_rxawlen),
	.rxawsize(i_mnim_i_sub_core_001_no_name_rxawsize),
	.rxawburst(i_mnim_i_sub_core_001_no_name_rxawburst),
	.rxwready(i_mnim_i_sub_core_001_no_name_rxwready),
	.rxwvalid(i_mnim_i_sub_core_001_no_name_rxwvalid),
	.rxwid(i_mnim_i_sub_core_001_no_name_rxwid),
	.rxwdata(i_mnim_i_sub_core_001_no_name_rxwdata),
	.rxwstrb(i_mnim_i_sub_core_001_no_name_rxwstrb),
	.rxwlast(i_mnim_i_sub_core_001_no_name_rxwlast),
	.rxbready(i_mnim_i_sub_core_001_no_name_rxbready),
	.rxbvalid(i_mnim_i_sub_core_001_no_name_rxbvalid),
	.rxbid(i_mnim_i_sub_core_001_no_name_rxbid),
	.rxbresp(i_mnim_i_sub_core_001_no_name_rxbresp),
	.rxarready(i_mnim_i_sub_core_001_no_name_rxarready),
	.rxarvalid(i_mnim_i_sub_core_001_no_name_rxarvalid),
	.rxaraddr(i_mnim_i_sub_core_001_no_name_rxaraddr),
	.rxarid(i_mnim_i_sub_core_001_no_name_rxarid),
	.rxarlen(i_mnim_i_sub_core_001_no_name_rxarlen),
	.rxarsize(i_mnim_i_sub_core_001_no_name_rxarsize),
	.rxarburst(i_mnim_i_sub_core_001_no_name_rxarburst),
	.rxrready(i_mnim_i_sub_core_001_no_name_rxrready),
	.rxrvalid(i_mnim_i_sub_core_001_no_name_rxrvalid),
	.rxrid(i_mnim_i_sub_core_001_no_name_rxrid),
	.rxrdata(i_mnim_i_sub_core_001_no_name_rxrdata),
	.rxrlast(i_mnim_i_sub_core_001_no_name_rxrlast),
	.rxrresp(i_mnim_i_sub_core_001_no_name_rxrresp),
	.sfni_link(i_mnim_i_sub_core_001_no_name_sfni_link),
	.sfni_ready(i_mnim_i_sub_core_001_no_name_sfni_ready),
	.sbni_link(i_mnim_i_sub_core_001_no_name_sbni_link),
	.sbni_ready(i_mnim_i_sub_core_001_no_name_sbni_ready),
	.svri_rlink(i_mnim_i_sub_core_001_no_name_svri_rlink),
	.svri_rack(i_mnim_i_sub_core_001_no_name_svri_rack),
	.svri_slink(i_mnim_i_sub_core_001_no_name_svri_slink),
	.svri_sack(i_mnim_i_sub_core_001_no_name_svri_sack),
	.local_spsel(i_mnim_i_sub_core_001_no_name_local_spsel),
	.local_spenable(i_mnim_i_sub_core_001_no_name_local_spenable),
	.local_spwrite(i_mnim_i_sub_core_001_no_name_local_spwrite),
	.local_spaddr(i_mnim_i_sub_core_001_no_name_local_spaddr),
	.local_spwdata(i_mnim_i_sub_core_001_no_name_local_spwdata),
	.local_spready(i_mnim_i_sub_core_001_no_name_local_spready),
	.local_sprdata(i_mnim_i_sub_core_001_no_name_local_sprdata),
	.local_spslverr(i_mnim_i_sub_core_001_no_name_local_spslverr)
);

MUNOC_AXI_MASTER_NETWORK_INTERFACE_MODULE_ASYNCH
#(
	.NODE_ID(`NODE_ID_I_MNIM_I_SUB_CORE_002_NO_NAME),
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT),
	.BW_PLATFORM_ADDR(32),
	.BW_NODE_DATA(32),
	.LOCAL_ENABLE(1),
	.LOCAL_UPPER_ADDR(4'h F),
	.NAME("i_sub_core_002_no_name"),
	.BW_AXI_MASTER_TID(4)
)
i_mnim_i_sub_core_002_no_name
(
	.clk_network(i_mnim_i_sub_core_002_no_name_clk_network),
	.rstnn_network(i_mnim_i_sub_core_002_no_name_rstnn_network),
	.clk_master(i_mnim_i_sub_core_002_no_name_clk_master),
	.rstnn_master(i_mnim_i_sub_core_002_no_name_rstnn_master),
	.comm_disable(i_mnim_i_sub_core_002_no_name_comm_disable),
	.local_allows_holds(i_mnim_i_sub_core_002_no_name_local_allows_holds),
	.rxawready(i_mnim_i_sub_core_002_no_name_rxawready),
	.rxawvalid(i_mnim_i_sub_core_002_no_name_rxawvalid),
	.rxawaddr(i_mnim_i_sub_core_002_no_name_rxawaddr),
	.rxawid(i_mnim_i_sub_core_002_no_name_rxawid),
	.rxawlen(i_mnim_i_sub_core_002_no_name_rxawlen),
	.rxawsize(i_mnim_i_sub_core_002_no_name_rxawsize),
	.rxawburst(i_mnim_i_sub_core_002_no_name_rxawburst),
	.rxwready(i_mnim_i_sub_core_002_no_name_rxwready),
	.rxwvalid(i_mnim_i_sub_core_002_no_name_rxwvalid),
	.rxwid(i_mnim_i_sub_core_002_no_name_rxwid),
	.rxwdata(i_mnim_i_sub_core_002_no_name_rxwdata),
	.rxwstrb(i_mnim_i_sub_core_002_no_name_rxwstrb),
	.rxwlast(i_mnim_i_sub_core_002_no_name_rxwlast),
	.rxbready(i_mnim_i_sub_core_002_no_name_rxbready),
	.rxbvalid(i_mnim_i_sub_core_002_no_name_rxbvalid),
	.rxbid(i_mnim_i_sub_core_002_no_name_rxbid),
	.rxbresp(i_mnim_i_sub_core_002_no_name_rxbresp),
	.rxarready(i_mnim_i_sub_core_002_no_name_rxarready),
	.rxarvalid(i_mnim_i_sub_core_002_no_name_rxarvalid),
	.rxaraddr(i_mnim_i_sub_core_002_no_name_rxaraddr),
	.rxarid(i_mnim_i_sub_core_002_no_name_rxarid),
	.rxarlen(i_mnim_i_sub_core_002_no_name_rxarlen),
	.rxarsize(i_mnim_i_sub_core_002_no_name_rxarsize),
	.rxarburst(i_mnim_i_sub_core_002_no_name_rxarburst),
	.rxrready(i_mnim_i_sub_core_002_no_name_rxrready),
	.rxrvalid(i_mnim_i_sub_core_002_no_name_rxrvalid),
	.rxrid(i_mnim_i_sub_core_002_no_name_rxrid),
	.rxrdata(i_mnim_i_sub_core_002_no_name_rxrdata),
	.rxrlast(i_mnim_i_sub_core_002_no_name_rxrlast),
	.rxrresp(i_mnim_i_sub_core_002_no_name_rxrresp),
	.sfni_link(i_mnim_i_sub_core_002_no_name_sfni_link),
	.sfni_ready(i_mnim_i_sub_core_002_no_name_sfni_ready),
	.sbni_link(i_mnim_i_sub_core_002_no_name_sbni_link),
	.sbni_ready(i_mnim_i_sub_core_002_no_name_sbni_ready),
	.svri_rlink(i_mnim_i_sub_core_002_no_name_svri_rlink),
	.svri_rack(i_mnim_i_sub_core_002_no_name_svri_rack),
	.svri_slink(i_mnim_i_sub_core_002_no_name_svri_slink),
	.svri_sack(i_mnim_i_sub_core_002_no_name_svri_sack),
	.local_spsel(i_mnim_i_sub_core_002_no_name_local_spsel),
	.local_spenable(i_mnim_i_sub_core_002_no_name_local_spenable),
	.local_spwrite(i_mnim_i_sub_core_002_no_name_local_spwrite),
	.local_spaddr(i_mnim_i_sub_core_002_no_name_local_spaddr),
	.local_spwdata(i_mnim_i_sub_core_002_no_name_local_spwdata),
	.local_spready(i_mnim_i_sub_core_002_no_name_local_spready),
	.local_sprdata(i_mnim_i_sub_core_002_no_name_local_sprdata),
	.local_spslverr(i_mnim_i_sub_core_002_no_name_local_spslverr)
);

MUNOC_AXI_MASTER_NETWORK_INTERFACE_MODULE_ASYNCH
#(
	.NODE_ID(`NODE_ID_I_MNIM_I_SUB_CORE_003_NO_NAME),
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT),
	.BW_PLATFORM_ADDR(32),
	.BW_NODE_DATA(32),
	.LOCAL_ENABLE(1),
	.LOCAL_UPPER_ADDR(4'h F),
	.NAME("i_sub_core_003_no_name"),
	.BW_AXI_MASTER_TID(4)
)
i_mnim_i_sub_core_003_no_name
(
	.clk_network(i_mnim_i_sub_core_003_no_name_clk_network),
	.rstnn_network(i_mnim_i_sub_core_003_no_name_rstnn_network),
	.clk_master(i_mnim_i_sub_core_003_no_name_clk_master),
	.rstnn_master(i_mnim_i_sub_core_003_no_name_rstnn_master),
	.comm_disable(i_mnim_i_sub_core_003_no_name_comm_disable),
	.local_allows_holds(i_mnim_i_sub_core_003_no_name_local_allows_holds),
	.rxawready(i_mnim_i_sub_core_003_no_name_rxawready),
	.rxawvalid(i_mnim_i_sub_core_003_no_name_rxawvalid),
	.rxawaddr(i_mnim_i_sub_core_003_no_name_rxawaddr),
	.rxawid(i_mnim_i_sub_core_003_no_name_rxawid),
	.rxawlen(i_mnim_i_sub_core_003_no_name_rxawlen),
	.rxawsize(i_mnim_i_sub_core_003_no_name_rxawsize),
	.rxawburst(i_mnim_i_sub_core_003_no_name_rxawburst),
	.rxwready(i_mnim_i_sub_core_003_no_name_rxwready),
	.rxwvalid(i_mnim_i_sub_core_003_no_name_rxwvalid),
	.rxwid(i_mnim_i_sub_core_003_no_name_rxwid),
	.rxwdata(i_mnim_i_sub_core_003_no_name_rxwdata),
	.rxwstrb(i_mnim_i_sub_core_003_no_name_rxwstrb),
	.rxwlast(i_mnim_i_sub_core_003_no_name_rxwlast),
	.rxbready(i_mnim_i_sub_core_003_no_name_rxbready),
	.rxbvalid(i_mnim_i_sub_core_003_no_name_rxbvalid),
	.rxbid(i_mnim_i_sub_core_003_no_name_rxbid),
	.rxbresp(i_mnim_i_sub_core_003_no_name_rxbresp),
	.rxarready(i_mnim_i_sub_core_003_no_name_rxarready),
	.rxarvalid(i_mnim_i_sub_core_003_no_name_rxarvalid),
	.rxaraddr(i_mnim_i_sub_core_003_no_name_rxaraddr),
	.rxarid(i_mnim_i_sub_core_003_no_name_rxarid),
	.rxarlen(i_mnim_i_sub_core_003_no_name_rxarlen),
	.rxarsize(i_mnim_i_sub_core_003_no_name_rxarsize),
	.rxarburst(i_mnim_i_sub_core_003_no_name_rxarburst),
	.rxrready(i_mnim_i_sub_core_003_no_name_rxrready),
	.rxrvalid(i_mnim_i_sub_core_003_no_name_rxrvalid),
	.rxrid(i_mnim_i_sub_core_003_no_name_rxrid),
	.rxrdata(i_mnim_i_sub_core_003_no_name_rxrdata),
	.rxrlast(i_mnim_i_sub_core_003_no_name_rxrlast),
	.rxrresp(i_mnim_i_sub_core_003_no_name_rxrresp),
	.sfni_link(i_mnim_i_sub_core_003_no_name_sfni_link),
	.sfni_ready(i_mnim_i_sub_core_003_no_name_sfni_ready),
	.sbni_link(i_mnim_i_sub_core_003_no_name_sbni_link),
	.sbni_ready(i_mnim_i_sub_core_003_no_name_sbni_ready),
	.svri_rlink(i_mnim_i_sub_core_003_no_name_svri_rlink),
	.svri_rack(i_mnim_i_sub_core_003_no_name_svri_rack),
	.svri_slink(i_mnim_i_sub_core_003_no_name_svri_slink),
	.svri_sack(i_mnim_i_sub_core_003_no_name_svri_sack),
	.local_spsel(i_mnim_i_sub_core_003_no_name_local_spsel),
	.local_spenable(i_mnim_i_sub_core_003_no_name_local_spenable),
	.local_spwrite(i_mnim_i_sub_core_003_no_name_local_spwrite),
	.local_spaddr(i_mnim_i_sub_core_003_no_name_local_spaddr),
	.local_spwdata(i_mnim_i_sub_core_003_no_name_local_spwdata),
	.local_spready(i_mnim_i_sub_core_003_no_name_local_spready),
	.local_sprdata(i_mnim_i_sub_core_003_no_name_local_sprdata),
	.local_spslverr(i_mnim_i_sub_core_003_no_name_local_spslverr)
);

MUNOC_AXI_SLAVE_NETWORK_INTERFACE_MODULE
#(
	.NODE_ID(`NODE_ID_I_SNIM_I_SYSTEM_SRAM_NO_NAME),
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT),
	.BW_PLATFORM_ADDR(32),
	.BW_NODE_DATA(32),
	.NAME("i_system_sram_no_name"),
	.BW_AXI_SLAVE_TID(`REQUIRED_BW_OF_SLAVE_TID)
)
i_snim_i_system_sram_no_name
(
	.clk(i_snim_i_system_sram_no_name_clk),
	.rstnn(i_snim_i_system_sram_no_name_rstnn),
	.comm_disable(i_snim_i_system_sram_no_name_comm_disable),
	.sxawready(i_snim_i_system_sram_no_name_sxawready),
	.sxawvalid(i_snim_i_system_sram_no_name_sxawvalid),
	.sxawaddr(i_snim_i_system_sram_no_name_sxawaddr),
	.sxawid(i_snim_i_system_sram_no_name_sxawid),
	.sxawlen(i_snim_i_system_sram_no_name_sxawlen),
	.sxawsize(i_snim_i_system_sram_no_name_sxawsize),
	.sxawburst(i_snim_i_system_sram_no_name_sxawburst),
	.sxwready(i_snim_i_system_sram_no_name_sxwready),
	.sxwvalid(i_snim_i_system_sram_no_name_sxwvalid),
	.sxwid(i_snim_i_system_sram_no_name_sxwid),
	.sxwdata(i_snim_i_system_sram_no_name_sxwdata),
	.sxwstrb(i_snim_i_system_sram_no_name_sxwstrb),
	.sxwlast(i_snim_i_system_sram_no_name_sxwlast),
	.sxbready(i_snim_i_system_sram_no_name_sxbready),
	.sxbvalid(i_snim_i_system_sram_no_name_sxbvalid),
	.sxbid(i_snim_i_system_sram_no_name_sxbid),
	.sxbresp(i_snim_i_system_sram_no_name_sxbresp),
	.sxarready(i_snim_i_system_sram_no_name_sxarready),
	.sxarvalid(i_snim_i_system_sram_no_name_sxarvalid),
	.sxaraddr(i_snim_i_system_sram_no_name_sxaraddr),
	.sxarid(i_snim_i_system_sram_no_name_sxarid),
	.sxarlen(i_snim_i_system_sram_no_name_sxarlen),
	.sxarsize(i_snim_i_system_sram_no_name_sxarsize),
	.sxarburst(i_snim_i_system_sram_no_name_sxarburst),
	.sxrready(i_snim_i_system_sram_no_name_sxrready),
	.sxrvalid(i_snim_i_system_sram_no_name_sxrvalid),
	.sxrid(i_snim_i_system_sram_no_name_sxrid),
	.sxrdata(i_snim_i_system_sram_no_name_sxrdata),
	.sxrlast(i_snim_i_system_sram_no_name_sxrlast),
	.sxrresp(i_snim_i_system_sram_no_name_sxrresp),
	.rfni_link(i_snim_i_system_sram_no_name_rfni_link),
	.rfni_ready(i_snim_i_system_sram_no_name_rfni_ready),
	.rbni_link(i_snim_i_system_sram_no_name_rbni_link),
	.rbni_ready(i_snim_i_system_sram_no_name_rbni_ready),
	.svri_rlink(i_snim_i_system_sram_no_name_svri_rlink),
	.svri_rack(i_snim_i_system_sram_no_name_svri_rack),
	.svri_slink(i_snim_i_system_sram_no_name_svri_slink),
	.svri_sack(i_snim_i_system_sram_no_name_svri_sack)
);

MUNOC_APB_SLAVE_NETWORK_INTERFACE_MODULE_ASYNCH
#(
	.NODE_ID(`NODE_ID_I_SNIM_COMMON_PERI_GROUP_NO_NAME),
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT),
	.BW_PLATFORM_ADDR(32),
	.BW_NODE_DATA(32),
	.NAME("common_peri_group_no_name")
)
i_snim_common_peri_group_no_name
(
	.clk_network(i_snim_common_peri_group_no_name_clk_network),
	.rstnn_network(i_snim_common_peri_group_no_name_rstnn_network),
	.clk_slave(i_snim_common_peri_group_no_name_clk_slave),
	.rstnn_slave(i_snim_common_peri_group_no_name_rstnn_slave),
	.comm_disable(i_snim_common_peri_group_no_name_comm_disable),
	.spsel(i_snim_common_peri_group_no_name_spsel),
	.spenable(i_snim_common_peri_group_no_name_spenable),
	.spwrite(i_snim_common_peri_group_no_name_spwrite),
	.spaddr(i_snim_common_peri_group_no_name_spaddr),
	.spwdata(i_snim_common_peri_group_no_name_spwdata),
	.spready(i_snim_common_peri_group_no_name_spready),
	.sprdata(i_snim_common_peri_group_no_name_sprdata),
	.spslverr(i_snim_common_peri_group_no_name_spslverr),
	.rfni_link(i_snim_common_peri_group_no_name_rfni_link),
	.rfni_ready(i_snim_common_peri_group_no_name_rfni_ready),
	.rbni_link(i_snim_common_peri_group_no_name_rbni_link),
	.rbni_ready(i_snim_common_peri_group_no_name_rbni_ready),
	.svri_rlink(i_snim_common_peri_group_no_name_svri_rlink),
	.svri_rack(i_snim_common_peri_group_no_name_svri_rack),
	.svri_slink(i_snim_common_peri_group_no_name_svri_slink),
	.svri_sack(i_snim_common_peri_group_no_name_svri_sack)
);

MUNOC_APB_SLAVE_NETWORK_INTERFACE_MODULE_ASYNCH
#(
	.NODE_ID(`NODE_ID_I_SNIM_EXTERNAL_PERI_GROUP_NO_NAME),
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT),
	.BW_PLATFORM_ADDR(32),
	.BW_NODE_DATA(32),
	.NAME("external_peri_group_no_name")
)
i_snim_external_peri_group_no_name
(
	.clk_network(i_snim_external_peri_group_no_name_clk_network),
	.rstnn_network(i_snim_external_peri_group_no_name_rstnn_network),
	.clk_slave(i_snim_external_peri_group_no_name_clk_slave),
	.rstnn_slave(i_snim_external_peri_group_no_name_rstnn_slave),
	.comm_disable(i_snim_external_peri_group_no_name_comm_disable),
	.spsel(i_snim_external_peri_group_no_name_spsel),
	.spenable(i_snim_external_peri_group_no_name_spenable),
	.spwrite(i_snim_external_peri_group_no_name_spwrite),
	.spaddr(i_snim_external_peri_group_no_name_spaddr),
	.spwdata(i_snim_external_peri_group_no_name_spwdata),
	.spready(i_snim_external_peri_group_no_name_spready),
	.sprdata(i_snim_external_peri_group_no_name_sprdata),
	.spslverr(i_snim_external_peri_group_no_name_spslverr),
	.rfni_link(i_snim_external_peri_group_no_name_rfni_link),
	.rfni_ready(i_snim_external_peri_group_no_name_rfni_ready),
	.rbni_link(i_snim_external_peri_group_no_name_rbni_link),
	.rbni_ready(i_snim_external_peri_group_no_name_rbni_ready),
	.svri_rlink(i_snim_external_peri_group_no_name_svri_rlink),
	.svri_rack(i_snim_external_peri_group_no_name_svri_rack),
	.svri_slink(i_snim_external_peri_group_no_name_svri_slink),
	.svri_sack(i_snim_external_peri_group_no_name_svri_sack)
);

MUNOC_APB_SLAVE_NETWORK_INTERFACE_MODULE_ASYNCH
#(
	.NODE_ID(`NODE_ID_I_SNIM_PLATFORM_CONTROLLER_NO_NAME),
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT),
	.BW_PLATFORM_ADDR(32),
	.BW_NODE_DATA(32),
	.NAME("platform_controller_no_name")
)
i_snim_platform_controller_no_name
(
	.clk_network(i_snim_platform_controller_no_name_clk_network),
	.rstnn_network(i_snim_platform_controller_no_name_rstnn_network),
	.clk_slave(i_snim_platform_controller_no_name_clk_slave),
	.rstnn_slave(i_snim_platform_controller_no_name_rstnn_slave),
	.comm_disable(i_snim_platform_controller_no_name_comm_disable),
	.spsel(i_snim_platform_controller_no_name_spsel),
	.spenable(i_snim_platform_controller_no_name_spenable),
	.spwrite(i_snim_platform_controller_no_name_spwrite),
	.spaddr(i_snim_platform_controller_no_name_spaddr),
	.spwdata(i_snim_platform_controller_no_name_spwdata),
	.spready(i_snim_platform_controller_no_name_spready),
	.sprdata(i_snim_platform_controller_no_name_sprdata),
	.spslverr(i_snim_platform_controller_no_name_spslverr),
	.rfni_link(i_snim_platform_controller_no_name_rfni_link),
	.rfni_ready(i_snim_platform_controller_no_name_rfni_ready),
	.rbni_link(i_snim_platform_controller_no_name_rbni_link),
	.rbni_ready(i_snim_platform_controller_no_name_rbni_ready),
	.svri_rlink(i_snim_platform_controller_no_name_svri_rlink),
	.svri_rack(i_snim_platform_controller_no_name_svri_rack),
	.svri_slink(i_snim_platform_controller_no_name_svri_slink),
	.svri_sack(i_snim_platform_controller_no_name_svri_sack)
);

MUNOC_APB_SLAVE_NETWORK_INTERFACE_MODULE_ASYNCH
#(
	.NODE_ID(`NODE_ID_I_SNIM_I_DCA_MATRIX_CONV00_CONTROL_MMIOX1_INTERFACE_MMIO),
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT),
	.BW_PLATFORM_ADDR(32),
	.BW_NODE_DATA(32),
	.NAME("i_dca_matrix_conv00_control_mmiox1_interface_mmio")
)
i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio
(
	.clk_network(i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_clk_network),
	.rstnn_network(i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_rstnn_network),
	.clk_slave(i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_clk_slave),
	.rstnn_slave(i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_rstnn_slave),
	.comm_disable(i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_comm_disable),
	.spsel(i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_spsel),
	.spenable(i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_spenable),
	.spwrite(i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_spwrite),
	.spaddr(i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_spaddr),
	.spwdata(i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_spwdata),
	.spready(i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_spready),
	.sprdata(i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_sprdata),
	.spslverr(i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_spslverr),
	.rfni_link(i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_rfni_link),
	.rfni_ready(i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_rfni_ready),
	.rbni_link(i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_rbni_link),
	.rbni_ready(i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_rbni_ready),
	.svri_rlink(i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_svri_rlink),
	.svri_rack(i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_svri_rack),
	.svri_slink(i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_svri_slink),
	.svri_sack(i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_svri_sack)
);

MUNOC_APB_SLAVE_NETWORK_INTERFACE_MODULE_ASYNCH
#(
	.NODE_ID(`NODE_ID_I_SNIM_I_DCA_MATRIX_MAC00_CONTROL_MMIOX1_INTERFACE_MMIO),
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT),
	.BW_PLATFORM_ADDR(32),
	.BW_NODE_DATA(32),
	.NAME("i_dca_matrix_mac00_control_mmiox1_interface_mmio")
)
i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio
(
	.clk_network(i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_clk_network),
	.rstnn_network(i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_rstnn_network),
	.clk_slave(i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_clk_slave),
	.rstnn_slave(i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_rstnn_slave),
	.comm_disable(i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_comm_disable),
	.spsel(i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_spsel),
	.spenable(i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_spenable),
	.spwrite(i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_spwrite),
	.spaddr(i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_spaddr),
	.spwdata(i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_spwdata),
	.spready(i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_spready),
	.sprdata(i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_sprdata),
	.spslverr(i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_spslverr),
	.rfni_link(i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_rfni_link),
	.rfni_ready(i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_rfni_ready),
	.rbni_link(i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_rbni_link),
	.rbni_ready(i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_rbni_ready),
	.svri_rlink(i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_svri_rlink),
	.svri_rack(i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_svri_rack),
	.svri_slink(i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_svri_slink),
	.svri_sack(i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_svri_sack)
);

MUNOC_AHB_MASTER_NETWORK_INTERFACE_MODULE_ASYNCH
#(
	.NODE_ID(`NODE_ID_I_MNIM_PLATFORM_CONTROLLER_MASTER),
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT),
	.BW_PLATFORM_ADDR(32),
	.BW_NODE_DATA(32),
	.NAME("platform_controller_master")
)
i_mnim_platform_controller_master
(
	.clk_network(i_mnim_platform_controller_master_clk_network),
	.rstnn_network(i_mnim_platform_controller_master_rstnn_network),
	.clk_master(i_mnim_platform_controller_master_clk_master),
	.rstnn_master(i_mnim_platform_controller_master_rstnn_master),
	.comm_disable(i_mnim_platform_controller_master_comm_disable),
	.rhready(i_mnim_platform_controller_master_rhready),
	.rhaddr(i_mnim_platform_controller_master_rhaddr),
	.rhburst(i_mnim_platform_controller_master_rhburst),
	.rhmasterlock(i_mnim_platform_controller_master_rhmasterlock),
	.rhprot(i_mnim_platform_controller_master_rhprot),
	.rhsize(i_mnim_platform_controller_master_rhsize),
	.rhtrans(i_mnim_platform_controller_master_rhtrans),
	.rhwrite(i_mnim_platform_controller_master_rhwrite),
	.rhwdata(i_mnim_platform_controller_master_rhwdata),
	.rhrdata(i_mnim_platform_controller_master_rhrdata),
	.rhresp(i_mnim_platform_controller_master_rhresp),
	.sfni_link(i_mnim_platform_controller_master_sfni_link),
	.sfni_ready(i_mnim_platform_controller_master_sfni_ready),
	.sbni_link(i_mnim_platform_controller_master_sbni_link),
	.sbni_ready(i_mnim_platform_controller_master_sbni_ready),
	.svri_rlink(i_mnim_platform_controller_master_svri_rlink),
	.svri_rack(i_mnim_platform_controller_master_svri_rack),
	.svri_slink(i_mnim_platform_controller_master_svri_slink),
	.svri_sack(i_mnim_platform_controller_master_svri_sack)
);

MUNOC_XMI_MASTER_NETWORK_INTERFACE_MODULE_ASYNCH
#(
	.NODE_ID(`NODE_ID_I_MNIM_I_DCA_MATRIX_CONV00_MI_MLSU_NOC_PART),
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT),
	.BW_PLATFORM_ADDR(32),
	.BW_NODE_DATA(128),
	.NAME("i_dca_matrix_conv00_mi_mlsu_noc_part"),
	.HAS_BURDEN(1),
	.BW_BURDEN(1)
)
i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part
(
	.clk_network(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_clk_network),
	.rstnn_network(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rstnn_network),
	.clk_master(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_clk_master),
	.rstnn_master(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rstnn_master),
	.comm_disable(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_comm_disable),
	.rlxqdready(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqdready),
	.rlxqvalid(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqvalid),
	.rlxqlast(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqlast),
	.rlxqwrite(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqwrite),
	.rlxqlen(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqlen),
	.rlxqsize(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqsize),
	.rlxqburst(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqburst),
	.rlxqwstrb(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqwstrb),
	.rlxqwdata(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqwdata),
	.rlxqaddr(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqaddr),
	.rlxqburden(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqburden),
	.rlxydready(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxydready),
	.rlxyvalid(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxyvalid),
	.rlxylast(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxylast),
	.rlxywreply(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxywreply),
	.rlxyresp(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxyresp),
	.rlxyrdata(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxyrdata),
	.rlxyburden(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxyburden),
	.sfni_link(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_sfni_link),
	.sfni_ready(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_sfni_ready),
	.sbni_link(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_sbni_link),
	.sbni_ready(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_sbni_ready),
	.svri_rlink(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_svri_rlink),
	.svri_rack(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_svri_rack),
	.svri_slink(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_svri_slink),
	.svri_sack(i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_svri_sack)
);

MUNOC_XMI_MASTER_NETWORK_INTERFACE_MODULE_ASYNCH
#(
	.NODE_ID(`NODE_ID_I_MNIM_I_DCA_MATRIX_CONV00_MK_MLSU_NOC_PART),
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT),
	.BW_PLATFORM_ADDR(32),
	.BW_NODE_DATA(128),
	.NAME("i_dca_matrix_conv00_mk_mlsu_noc_part"),
	.HAS_BURDEN(1),
	.BW_BURDEN(1)
)
i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part
(
	.clk_network(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_clk_network),
	.rstnn_network(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rstnn_network),
	.clk_master(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_clk_master),
	.rstnn_master(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rstnn_master),
	.comm_disable(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_comm_disable),
	.rlxqdready(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqdready),
	.rlxqvalid(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqvalid),
	.rlxqlast(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqlast),
	.rlxqwrite(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqwrite),
	.rlxqlen(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqlen),
	.rlxqsize(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqsize),
	.rlxqburst(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqburst),
	.rlxqwstrb(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqwstrb),
	.rlxqwdata(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqwdata),
	.rlxqaddr(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqaddr),
	.rlxqburden(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqburden),
	.rlxydready(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxydready),
	.rlxyvalid(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxyvalid),
	.rlxylast(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxylast),
	.rlxywreply(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxywreply),
	.rlxyresp(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxyresp),
	.rlxyrdata(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxyrdata),
	.rlxyburden(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxyburden),
	.sfni_link(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_sfni_link),
	.sfni_ready(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_sfni_ready),
	.sbni_link(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_sbni_link),
	.sbni_ready(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_sbni_ready),
	.svri_rlink(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_svri_rlink),
	.svri_rack(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_svri_rack),
	.svri_slink(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_svri_slink),
	.svri_sack(i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_svri_sack)
);

MUNOC_XMI_MASTER_NETWORK_INTERFACE_MODULE_ASYNCH
#(
	.NODE_ID(`NODE_ID_I_MNIM_I_DCA_MATRIX_CONV00_MO_MLSU_NOC_PART),
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT),
	.BW_PLATFORM_ADDR(32),
	.BW_NODE_DATA(128),
	.NAME("i_dca_matrix_conv00_mo_mlsu_noc_part"),
	.HAS_BURDEN(1),
	.BW_BURDEN(1)
)
i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part
(
	.clk_network(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_clk_network),
	.rstnn_network(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rstnn_network),
	.clk_master(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_clk_master),
	.rstnn_master(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rstnn_master),
	.comm_disable(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_comm_disable),
	.rlxqdready(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqdready),
	.rlxqvalid(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqvalid),
	.rlxqlast(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqlast),
	.rlxqwrite(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqwrite),
	.rlxqlen(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqlen),
	.rlxqsize(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqsize),
	.rlxqburst(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqburst),
	.rlxqwstrb(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqwstrb),
	.rlxqwdata(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqwdata),
	.rlxqaddr(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqaddr),
	.rlxqburden(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqburden),
	.rlxydready(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxydready),
	.rlxyvalid(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxyvalid),
	.rlxylast(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxylast),
	.rlxywreply(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxywreply),
	.rlxyresp(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxyresp),
	.rlxyrdata(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxyrdata),
	.rlxyburden(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxyburden),
	.sfni_link(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_sfni_link),
	.sfni_ready(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_sfni_ready),
	.sbni_link(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_sbni_link),
	.sbni_ready(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_sbni_ready),
	.svri_rlink(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_svri_rlink),
	.svri_rack(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_svri_rack),
	.svri_slink(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_svri_slink),
	.svri_sack(i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_svri_sack)
);

MUNOC_XMI_MASTER_NETWORK_INTERFACE_MODULE_ASYNCH
#(
	.NODE_ID(`NODE_ID_I_MNIM_I_DCA_MATRIX_MAC00_MA_MLSU_NOC_PART),
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT),
	.BW_PLATFORM_ADDR(32),
	.BW_NODE_DATA(128),
	.NAME("i_dca_matrix_mac00_ma_mlsu_noc_part"),
	.HAS_BURDEN(1),
	.BW_BURDEN(1)
)
i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part
(
	.clk_network(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_clk_network),
	.rstnn_network(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rstnn_network),
	.clk_master(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_clk_master),
	.rstnn_master(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rstnn_master),
	.comm_disable(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_comm_disable),
	.rlxqdready(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqdready),
	.rlxqvalid(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqvalid),
	.rlxqlast(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqlast),
	.rlxqwrite(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqwrite),
	.rlxqlen(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqlen),
	.rlxqsize(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqsize),
	.rlxqburst(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqburst),
	.rlxqwstrb(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqwstrb),
	.rlxqwdata(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqwdata),
	.rlxqaddr(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqaddr),
	.rlxqburden(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqburden),
	.rlxydready(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxydready),
	.rlxyvalid(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxyvalid),
	.rlxylast(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxylast),
	.rlxywreply(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxywreply),
	.rlxyresp(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxyresp),
	.rlxyrdata(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxyrdata),
	.rlxyburden(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxyburden),
	.sfni_link(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_sfni_link),
	.sfni_ready(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_sfni_ready),
	.sbni_link(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_sbni_link),
	.sbni_ready(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_sbni_ready),
	.svri_rlink(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_svri_rlink),
	.svri_rack(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_svri_rack),
	.svri_slink(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_svri_slink),
	.svri_sack(i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_svri_sack)
);

MUNOC_XMI_MASTER_NETWORK_INTERFACE_MODULE_ASYNCH
#(
	.NODE_ID(`NODE_ID_I_MNIM_I_DCA_MATRIX_MAC00_MB_MLSU_NOC_PART),
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT),
	.BW_PLATFORM_ADDR(32),
	.BW_NODE_DATA(128),
	.NAME("i_dca_matrix_mac00_mb_mlsu_noc_part"),
	.HAS_BURDEN(1),
	.BW_BURDEN(1)
)
i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part
(
	.clk_network(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_clk_network),
	.rstnn_network(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rstnn_network),
	.clk_master(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_clk_master),
	.rstnn_master(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rstnn_master),
	.comm_disable(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_comm_disable),
	.rlxqdready(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqdready),
	.rlxqvalid(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqvalid),
	.rlxqlast(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqlast),
	.rlxqwrite(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqwrite),
	.rlxqlen(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqlen),
	.rlxqsize(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqsize),
	.rlxqburst(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqburst),
	.rlxqwstrb(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqwstrb),
	.rlxqwdata(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqwdata),
	.rlxqaddr(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqaddr),
	.rlxqburden(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqburden),
	.rlxydready(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxydready),
	.rlxyvalid(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxyvalid),
	.rlxylast(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxylast),
	.rlxywreply(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxywreply),
	.rlxyresp(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxyresp),
	.rlxyrdata(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxyrdata),
	.rlxyburden(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxyburden),
	.sfni_link(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_sfni_link),
	.sfni_ready(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_sfni_ready),
	.sbni_link(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_sbni_link),
	.sbni_ready(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_sbni_ready),
	.svri_rlink(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_svri_rlink),
	.svri_rack(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_svri_rack),
	.svri_slink(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_svri_slink),
	.svri_sack(i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_svri_sack)
);

MUNOC_XMI_MASTER_NETWORK_INTERFACE_MODULE_ASYNCH
#(
	.NODE_ID(`NODE_ID_I_MNIM_I_DCA_MATRIX_MAC00_MC_MLSU_NOC_PART),
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT),
	.BW_PLATFORM_ADDR(32),
	.BW_NODE_DATA(128),
	.NAME("i_dca_matrix_mac00_mc_mlsu_noc_part"),
	.HAS_BURDEN(1),
	.BW_BURDEN(1)
)
i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part
(
	.clk_network(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_clk_network),
	.rstnn_network(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rstnn_network),
	.clk_master(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_clk_master),
	.rstnn_master(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rstnn_master),
	.comm_disable(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_comm_disable),
	.rlxqdready(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqdready),
	.rlxqvalid(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqvalid),
	.rlxqlast(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqlast),
	.rlxqwrite(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqwrite),
	.rlxqlen(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqlen),
	.rlxqsize(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqsize),
	.rlxqburst(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqburst),
	.rlxqwstrb(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqwstrb),
	.rlxqwdata(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqwdata),
	.rlxqaddr(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqaddr),
	.rlxqburden(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqburden),
	.rlxydready(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxydready),
	.rlxyvalid(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxyvalid),
	.rlxylast(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxylast),
	.rlxywreply(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxywreply),
	.rlxyresp(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxyresp),
	.rlxyrdata(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxyrdata),
	.rlxyburden(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxyburden),
	.sfni_link(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_sfni_link),
	.sfni_ready(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_sfni_ready),
	.sbni_link(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_sbni_link),
	.sbni_ready(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_sbni_ready),
	.svri_rlink(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_svri_rlink),
	.svri_rack(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_svri_rack),
	.svri_slink(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_svri_slink),
	.svri_sack(i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_svri_sack)
);

MUNOC_AXI_SLAVE_NETWORK_INTERFACE_MODULE
#(
	.NODE_ID(`NODE_ID_I_SNIM_I_SYSTEM_DDR_NO_NAME),
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT),
	.BW_PLATFORM_ADDR(32),
	.BW_NODE_DATA(32),
	.NAME("i_system_ddr_no_name"),
	.BW_AXI_SLAVE_TID(16)
)
i_snim_i_system_ddr_no_name
(
	.clk(i_snim_i_system_ddr_no_name_clk),
	.rstnn(i_snim_i_system_ddr_no_name_rstnn),
	.comm_disable(i_snim_i_system_ddr_no_name_comm_disable),
	.sxawready(i_snim_i_system_ddr_no_name_sxawready),
	.sxawvalid(i_snim_i_system_ddr_no_name_sxawvalid),
	.sxawaddr(i_snim_i_system_ddr_no_name_sxawaddr),
	.sxawid(i_snim_i_system_ddr_no_name_sxawid),
	.sxawlen(i_snim_i_system_ddr_no_name_sxawlen),
	.sxawsize(i_snim_i_system_ddr_no_name_sxawsize),
	.sxawburst(i_snim_i_system_ddr_no_name_sxawburst),
	.sxwready(i_snim_i_system_ddr_no_name_sxwready),
	.sxwvalid(i_snim_i_system_ddr_no_name_sxwvalid),
	.sxwid(i_snim_i_system_ddr_no_name_sxwid),
	.sxwdata(i_snim_i_system_ddr_no_name_sxwdata),
	.sxwstrb(i_snim_i_system_ddr_no_name_sxwstrb),
	.sxwlast(i_snim_i_system_ddr_no_name_sxwlast),
	.sxbready(i_snim_i_system_ddr_no_name_sxbready),
	.sxbvalid(i_snim_i_system_ddr_no_name_sxbvalid),
	.sxbid(i_snim_i_system_ddr_no_name_sxbid),
	.sxbresp(i_snim_i_system_ddr_no_name_sxbresp),
	.sxarready(i_snim_i_system_ddr_no_name_sxarready),
	.sxarvalid(i_snim_i_system_ddr_no_name_sxarvalid),
	.sxaraddr(i_snim_i_system_ddr_no_name_sxaraddr),
	.sxarid(i_snim_i_system_ddr_no_name_sxarid),
	.sxarlen(i_snim_i_system_ddr_no_name_sxarlen),
	.sxarsize(i_snim_i_system_ddr_no_name_sxarsize),
	.sxarburst(i_snim_i_system_ddr_no_name_sxarburst),
	.sxrready(i_snim_i_system_ddr_no_name_sxrready),
	.sxrvalid(i_snim_i_system_ddr_no_name_sxrvalid),
	.sxrid(i_snim_i_system_ddr_no_name_sxrid),
	.sxrdata(i_snim_i_system_ddr_no_name_sxrdata),
	.sxrlast(i_snim_i_system_ddr_no_name_sxrlast),
	.sxrresp(i_snim_i_system_ddr_no_name_sxrresp),
	.rfni_link(i_snim_i_system_ddr_no_name_rfni_link),
	.rfni_ready(i_snim_i_system_ddr_no_name_rfni_ready),
	.rbni_link(i_snim_i_system_ddr_no_name_rbni_link),
	.rbni_ready(i_snim_i_system_ddr_no_name_rbni_ready),
	.svri_rlink(i_snim_i_system_ddr_no_name_svri_rlink),
	.svri_rack(i_snim_i_system_ddr_no_name_svri_rack),
	.svri_slink(i_snim_i_system_ddr_no_name_svri_slink),
	.svri_sack(i_snim_i_system_ddr_no_name_svri_sack)
);

MUNOC_NETWORK_DUAL_ROUTER
#(
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT),
	.NUM_MASTER(4),
	.NUM_SLAVE(2),
	.ROUTER_ID(`ROUTER_ID_I_ROUTER00)
)
i_router00
(
	.clk(i_router00_clk),
	.rstnn(i_router00_rstnn),
	.rfni_link_list(i_router00_rfni_link_list),
	.rfni_ready_list(i_router00_rfni_ready_list),
	.rbni_link_list(i_router00_rbni_link_list),
	.rbni_ready_list(i_router00_rbni_ready_list),
	.sfni_link_list(i_router00_sfni_link_list),
	.sfni_ready_list(i_router00_sfni_ready_list),
	.sbni_link_list(i_router00_sbni_link_list),
	.sbni_ready_list(i_router00_sbni_ready_list)
);

MUNOC_NETWORK_DUAL_ROUTER
#(
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT),
	.NUM_MASTER(2),
	.NUM_SLAVE(7),
	.ROUTER_ID(`ROUTER_ID_I_SYSTEM_ROUTER)
)
i_system_router
(
	.clk(i_system_router_clk),
	.rstnn(i_system_router_rstnn),
	.rfni_link_list(i_system_router_rfni_link_list),
	.rfni_ready_list(i_system_router_rfni_ready_list),
	.rbni_link_list(i_system_router_rbni_link_list),
	.rbni_ready_list(i_system_router_rbni_ready_list),
	.sfni_link_list(i_system_router_sfni_link_list),
	.sfni_ready_list(i_system_router_sfni_ready_list),
	.sbni_link_list(i_system_router_sbni_link_list),
	.sbni_ready_list(i_system_router_sbni_ready_list)
);

MUNOC_NETWORK_DUAL_ROUTER
#(
	.BW_FNI_PHIT(BW_FNI_PHIT),
	.BW_BNI_PHIT(BW_BNI_PHIT),
	.NUM_MASTER(8),
	.NUM_SLAVE(2),
	.ROUTER_ID(`ROUTER_ID_I_USER_ROUTER)
)
i_user_router
(
	.clk(i_user_router_clk),
	.rstnn(i_user_router_rstnn),
	.rfni_link_list(i_user_router_rfni_link_list),
	.rfni_ready_list(i_user_router_rfni_ready_list),
	.rbni_link_list(i_user_router_rbni_link_list),
	.rbni_ready_list(i_user_router_rbni_ready_list),
	.sfni_link_list(i_user_router_sfni_link_list),
	.sfni_ready_list(i_user_router_sfni_ready_list),
	.sbni_link_list(i_user_router_sbni_link_list),
	.sbni_ready_list(i_user_router_sbni_ready_list)
);

assign clk_dca_core = clk_system;
assign clk_core = clk_system;
assign clk_system_external = clk_system;
assign clk_system_debug = clk_system;
assign clk_local_access = clk_core;
assign clk_process_000 = clk_core;
assign clk_process_001 = clk_core;
assign clk_process_002 = clk_core;
assign clk_process_003 = clk_core;
assign clk_noc = clk_dram_if;
assign gclk_system = clk_system;
assign gclk_dca_core = clk_dca_core;
assign gclk_core = clk_core;
assign gclk_system_external = clk_system_external;
assign gclk_system_debug = clk_system_debug;
assign gclk_local_access = clk_local_access;
assign gclk_process_000 = clk_process_000;
assign gclk_process_001 = clk_process_001;
assign gclk_process_002 = clk_process_002;
assign gclk_process_003 = clk_process_003;
assign gclk_noc = clk_noc;
assign tick_1us = autoname_103_tick_1us;
assign tick_62d5ms = autoname_103_tick_62d5ms;
assign tick_gpio = external_peri_group_tick_gpio;
assign autoname_104 = tick_1us;
assign spi_common_sclk = external_peri_group_spi_common_sclk;
assign spi_common_sdq0 = external_peri_group_spi_common_sdq0;
assign i_dca_matrix_conv00_control_mmiox1_interface_clk_acc = i_dca_matrix_conv00_clk;
assign i_dca_matrix_conv00_control_mmiox1_interface_rstnn_acc = i_dca_matrix_conv00_rstnn;
assign i_dca_matrix_mac00_control_mmiox1_interface_clk_acc = i_dca_matrix_mac00_clk;
assign i_dca_matrix_mac00_control_mmiox1_interface_rstnn_acc = i_dca_matrix_mac00_rstnn;
assign i_dca_matrix_conv00_mi_mlsu_clk = i_dca_matrix_conv00_clk;
assign i_dca_matrix_conv00_mi_mlsu_rstnn = i_dca_matrix_conv00_rstnn;
assign i_dca_matrix_conv00_mk_mlsu_clk = i_dca_matrix_conv00_clk;
assign i_dca_matrix_conv00_mk_mlsu_rstnn = i_dca_matrix_conv00_rstnn;
assign i_dca_matrix_conv00_mo_mlsu_clk = i_dca_matrix_conv00_clk;
assign i_dca_matrix_conv00_mo_mlsu_rstnn = i_dca_matrix_conv00_rstnn;
assign i_dca_matrix_mac00_ma_mlsu_clk = i_dca_matrix_mac00_clk;
assign i_dca_matrix_mac00_ma_mlsu_rstnn = i_dca_matrix_mac00_rstnn;
assign i_dca_matrix_mac00_mb_mlsu_clk = i_dca_matrix_mac00_clk;
assign i_dca_matrix_mac00_mb_mlsu_rstnn = i_dca_matrix_mac00_rstnn;
assign i_dca_matrix_mac00_mc_mlsu_clk = i_dca_matrix_mac00_clk;
assign i_dca_matrix_mac00_mc_mlsu_rstnn = i_dca_matrix_mac00_rstnn;
assign global_rstnn = platform_controller_global_rstnn;
assign global_rstpp = platform_controller_global_rstpp;
assign rstnn_seqeunce = platform_controller_rstnn_seqeunce;
assign rstpp_seqeunce = platform_controller_rstpp_seqeunce;
assign i_led_rstnn = rstnn_seqeunce[1];
assign i_system_ddr_rstnn_dram_if = rstnn_seqeunce[1];
assign i_system_sram_rstnn = rstnn_seqeunce[1];
assign common_peri_group_rstnn = rstnn_seqeunce[1];
assign autoname_103_rstnn = rstnn_seqeunce[2];
assign autoname_105_rstnn = rstnn_seqeunce[2];
assign external_peri_group_rstnn = rstnn_seqeunce[2];
assign core_peri_group_rstnn = rstnn_seqeunce[2];
assign autoname_106_rstnn = rstnn_seqeunce[3];
assign autoname_107_rstnn = rstnn_seqeunce[3];
assign autoname_108_rstnn = rstnn_seqeunce[3];
assign platform_controller_rstnn = rstnn_seqeunce[3];
assign default_slave_rstnn_network = rstnn_seqeunce[4];
assign default_slave_rstnn_debug = rstnn_seqeunce[4];
assign i_dca_matrix_conv00_rstnn = rstnn_seqeunce[5];
assign i_dca_matrix_conv00_control_mmiox1_interface_rstnn_mmio = rstnn_seqeunce[5];
assign i_dca_matrix_mac00_rstnn = rstnn_seqeunce[5];
assign i_dca_matrix_mac00_control_mmiox1_interface_rstnn_mmio = rstnn_seqeunce[5];
assign i_main_core_rstnn = rstnn_seqeunce[6];
assign i_sub_core_001_rstnn = rstnn_seqeunce[7];
assign i_sub_core_002_rstnn = rstnn_seqeunce[8];
assign i_sub_core_003_rstnn = rstnn_seqeunce[9];
assign rstnn_user = rstnn_seqeunce[3];
assign rstpp_user = rstpp_seqeunce[3];
assign i_dca_matrix_conv00_clk = clk_dca_core;
assign i_dca_matrix_mac00_clk = clk_dca_core;
assign i_led_clk = gclk_system_external;
assign external_peri_group_clk = gclk_system_external;
assign clk_dram_ref = i_pll0_clk_dram_ref;
assign i_system_ddr_clk_ref = clk_dram_ref;
assign clk_dram_sys = i_pll0_clk_dram_sys;
assign i_system_ddr_clk_sys = clk_dram_sys;
assign clk_dram_if = i_system_ddr_clk_dram_if;
assign clk_system = i_pll0_clk_system;
assign common_peri_group_clk = clk_system;
assign autoname_103_clk = clk_system;
assign autoname_105_clk = clk_system;
assign platform_controller_clk = clk_system;
assign core_peri_group_clk = gclk_local_access;
assign autoname_106_clk = gclk_local_access;
assign autoname_107_clk = gclk_local_access;
assign autoname_108_clk = gclk_local_access;
assign default_slave_clk_debug = gclk_system_debug;
assign i_dca_matrix_conv00_control_mmiox1_interface_clk_mmio = gclk_system;
assign i_dca_matrix_mac00_control_mmiox1_interface_clk_mmio = gclk_system;
assign i_main_core_clk = gclk_process_000;
assign i_sub_core_001_clk = gclk_process_001;
assign i_sub_core_002_clk = gclk_process_002;
assign i_sub_core_003_clk = gclk_process_003;
assign rstnn_noc = rstnn_seqeunce[1];
assign i_router00_rstnn = rstnn_noc;
assign i_system_router_rstnn = rstnn_noc;
assign i_user_router_rstnn = rstnn_noc;
assign i_router00_clk = gclk_noc;
assign i_system_router_clk = gclk_noc;
assign i_user_router_clk = gclk_noc;
assign i_system_sram_clk = gclk_noc;
assign default_slave_clk_network = gclk_noc;
assign i_inter_router_fifo00_clk = gclk_noc;
assign i_inter_router_fifo00_rstnn = rstnn_noc;
assign i_inter_router_fifo01_clk = gclk_noc;
assign i_inter_router_fifo01_rstnn = rstnn_noc;
assign i_inter_router_fifo02_clk = gclk_noc;
assign i_inter_router_fifo02_rstnn = rstnn_noc;
assign i_mnim_i_main_core_no_name_clk_network = gclk_noc;
assign i_mnim_i_main_core_no_name_rstnn_network = rstnn_noc;
assign i_mnim_i_main_core_no_name_clk_master = gclk_process_000;
assign i_mnim_i_main_core_no_name_rstnn_master = rstnn_seqeunce[6];
assign i_mnim_i_sub_core_001_no_name_clk_network = gclk_noc;
assign i_mnim_i_sub_core_001_no_name_rstnn_network = rstnn_noc;
assign i_mnim_i_sub_core_001_no_name_clk_master = gclk_process_001;
assign i_mnim_i_sub_core_001_no_name_rstnn_master = rstnn_seqeunce[7];
assign i_mnim_i_sub_core_002_no_name_clk_network = gclk_noc;
assign i_mnim_i_sub_core_002_no_name_rstnn_network = rstnn_noc;
assign i_mnim_i_sub_core_002_no_name_clk_master = gclk_process_002;
assign i_mnim_i_sub_core_002_no_name_rstnn_master = rstnn_seqeunce[8];
assign i_mnim_i_sub_core_003_no_name_clk_network = gclk_noc;
assign i_mnim_i_sub_core_003_no_name_rstnn_network = rstnn_noc;
assign i_mnim_i_sub_core_003_no_name_clk_master = gclk_process_003;
assign i_mnim_i_sub_core_003_no_name_rstnn_master = rstnn_seqeunce[9];
assign i_snim_i_system_sram_no_name_clk = gclk_noc;
assign i_snim_i_system_sram_no_name_rstnn = rstnn_noc;
assign i_snim_common_peri_group_no_name_clk_network = gclk_noc;
assign i_snim_common_peri_group_no_name_rstnn_network = rstnn_noc;
assign i_snim_common_peri_group_no_name_clk_slave = clk_system;
assign i_snim_common_peri_group_no_name_rstnn_slave = rstnn_seqeunce[1];
assign i_snim_external_peri_group_no_name_clk_network = gclk_noc;
assign i_snim_external_peri_group_no_name_rstnn_network = rstnn_noc;
assign i_snim_external_peri_group_no_name_clk_slave = gclk_system_external;
assign i_snim_external_peri_group_no_name_rstnn_slave = rstnn_seqeunce[2];
assign i_snim_platform_controller_no_name_clk_network = gclk_noc;
assign i_snim_platform_controller_no_name_rstnn_network = rstnn_noc;
assign i_snim_platform_controller_no_name_clk_slave = clk_system;
assign i_snim_platform_controller_no_name_rstnn_slave = rstnn_seqeunce[3];
assign i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_clk_network = gclk_noc;
assign i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_rstnn_network = rstnn_noc;
assign i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_clk_slave = gclk_system;
assign i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_rstnn_slave = rstnn_seqeunce[5];
assign i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_clk_network = gclk_noc;
assign i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_rstnn_network = rstnn_noc;
assign i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_clk_slave = gclk_system;
assign i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_rstnn_slave = rstnn_seqeunce[5];
assign i_mnim_platform_controller_master_clk_network = gclk_noc;
assign i_mnim_platform_controller_master_rstnn_network = rstnn_noc;
assign i_mnim_platform_controller_master_clk_master = clk_system;
assign i_mnim_platform_controller_master_rstnn_master = rstnn_seqeunce[3];
assign i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_clk_network = gclk_noc;
assign i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rstnn_network = rstnn_noc;
assign i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_clk_master = clk_dca_core;
assign i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rstnn_master = i_dca_matrix_conv00_rstnn;
assign i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_clk_network = gclk_noc;
assign i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rstnn_network = rstnn_noc;
assign i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_clk_master = clk_dca_core;
assign i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rstnn_master = i_dca_matrix_conv00_rstnn;
assign i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_clk_network = gclk_noc;
assign i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rstnn_network = rstnn_noc;
assign i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_clk_master = clk_dca_core;
assign i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rstnn_master = i_dca_matrix_conv00_rstnn;
assign i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_clk_network = gclk_noc;
assign i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rstnn_network = rstnn_noc;
assign i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_clk_master = clk_dca_core;
assign i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rstnn_master = i_dca_matrix_mac00_rstnn;
assign i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_clk_network = gclk_noc;
assign i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rstnn_network = rstnn_noc;
assign i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_clk_master = clk_dca_core;
assign i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rstnn_master = i_dca_matrix_mac00_rstnn;
assign i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_clk_network = gclk_noc;
assign i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rstnn_network = rstnn_noc;
assign i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_clk_master = clk_dca_core;
assign i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rstnn_master = i_dca_matrix_mac00_rstnn;
assign i_snim_i_system_ddr_no_name_clk = gclk_noc;
assign i_snim_i_system_ddr_no_name_rstnn = rstnn_noc;
assign i_led_tick_62d5ms = autoname_103_tick_62d5ms;
assign i_led_app_finished = platform_controller_app_finished;
assign i_system_ddr_rstnn_sys = platform_controller_global_rstnn;
assign i_pll0_external_rstnn = platform_controller_global_rstnn;
assign platform_controller_initialized = i_system_ddr_initialized;
assign core_peri_group_lock_status_list = common_peri_group_lock_status_list;
assign autoname_106_lock_status_list = common_peri_group_lock_status_list;
assign autoname_107_lock_status_list = common_peri_group_lock_status_list;
assign autoname_108_lock_status_list = common_peri_group_lock_status_list;
assign core_peri_group_thread_status_list = common_peri_group_thread_status_list;
assign autoname_106_thread_status_list = common_peri_group_thread_status_list;
assign autoname_107_thread_status_list = common_peri_group_thread_status_list;
assign autoname_108_thread_status_list = common_peri_group_thread_status_list;
assign common_peri_group_real_clock = autoname_105_real_clock;
assign core_peri_group_global_tag_list = common_peri_group_global_tag_list;
assign autoname_106_global_tag_list = common_peri_group_global_tag_list;
assign autoname_107_global_tag_list = common_peri_group_global_tag_list;
assign autoname_108_global_tag_list = common_peri_group_global_tag_list;
assign autoname_103_tick_config = common_peri_group_system_tick_config;
assign autoname_105_tick_1us = autoname_103_tick_1us;
assign external_peri_group_tick_1us = autoname_103_tick_1us;
assign core_peri_group_tick_1us = autoname_104;
assign autoname_106_tick_1us = autoname_104;
assign autoname_107_tick_1us = autoname_104;
assign autoname_108_tick_1us = autoname_104;
assign platform_controller_external_rstnn = external_rstnn;
assign platform_controller_boot_mode = boot_mode;
assign platform_controller_jtag_select = `JTAG_SELECT_NOC;
assign i_main_core_interrupt_vector = core_peri_group_core_interrupt_vector;
assign i_sub_core_001_interrupt_vector = autoname_106_core_interrupt_vector;
assign i_sub_core_002_interrupt_vector = autoname_107_core_interrupt_vector;
assign i_sub_core_003_interrupt_vector = autoname_108_core_interrupt_vector;
assign core_peri_group_allows_holds = i_mnim_i_main_core_no_name_local_allows_holds;
assign autoname_106_allows_holds = i_mnim_i_sub_core_001_no_name_local_allows_holds;
assign autoname_107_allows_holds = i_mnim_i_sub_core_002_no_name_local_allows_holds;
assign autoname_108_allows_holds = i_mnim_i_sub_core_003_no_name_local_allows_holds;
assign default_slave_comm_disable = 0;
assign i_snim_common_peri_group_no_name_comm_disable = 0;
assign i_snim_external_peri_group_no_name_comm_disable = 0;
assign i_snim_platform_controller_no_name_comm_disable = 0;
assign i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_comm_disable = 0;
assign i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_comm_disable = 0;
assign i_mnim_platform_controller_master_comm_disable = 0;
assign core_peri_group_plic_interrupt = 0;
assign autoname_106_plic_interrupt = 0;
assign autoname_107_plic_interrupt = 0;
assign autoname_108_plic_interrupt = 0;
assign i_mnim_i_main_core_no_name_comm_disable = 0;
assign i_mnim_i_sub_core_001_no_name_comm_disable = 0;
assign i_mnim_i_sub_core_002_no_name_comm_disable = 0;
assign i_mnim_i_sub_core_003_no_name_comm_disable = 0;
assign i_snim_i_system_sram_no_name_comm_disable = 0;
assign i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_comm_disable = 0;
assign i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_comm_disable = 0;
assign i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_comm_disable = 0;
assign i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_comm_disable = 0;
assign i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_comm_disable = 0;
assign i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_comm_disable = 0;
assign i_snim_i_system_ddr_no_name_comm_disable = 0;
assign led_list[1*(0+1)-1 -:1] = i_led_led_list[1*(0+1)-1 -:1];
assign i_dca_matrix_conv00_control_rmx_core_config = i_dca_matrix_conv00_control_mmiox1_interface_smx_core_config;
assign i_dca_matrix_conv00_control_mmiox1_interface_smx_core_status = i_dca_matrix_conv00_control_rmx_core_status;
assign i_dca_matrix_conv00_control_rmx_clear_request = i_dca_matrix_conv00_control_mmiox1_interface_smx_clear_request;
assign i_dca_matrix_conv00_control_mmiox1_interface_smx_clear_finish = i_dca_matrix_conv00_control_rmx_clear_finish;
assign i_dca_matrix_conv00_control_rmx_log_fifo_wready = i_dca_matrix_conv00_control_mmiox1_interface_smx_log_fifo_wready;
assign i_dca_matrix_conv00_control_mmiox1_interface_smx_log_fifo_wrequest = i_dca_matrix_conv00_control_rmx_log_fifo_wrequest;
assign i_dca_matrix_conv00_control_mmiox1_interface_smx_log_fifo_wdata = i_dca_matrix_conv00_control_rmx_log_fifo_wdata;
assign i_dca_matrix_conv00_control_rmx_inst_fifo_rready = i_dca_matrix_conv00_control_mmiox1_interface_smx_inst_fifo_rready;
assign i_dca_matrix_conv00_control_rmx_inst_fifo_rdata = i_dca_matrix_conv00_control_mmiox1_interface_smx_inst_fifo_rdata;
assign i_dca_matrix_conv00_control_mmiox1_interface_smx_inst_fifo_rrequest = i_dca_matrix_conv00_control_rmx_inst_fifo_rrequest;
assign i_dca_matrix_conv00_control_mmiox1_interface_smx_operation_finish = i_dca_matrix_conv00_control_rmx_operation_finish;
assign i_dca_matrix_conv00_control_rmx_input_fifo_rready = i_dca_matrix_conv00_control_mmiox1_interface_smx_input_fifo_rready;
assign i_dca_matrix_conv00_control_rmx_input_fifo_rdata = i_dca_matrix_conv00_control_mmiox1_interface_smx_input_fifo_rdata;
assign i_dca_matrix_conv00_control_mmiox1_interface_smx_input_fifo_rrequest = i_dca_matrix_conv00_control_rmx_input_fifo_rrequest;
assign i_dca_matrix_conv00_control_rmx_output_fifo_wready = i_dca_matrix_conv00_control_mmiox1_interface_smx_output_fifo_wready;
assign i_dca_matrix_conv00_control_mmiox1_interface_smx_output_fifo_wrequest = i_dca_matrix_conv00_control_rmx_output_fifo_wrequest;
assign i_dca_matrix_conv00_control_mmiox1_interface_smx_output_fifo_wdata = i_dca_matrix_conv00_control_rmx_output_fifo_wdata;
assign i_dca_matrix_mac00_control_rmx_core_config = i_dca_matrix_mac00_control_mmiox1_interface_smx_core_config;
assign i_dca_matrix_mac00_control_mmiox1_interface_smx_core_status = i_dca_matrix_mac00_control_rmx_core_status;
assign i_dca_matrix_mac00_control_rmx_clear_request = i_dca_matrix_mac00_control_mmiox1_interface_smx_clear_request;
assign i_dca_matrix_mac00_control_mmiox1_interface_smx_clear_finish = i_dca_matrix_mac00_control_rmx_clear_finish;
assign i_dca_matrix_mac00_control_rmx_log_fifo_wready = i_dca_matrix_mac00_control_mmiox1_interface_smx_log_fifo_wready;
assign i_dca_matrix_mac00_control_mmiox1_interface_smx_log_fifo_wrequest = i_dca_matrix_mac00_control_rmx_log_fifo_wrequest;
assign i_dca_matrix_mac00_control_mmiox1_interface_smx_log_fifo_wdata = i_dca_matrix_mac00_control_rmx_log_fifo_wdata;
assign i_dca_matrix_mac00_control_rmx_inst_fifo_rready = i_dca_matrix_mac00_control_mmiox1_interface_smx_inst_fifo_rready;
assign i_dca_matrix_mac00_control_rmx_inst_fifo_rdata = i_dca_matrix_mac00_control_mmiox1_interface_smx_inst_fifo_rdata;
assign i_dca_matrix_mac00_control_mmiox1_interface_smx_inst_fifo_rrequest = i_dca_matrix_mac00_control_rmx_inst_fifo_rrequest;
assign i_dca_matrix_mac00_control_mmiox1_interface_smx_operation_finish = i_dca_matrix_mac00_control_rmx_operation_finish;
assign i_dca_matrix_mac00_control_rmx_input_fifo_rready = i_dca_matrix_mac00_control_mmiox1_interface_smx_input_fifo_rready;
assign i_dca_matrix_mac00_control_rmx_input_fifo_rdata = i_dca_matrix_mac00_control_mmiox1_interface_smx_input_fifo_rdata;
assign i_dca_matrix_mac00_control_mmiox1_interface_smx_input_fifo_rrequest = i_dca_matrix_mac00_control_rmx_input_fifo_rrequest;
assign i_dca_matrix_mac00_control_rmx_output_fifo_wready = i_dca_matrix_mac00_control_mmiox1_interface_smx_output_fifo_wready;
assign i_dca_matrix_mac00_control_mmiox1_interface_smx_output_fifo_wrequest = i_dca_matrix_mac00_control_rmx_output_fifo_wrequest;
assign i_dca_matrix_mac00_control_mmiox1_interface_smx_output_fifo_wdata = i_dca_matrix_mac00_control_rmx_output_fifo_wdata;
assign i_dca_matrix_conv00_mi_mlsu_rinst_wvalid = i_dca_matrix_conv00_mi_sinst_wvalid;
assign i_dca_matrix_conv00_mi_mlsu_rinst_wdata = i_dca_matrix_conv00_mi_sinst_wdata;
assign i_dca_matrix_conv00_mi_sinst_wready = i_dca_matrix_conv00_mi_mlsu_rinst_wready;
assign i_dca_matrix_conv00_mi_sinst_decode_finish = i_dca_matrix_conv00_mi_mlsu_rinst_decode_finish;
assign i_dca_matrix_conv00_mi_sinst_execute_finish = i_dca_matrix_conv00_mi_mlsu_rinst_execute_finish;
assign i_dca_matrix_conv00_mi_sinst_busy = i_dca_matrix_conv00_mi_mlsu_rinst_busy;
assign i_dca_matrix_conv00_mi_sload_tensor_row_wvalid = i_dca_matrix_conv00_mi_mlsu_rload_tensor_row_wvalid;
assign i_dca_matrix_conv00_mi_sload_tensor_row_wlast = i_dca_matrix_conv00_mi_mlsu_rload_tensor_row_wlast;
assign i_dca_matrix_conv00_mi_sload_tensor_row_wdata = i_dca_matrix_conv00_mi_mlsu_rload_tensor_row_wdata;
assign i_dca_matrix_conv00_mi_mlsu_rload_tensor_row_wready = i_dca_matrix_conv00_mi_sload_tensor_row_wready;
assign i_dca_matrix_conv00_mi_sstore_tensor_row_rvalid = i_dca_matrix_conv00_mi_mlsu_rstore_tensor_row_rvalid;
assign i_dca_matrix_conv00_mi_sstore_tensor_row_rlast = i_dca_matrix_conv00_mi_mlsu_rstore_tensor_row_rlast;
assign i_dca_matrix_conv00_mi_mlsu_rstore_tensor_row_rready = i_dca_matrix_conv00_mi_sstore_tensor_row_rready;
assign i_dca_matrix_conv00_mi_mlsu_rstore_tensor_row_rdata = i_dca_matrix_conv00_mi_sstore_tensor_row_rdata;
assign i_dca_matrix_conv00_mk_mlsu_rinst_wvalid = i_dca_matrix_conv00_mk_sinst_wvalid;
assign i_dca_matrix_conv00_mk_mlsu_rinst_wdata = i_dca_matrix_conv00_mk_sinst_wdata;
assign i_dca_matrix_conv00_mk_sinst_wready = i_dca_matrix_conv00_mk_mlsu_rinst_wready;
assign i_dca_matrix_conv00_mk_sinst_decode_finish = i_dca_matrix_conv00_mk_mlsu_rinst_decode_finish;
assign i_dca_matrix_conv00_mk_sinst_execute_finish = i_dca_matrix_conv00_mk_mlsu_rinst_execute_finish;
assign i_dca_matrix_conv00_mk_sinst_busy = i_dca_matrix_conv00_mk_mlsu_rinst_busy;
assign i_dca_matrix_conv00_mk_sload_tensor_row_wvalid = i_dca_matrix_conv00_mk_mlsu_rload_tensor_row_wvalid;
assign i_dca_matrix_conv00_mk_sload_tensor_row_wlast = i_dca_matrix_conv00_mk_mlsu_rload_tensor_row_wlast;
assign i_dca_matrix_conv00_mk_sload_tensor_row_wdata = i_dca_matrix_conv00_mk_mlsu_rload_tensor_row_wdata;
assign i_dca_matrix_conv00_mk_mlsu_rload_tensor_row_wready = i_dca_matrix_conv00_mk_sload_tensor_row_wready;
assign i_dca_matrix_conv00_mk_sstore_tensor_row_rvalid = i_dca_matrix_conv00_mk_mlsu_rstore_tensor_row_rvalid;
assign i_dca_matrix_conv00_mk_sstore_tensor_row_rlast = i_dca_matrix_conv00_mk_mlsu_rstore_tensor_row_rlast;
assign i_dca_matrix_conv00_mk_mlsu_rstore_tensor_row_rready = i_dca_matrix_conv00_mk_sstore_tensor_row_rready;
assign i_dca_matrix_conv00_mk_mlsu_rstore_tensor_row_rdata = i_dca_matrix_conv00_mk_sstore_tensor_row_rdata;
assign i_dca_matrix_conv00_mo_mlsu_rinst_wvalid = i_dca_matrix_conv00_mo_sinst_wvalid;
assign i_dca_matrix_conv00_mo_mlsu_rinst_wdata = i_dca_matrix_conv00_mo_sinst_wdata;
assign i_dca_matrix_conv00_mo_sinst_wready = i_dca_matrix_conv00_mo_mlsu_rinst_wready;
assign i_dca_matrix_conv00_mo_sinst_decode_finish = i_dca_matrix_conv00_mo_mlsu_rinst_decode_finish;
assign i_dca_matrix_conv00_mo_sinst_execute_finish = i_dca_matrix_conv00_mo_mlsu_rinst_execute_finish;
assign i_dca_matrix_conv00_mo_sinst_busy = i_dca_matrix_conv00_mo_mlsu_rinst_busy;
assign i_dca_matrix_conv00_mo_sload_tensor_row_wvalid = i_dca_matrix_conv00_mo_mlsu_rload_tensor_row_wvalid;
assign i_dca_matrix_conv00_mo_sload_tensor_row_wlast = i_dca_matrix_conv00_mo_mlsu_rload_tensor_row_wlast;
assign i_dca_matrix_conv00_mo_sload_tensor_row_wdata = i_dca_matrix_conv00_mo_mlsu_rload_tensor_row_wdata;
assign i_dca_matrix_conv00_mo_mlsu_rload_tensor_row_wready = i_dca_matrix_conv00_mo_sload_tensor_row_wready;
assign i_dca_matrix_conv00_mo_sstore_tensor_row_rvalid = i_dca_matrix_conv00_mo_mlsu_rstore_tensor_row_rvalid;
assign i_dca_matrix_conv00_mo_sstore_tensor_row_rlast = i_dca_matrix_conv00_mo_mlsu_rstore_tensor_row_rlast;
assign i_dca_matrix_conv00_mo_mlsu_rstore_tensor_row_rready = i_dca_matrix_conv00_mo_sstore_tensor_row_rready;
assign i_dca_matrix_conv00_mo_mlsu_rstore_tensor_row_rdata = i_dca_matrix_conv00_mo_sstore_tensor_row_rdata;
assign i_dca_matrix_mac00_ma_mlsu_rinst_wvalid = i_dca_matrix_mac00_ma_sinst_wvalid;
assign i_dca_matrix_mac00_ma_mlsu_rinst_wdata = i_dca_matrix_mac00_ma_sinst_wdata;
assign i_dca_matrix_mac00_ma_sinst_wready = i_dca_matrix_mac00_ma_mlsu_rinst_wready;
assign i_dca_matrix_mac00_ma_sinst_decode_finish = i_dca_matrix_mac00_ma_mlsu_rinst_decode_finish;
assign i_dca_matrix_mac00_ma_sinst_execute_finish = i_dca_matrix_mac00_ma_mlsu_rinst_execute_finish;
assign i_dca_matrix_mac00_ma_sinst_busy = i_dca_matrix_mac00_ma_mlsu_rinst_busy;
assign i_dca_matrix_mac00_ma_sload_tensor_row_wvalid = i_dca_matrix_mac00_ma_mlsu_rload_tensor_row_wvalid;
assign i_dca_matrix_mac00_ma_sload_tensor_row_wlast = i_dca_matrix_mac00_ma_mlsu_rload_tensor_row_wlast;
assign i_dca_matrix_mac00_ma_sload_tensor_row_wdata = i_dca_matrix_mac00_ma_mlsu_rload_tensor_row_wdata;
assign i_dca_matrix_mac00_ma_mlsu_rload_tensor_row_wready = i_dca_matrix_mac00_ma_sload_tensor_row_wready;
assign i_dca_matrix_mac00_ma_sstore_tensor_row_rvalid = i_dca_matrix_mac00_ma_mlsu_rstore_tensor_row_rvalid;
assign i_dca_matrix_mac00_ma_sstore_tensor_row_rlast = i_dca_matrix_mac00_ma_mlsu_rstore_tensor_row_rlast;
assign i_dca_matrix_mac00_ma_mlsu_rstore_tensor_row_rready = i_dca_matrix_mac00_ma_sstore_tensor_row_rready;
assign i_dca_matrix_mac00_ma_mlsu_rstore_tensor_row_rdata = i_dca_matrix_mac00_ma_sstore_tensor_row_rdata;
assign i_dca_matrix_mac00_mb_mlsu_rinst_wvalid = i_dca_matrix_mac00_mb_sinst_wvalid;
assign i_dca_matrix_mac00_mb_mlsu_rinst_wdata = i_dca_matrix_mac00_mb_sinst_wdata;
assign i_dca_matrix_mac00_mb_sinst_wready = i_dca_matrix_mac00_mb_mlsu_rinst_wready;
assign i_dca_matrix_mac00_mb_sinst_decode_finish = i_dca_matrix_mac00_mb_mlsu_rinst_decode_finish;
assign i_dca_matrix_mac00_mb_sinst_execute_finish = i_dca_matrix_mac00_mb_mlsu_rinst_execute_finish;
assign i_dca_matrix_mac00_mb_sinst_busy = i_dca_matrix_mac00_mb_mlsu_rinst_busy;
assign i_dca_matrix_mac00_mb_sload_tensor_row_wvalid = i_dca_matrix_mac00_mb_mlsu_rload_tensor_row_wvalid;
assign i_dca_matrix_mac00_mb_sload_tensor_row_wlast = i_dca_matrix_mac00_mb_mlsu_rload_tensor_row_wlast;
assign i_dca_matrix_mac00_mb_sload_tensor_row_wdata = i_dca_matrix_mac00_mb_mlsu_rload_tensor_row_wdata;
assign i_dca_matrix_mac00_mb_mlsu_rload_tensor_row_wready = i_dca_matrix_mac00_mb_sload_tensor_row_wready;
assign i_dca_matrix_mac00_mb_sstore_tensor_row_rvalid = i_dca_matrix_mac00_mb_mlsu_rstore_tensor_row_rvalid;
assign i_dca_matrix_mac00_mb_sstore_tensor_row_rlast = i_dca_matrix_mac00_mb_mlsu_rstore_tensor_row_rlast;
assign i_dca_matrix_mac00_mb_mlsu_rstore_tensor_row_rready = i_dca_matrix_mac00_mb_sstore_tensor_row_rready;
assign i_dca_matrix_mac00_mb_mlsu_rstore_tensor_row_rdata = i_dca_matrix_mac00_mb_sstore_tensor_row_rdata;
assign i_dca_matrix_mac00_mc_mlsu_rinst_wvalid = i_dca_matrix_mac00_mc_sinst_wvalid;
assign i_dca_matrix_mac00_mc_mlsu_rinst_wdata = i_dca_matrix_mac00_mc_sinst_wdata;
assign i_dca_matrix_mac00_mc_sinst_wready = i_dca_matrix_mac00_mc_mlsu_rinst_wready;
assign i_dca_matrix_mac00_mc_sinst_decode_finish = i_dca_matrix_mac00_mc_mlsu_rinst_decode_finish;
assign i_dca_matrix_mac00_mc_sinst_execute_finish = i_dca_matrix_mac00_mc_mlsu_rinst_execute_finish;
assign i_dca_matrix_mac00_mc_sinst_busy = i_dca_matrix_mac00_mc_mlsu_rinst_busy;
assign i_dca_matrix_mac00_mc_sload_tensor_row_wvalid = i_dca_matrix_mac00_mc_mlsu_rload_tensor_row_wvalid;
assign i_dca_matrix_mac00_mc_sload_tensor_row_wlast = i_dca_matrix_mac00_mc_mlsu_rload_tensor_row_wlast;
assign i_dca_matrix_mac00_mc_sload_tensor_row_wdata = i_dca_matrix_mac00_mc_mlsu_rload_tensor_row_wdata;
assign i_dca_matrix_mac00_mc_mlsu_rload_tensor_row_wready = i_dca_matrix_mac00_mc_sload_tensor_row_wready;
assign i_dca_matrix_mac00_mc_sstore_tensor_row_rvalid = i_dca_matrix_mac00_mc_mlsu_rstore_tensor_row_rvalid;
assign i_dca_matrix_mac00_mc_sstore_tensor_row_rlast = i_dca_matrix_mac00_mc_mlsu_rstore_tensor_row_rlast;
assign i_dca_matrix_mac00_mc_mlsu_rstore_tensor_row_rready = i_dca_matrix_mac00_mc_sstore_tensor_row_rready;
assign i_dca_matrix_mac00_mc_mlsu_rstore_tensor_row_rdata = i_dca_matrix_mac00_mc_sstore_tensor_row_rdata;
assign i_main_core_sxawready = i_mnim_i_main_core_no_name_rxawready;
assign i_mnim_i_main_core_no_name_rxawvalid = i_main_core_sxawvalid;
assign i_mnim_i_main_core_no_name_rxawaddr = i_main_core_sxawaddr;
assign i_mnim_i_main_core_no_name_rxawid = i_main_core_sxawid;
assign i_mnim_i_main_core_no_name_rxawlen = i_main_core_sxawlen;
assign i_mnim_i_main_core_no_name_rxawsize = i_main_core_sxawsize;
assign i_mnim_i_main_core_no_name_rxawburst = i_main_core_sxawburst;
assign i_main_core_sxwready = i_mnim_i_main_core_no_name_rxwready;
assign i_mnim_i_main_core_no_name_rxwvalid = i_main_core_sxwvalid;
assign i_mnim_i_main_core_no_name_rxwid = i_main_core_sxwid;
assign i_mnim_i_main_core_no_name_rxwdata = i_main_core_sxwdata;
assign i_mnim_i_main_core_no_name_rxwstrb = i_main_core_sxwstrb;
assign i_mnim_i_main_core_no_name_rxwlast = i_main_core_sxwlast;
assign i_mnim_i_main_core_no_name_rxbready = i_main_core_sxbready;
assign i_main_core_sxbvalid = i_mnim_i_main_core_no_name_rxbvalid;
assign i_main_core_sxbid = i_mnim_i_main_core_no_name_rxbid;
assign i_main_core_sxbresp = i_mnim_i_main_core_no_name_rxbresp;
assign i_main_core_sxarready = i_mnim_i_main_core_no_name_rxarready;
assign i_mnim_i_main_core_no_name_rxarvalid = i_main_core_sxarvalid;
assign i_mnim_i_main_core_no_name_rxaraddr = i_main_core_sxaraddr;
assign i_mnim_i_main_core_no_name_rxarid = i_main_core_sxarid;
assign i_mnim_i_main_core_no_name_rxarlen = i_main_core_sxarlen;
assign i_mnim_i_main_core_no_name_rxarsize = i_main_core_sxarsize;
assign i_mnim_i_main_core_no_name_rxarburst = i_main_core_sxarburst;
assign i_mnim_i_main_core_no_name_rxrready = i_main_core_sxrready;
assign i_main_core_sxrvalid = i_mnim_i_main_core_no_name_rxrvalid;
assign i_main_core_sxrid = i_mnim_i_main_core_no_name_rxrid;
assign i_main_core_sxrdata = i_mnim_i_main_core_no_name_rxrdata;
assign i_main_core_sxrlast = i_mnim_i_main_core_no_name_rxrlast;
assign i_main_core_sxrresp = i_mnim_i_main_core_no_name_rxrresp;
assign i_sub_core_001_sxawready = i_mnim_i_sub_core_001_no_name_rxawready;
assign i_mnim_i_sub_core_001_no_name_rxawvalid = i_sub_core_001_sxawvalid;
assign i_mnim_i_sub_core_001_no_name_rxawaddr = i_sub_core_001_sxawaddr;
assign i_mnim_i_sub_core_001_no_name_rxawid = i_sub_core_001_sxawid;
assign i_mnim_i_sub_core_001_no_name_rxawlen = i_sub_core_001_sxawlen;
assign i_mnim_i_sub_core_001_no_name_rxawsize = i_sub_core_001_sxawsize;
assign i_mnim_i_sub_core_001_no_name_rxawburst = i_sub_core_001_sxawburst;
assign i_sub_core_001_sxwready = i_mnim_i_sub_core_001_no_name_rxwready;
assign i_mnim_i_sub_core_001_no_name_rxwvalid = i_sub_core_001_sxwvalid;
assign i_mnim_i_sub_core_001_no_name_rxwid = i_sub_core_001_sxwid;
assign i_mnim_i_sub_core_001_no_name_rxwdata = i_sub_core_001_sxwdata;
assign i_mnim_i_sub_core_001_no_name_rxwstrb = i_sub_core_001_sxwstrb;
assign i_mnim_i_sub_core_001_no_name_rxwlast = i_sub_core_001_sxwlast;
assign i_mnim_i_sub_core_001_no_name_rxbready = i_sub_core_001_sxbready;
assign i_sub_core_001_sxbvalid = i_mnim_i_sub_core_001_no_name_rxbvalid;
assign i_sub_core_001_sxbid = i_mnim_i_sub_core_001_no_name_rxbid;
assign i_sub_core_001_sxbresp = i_mnim_i_sub_core_001_no_name_rxbresp;
assign i_sub_core_001_sxarready = i_mnim_i_sub_core_001_no_name_rxarready;
assign i_mnim_i_sub_core_001_no_name_rxarvalid = i_sub_core_001_sxarvalid;
assign i_mnim_i_sub_core_001_no_name_rxaraddr = i_sub_core_001_sxaraddr;
assign i_mnim_i_sub_core_001_no_name_rxarid = i_sub_core_001_sxarid;
assign i_mnim_i_sub_core_001_no_name_rxarlen = i_sub_core_001_sxarlen;
assign i_mnim_i_sub_core_001_no_name_rxarsize = i_sub_core_001_sxarsize;
assign i_mnim_i_sub_core_001_no_name_rxarburst = i_sub_core_001_sxarburst;
assign i_mnim_i_sub_core_001_no_name_rxrready = i_sub_core_001_sxrready;
assign i_sub_core_001_sxrvalid = i_mnim_i_sub_core_001_no_name_rxrvalid;
assign i_sub_core_001_sxrid = i_mnim_i_sub_core_001_no_name_rxrid;
assign i_sub_core_001_sxrdata = i_mnim_i_sub_core_001_no_name_rxrdata;
assign i_sub_core_001_sxrlast = i_mnim_i_sub_core_001_no_name_rxrlast;
assign i_sub_core_001_sxrresp = i_mnim_i_sub_core_001_no_name_rxrresp;
assign i_sub_core_002_sxawready = i_mnim_i_sub_core_002_no_name_rxawready;
assign i_mnim_i_sub_core_002_no_name_rxawvalid = i_sub_core_002_sxawvalid;
assign i_mnim_i_sub_core_002_no_name_rxawaddr = i_sub_core_002_sxawaddr;
assign i_mnim_i_sub_core_002_no_name_rxawid = i_sub_core_002_sxawid;
assign i_mnim_i_sub_core_002_no_name_rxawlen = i_sub_core_002_sxawlen;
assign i_mnim_i_sub_core_002_no_name_rxawsize = i_sub_core_002_sxawsize;
assign i_mnim_i_sub_core_002_no_name_rxawburst = i_sub_core_002_sxawburst;
assign i_sub_core_002_sxwready = i_mnim_i_sub_core_002_no_name_rxwready;
assign i_mnim_i_sub_core_002_no_name_rxwvalid = i_sub_core_002_sxwvalid;
assign i_mnim_i_sub_core_002_no_name_rxwid = i_sub_core_002_sxwid;
assign i_mnim_i_sub_core_002_no_name_rxwdata = i_sub_core_002_sxwdata;
assign i_mnim_i_sub_core_002_no_name_rxwstrb = i_sub_core_002_sxwstrb;
assign i_mnim_i_sub_core_002_no_name_rxwlast = i_sub_core_002_sxwlast;
assign i_mnim_i_sub_core_002_no_name_rxbready = i_sub_core_002_sxbready;
assign i_sub_core_002_sxbvalid = i_mnim_i_sub_core_002_no_name_rxbvalid;
assign i_sub_core_002_sxbid = i_mnim_i_sub_core_002_no_name_rxbid;
assign i_sub_core_002_sxbresp = i_mnim_i_sub_core_002_no_name_rxbresp;
assign i_sub_core_002_sxarready = i_mnim_i_sub_core_002_no_name_rxarready;
assign i_mnim_i_sub_core_002_no_name_rxarvalid = i_sub_core_002_sxarvalid;
assign i_mnim_i_sub_core_002_no_name_rxaraddr = i_sub_core_002_sxaraddr;
assign i_mnim_i_sub_core_002_no_name_rxarid = i_sub_core_002_sxarid;
assign i_mnim_i_sub_core_002_no_name_rxarlen = i_sub_core_002_sxarlen;
assign i_mnim_i_sub_core_002_no_name_rxarsize = i_sub_core_002_sxarsize;
assign i_mnim_i_sub_core_002_no_name_rxarburst = i_sub_core_002_sxarburst;
assign i_mnim_i_sub_core_002_no_name_rxrready = i_sub_core_002_sxrready;
assign i_sub_core_002_sxrvalid = i_mnim_i_sub_core_002_no_name_rxrvalid;
assign i_sub_core_002_sxrid = i_mnim_i_sub_core_002_no_name_rxrid;
assign i_sub_core_002_sxrdata = i_mnim_i_sub_core_002_no_name_rxrdata;
assign i_sub_core_002_sxrlast = i_mnim_i_sub_core_002_no_name_rxrlast;
assign i_sub_core_002_sxrresp = i_mnim_i_sub_core_002_no_name_rxrresp;
assign i_sub_core_003_sxawready = i_mnim_i_sub_core_003_no_name_rxawready;
assign i_mnim_i_sub_core_003_no_name_rxawvalid = i_sub_core_003_sxawvalid;
assign i_mnim_i_sub_core_003_no_name_rxawaddr = i_sub_core_003_sxawaddr;
assign i_mnim_i_sub_core_003_no_name_rxawid = i_sub_core_003_sxawid;
assign i_mnim_i_sub_core_003_no_name_rxawlen = i_sub_core_003_sxawlen;
assign i_mnim_i_sub_core_003_no_name_rxawsize = i_sub_core_003_sxawsize;
assign i_mnim_i_sub_core_003_no_name_rxawburst = i_sub_core_003_sxawburst;
assign i_sub_core_003_sxwready = i_mnim_i_sub_core_003_no_name_rxwready;
assign i_mnim_i_sub_core_003_no_name_rxwvalid = i_sub_core_003_sxwvalid;
assign i_mnim_i_sub_core_003_no_name_rxwid = i_sub_core_003_sxwid;
assign i_mnim_i_sub_core_003_no_name_rxwdata = i_sub_core_003_sxwdata;
assign i_mnim_i_sub_core_003_no_name_rxwstrb = i_sub_core_003_sxwstrb;
assign i_mnim_i_sub_core_003_no_name_rxwlast = i_sub_core_003_sxwlast;
assign i_mnim_i_sub_core_003_no_name_rxbready = i_sub_core_003_sxbready;
assign i_sub_core_003_sxbvalid = i_mnim_i_sub_core_003_no_name_rxbvalid;
assign i_sub_core_003_sxbid = i_mnim_i_sub_core_003_no_name_rxbid;
assign i_sub_core_003_sxbresp = i_mnim_i_sub_core_003_no_name_rxbresp;
assign i_sub_core_003_sxarready = i_mnim_i_sub_core_003_no_name_rxarready;
assign i_mnim_i_sub_core_003_no_name_rxarvalid = i_sub_core_003_sxarvalid;
assign i_mnim_i_sub_core_003_no_name_rxaraddr = i_sub_core_003_sxaraddr;
assign i_mnim_i_sub_core_003_no_name_rxarid = i_sub_core_003_sxarid;
assign i_mnim_i_sub_core_003_no_name_rxarlen = i_sub_core_003_sxarlen;
assign i_mnim_i_sub_core_003_no_name_rxarsize = i_sub_core_003_sxarsize;
assign i_mnim_i_sub_core_003_no_name_rxarburst = i_sub_core_003_sxarburst;
assign i_mnim_i_sub_core_003_no_name_rxrready = i_sub_core_003_sxrready;
assign i_sub_core_003_sxrvalid = i_mnim_i_sub_core_003_no_name_rxrvalid;
assign i_sub_core_003_sxrid = i_mnim_i_sub_core_003_no_name_rxrid;
assign i_sub_core_003_sxrdata = i_mnim_i_sub_core_003_no_name_rxrdata;
assign i_sub_core_003_sxrlast = i_mnim_i_sub_core_003_no_name_rxrlast;
assign i_sub_core_003_sxrresp = i_mnim_i_sub_core_003_no_name_rxrresp;
assign i_snim_i_system_sram_no_name_sxawready = i_system_sram_sxawready;
assign i_system_sram_sxawvalid = i_snim_i_system_sram_no_name_sxawvalid;
assign i_system_sram_sxawaddr = i_snim_i_system_sram_no_name_sxawaddr;
assign i_system_sram_sxawid = i_snim_i_system_sram_no_name_sxawid;
assign i_system_sram_sxawlen = i_snim_i_system_sram_no_name_sxawlen;
assign i_system_sram_sxawsize = i_snim_i_system_sram_no_name_sxawsize;
assign i_system_sram_sxawburst = i_snim_i_system_sram_no_name_sxawburst;
assign i_snim_i_system_sram_no_name_sxwready = i_system_sram_sxwready;
assign i_system_sram_sxwvalid = i_snim_i_system_sram_no_name_sxwvalid;
assign i_system_sram_sxwid = i_snim_i_system_sram_no_name_sxwid;
assign i_system_sram_sxwdata = i_snim_i_system_sram_no_name_sxwdata;
assign i_system_sram_sxwstrb = i_snim_i_system_sram_no_name_sxwstrb;
assign i_system_sram_sxwlast = i_snim_i_system_sram_no_name_sxwlast;
assign i_system_sram_sxbready = i_snim_i_system_sram_no_name_sxbready;
assign i_snim_i_system_sram_no_name_sxbvalid = i_system_sram_sxbvalid;
assign i_snim_i_system_sram_no_name_sxbid = i_system_sram_sxbid;
assign i_snim_i_system_sram_no_name_sxbresp = i_system_sram_sxbresp;
assign i_snim_i_system_sram_no_name_sxarready = i_system_sram_sxarready;
assign i_system_sram_sxarvalid = i_snim_i_system_sram_no_name_sxarvalid;
assign i_system_sram_sxaraddr = i_snim_i_system_sram_no_name_sxaraddr;
assign i_system_sram_sxarid = i_snim_i_system_sram_no_name_sxarid;
assign i_system_sram_sxarlen = i_snim_i_system_sram_no_name_sxarlen;
assign i_system_sram_sxarsize = i_snim_i_system_sram_no_name_sxarsize;
assign i_system_sram_sxarburst = i_snim_i_system_sram_no_name_sxarburst;
assign i_system_sram_sxrready = i_snim_i_system_sram_no_name_sxrready;
assign i_snim_i_system_sram_no_name_sxrvalid = i_system_sram_sxrvalid;
assign i_snim_i_system_sram_no_name_sxrid = i_system_sram_sxrid;
assign i_snim_i_system_sram_no_name_sxrdata = i_system_sram_sxrdata;
assign i_snim_i_system_sram_no_name_sxrlast = i_system_sram_sxrlast;
assign i_snim_i_system_sram_no_name_sxrresp = i_system_sram_sxrresp;
assign common_peri_group_rpsel = i_snim_common_peri_group_no_name_spsel;
assign common_peri_group_rpenable = i_snim_common_peri_group_no_name_spenable;
assign common_peri_group_rpwrite = i_snim_common_peri_group_no_name_spwrite;
assign common_peri_group_rpaddr = i_snim_common_peri_group_no_name_spaddr;
assign common_peri_group_rpwdata = i_snim_common_peri_group_no_name_spwdata;
assign i_snim_common_peri_group_no_name_spready = common_peri_group_rpready;
assign i_snim_common_peri_group_no_name_sprdata = common_peri_group_rprdata;
assign i_snim_common_peri_group_no_name_spslverr = common_peri_group_rpslverr;
assign external_peri_group_rpsel = i_snim_external_peri_group_no_name_spsel;
assign external_peri_group_rpenable = i_snim_external_peri_group_no_name_spenable;
assign external_peri_group_rpwrite = i_snim_external_peri_group_no_name_spwrite;
assign external_peri_group_rpaddr = i_snim_external_peri_group_no_name_spaddr;
assign external_peri_group_rpwdata = i_snim_external_peri_group_no_name_spwdata;
assign i_snim_external_peri_group_no_name_spready = external_peri_group_rpready;
assign i_snim_external_peri_group_no_name_sprdata = external_peri_group_rprdata;
assign i_snim_external_peri_group_no_name_spslverr = external_peri_group_rpslverr;
assign platform_controller_rpsel = i_snim_platform_controller_no_name_spsel;
assign platform_controller_rpenable = i_snim_platform_controller_no_name_spenable;
assign platform_controller_rpwrite = i_snim_platform_controller_no_name_spwrite;
assign platform_controller_rpaddr = i_snim_platform_controller_no_name_spaddr;
assign platform_controller_rpwdata = i_snim_platform_controller_no_name_spwdata;
assign i_snim_platform_controller_no_name_spready = platform_controller_rpready;
assign i_snim_platform_controller_no_name_sprdata = platform_controller_rprdata;
assign i_snim_platform_controller_no_name_spslverr = platform_controller_rpslverr;
assign i_dca_matrix_conv00_control_mmiox1_interface_mmio_rpsel = i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_spsel;
assign i_dca_matrix_conv00_control_mmiox1_interface_mmio_rpenable = i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_spenable;
assign i_dca_matrix_conv00_control_mmiox1_interface_mmio_rpwrite = i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_spwrite;
assign i_dca_matrix_conv00_control_mmiox1_interface_mmio_rpaddr = i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_spaddr;
assign i_dca_matrix_conv00_control_mmiox1_interface_mmio_rpwdata = i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_spwdata;
assign i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_spready = i_dca_matrix_conv00_control_mmiox1_interface_mmio_rpready;
assign i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_sprdata = i_dca_matrix_conv00_control_mmiox1_interface_mmio_rprdata;
assign i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_spslverr = i_dca_matrix_conv00_control_mmiox1_interface_mmio_rpslverr;
assign i_dca_matrix_mac00_control_mmiox1_interface_mmio_rpsel = i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_spsel;
assign i_dca_matrix_mac00_control_mmiox1_interface_mmio_rpenable = i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_spenable;
assign i_dca_matrix_mac00_control_mmiox1_interface_mmio_rpwrite = i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_spwrite;
assign i_dca_matrix_mac00_control_mmiox1_interface_mmio_rpaddr = i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_spaddr;
assign i_dca_matrix_mac00_control_mmiox1_interface_mmio_rpwdata = i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_spwdata;
assign i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_spready = i_dca_matrix_mac00_control_mmiox1_interface_mmio_rpready;
assign i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_sprdata = i_dca_matrix_mac00_control_mmiox1_interface_mmio_rprdata;
assign i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_spslverr = i_dca_matrix_mac00_control_mmiox1_interface_mmio_rpslverr;
assign platform_controller_shready = i_mnim_platform_controller_master_rhready;
assign i_mnim_platform_controller_master_rhaddr = platform_controller_shaddr;
assign i_mnim_platform_controller_master_rhburst = platform_controller_shburst;
assign i_mnim_platform_controller_master_rhmasterlock = platform_controller_shmasterlock;
assign i_mnim_platform_controller_master_rhprot = platform_controller_shprot;
assign i_mnim_platform_controller_master_rhsize = platform_controller_shsize;
assign i_mnim_platform_controller_master_rhtrans = platform_controller_shtrans;
assign i_mnim_platform_controller_master_rhwrite = platform_controller_shwrite;
assign i_mnim_platform_controller_master_rhwdata = platform_controller_shwdata;
assign platform_controller_shrdata = i_mnim_platform_controller_master_rhrdata;
assign platform_controller_shresp = i_mnim_platform_controller_master_rhresp;
assign i_dca_matrix_conv00_mi_mlsu_slxqdready = i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqdready;
assign i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqvalid = i_dca_matrix_conv00_mi_mlsu_slxqvalid;
assign i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqlast = i_dca_matrix_conv00_mi_mlsu_slxqlast;
assign i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqwrite = i_dca_matrix_conv00_mi_mlsu_slxqwrite;
assign i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqlen = i_dca_matrix_conv00_mi_mlsu_slxqlen;
assign i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqsize = i_dca_matrix_conv00_mi_mlsu_slxqsize;
assign i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqburst = i_dca_matrix_conv00_mi_mlsu_slxqburst;
assign i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqwstrb = i_dca_matrix_conv00_mi_mlsu_slxqwstrb;
assign i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqwdata = i_dca_matrix_conv00_mi_mlsu_slxqwdata;
assign i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqaddr = i_dca_matrix_conv00_mi_mlsu_slxqaddr;
assign i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxqburden = i_dca_matrix_conv00_mi_mlsu_slxqburden;
assign i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxydready = i_dca_matrix_conv00_mi_mlsu_slxydready;
assign i_dca_matrix_conv00_mi_mlsu_slxyvalid = i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxyvalid;
assign i_dca_matrix_conv00_mi_mlsu_slxylast = i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxylast;
assign i_dca_matrix_conv00_mi_mlsu_slxywreply = i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxywreply;
assign i_dca_matrix_conv00_mi_mlsu_slxyresp = i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxyresp;
assign i_dca_matrix_conv00_mi_mlsu_slxyrdata = i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxyrdata;
assign i_dca_matrix_conv00_mi_mlsu_slxyburden = i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_rlxyburden;
assign i_dca_matrix_conv00_mk_mlsu_slxqdready = i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqdready;
assign i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqvalid = i_dca_matrix_conv00_mk_mlsu_slxqvalid;
assign i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqlast = i_dca_matrix_conv00_mk_mlsu_slxqlast;
assign i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqwrite = i_dca_matrix_conv00_mk_mlsu_slxqwrite;
assign i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqlen = i_dca_matrix_conv00_mk_mlsu_slxqlen;
assign i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqsize = i_dca_matrix_conv00_mk_mlsu_slxqsize;
assign i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqburst = i_dca_matrix_conv00_mk_mlsu_slxqburst;
assign i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqwstrb = i_dca_matrix_conv00_mk_mlsu_slxqwstrb;
assign i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqwdata = i_dca_matrix_conv00_mk_mlsu_slxqwdata;
assign i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqaddr = i_dca_matrix_conv00_mk_mlsu_slxqaddr;
assign i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxqburden = i_dca_matrix_conv00_mk_mlsu_slxqburden;
assign i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxydready = i_dca_matrix_conv00_mk_mlsu_slxydready;
assign i_dca_matrix_conv00_mk_mlsu_slxyvalid = i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxyvalid;
assign i_dca_matrix_conv00_mk_mlsu_slxylast = i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxylast;
assign i_dca_matrix_conv00_mk_mlsu_slxywreply = i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxywreply;
assign i_dca_matrix_conv00_mk_mlsu_slxyresp = i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxyresp;
assign i_dca_matrix_conv00_mk_mlsu_slxyrdata = i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxyrdata;
assign i_dca_matrix_conv00_mk_mlsu_slxyburden = i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_rlxyburden;
assign i_dca_matrix_conv00_mo_mlsu_slxqdready = i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqdready;
assign i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqvalid = i_dca_matrix_conv00_mo_mlsu_slxqvalid;
assign i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqlast = i_dca_matrix_conv00_mo_mlsu_slxqlast;
assign i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqwrite = i_dca_matrix_conv00_mo_mlsu_slxqwrite;
assign i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqlen = i_dca_matrix_conv00_mo_mlsu_slxqlen;
assign i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqsize = i_dca_matrix_conv00_mo_mlsu_slxqsize;
assign i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqburst = i_dca_matrix_conv00_mo_mlsu_slxqburst;
assign i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqwstrb = i_dca_matrix_conv00_mo_mlsu_slxqwstrb;
assign i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqwdata = i_dca_matrix_conv00_mo_mlsu_slxqwdata;
assign i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqaddr = i_dca_matrix_conv00_mo_mlsu_slxqaddr;
assign i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxqburden = i_dca_matrix_conv00_mo_mlsu_slxqburden;
assign i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxydready = i_dca_matrix_conv00_mo_mlsu_slxydready;
assign i_dca_matrix_conv00_mo_mlsu_slxyvalid = i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxyvalid;
assign i_dca_matrix_conv00_mo_mlsu_slxylast = i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxylast;
assign i_dca_matrix_conv00_mo_mlsu_slxywreply = i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxywreply;
assign i_dca_matrix_conv00_mo_mlsu_slxyresp = i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxyresp;
assign i_dca_matrix_conv00_mo_mlsu_slxyrdata = i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxyrdata;
assign i_dca_matrix_conv00_mo_mlsu_slxyburden = i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_rlxyburden;
assign i_dca_matrix_mac00_ma_mlsu_slxqdready = i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqdready;
assign i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqvalid = i_dca_matrix_mac00_ma_mlsu_slxqvalid;
assign i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqlast = i_dca_matrix_mac00_ma_mlsu_slxqlast;
assign i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqwrite = i_dca_matrix_mac00_ma_mlsu_slxqwrite;
assign i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqlen = i_dca_matrix_mac00_ma_mlsu_slxqlen;
assign i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqsize = i_dca_matrix_mac00_ma_mlsu_slxqsize;
assign i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqburst = i_dca_matrix_mac00_ma_mlsu_slxqburst;
assign i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqwstrb = i_dca_matrix_mac00_ma_mlsu_slxqwstrb;
assign i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqwdata = i_dca_matrix_mac00_ma_mlsu_slxqwdata;
assign i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqaddr = i_dca_matrix_mac00_ma_mlsu_slxqaddr;
assign i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxqburden = i_dca_matrix_mac00_ma_mlsu_slxqburden;
assign i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxydready = i_dca_matrix_mac00_ma_mlsu_slxydready;
assign i_dca_matrix_mac00_ma_mlsu_slxyvalid = i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxyvalid;
assign i_dca_matrix_mac00_ma_mlsu_slxylast = i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxylast;
assign i_dca_matrix_mac00_ma_mlsu_slxywreply = i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxywreply;
assign i_dca_matrix_mac00_ma_mlsu_slxyresp = i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxyresp;
assign i_dca_matrix_mac00_ma_mlsu_slxyrdata = i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxyrdata;
assign i_dca_matrix_mac00_ma_mlsu_slxyburden = i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_rlxyburden;
assign i_dca_matrix_mac00_mb_mlsu_slxqdready = i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqdready;
assign i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqvalid = i_dca_matrix_mac00_mb_mlsu_slxqvalid;
assign i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqlast = i_dca_matrix_mac00_mb_mlsu_slxqlast;
assign i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqwrite = i_dca_matrix_mac00_mb_mlsu_slxqwrite;
assign i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqlen = i_dca_matrix_mac00_mb_mlsu_slxqlen;
assign i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqsize = i_dca_matrix_mac00_mb_mlsu_slxqsize;
assign i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqburst = i_dca_matrix_mac00_mb_mlsu_slxqburst;
assign i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqwstrb = i_dca_matrix_mac00_mb_mlsu_slxqwstrb;
assign i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqwdata = i_dca_matrix_mac00_mb_mlsu_slxqwdata;
assign i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqaddr = i_dca_matrix_mac00_mb_mlsu_slxqaddr;
assign i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxqburden = i_dca_matrix_mac00_mb_mlsu_slxqburden;
assign i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxydready = i_dca_matrix_mac00_mb_mlsu_slxydready;
assign i_dca_matrix_mac00_mb_mlsu_slxyvalid = i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxyvalid;
assign i_dca_matrix_mac00_mb_mlsu_slxylast = i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxylast;
assign i_dca_matrix_mac00_mb_mlsu_slxywreply = i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxywreply;
assign i_dca_matrix_mac00_mb_mlsu_slxyresp = i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxyresp;
assign i_dca_matrix_mac00_mb_mlsu_slxyrdata = i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxyrdata;
assign i_dca_matrix_mac00_mb_mlsu_slxyburden = i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_rlxyburden;
assign i_dca_matrix_mac00_mc_mlsu_slxqdready = i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqdready;
assign i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqvalid = i_dca_matrix_mac00_mc_mlsu_slxqvalid;
assign i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqlast = i_dca_matrix_mac00_mc_mlsu_slxqlast;
assign i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqwrite = i_dca_matrix_mac00_mc_mlsu_slxqwrite;
assign i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqlen = i_dca_matrix_mac00_mc_mlsu_slxqlen;
assign i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqsize = i_dca_matrix_mac00_mc_mlsu_slxqsize;
assign i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqburst = i_dca_matrix_mac00_mc_mlsu_slxqburst;
assign i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqwstrb = i_dca_matrix_mac00_mc_mlsu_slxqwstrb;
assign i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqwdata = i_dca_matrix_mac00_mc_mlsu_slxqwdata;
assign i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqaddr = i_dca_matrix_mac00_mc_mlsu_slxqaddr;
assign i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxqburden = i_dca_matrix_mac00_mc_mlsu_slxqburden;
assign i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxydready = i_dca_matrix_mac00_mc_mlsu_slxydready;
assign i_dca_matrix_mac00_mc_mlsu_slxyvalid = i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxyvalid;
assign i_dca_matrix_mac00_mc_mlsu_slxylast = i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxylast;
assign i_dca_matrix_mac00_mc_mlsu_slxywreply = i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxywreply;
assign i_dca_matrix_mac00_mc_mlsu_slxyresp = i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxyresp;
assign i_dca_matrix_mac00_mc_mlsu_slxyrdata = i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxyrdata;
assign i_dca_matrix_mac00_mc_mlsu_slxyburden = i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_rlxyburden;
assign i_snim_i_system_ddr_no_name_sxawready = i_system_ddr_sxawready;
assign i_system_ddr_sxawvalid = i_snim_i_system_ddr_no_name_sxawvalid;
assign i_system_ddr_sxawaddr = i_snim_i_system_ddr_no_name_sxawaddr;
assign i_system_ddr_sxawid = i_snim_i_system_ddr_no_name_sxawid;
assign i_system_ddr_sxawlen = i_snim_i_system_ddr_no_name_sxawlen;
assign i_system_ddr_sxawsize = i_snim_i_system_ddr_no_name_sxawsize;
assign i_system_ddr_sxawburst = i_snim_i_system_ddr_no_name_sxawburst;
assign i_snim_i_system_ddr_no_name_sxwready = i_system_ddr_sxwready;
assign i_system_ddr_sxwvalid = i_snim_i_system_ddr_no_name_sxwvalid;
assign i_system_ddr_sxwid = i_snim_i_system_ddr_no_name_sxwid;
assign i_system_ddr_sxwdata = i_snim_i_system_ddr_no_name_sxwdata;
assign i_system_ddr_sxwstrb = i_snim_i_system_ddr_no_name_sxwstrb;
assign i_system_ddr_sxwlast = i_snim_i_system_ddr_no_name_sxwlast;
assign i_system_ddr_sxbready = i_snim_i_system_ddr_no_name_sxbready;
assign i_snim_i_system_ddr_no_name_sxbvalid = i_system_ddr_sxbvalid;
assign i_snim_i_system_ddr_no_name_sxbid = i_system_ddr_sxbid;
assign i_snim_i_system_ddr_no_name_sxbresp = i_system_ddr_sxbresp;
assign i_snim_i_system_ddr_no_name_sxarready = i_system_ddr_sxarready;
assign i_system_ddr_sxarvalid = i_snim_i_system_ddr_no_name_sxarvalid;
assign i_system_ddr_sxaraddr = i_snim_i_system_ddr_no_name_sxaraddr;
assign i_system_ddr_sxarid = i_snim_i_system_ddr_no_name_sxarid;
assign i_system_ddr_sxarlen = i_snim_i_system_ddr_no_name_sxarlen;
assign i_system_ddr_sxarsize = i_snim_i_system_ddr_no_name_sxarsize;
assign i_system_ddr_sxarburst = i_snim_i_system_ddr_no_name_sxarburst;
assign i_system_ddr_sxrready = i_snim_i_system_ddr_no_name_sxrready;
assign i_snim_i_system_ddr_no_name_sxrvalid = i_system_ddr_sxrvalid;
assign i_snim_i_system_ddr_no_name_sxrid = i_system_ddr_sxrid;
assign i_snim_i_system_ddr_no_name_sxrdata = i_system_ddr_sxrdata;
assign i_snim_i_system_ddr_no_name_sxrlast = i_system_ddr_sxrlast;
assign i_snim_i_system_ddr_no_name_sxrresp = i_system_ddr_sxrresp;
assign i_router00_rfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(0+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)] = i_mnim_i_main_core_no_name_sfni_link;
assign i_mnim_i_main_core_no_name_sfni_ready = i_router00_rfni_ready_list[1*(0+1)-1 -:1];
assign i_mnim_i_main_core_no_name_sbni_link = i_router00_rbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(0+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)];
assign i_router00_rbni_ready_list[1*(0+1)-1 -:1] = i_mnim_i_main_core_no_name_sbni_ready;
assign i_router00_rfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(1+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)] = i_mnim_i_sub_core_001_no_name_sfni_link;
assign i_mnim_i_sub_core_001_no_name_sfni_ready = i_router00_rfni_ready_list[1*(1+1)-1 -:1];
assign i_mnim_i_sub_core_001_no_name_sbni_link = i_router00_rbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(1+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)];
assign i_router00_rbni_ready_list[1*(1+1)-1 -:1] = i_mnim_i_sub_core_001_no_name_sbni_ready;
assign i_router00_rfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(2+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)] = i_mnim_i_sub_core_002_no_name_sfni_link;
assign i_mnim_i_sub_core_002_no_name_sfni_ready = i_router00_rfni_ready_list[1*(2+1)-1 -:1];
assign i_mnim_i_sub_core_002_no_name_sbni_link = i_router00_rbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(2+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)];
assign i_router00_rbni_ready_list[1*(2+1)-1 -:1] = i_mnim_i_sub_core_002_no_name_sbni_ready;
assign i_router00_rfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(3+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)] = i_mnim_i_sub_core_003_no_name_sfni_link;
assign i_mnim_i_sub_core_003_no_name_sfni_ready = i_router00_rfni_ready_list[1*(3+1)-1 -:1];
assign i_mnim_i_sub_core_003_no_name_sbni_link = i_router00_rbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(3+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)];
assign i_router00_rbni_ready_list[1*(3+1)-1 -:1] = i_mnim_i_sub_core_003_no_name_sbni_ready;
assign i_inter_router_fifo00_rfni_link = i_router00_sfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(0+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)];
assign i_router00_sfni_ready_list[1*(0+1)-1 -:1] = i_inter_router_fifo00_rfni_ready;
assign i_router00_sbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(0+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)] = i_inter_router_fifo00_rbni_link;
assign i_inter_router_fifo00_rbni_ready = i_router00_sbni_ready_list[1*(0+1)-1 -:1];
assign i_inter_router_fifo01_rfni_link = i_router00_sfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(1+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)];
assign i_router00_sfni_ready_list[1*(1+1)-1 -:1] = i_inter_router_fifo01_rfni_ready;
assign i_router00_sbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(1+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)] = i_inter_router_fifo01_rbni_link;
assign i_inter_router_fifo01_rbni_ready = i_router00_sbni_ready_list[1*(1+1)-1 -:1];
assign i_system_router_rfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(0+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)] = i_inter_router_fifo00_sfni_link;
assign i_inter_router_fifo00_sfni_ready = i_system_router_rfni_ready_list[1*(0+1)-1 -:1];
assign i_inter_router_fifo00_sbni_link = i_system_router_rbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(0+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)];
assign i_system_router_rbni_ready_list[1*(0+1)-1 -:1] = i_inter_router_fifo00_sbni_ready;
assign i_system_router_rfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(1+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)] = i_inter_router_fifo02_sfni_link;
assign i_inter_router_fifo02_sfni_ready = i_system_router_rfni_ready_list[1*(1+1)-1 -:1];
assign i_inter_router_fifo02_sbni_link = i_system_router_rbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(1+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)];
assign i_system_router_rbni_ready_list[1*(1+1)-1 -:1] = i_inter_router_fifo02_sbni_ready;
assign i_snim_i_system_sram_no_name_rfni_link = i_system_router_sfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(0+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)];
assign i_system_router_sfni_ready_list[1*(0+1)-1 -:1] = i_snim_i_system_sram_no_name_rfni_ready;
assign i_system_router_sbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(0+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)] = i_snim_i_system_sram_no_name_rbni_link;
assign i_snim_i_system_sram_no_name_rbni_ready = i_system_router_sbni_ready_list[1*(0+1)-1 -:1];
assign i_snim_common_peri_group_no_name_rfni_link = i_system_router_sfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(1+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)];
assign i_system_router_sfni_ready_list[1*(1+1)-1 -:1] = i_snim_common_peri_group_no_name_rfni_ready;
assign i_system_router_sbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(1+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)] = i_snim_common_peri_group_no_name_rbni_link;
assign i_snim_common_peri_group_no_name_rbni_ready = i_system_router_sbni_ready_list[1*(1+1)-1 -:1];
assign i_snim_external_peri_group_no_name_rfni_link = i_system_router_sfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(2+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)];
assign i_system_router_sfni_ready_list[1*(2+1)-1 -:1] = i_snim_external_peri_group_no_name_rfni_ready;
assign i_system_router_sbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(2+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)] = i_snim_external_peri_group_no_name_rbni_link;
assign i_snim_external_peri_group_no_name_rbni_ready = i_system_router_sbni_ready_list[1*(2+1)-1 -:1];
assign i_snim_platform_controller_no_name_rfni_link = i_system_router_sfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(3+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)];
assign i_system_router_sfni_ready_list[1*(3+1)-1 -:1] = i_snim_platform_controller_no_name_rfni_ready;
assign i_system_router_sbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(3+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)] = i_snim_platform_controller_no_name_rbni_link;
assign i_snim_platform_controller_no_name_rbni_ready = i_system_router_sbni_ready_list[1*(3+1)-1 -:1];
assign default_slave_rfni_link = i_system_router_sfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(4+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)];
assign i_system_router_sfni_ready_list[1*(4+1)-1 -:1] = default_slave_rfni_ready;
assign i_system_router_sbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(4+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)] = default_slave_rbni_link;
assign default_slave_rbni_ready = i_system_router_sbni_ready_list[1*(4+1)-1 -:1];
assign i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_rfni_link = i_system_router_sfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(5+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)];
assign i_system_router_sfni_ready_list[1*(5+1)-1 -:1] = i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_rfni_ready;
assign i_system_router_sbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(5+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)] = i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_rbni_link;
assign i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_rbni_ready = i_system_router_sbni_ready_list[1*(5+1)-1 -:1];
assign i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_rfni_link = i_system_router_sfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(6+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)];
assign i_system_router_sfni_ready_list[1*(6+1)-1 -:1] = i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_rfni_ready;
assign i_system_router_sbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(6+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)] = i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_rbni_link;
assign i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_rbni_ready = i_system_router_sbni_ready_list[1*(6+1)-1 -:1];
assign i_user_router_rfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(0+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)] = i_inter_router_fifo01_sfni_link;
assign i_inter_router_fifo01_sfni_ready = i_user_router_rfni_ready_list[1*(0+1)-1 -:1];
assign i_inter_router_fifo01_sbni_link = i_user_router_rbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(0+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)];
assign i_user_router_rbni_ready_list[1*(0+1)-1 -:1] = i_inter_router_fifo01_sbni_ready;
assign i_user_router_rfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(1+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)] = i_mnim_platform_controller_master_sfni_link;
assign i_mnim_platform_controller_master_sfni_ready = i_user_router_rfni_ready_list[1*(1+1)-1 -:1];
assign i_mnim_platform_controller_master_sbni_link = i_user_router_rbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(1+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)];
assign i_user_router_rbni_ready_list[1*(1+1)-1 -:1] = i_mnim_platform_controller_master_sbni_ready;
assign i_user_router_rfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(2+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)] = i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_sfni_link;
assign i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_sfni_ready = i_user_router_rfni_ready_list[1*(2+1)-1 -:1];
assign i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_sbni_link = i_user_router_rbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(2+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)];
assign i_user_router_rbni_ready_list[1*(2+1)-1 -:1] = i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_sbni_ready;
assign i_user_router_rfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(3+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)] = i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_sfni_link;
assign i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_sfni_ready = i_user_router_rfni_ready_list[1*(3+1)-1 -:1];
assign i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_sbni_link = i_user_router_rbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(3+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)];
assign i_user_router_rbni_ready_list[1*(3+1)-1 -:1] = i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_sbni_ready;
assign i_user_router_rfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(4+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)] = i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_sfni_link;
assign i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_sfni_ready = i_user_router_rfni_ready_list[1*(4+1)-1 -:1];
assign i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_sbni_link = i_user_router_rbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(4+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)];
assign i_user_router_rbni_ready_list[1*(4+1)-1 -:1] = i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_sbni_ready;
assign i_user_router_rfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(5+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)] = i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_sfni_link;
assign i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_sfni_ready = i_user_router_rfni_ready_list[1*(5+1)-1 -:1];
assign i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_sbni_link = i_user_router_rbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(5+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)];
assign i_user_router_rbni_ready_list[1*(5+1)-1 -:1] = i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_sbni_ready;
assign i_user_router_rfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(6+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)] = i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_sfni_link;
assign i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_sfni_ready = i_user_router_rfni_ready_list[1*(6+1)-1 -:1];
assign i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_sbni_link = i_user_router_rbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(6+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)];
assign i_user_router_rbni_ready_list[1*(6+1)-1 -:1] = i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_sbni_ready;
assign i_user_router_rfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(7+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)] = i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_sfni_link;
assign i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_sfni_ready = i_user_router_rfni_ready_list[1*(7+1)-1 -:1];
assign i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_sbni_link = i_user_router_rbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(7+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)];
assign i_user_router_rbni_ready_list[1*(7+1)-1 -:1] = i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_sbni_ready;
assign i_snim_i_system_ddr_no_name_rfni_link = i_user_router_sfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(0+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)];
assign i_user_router_sfni_ready_list[1*(0+1)-1 -:1] = i_snim_i_system_ddr_no_name_rfni_ready;
assign i_user_router_sbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(0+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)] = i_snim_i_system_ddr_no_name_rbni_link;
assign i_snim_i_system_ddr_no_name_rbni_ready = i_user_router_sbni_ready_list[1*(0+1)-1 -:1];
assign i_inter_router_fifo02_rfni_link = i_user_router_sfni_link_list[`BW_FNI_LINK(BW_FNI_PHIT)*(1+1)-1 -:`BW_FNI_LINK(BW_FNI_PHIT)];
assign i_user_router_sfni_ready_list[1*(1+1)-1 -:1] = i_inter_router_fifo02_rfni_ready;
assign i_user_router_sbni_link_list[`BW_BNI_LINK(BW_BNI_PHIT)*(1+1)-1 -:`BW_BNI_LINK(BW_BNI_PHIT)] = i_inter_router_fifo02_rbni_link;
assign i_inter_router_fifo02_rbni_ready = i_user_router_sbni_ready_list[1*(1+1)-1 -:1];
assign platform_controller_rpc_list[32*(0+1)-1 -:32] = i_main_core_spc;
assign platform_controller_rinst_list[32*(0+1)-1 -:32] = i_main_core_sinst;
assign platform_controller_rpc_list[32*(1+1)-1 -:32] = i_sub_core_001_spc;
assign platform_controller_rinst_list[32*(1+1)-1 -:32] = i_sub_core_001_sinst;
assign platform_controller_rpc_list[32*(2+1)-1 -:32] = i_sub_core_002_spc;
assign platform_controller_rinst_list[32*(2+1)-1 -:32] = i_sub_core_002_sinst;
assign platform_controller_rpc_list[32*(3+1)-1 -:32] = i_sub_core_003_spc;
assign platform_controller_rinst_list[32*(3+1)-1 -:32] = i_sub_core_003_sinst;
assign default_slave_debug_rpsel = platform_controller_noc_debug_spsel;
assign default_slave_debug_rpenable = platform_controller_noc_debug_spenable;
assign default_slave_debug_rpwrite = platform_controller_noc_debug_spwrite;
assign default_slave_debug_rpaddr = platform_controller_noc_debug_spaddr;
assign default_slave_debug_rpwdata = platform_controller_noc_debug_spwdata;
assign platform_controller_noc_debug_spready = default_slave_debug_rpready;
assign platform_controller_noc_debug_sprdata = default_slave_debug_rprdata;
assign platform_controller_noc_debug_spslverr = default_slave_debug_rpslverr;
assign core_peri_group_rpsel = i_mnim_i_main_core_no_name_local_spsel;
assign core_peri_group_rpenable = i_mnim_i_main_core_no_name_local_spenable;
assign core_peri_group_rpwrite = i_mnim_i_main_core_no_name_local_spwrite;
assign core_peri_group_rpaddr = i_mnim_i_main_core_no_name_local_spaddr;
assign core_peri_group_rpwdata = i_mnim_i_main_core_no_name_local_spwdata;
assign i_mnim_i_main_core_no_name_local_spready = core_peri_group_rpready;
assign i_mnim_i_main_core_no_name_local_sprdata = core_peri_group_rprdata;
assign i_mnim_i_main_core_no_name_local_spslverr = core_peri_group_rpslverr;
assign autoname_106_rpsel = i_mnim_i_sub_core_001_no_name_local_spsel;
assign autoname_106_rpenable = i_mnim_i_sub_core_001_no_name_local_spenable;
assign autoname_106_rpwrite = i_mnim_i_sub_core_001_no_name_local_spwrite;
assign autoname_106_rpaddr = i_mnim_i_sub_core_001_no_name_local_spaddr;
assign autoname_106_rpwdata = i_mnim_i_sub_core_001_no_name_local_spwdata;
assign i_mnim_i_sub_core_001_no_name_local_spready = autoname_106_rpready;
assign i_mnim_i_sub_core_001_no_name_local_sprdata = autoname_106_rprdata;
assign i_mnim_i_sub_core_001_no_name_local_spslverr = autoname_106_rpslverr;
assign autoname_107_rpsel = i_mnim_i_sub_core_002_no_name_local_spsel;
assign autoname_107_rpenable = i_mnim_i_sub_core_002_no_name_local_spenable;
assign autoname_107_rpwrite = i_mnim_i_sub_core_002_no_name_local_spwrite;
assign autoname_107_rpaddr = i_mnim_i_sub_core_002_no_name_local_spaddr;
assign autoname_107_rpwdata = i_mnim_i_sub_core_002_no_name_local_spwdata;
assign i_mnim_i_sub_core_002_no_name_local_spready = autoname_107_rpready;
assign i_mnim_i_sub_core_002_no_name_local_sprdata = autoname_107_rprdata;
assign i_mnim_i_sub_core_002_no_name_local_spslverr = autoname_107_rpslverr;
assign autoname_108_rpsel = i_mnim_i_sub_core_003_no_name_local_spsel;
assign autoname_108_rpenable = i_mnim_i_sub_core_003_no_name_local_spenable;
assign autoname_108_rpwrite = i_mnim_i_sub_core_003_no_name_local_spwrite;
assign autoname_108_rpaddr = i_mnim_i_sub_core_003_no_name_local_spaddr;
assign autoname_108_rpwdata = i_mnim_i_sub_core_003_no_name_local_spwdata;
assign i_mnim_i_sub_core_003_no_name_local_spready = autoname_108_rpready;
assign i_mnim_i_sub_core_003_no_name_local_sprdata = autoname_108_rprdata;
assign i_mnim_i_sub_core_003_no_name_local_spslverr = autoname_108_rpslverr;
assign platform_controller_pjtag_rtck = pjtag_rtck;
assign platform_controller_pjtag_rtrstnn = pjtag_rtrstnn;
assign platform_controller_pjtag_rtms = pjtag_rtms;
assign platform_controller_pjtag_rtdi = pjtag_rtdi;
assign pjtag_rtdo = platform_controller_pjtag_rtdo;
assign external_peri_group_oled_sdcsel_ival = 0;
assign external_peri_group_oled_srstnn_ival = 0;
assign external_peri_group_oled_svbat_ival = 0;
assign external_peri_group_oled_svdd_ival = 0;
assign external_peri_group_wifi_sitr = 0;
assign default_slave_svri_rlink = 0;
assign default_slave_svri_sack = 0;
assign i_mnim_i_main_core_no_name_svri_rlink = 0;
assign i_mnim_i_main_core_no_name_svri_sack = 0;
assign i_mnim_i_sub_core_001_no_name_svri_rlink = 0;
assign i_mnim_i_sub_core_001_no_name_svri_sack = 0;
assign i_mnim_i_sub_core_002_no_name_svri_rlink = 0;
assign i_mnim_i_sub_core_002_no_name_svri_sack = 0;
assign i_mnim_i_sub_core_003_no_name_svri_rlink = 0;
assign i_mnim_i_sub_core_003_no_name_svri_sack = 0;
assign i_snim_i_system_sram_no_name_svri_rlink = 0;
assign i_snim_i_system_sram_no_name_svri_sack = 0;
assign i_snim_common_peri_group_no_name_svri_rlink = 0;
assign i_snim_common_peri_group_no_name_svri_sack = 0;
assign i_snim_external_peri_group_no_name_svri_rlink = 0;
assign i_snim_external_peri_group_no_name_svri_sack = 0;
assign i_snim_platform_controller_no_name_svri_rlink = 0;
assign i_snim_platform_controller_no_name_svri_sack = 0;
assign i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_svri_rlink = 0;
assign i_snim_i_dca_matrix_conv00_control_mmiox1_interface_mmio_svri_sack = 0;
assign i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_svri_rlink = 0;
assign i_snim_i_dca_matrix_mac00_control_mmiox1_interface_mmio_svri_sack = 0;
assign i_mnim_platform_controller_master_svri_rlink = 0;
assign i_mnim_platform_controller_master_svri_sack = 0;
assign i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_svri_rlink = 0;
assign i_mnim_i_dca_matrix_conv00_mi_mlsu_noc_part_svri_sack = 0;
assign i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_svri_rlink = 0;
assign i_mnim_i_dca_matrix_conv00_mk_mlsu_noc_part_svri_sack = 0;
assign i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_svri_rlink = 0;
assign i_mnim_i_dca_matrix_conv00_mo_mlsu_noc_part_svri_sack = 0;
assign i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_svri_rlink = 0;
assign i_mnim_i_dca_matrix_mac00_ma_mlsu_noc_part_svri_sack = 0;
assign i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_svri_rlink = 0;
assign i_mnim_i_dca_matrix_mac00_mb_mlsu_noc_part_svri_sack = 0;
assign i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_svri_rlink = 0;
assign i_mnim_i_dca_matrix_mac00_mc_mlsu_noc_part_svri_sack = 0;
assign i_snim_i_system_ddr_no_name_svri_rlink = 0;
assign i_snim_i_system_ddr_no_name_svri_sack = 0;
assign core_peri_group_tcu_spready = 0;
assign core_peri_group_tcu_sprdata = 0;
assign core_peri_group_tcu_spslverr = 0;
assign autoname_106_tcu_spready = 0;
assign autoname_106_tcu_sprdata = 0;
assign autoname_106_tcu_spslverr = 0;
assign autoname_107_tcu_spready = 0;
assign autoname_107_tcu_sprdata = 0;
assign autoname_107_tcu_spslverr = 0;
assign autoname_108_tcu_spready = 0;
assign autoname_108_tcu_sprdata = 0;
assign autoname_108_tcu_spslverr = 0;
assign core_peri_group_florian_spready = 0;
assign core_peri_group_florian_sprdata = 0;
assign core_peri_group_florian_spslverr = 0;
assign autoname_106_florian_spready = 0;
assign autoname_106_florian_sprdata = 0;
assign autoname_106_florian_spslverr = 0;
assign autoname_107_florian_spready = 0;
assign autoname_107_florian_sprdata = 0;
assign autoname_107_florian_spslverr = 0;
assign autoname_108_florian_spready = 0;
assign autoname_108_florian_sprdata = 0;
assign autoname_108_florian_spslverr = 0;
assign printf_tx = external_peri_group_uart_stx_list[1*(`UART_INDEX_FOR_UART_PRINTF+1)-1 -:1];
assign external_peri_group_uart_srx_list[1*(`UART_INDEX_FOR_UART_PRINTF+1)-1 -:1] = printf_rx;
assign spi_flash_sclk = external_peri_group_spi_sclk_list[1*(`SPI_INDEX_FOR_SPI_FLASH+1)-1 -:1];
assign spi_flash_scs = external_peri_group_spi_scs_list[1*(`SPI_INDEX_FOR_SPI_FLASH+1)-1 -:1];
assign spi_flash_sdq0 = external_peri_group_spi_sdq0_list[1*(`SPI_INDEX_FOR_SPI_FLASH+1)-1 -:1];
assign external_peri_group_spi_sdq1_list[1*(`SPI_INDEX_FOR_SPI_FLASH+1)-1 -:1] = spi_flash_sdq1;


endmodule