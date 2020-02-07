`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/06 15:07:18
// Design Name: 
// Module Name: smg_control
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


module smg_control(
    input clk_100m,
    input rst_n,
    input [15:0]smg_number,
    output [7:0]smg_data,
    output [3:0]smg_scan
    );

wire [3:0]output_number;
//将要显示的值编码后输出到数码管的段选
smg_encode smg_encode     
(
    .clk_100m(clk_100m),
    .rst_n(rst_n),
    .smg_data(smg_data),
    .output_number(output_number)
);

smg_select smg_select
(
    .clk_100m(clk_100m),
    .rst_n(rst_n),
    .smg_number(smg_number),
    .output_number(output_number)
);

smg_scans smg_scans
(
    .clk_100m(clk_100m),
    .rst_n(rst_n),
    .smg_scan(smg_scan)
);

endmodule
