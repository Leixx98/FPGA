`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/01 16:54:14
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
reg [9:0]ADC0_D;
wire ADC0_CLK;

initial begin
    clk_100m = 1'b0;
    rst_n = 1'b1;
    #10
    rst_n = 1'b0;
    #500
    rst_n = 1'b1;
end

always #5 clk_100m = ~clk_100m;
always #5 ADC0_D = {$random} % 1024; 
// parameter data_num = 10'd1023;
// reg signed [10:0]  data_men[0:data_num];
// initial begin
//     $readmemb("E:/Data/Vivado_FPGA/PROJECT/fft_1024point/fft.srcs/sources_1/new/sin_test.txt",data_men);   //注意斜杠的方向，不能反<<<<<<<
// end

// always @(*) begin
//     adc_data = data_men[adcdata_cnt];    
// end


top top_ini(
    .clk_100m(clk_100m),
    .rst_n(rst_n),
    .ADC0_D(ADC0_D),
    .ADC0_CLK(ADC0_CLK)
);

endmodule
