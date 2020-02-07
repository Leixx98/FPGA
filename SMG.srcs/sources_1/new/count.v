`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/06 15:11:54
// Design Name: 
// Module Name: count
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


module count(
    input rst_n,
    input clk_100m,
    output [15:0]smg_number
    );
parameter t100ms = 24'd9_999_999;
reg [23:0]count=24'd0;

///////////////////////////////////////////
//计数模块
///////////////////////////////////////////
always @(posedge clk_100m or negedge rst_n)
begin
    if(!rst_n)
        count <= 24'd0;
    else if(count == t100ms)
        count <= 24'd0;
    else 
        count <= count + 1'b1;      
end

reg [3:0]i=4'd0;
reg [15:0]smg_num_r=16'd0;
reg [15:0]smg_number_r=16'd0;

///////////////////////////////////////////
//进位模块
///////////////////////////////////////////
always @(posedge clk_100m or negedge rst_n)
begin
    if(!rst_n)
    begin
        i <= 4'd0;
        smg_num_r <= 24'd0;
        smg_number_r <= 24'd0;
    end
    else
    begin
        case (i)
            4'd0:if(count==t100ms)begin smg_num_r[3:0]<=smg_num_r[3:0]+1'b1;i<=i+1'b1;end //个位的计数
            4'd1:if(smg_num_r[3:0]>4'd9)begin smg_num_r[7:4]<=smg_num_r[7:4]+1'b1;smg_num_r[3:0]<=4'd0; 
                                              i<=i+1'b1;end//个位>9，向十位进1
                 else i<=i+1'b1;
            4'd2:if(smg_num_r[7:4]>4'd9)begin smg_num_r[11:8]<=smg_num_r[7:4]+1'b1;smg_num_r[7:4]<=4'd0; 
                                              i<=i+1'b1;end//十位>9，向百位进1
                 else i<=i+1'b1; 
            4'd3:if(smg_num_r[11:8]>4'd9)begin smg_num_r[15:12]<=smg_num_r[15:12]+1'b1;smg_num_r[11:8]<=4'd0; 
                                              i<=i+1'b1;end//百位>9，向千位进1
                 else i<=i+1'b1;                              
            4'd4:if(smg_num_r[15:12]>4'd9)begin smg_num_r<=16'd0;
                                              i<=i+1'b1;end//千位>9，归零重新计数
                 else i<=i+1'b1;                                                                             
            4'd5:begin smg_number_r <= smg_num_r;i<=4'd0;end
        endcase
    end
end

assign smg_number = smg_number_r;


endmodule
