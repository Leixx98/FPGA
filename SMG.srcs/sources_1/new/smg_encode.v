`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/06 16:05:51
// Design Name: 
// Module Name: smg_encode
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


module smg_encode(
    input clk_100m,
    input rst_n,
    input [3:0]output_number,
    output [7:0]smg_data
    );

parameter _0 = 8'b1100_0000, _1 = 8'b1111_1001, _2 = 8'b1010_0100, 
	      _3 = 8'b1011_0000, _4 = 8'b1001_1001, _5 = 8'b1001_0010, 
		  _6 = 8'b1000_0010, _7 = 8'b1111_1000, _8 = 8'b1000_0000,
		  _9 = 8'b1001_0000;

reg [7:0]smg_data_r=8'd0;

always @(posedge clk_100m or negedge rst_n)
begin
    if(!rst_n)
        smg_data_r <= 8'b1111_1111; 
    else 
        case (output_number)
            4'd0:smg_data_r <= _0;
            4'd1:smg_data_r <= _1;
            4'd2:smg_data_r <= _2;
            4'd3:smg_data_r <= _3;
            4'd4:smg_data_r <= _4;
            4'd5:smg_data_r <= _5;
            4'd6:smg_data_r <= _6;
            4'd7:smg_data_r <= _7;
            4'd8:smg_data_r <= _8; 
            4'd9:smg_data_r <= _9;
        endcase  
end

assign smg_data = smg_data_r;

endmodule
