`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/11 10:29:28
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

module Uart_TX(
	input clk_100m,
	input [7:0] uart_tx_data,	 
    input rst_n,    
	input uart_tx_en,		       
	output uart_tx_done,
    output uart_tx
);

parameter BAUD_DIV     = 16'd868;          //buads115200
parameter BAUD_DIV_CAP = 16'd434;

reg [9:0] send_data=10'b1111111111;  
reg [3:0] bit_num=0;
reg uart_send_flag=0;	

reg [15:0] cnt=16'd0;        //分频计数
reg uartclk=0;
reg uart_tx_r=1;

///////////////////////////////////////////
//分频：1000MHZ的时钟10416分频
///////////////////////////////////////////
always@(posedge clk_100m or negedge rst_n)
begin
    if(!rst_n)
    begin
        uartclk <= 1'b0;
        cnt <= 1'b0;
    end
    else if(cnt == BAUD_DIV_CAP)
    begin
        uartclk <= 1'b1;
        cnt <= cnt + 1'b1; 
    end
    else if(cnt < BAUD_DIV & uart_send_flag) 
    begin
        uartclk <= 1'b0;
        cnt <= cnt + 1'b1; 
    end
    else
    begin
        uartclk <= 1'b0;
        cnt <= 16'b0;

    end
end

///////////////////////////////////////////
//装载数据，并和起始位，停止位合并
///////////////////////////////////////////
always@(posedge clk_100m or negedge rst_n)
begin
    if(!rst_n)
    begin
        uart_send_flag <= 1'b0;
        send_data <= 10'b1_11111111_1;
    end
    else if(uart_tx_en)
    begin
        uart_send_flag <= 1'b1;
        send_data <= {1'b1,uart_tx_data,1'b0}; //发送10位，{停止位，数据，起始位} 
    end
    else if(bit_num == 4'd10)  //一次发送结束 
    begin
        uart_send_flag <= 1'b0;
        send_data <= 10'b1_11111111_1;
    end
end

always@(posedge clk_100m or negedge rst_n) 
begin
    if(!rst_n)
    begin
        uart_tx_r <= 1'b1;
        bit_num <= 4'd0;
    end
    else if(uart_send_flag) 
    begin
        if(uartclk) 
        begin
            if(bit_num <= 4'd9) 
            begin
                uart_tx_r <= send_data[bit_num];
                bit_num <= bit_num + 1'b1;
            end
            else if(bit_num == 4'd10)
            begin
                bit_num <= 0;
            end
        end
    end
    else 
    begin
        uart_tx_r <= 1'b1;
        bit_num <= 4'd0;
    end    
end

assign uart_tx=uart_tx_r;
assign uart_tx_done = (bit_num == 10) ? 1:0;

endmodule










