`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/15 13:45:25
// Design Name: 
// Module Name: Uart_RX
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


module Uart_RX(
    input clk_100m,
    input rst_n,
	input uart_rx,
	output reg [7:0] uart_rx_data,
	output reg uart_rx_done
    );

parameter BAUD_DIV     = 16'd10416;  
parameter BAUD_DIV_CAP = 16'd5208; 

reg [15:0] cnt=16'd0;        //分频计数
reg uartclk=0;
reg uart_receive_flag=0;
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
    else if(cnt < BAUD_DIV & uart_receive_flag) 
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
//连续检测五个电平，如果均为低电平，说明检测到了起始位
///////////////////////////////////////////
reg [4:0] uart_rx_bus=5'b11111;			 
always@(posedge clk_100m)
begin
	uart_rx_bus<={uart_rx_bus[3:0],uart_rx};
end
wire uart_rx_detect=uart_rx_bus[4]|uart_rx_bus[3]
               |uart_rx_bus[2]|uart_rx_bus[1]|uart_rx_bus[0];

reg [3:0] uart_rx_step = 0;
reg [7:0] uart_rx_data_r = 0;
///////////////////////////////////////////
//数据接收
///////////////////////////////////////////
always@(posedge clk_100m or negedge rst_n)
begin
    if(!rst_n)
    begin
        uart_receive_flag <= 1'b0;
        uart_rx_done <= 1'b0;       
    end
    else
    begin
        case (uart_rx_step)
            4'd0:
                if(!uart_rx_detect)   //首位检测到了低电平
                begin
                    uart_rx_step <= uart_rx_step + 1'b1;
                    uart_receive_flag <= 1'b1;    
                end
            4'd1:
                if (uartclk)        //忽略第一位，即起始位
                begin
                    uart_rx_step <= uart_rx_step + 1'b1;       
                end
            //接收数据
            4'd2, 4'd3, 4'd4, 4'd5, 4'd6, 4'd7, 4'd8, 4'd9 :
                if (uartclk)        //忽略第一位，即起始位
                begin
                    uart_rx_step <= uart_rx_step + 1'b1; 
                    uart_rx_data_r[uart_rx_step-2] <= uart_rx;      
                end
            4'd10:                  //结束位接收
                if (uartclk) 
                begin
                    if(1'b1 == uart_rx)
                    begin
                        uart_rx_data <= uart_rx_data_r;
                        uart_receive_flag <= 1'b0;
                        uart_rx_done <= 1'b1;
                        uart_rx_step <= uart_rx_step + 1'b1;
                    end
                    else
                    begin
                        uart_rx_data <= 8'd0;
                        uart_receive_flag <= 1'b0;
                        uart_rx_done <= 1'b0;
                        uart_rx_step <= uart_rx_step + 1'b1;     
                        //如果没有接收到停止位，表示帧出错   
                    end                
                end
            default:
                begin
                    uart_rx_step <= 4'd0;   
                    uart_rx_done <= 1'b0; 
                end 
        endcase
    end
end


endmodule
