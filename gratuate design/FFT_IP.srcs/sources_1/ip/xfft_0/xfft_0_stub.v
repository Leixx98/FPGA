// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Fri Apr 24 12:57:47 2020
// Host        : LAPTOP-O8J4EGBC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top xfft_0 -prefix
//               xfft_0_ xfft_0_stub.v
// Design      : xfft_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "xfft_v9_1_1,Vivado 2018.3" *)
module xfft_0(aclk, s_axis_config_tdata, 
  s_axis_config_tvalid, s_axis_config_tready, s_axis_data_tdata, s_axis_data_tvalid, 
  s_axis_data_tready, s_axis_data_tlast, m_axis_data_tdata, m_axis_data_tuser, 
  m_axis_data_tvalid, m_axis_data_tlast, m_axis_status_tdata, m_axis_status_tvalid, 
  event_frame_started, event_tlast_unexpected, event_tlast_missing, event_fft_overflow, 
  event_data_in_channel_halt)
/* synthesis syn_black_box black_box_pad_pin="aclk,s_axis_config_tdata[15:0],s_axis_config_tvalid,s_axis_config_tready,s_axis_data_tdata[31:0],s_axis_data_tvalid,s_axis_data_tready,s_axis_data_tlast,m_axis_data_tdata[31:0],m_axis_data_tuser[7:0],m_axis_data_tvalid,m_axis_data_tlast,m_axis_status_tdata[7:0],m_axis_status_tvalid,event_frame_started,event_tlast_unexpected,event_tlast_missing,event_fft_overflow,event_data_in_channel_halt" */;
  input aclk;
  input [15:0]s_axis_config_tdata;
  input s_axis_config_tvalid;
  output s_axis_config_tready;
  input [31:0]s_axis_data_tdata;
  input s_axis_data_tvalid;
  output s_axis_data_tready;
  input s_axis_data_tlast;
  output [31:0]m_axis_data_tdata;
  output [7:0]m_axis_data_tuser;
  output m_axis_data_tvalid;
  output m_axis_data_tlast;
  output [7:0]m_axis_status_tdata;
  output m_axis_status_tvalid;
  output event_frame_started;
  output event_tlast_unexpected;
  output event_tlast_missing;
  output event_fft_overflow;
  output event_data_in_channel_halt;
endmodule
