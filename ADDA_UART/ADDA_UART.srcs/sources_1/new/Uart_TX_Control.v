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

module Uart_TX_Control(
    input clk_100m,              //时钟输入
    input rst_n,                 //复位
    input [7:0] uart_data_txwait,    //将要发送的数据寄存器
    input uart_tx_start,        //开始发送一帧数据的标志位
    output uart_tx,
    output uart_tx_signal         //发送状态标志位
);

wire uart_tx_done;               //串口一帧数据发送完成标志

reg  [7:0]uart_tx_cache;         //串口发送数据缓存寄存器
reg  [7:0]uart_tx_buf;           //串口发送数据发送寄存器
reg  [1:0]state;                 //状态机状态寄存器        
reg  uart_tx_ready;              //开始发送数据标志位(接到uart_tx.v)
reg  start_signal;               
reg  start_signalcache;
reg  tx_signal=1'b0;                  //串口发送状态标志位

///////////////////////////////////////////
//读取开始发送信号
///////////////////////////////////////////
always@(posedge clk_100m)
begin
	start_signal <= uart_tx_start;
	start_signalcache <= start_signal;
end
wire tx_start = start_signal & ~start_signalcache;

///////////////////////////////////////////
//将要发送的数据装载到缓存寄存器中
///////////////////////////////////////////
always@(posedge clk_100m or negedge rst_n)
begin
	if(!rst_n)
		uart_tx_cache <= 8'd0;
	else if(tx_start)
		uart_tx_cache <= uart_data_txwait;
	else
		uart_tx_cache <= uart_tx_cache;
end

///////////////////////////////////////////
//发送控制状态机
///////////////////////////////////////////
always @(posedge clk_100m or negedge rst_n) 
begin
    if(!rst_n)      //复位键被按下
    begin
        state <= 2'b0;
        uart_tx_buf <= 8'b0;
        uart_tx_ready <= 1'b0;
        tx_signal <= 0;
    end  

    else
    begin
        case (state)
            2'b00:
            begin
                if(tx_start)      //接收到需要发送一帧数据
                begin
                    state <= state+1'b1;   //给数据装载一定缓冲时间
                    tx_signal <= 1'b1;
                end
            end
            2'b01:
            begin
                uart_tx_buf <= uart_tx_cache;  //将缓存中的数据装载到
                uart_tx_ready <= 1;         //启动发送
                state <= state+1'b1;
            end
            2'b10:
                if (uart_tx_done)      //完成一帧数据的发送
                begin
                    uart_tx_buf <= 8'b0;
                    uart_tx_ready <= 1'b0;
                    tx_signal <= 1'b0;
                    state <= 2'b00;   
                end 
            default: begin state <= 0; end
        endcase  
    end
end

assign uart_tx_signal = tx_signal;

Uart_TX Uart_TX_Ini
(
.clk_100m(clk_100m),
.rst_n(rst_n),
.uart_tx_data(uart_tx_buf),	      
.uart_tx_en(uart_tx_ready),			        
.uart_tx_done(uart_tx_done),
.uart_tx(uart_tx)
);


endmodule










