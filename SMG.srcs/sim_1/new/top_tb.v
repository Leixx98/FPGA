`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/06 17:02:26
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
wire [7:0]smg_data;
wire [3:0]smg_scan;


initial
begin
    clk_100m = 1'b0;
    rst_n = 1'b1;
end

always                                                         
begin                                                
    #10
    clk_100m = ~ clk_100m;
end 

top top
(
    .clk_100m(clk_100m),
    .rst_n(rst_n),
    .smg_data(smg_data),
    .smg_scan(smg_scan)
);

endmodule
