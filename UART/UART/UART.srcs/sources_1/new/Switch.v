`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/14 16:05:50
// Design Name: 
// Module Name: Switch
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


module Switch(
    input clk_100m,
    input [1:0]sw,
    input rst_n,
    output reg [7:0]uart_tx_data=8'b0000_0000,
    output reg uart_tx_start
);

reg button0_sig0;
reg button0_sig1;
reg button1_sig0;
reg button1_sig1;

wire [1:0]key;

always@ (posedge clk_100m or negedge rst_n)
begin
    if (!rst_n) 
    begin
        button0_sig0 <= 1'b0;
        button0_sig1 <= 1'b0;   
    end
    else
    begin
        button0_sig0 <= sw[0];
        button0_sig1 <= button0_sig0;
    end
end

assign key[0] =  ~button0_sig0 & button0_sig1;        //下降沿检测

always@ (posedge clk_100m or negedge rst_n)
begin
    if (!rst_n) 
    begin
        button1_sig0 <= 1'b0;
        button1_sig1 <= 1'b0;   
    end
    else
    begin
        button1_sig0 <= sw[1];
        button1_sig1 <= button1_sig0;
    end
end

assign key[1] =  ~button1_sig0 & button1_sig1;        //下降沿检测

always@ (posedge clk_100m or negedge rst_n)
begin
    if (!rst_n) 
    begin
        uart_tx_data <= 8'b0000_0000;
    end
    else
    begin
        case (key)
            2'b01:  
            begin
                uart_tx_data <= uart_tx_data + 1'b1;
                uart_tx_start <= 1'b1;
            end 
            2'b10:
            begin
                uart_tx_data <= uart_tx_data - 1'b1;
                uart_tx_start <= 1'b1; 
            end
            default: 
            begin
                uart_tx_start <= 1'b0; 
            end
        endcase
    end
end



endmodule
