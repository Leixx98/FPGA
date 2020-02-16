`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/16 10:19:56
// Design Name: 
// Module Name: top_tb
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


module top_tb(

    );

reg clk_100m;
reg rst_n;
wire uart_rx;
wire ADC0_CLK;
wire [9:0]ADC0_D;
wire ADC1_CLK;
wire [9:0]ADC1_D;
wire [9:0]DAC0_D;
wire DAC0_CLK;
wire DAC0_PD;
wire uart_tx;

initial
begin
    clk_100m = 1'b0;
    rst_n = 1'b1;
    #10
    rst_n = 1'b0;
    #500
    rst_n = 1'b1;
end

always #10 clk_100m = ~clk_100m;

top top(
    .clk_100m(clk_100m),
    .rst_n(rst_n),
    .uart_rx(uart_rx),
    .uart_tx(uart_tx),
    .ADC0_CLK(ADC0_CLK),
    .ADC0_D(ADC0_D),
    .ADC1_CLK(ADC1_CLK),
    .ADC1_D(ADC1_D),
    .DAC0_D(DAC0_D),
    .DAC0_CLK(DAC0_CLK),
    .DAC0_PD(DAC0_PD)
);

endmodule
