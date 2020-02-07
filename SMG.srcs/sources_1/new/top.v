`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/06 15:06:57
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
    input rst_n,
    input clk_100m,
    output [7:0]smg_data,
    output [3:0]smg_scan
    );

wire [15:0]smg_number;

smg_control smg_control
(
    .rst_n(rst_n),
    .clk_100m(clk_100m),
    .smg_data(smg_data),
    .smg_scan(smg_scan),
    .smg_number(smg_number)
);

count count
(
    .rst_n(rst_n),
    .clk_100m(clk_100m),
    .smg_number(smg_number)
);

endmodule
