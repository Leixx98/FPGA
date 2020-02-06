`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/11 11:26:42
// Design Name: 
// Module Name: Top_tb
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


module Top_tb(

    );

reg clk_100m;
reg rst_n;


initial
begin
    clk_100m = 1'b0;
    rst_n = 1'b1;
    #10
    rst_n = 1'b0;
    #500
    rst_n = 1'b1;
end

Top Top_Ini
(
    .clk_100m(clk_100m),
    .rst_n(rst_n)
);

endmodule
