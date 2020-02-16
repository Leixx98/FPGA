`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/17 13:02:33
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
    ////////ADC1///////////////
    output ADC1_CLK,
    input [9:0]ADC1_D,
    output [7:0]dataoutput,
    input [7:0]datainput,
    input uart_tx_signal,
    output tx_start_sig,
    output [9:0]dac_dataout
    );


reg [9:0]ad_data_r0=10'd0;
reg [9:0]ad_data_r1=10'd0;
reg [255:0] ad_databuf0=256'd0;
reg [255:0] ad_databuf0_r=256'd0;
reg [255:0] ad_databuf1_r=256'd0;
reg [255:0] ad_databuf1=256'd0;  
reg tx_start_sig_r=1'd0;
reg [7:0]dataoutput_r=8'd0;
reg ad_done=1'd0;

assign ADC0_CLK = clk_30m;
assign ADC1_CLK = clk_30m;
assign tx_start_sig = tx_start_sig_r;
assign dataoutput = dataoutput_r;

reg [7:0]cnt;
//////////////////////////////////////////
//ADC采样，并放入BUF中
//////////////////////////////////////////
always @(posedge clk_30m or negedge rst_n)
begin
    if (!rst_n) begin
        ad_data_r0 <= 10'd0;
        ad_data_r1 <= 10'd0;
        cnt <= 8'd0;
    end
    else if(!ad_done) begin
        ad_data_r0 <= ADC0_D;
        ad_data_r1 <= ADC1_D; 
        
        ad_databuf0 <= {ad_databuf0[239:0],6'd0,ad_data_r0[9:0]};
        ad_databuf1 <= {ad_databuf1[239:0],6'd0,ad_data_r1[9:0]};
        
        if (cnt<8'd16)begin
            cnt <= cnt+1'b1; 
        end
        else if (ad_databuf0_r[255:248]==8'hff||ad_databuf1_r[255:248]==8'hff) begin
            cnt <= 8'd0;    
        end
    end       
end

reg adc_choose=1'b0;
//////////////////////////////////////////
//ADC通道选择
//////////////////////////////////////////
always @(posedge clk_30m) begin
    if (datainput == 8'h0a) begin
        adc_choose <= 1'b1;
    end
    else 
        adc_choose <= 1'b0;
end

reg [1:0]state=2'd0;
//////////////////////////////////////////
//数据传输状态机
//////////////////////////////////////////
always @(posedge clk_30m or negedge rst_n)begin
    if (!rst_n) begin
        state <= 2'd0;
    end
    else 
        case (state)
            2'd0:
                if(cnt==8'd16&&!uart_tx_signal)begin
                    ad_done <= 1'b1;
                    state <= state +1'b1;
                    ad_databuf0_r <= ad_databuf0;
                    ad_databuf1_r <= ad_databuf1;         
                end
            2'd1:       //装载一帧数据
                if (!adc_choose&&!uart_tx_signal) begin
                    dataoutput_r <= ad_databuf0_r[255:248];  
                    ad_databuf0_r <= {ad_databuf0_r[247:0],8'hff};
                    state <= state+1'b1;   
                end
                else if(adc_choose&&!uart_tx_signal) begin
                    dataoutput_r <= ad_databuf1_r[255:248];  
                    ad_databuf1_r <= {ad_databuf1_r[247:0],8'hff};
                    state <= state+1'b1;
                  
                end 
            2'd2:        //开启串口传输
                if(ad_databuf0_r[255:248]==8'hff) begin
                    ad_done <= 1'b0;
                    state <= 2'd0;
                end
                else if (ad_databuf1_r[255:248]==8'hff) begin
                    ad_done <= 1'b0;
                    state <= 2'd0;     
                end  
                else begin
                    tx_start_sig_r <= 1'b1;
                    state <= state+1'b1;
                end
            2'd3:       //完成一帧数据传输
                if (uart_tx_signal) begin
                   tx_start_sig_r <= 1'b0;
                   state <= 2'd1;  
                end        
        endcase
end

assign dac_dataout = (adc_choose)?ADC1_D:ADC0_D;

endmodule
