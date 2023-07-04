// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Thu Jun 22 20:28:38 2023
// Host        : macbuntu running 64-bit Ubuntu 22.04.2 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ i2s_transmitter_stub.v
// Design      : i2s_transmitter
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "i2s_transmitter_v1_0_6,Vivado 2023.1" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(s_axi_ctrl_aclk, s_axi_ctrl_aresetn, 
  aud_mclk, aud_mrst, s_axis_aud_aclk, s_axis_aud_aresetn, s_axi_ctrl_awvalid, 
  s_axi_ctrl_awready, s_axi_ctrl_awaddr, s_axi_ctrl_wvalid, s_axi_ctrl_wready, 
  s_axi_ctrl_wdata, s_axi_ctrl_bvalid, s_axi_ctrl_bready, s_axi_ctrl_bresp, 
  s_axi_ctrl_arvalid, s_axi_ctrl_arready, s_axi_ctrl_araddr, s_axi_ctrl_rvalid, 
  s_axi_ctrl_rready, s_axi_ctrl_rdata, s_axi_ctrl_rresp, irq, lrclk_out, sclk_out, sdata_0_out, 
  s_axis_aud_tdata, s_axis_aud_tid, s_axis_aud_tvalid, s_axis_aud_tready)
/* synthesis syn_black_box black_box_pad_pin="s_axi_ctrl_aresetn,aud_mrst,s_axis_aud_aresetn,s_axi_ctrl_awvalid,s_axi_ctrl_awready,s_axi_ctrl_awaddr[7:0],s_axi_ctrl_wvalid,s_axi_ctrl_wready,s_axi_ctrl_wdata[31:0],s_axi_ctrl_bvalid,s_axi_ctrl_bready,s_axi_ctrl_bresp[1:0],s_axi_ctrl_arvalid,s_axi_ctrl_arready,s_axi_ctrl_araddr[7:0],s_axi_ctrl_rvalid,s_axi_ctrl_rready,s_axi_ctrl_rdata[31:0],s_axi_ctrl_rresp[1:0],irq,lrclk_out,sclk_out,sdata_0_out,s_axis_aud_tdata[31:0],s_axis_aud_tid[2:0],s_axis_aud_tvalid,s_axis_aud_tready" */
/* synthesis syn_force_seq_prim="s_axi_ctrl_aclk" */
/* synthesis syn_force_seq_prim="aud_mclk" */
/* synthesis syn_force_seq_prim="s_axis_aud_aclk" */;
  input s_axi_ctrl_aclk /* synthesis syn_isclock = 1 */;
  input s_axi_ctrl_aresetn;
  input aud_mclk /* synthesis syn_isclock = 1 */;
  input aud_mrst;
  input s_axis_aud_aclk /* synthesis syn_isclock = 1 */;
  input s_axis_aud_aresetn;
  input s_axi_ctrl_awvalid;
  output s_axi_ctrl_awready;
  input [7:0]s_axi_ctrl_awaddr;
  input s_axi_ctrl_wvalid;
  output s_axi_ctrl_wready;
  input [31:0]s_axi_ctrl_wdata;
  output s_axi_ctrl_bvalid;
  input s_axi_ctrl_bready;
  output [1:0]s_axi_ctrl_bresp;
  input s_axi_ctrl_arvalid;
  output s_axi_ctrl_arready;
  input [7:0]s_axi_ctrl_araddr;
  output s_axi_ctrl_rvalid;
  input s_axi_ctrl_rready;
  output [31:0]s_axi_ctrl_rdata;
  output [1:0]s_axi_ctrl_rresp;
  output irq;
  output lrclk_out;
  output sclk_out;
  output sdata_0_out;
  input [31:0]s_axis_aud_tdata;
  input [2:0]s_axis_aud_tid;
  input s_axis_aud_tvalid;
  output s_axis_aud_tready;
endmodule
