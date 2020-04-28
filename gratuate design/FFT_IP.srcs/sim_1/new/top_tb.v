`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/23 16:10:13
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

reg 	sclk;
reg		rst_n;
wire 	uart_tx;
reg  	[9:0]ADC0_D;
wire 	ADC0_CLK;

//--------------------------//
initial	sclk = 1;
always	#10	sclk = !sclk;

initial	begin
	rst_n = 0;
	#800
	rst_n = 1;
end

//------------读取外部数据-------------//
parameter data_num = 16'd4096;
//integer   i = 0;
reg	[15:0]	i = 0;
reg [9:0]  data_men[1:data_num];
initial begin
    $readmemb("E:/Data/Vivado_FPGA/PROJECT/FFT_IP/FFT_IP.srcs/sources_1/new/sin_test.txt",data_men);
end
always @(posedge sclk) begin
	if(i == data_num)	begin
		i <= 1;
		ADC0_D <= data_men[i];
	end
	else	begin
	    ADC0_D <= data_men[i];
	    i <= i + 1;
	end
end
//----------------例化-----------------//
top				        top_inst(
	.clk_100m			(sclk),
	.rst_n				(rst_n),
	.uart_tx			(uart_tx),
	.ADC0_D				(ADC0_D),
	.ADC0_CLK			(ADC0_CLK)
);

endmodule
