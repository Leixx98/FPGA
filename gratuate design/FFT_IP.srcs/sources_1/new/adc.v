`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/25 19:04:27
// Design Name: 
// Module Name: adc
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


module adc(
    input clk_30m,
    input rst_n,
    ////////ADC0///////////////
    output ADC0_CLK,
    input [9:0]ADC0_D,
    output [15:0]ad_data0
    );


//--------------adc-------------------//
reg [15:0]ad_data0_r;

assign ADC0_CLK = clk_30m;

always @(posedge clk_30m or negedge rst_n) begin
    if(!rst_n)begin
        ad_data0_r <= 16'd0;
    end  
    else begin
        ad_data0_r <= ADC0_D;    
    end  
end

assign ad_data0 = ad_data0_r;


endmodule
