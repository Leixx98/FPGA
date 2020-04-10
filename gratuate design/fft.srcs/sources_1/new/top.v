`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/26 14:26:30
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
    input clk_100m,
    input rst_n,
    output ADC0_CLK,
    input [9:0]ADC0_D,
    output uart_tx,
    input uart_rx
    );

wire [23:0]fft_data;
wire clk_30m;
wire sample_begin;
wire trans_begin;
wire sample_done;
wire [9:0]trans_cnt;
wire [10:0]adc_data;
wire [7:0]data_output;
wire tx_start_sig;
wire uart_tx_signal;
wire data_input;
wire sw_start_sig;
wire rx_sig;


fft fft_ini(
    .clk_100m(clk_100m),
    .rst_n(rst_n),
    .sample_begin(sample_begin),
    .sample_done(sample_done),
    .trans_begin(trans_begin),
    .trans_cnt(trans_cnt),
    .adc_data(adc_data),
    .fft_data(fft_data)
);

adc adc_ini(
    .clk_30m(clk_30m),
    .rst_n(rst_n),
    .sample_begin(sample_begin),            //ADC采样标志位
    .trans_begin(trans_begin),              //向FFT模块传输数据标志位    
    .trans_cnt(trans_cnt),                  //与fft模块同步的计数器
    .sample_done(sample_done),
    .ADC0_CLK(ADC0_CLK),
    .ADC0_D(ADC0_D),
    .adc_dataout(adc_data)
);

Uart_TX_Control Uart_TX_Control_Ini
(
    .clk_100m(clk_100m),
    .rst_n(rst_n),
    .uart_data_txwait(data_output),
    .uart_tx_start(tx_start_sig),
    .uart_tx_signal(uart_tx_signal),
    .uart_tx(uart_tx)
);

Uart_RX_Control Uart_RX_Control_Ini
(
    .clk_100m(clk_100m),
    .rst_n(rst_n),
    .uart_data_receive(data_input), 
    .uart_tx_start(sw_start_sig),
    .uart_rx_signal(rx_sig),
    .uart_rx(uart_rx)   
);

clk_wiz_0 clk_wiz_0_ini(
    .clk_in1(clk_100m),
    .clk_out1(clk_30m)
);

endmodule
