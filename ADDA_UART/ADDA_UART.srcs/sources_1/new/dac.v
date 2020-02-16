`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/16 09:58:44
// Design Name: 
// Module Name: dac
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


module dac(
    input clk_165m,
    input rst_n,
    input [9:0]dac_datain,
    
    output [9:0]DAC0_D,
    output DAC0_CLK,
    output DAC0_PD 
    );

reg [9:0]dac_data_r=10'd0;
assign DAC0_PD = 0;
assign DAC0_CLK = clk_165m;
assign DAC0_D = {dac_data_r[0],dac_data_r[1],dac_data_r[2],dac_data_r[3],dac_data_r[4],dac_data_r[5],
                 dac_data_r[6],dac_data_r[7],dac_data_r[8],dac_data_r[9]};

always @(negedge clk_165m)
begin
    dac_data_r <= dac_datain;
end

endmodule
