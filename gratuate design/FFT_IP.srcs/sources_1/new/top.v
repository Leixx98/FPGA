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
// Revision: 2020/04/26 0.03
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input   clk_100m,
    input   rst_n,
    output  uart_tx,
    ////////ADC0///////////////
    output ADC0_CLK,
    input [9:0]ADC0_D
    );

//------------采样率控制------------------//
wire    clk_30m;           //adc时钟
wire    clk_10m;           //采样率
clk_ctrl            clk_ctrl_inst(
	.clk_100m        (clk_100m),
	.clk_30m         (clk_30m),
    .clk_10m         (clk_10m)
);

//------------adc------------------//
wire [15:0] ad_data;
adc                         adc_inst(
    .clk_30m                (clk_30m),
    .rst_n                  (rst_n),
    .ADC0_D                 (ADC0_D),
    .ADC0_CLK               (ADC0_CLK),
    .ad_data0               (ad_data)
);

//------------FFT IP------------------//
wire	[15:0]	data_out_im;
wire	[15:0]	data_out_re;
wire    m_axis_data_tlast;      //一帧数据开始信号
fft_ctrl                FFT_Ctrl_inst(
    .clk_100m               (clk_100m),
	.rst_n                  (rst_n),
    .clk_10m                (clk_10m),
	.data_in                (ad_data),
	.data_out_re            (data_out_re),
    .data_out_im            (data_out_im),
	.m_axis_data_tlast     (m_axis_data_tlast)
);

//--------------uart tx-------------------//
wire    uart_tx_start;        //串口发送使能标志位
wire    uart_tx_signal;       //发送状态标志，1表示忙，0表示空闲
wire    [7:0] uart_txdata;
Uart_TX_Control Uart_TX_Control_Ini
(
    .clk_100m(clk_100m),
    .rst_n(rst_n),
    .uart_data_txwait(uart_txdata),
    .uart_tx_start(uart_tx_start),
    .uart_tx_signal(uart_tx_signal),
    .uart_tx(uart_tx)
);

//--------------RAM IP-------------------//
ram_ctrl ram_ctrl_inst(
    .clk_100m			(clk_100m),
    .rst_n				(rst_n),
    
    .clk_10m		    (clk_10m),
    .m_axis_data_tlast	(m_axis_data_tlast),
    .fft_re			    (data_out_re),

    .uart_tx_signal     (uart_tx_signal),
    .uart_tx_start      (uart_tx_start),
    .uart_txdata        (uart_txdata)    
);



endmodule
