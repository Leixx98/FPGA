`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/06 16:06:15
// Design Name: 
// Module Name: smg_scan
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


module smg_scans(
    input clk_100m,
    input rst_n,
    output [3:0]smg_scan
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
reg [3:0]smg_scan_r=4'd0;
always @(posedge clk_100m or negedge rst_n)
begin
    if(!rst_n)
    begin
        i <= 4'd0;
        smg_scan_r <= 4'b1111;
    end
    else
        case (i)
            4'd0:if(count == t1ms)i<=i+1'b1;
                 else smg_scan_r<=4'b0111;         //选通第一个数码管
            4'd1:if(count == t1ms)i<=i+1'b1;
                 else smg_scan_r<=4'b1011;         //选通第二个数码管
            4'd2:if(count == t1ms)i<=i+1'b1;
                 else smg_scan_r<=4'b1101;         //选通第三个数码管
            4'd3:if(count == t1ms)i<=4'd0;
                 else smg_scan_r<=4'b1110;         //选通第四个数码管                                                     
        endcase 
end

assign smg_scan = smg_scan_r; 

endmodule
