`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/23 15:55:56
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input   clk,
    input   rst_n,
    input 	[15:0]ad_data
    );

//------------采样率控制------------------//
wire    clk_fft;           //采样率
clk_ctrl        clk_ctrl_inst(
	.clk        (clk),
	.clk_fft    (clk_fft)
);

//------------FFT IP------------------//
wire	[15:0]	data_out_im;
wire	[15:0]	data_out_re;
wire    m_axis_data_tvalid;      //一帧数据开始信号
fft_ctrl                FFT_Ctrl_inst(
    .clk                (clk),
	.rst_n              (rst_n),
    .clk_fft            (clk_fft),
	.data_in            (ad_data),
	.data_out_re        (data_out_re),
    .data_out_im        (data_out_im),
	.m_axis_data_tvalid  (m_axis_data_tvalid)
);

//--------------RAM IP-------------------//
ram_ctrl ram_ctrl_inst(
    .clk				(clk),
    .rst_n				(rst_n),
    
    .clk_fft			(clk_fft),
    .m_axis_data_tvalid	(m_axis_data_tvalid),
    .fft_re			    (data_out_re),
    .ram_out			(ram_out)    
);

endmodule
