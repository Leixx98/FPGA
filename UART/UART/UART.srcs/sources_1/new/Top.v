`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/10 16:03:28
// Design Name: 
// Module Name: Top
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


module Top(
    input clk_100m,
    input rst_n,
    input [1:0]sw,
    input uart_rx,
    output uart_tx
);

wire [7:0] data_output;
wire [7:0] data_input;
wire tx_sig;
wire tx_start_sig;
wire sw_start_sig;
wire rx_sig;

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
    .uart_data_receive(data_output), 
    .uart_tx_start(tx_start_sig),
    .uart_rx_signal(rx_sig),
    .uart_rx(uart_rx)   
);

Switch Switch_Ini
(
    .clk_100m(clk_100m),
    .rst_n(rst_n),
    .uart_tx_start(sw_start_sig),
    .sw(sw),
    .uart_tx_data(data_input)
);




endmodule
