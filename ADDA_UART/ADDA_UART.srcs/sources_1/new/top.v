`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/17 13:01:48
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
    input uart_rx,
    ////////ADC0///////////////
    output ADC0_CLK,
    input [9:0]ADC0_D,
    ////////ADC1///////////////
    output ADC1_CLK,
    input [9:0]ADC1_D,
    ////////DAC0///////////////
    output [9:0]DAC0_D,
    output DAC0_CLK,
    output DAC0_PD, 
    output uart_tx
    );

wire [7:0] data_output;
wire [7:0] data_input;
wire [9:0] dac_dataout;
wire tx_sig;
wire tx_start_sig;
wire sw_start_sig;
wire rx_sig;
wire clk_30m;
wire clk_165m;

adc adc_ini
(
    .clk_30m(clk_30m),
    .rst_n(rst_n),
    .ADC0_CLK(ADC0_CLK),
    .ADC0_D(ADC0_D),
    .ADC1_CLK(ADC1_CLK),
    .ADC1_D(ADC1_D),
    .dataoutput(data_output),
    .tx_start_sig(tx_start_sig),
    .uart_tx_signal(tx_sig),
    .datainput(data_input),
    .dac_dataout(dac_dataout)
);

dac dac_ini
(
    .clk_165m(clk_165m),
    .rst_n(rst_n),
    .dac_datain(dac_dataout),
    .DAC0_D(DAC0_D),
    .DAC0_CLK(DAC0_CLK),
    .DAC0_PD(DAC0_PD)
);

Uart_TX_Control Uart_TX_Control_Ini
(
    .clk_100m(clk_100m),
    .rst_n(rst_n),
    .uart_data_txwait(data_output),
    .uart_tx_start(tx_start_sig),
    .uart_tx_signal(tx_sig),
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

clk_wiz_0 clk_wiz_0_Ini(
    .clk_in1(clk_100m),
    .clk_out1(clk_30m),
    .clk_out2(clk_165m)
);

ila_0 ila_0_Ini(
    .clk(clk_100m),
    .probe0(ADC0_D),
    .probe1(ADC1_D),
    .probe2(DAC0_D)
);

endmodule
