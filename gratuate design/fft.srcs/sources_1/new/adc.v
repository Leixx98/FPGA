`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/01 17:19:13
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
    input sample_begin,                   //ADC采样标志位
    input trans_begin,                    //向FFT模块传输数据标志位    
    input [9:0]trans_cnt,       //与fft模块同步的计数器
    output sample_done,         //adc采样完成标志位
    output ADC0_CLK,
    input [9:0]ADC0_D,
    output signed [10:0]adc_dataout
    );

//常数定义
parameter N = 11'd1024;     //fft计算点数

reg signed [10:0] adcdata_buf [0:N-1];  //原始输入数据,最高位为符号位
reg [9:0]ad_data_r0=10'd0;          //ADC采样数据

reg [10:0]adc_cnt;
reg signed [10:0]adc_dataout_r; 
////////////ADC采样和传输////////////
always @(posedge clk_30m or negedge rst_n)begin
    if (!rst_n) begin
        ad_data_r0 <= 11'd0;
        adc_cnt <= 11'd0;
    end    
    else if(sample_begin) begin
        ad_data_r0 = ADC0_D ;
        adcdata_buf[adc_cnt] = {1'b0,ad_data_r0};
        adc_cnt = adc_cnt+1'b1;
    end
    else if(trans_begin) begin
        adc_dataout_r <= adcdata_buf[trans_cnt];   
    end
    else begin
        adc_cnt <= 11'd0;
    end    
end

assign ADC0_CLK = clk_30m;
assign adc_dataout = adc_dataout_r; 
assign sample_done = sample_begin&&adc_cnt[10];    //若已存满1024个，则完成采样

endmodule
