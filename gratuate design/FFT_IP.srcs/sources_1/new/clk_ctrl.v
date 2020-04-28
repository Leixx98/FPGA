`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/24 12:45:44
// Design Name: 
// Module Name: clk_ctrl
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


module clk_ctrl(
    input clk_100m,
    output clk_30m,
    output clk_10m
    );

//-------------clk ip-------------------//
clk_wiz_0      clk_wiz_0_inst(
	.clk_in1				(clk_100m),
	.clk_out1				(clk_30m),
    .clk_out2               (clk_10m)
);

endmodule
