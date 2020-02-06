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

module Uart_RX_Control(
    input clk_100m,              //时钟输入
    input rst_n,                 //复位
    input uart_rx,               //串口输入
    output [7:0] uart_data_receive, //串口接收到的数据
    output reg uart_tx_start,
    output uart_rx_signal         //接收状态标志位

);

reg [1:0] uart_rx_state;       //串口接收状态机
reg [7:0]uart_rx_buf;          //串口接收数据接收寄存器
reg uart_rx_sig;

wire uart_rx_done;
wire [7:0]uart_rx_data;

///////////////////////////////////////////
//发送控制状态机
///////////////////////////////////////////
always@(posedge clk_100m or negedge rst_n)
begin
    if (!rst_n) 
    begin
        uart_rx_state <= 1'b0;
        uart_rx_buf <= 8'b0000_0000;   
        uart_rx_sig <= 1'b0;
    end
    else
    begin
        case (uart_rx_state)
            2'b00:
            begin
                uart_rx_sig <= 1'b0;
                uart_rx_state <= uart_rx_state + 1'b1; 
            end 
            2'b01:
            begin
                if(uart_rx_done)
                begin
                    uart_rx_buf <= uart_rx_data;    
                    uart_rx_state <= uart_rx_state + 1'b1;
                    uart_tx_start <= 1'b1;
                end
            end
            2'b10:
            begin
                uart_rx_sig <= 1'b1;
                uart_rx_state <= uart_rx_state + 1'b1;
            end
            default:
            begin
                uart_rx_state <= 2'b00; 
                uart_tx_start <= 1'b0;
            end
        endcase
    end
end

assign uart_data_receive = uart_rx_buf;

Uart_RX Uart_RX_Ini
(
    .clk_100m(clk_100m),
    .rst_n(rst_n),
    .uart_rx(uart_rx),
    .uart_rx_data(uart_rx_data),
    .uart_rx_done(uart_rx_done)
);

endmodule