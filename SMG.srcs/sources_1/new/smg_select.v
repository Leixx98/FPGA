`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/06 16:07:06
// Design Name: 
// Module Name: smg_select
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


module smg_select(
    input clk_100m,
    input rst_n,
    input [15:0]smg_number,
    output [3:0]output_number
    );

parameter t1ms = 20'd99999;
reg [23:0]count=24'd0;

///////////////////////////////////////////
//计数模块
///////////////////////////////////////////
always @(posedge clk_100m or negedge rst_n)
begin
    if(!rst_n)
        count <= 24'd0;
    else if(count == t1ms)
        count <= 24'd0;
    else 
        count <= count + 1'b1;      
end

reg [3:0]i=4'd0;
reg [3:0]output_number_r=4'd0;
///////////////////////////////////////////
//选择输出哪一位数
///////////////////////////////////////////
always @(posedge clk_100m or negedge rst_n)
begin
    if(!rst_n)
        output_number_r <= 4'b1111;
    else
        case (i)
            4'd0:if(count == t1ms)i<=i+1'b1;
                 else output_number_r<=smg_number[15:12];
            4'd1:if(count == t1ms)i<=i+1'b1;
                 else output_number_r<=smg_number[11:8]; 
            4'd2:if(count == t1ms)i<=i+1'b1;
                 else output_number_r<=smg_number[7:4];  
            4'd3:if(count == t1ms)i<=4'd0;
                 else output_number_r<=smg_number[3:0];   
        endcase
end

assign output_number = output_number_r;

endmodule
