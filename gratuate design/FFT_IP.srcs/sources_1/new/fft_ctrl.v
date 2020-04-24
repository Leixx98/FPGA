`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/23 15:56:14
// Design Name: 
// Module Name: fft_ctrl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision: 2020/04/24 0.02
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fft_ctrl(
	input	clk,
	input	rst_n,
	input   clk_fft,              //采样率
	input	[15:0]	data_in,
	output	[15:0]	data_out_re,
	output	[15:0]	data_out_im,
	output	m_axis_data_tvalid    
    );

parameter fft_point = 16'd4096;		//FFT运算点数

//--------------接口信号--------------//
reg 	[31:0]	s_axis_data_tdata;
reg 	[15:0]	s_axis_config_tdata = 16'b00_00_00_10_11_11_11_11;
reg 	s_axis_config_tvalid;
reg 	s_axis_data_tvalid;
reg 	s_axis_data_tlast;
//reg 	m_axis_data_tready = 1;

wire 	[31:0]	m_axis_data_tdata;
wire 	s_axis_config_tready;
wire 	s_axis_data_tready;
wire	[7:0]m_axis_data_tuser;
//wire 	m_axis_data_tvalid;
wire 	m_axis_data_tlast;
wire	[7:0]	m_axis_status_tdata;
wire	m_axis_status_tvalid;
wire 	event_frame_started;
wire 	event_tlast_unexpected;
wire 	event_tlast_missing;
//wire 	event_status_channel_halt;
wire 	event_fft_overflow;
wire 	event_data_in_channel_halt;
//wire 	event_data_out_channel_halt;
//-----------------------------------//

//------------设置输入数据------------//
always @(posedge clk or negedge rst_n) begin
	if(!rst_n)	begin
		s_axis_data_tdata <= 0;
	end
	else	begin
		s_axis_data_tdata <= {{16'd0},data_in};		//虚部补零
	end
end
//------------设置配置通道------------//
always @(posedge clk or negedge rst_n) begin
	if(!rst_n)	begin
		s_axis_config_tvalid <= 0;
	end
	else if(s_axis_config_tready == 1)	begin
		s_axis_config_tvalid <= 1;
	end
	else	begin
		s_axis_config_tvalid <= 0;
	end
end
//------------设置数据通道-------------//
wire 	data_tready_pose;
wire 	data_tready_nege;
reg		data_tready_r0;
reg		data_tready_r1;
reg		data_tready_r2;
reg		[15:0]	cnt;
reg		cnt_en;

/*检测s_axis_data_tready上下沿*/
always @(posedge clk or negedge rst_n) begin
	if(!rst_n)	begin
		data_tready_r0 <= 0;
		data_tready_r1 <= 0;
		data_tready_r2 <= 0;
	end
	else	begin
		data_tready_r0 <= s_axis_data_tready;
		data_tready_r1 <= data_tready_r0;
		data_tready_r2 <= data_tready_r1;
	end
end
assign	data_tready_pose = data_tready_r1 & !data_tready_r2;
assign	data_tready_nege = !data_tready_r1 & data_tready_r2;
/*设置tvalid信号*/
always @(posedge clk or negedge rst_n) begin
	if(!rst_n)	begin
		s_axis_data_tvalid <= 0;
	end
	else if(data_tready_nege)	begin
		s_axis_data_tvalid <= 0;
	end
	else if(data_tready_pose)	begin
		s_axis_data_tvalid <= 1;
	end
	else	begin
		s_axis_data_tvalid <= s_axis_data_tvalid;
	end
end
/*设置tlast信号*/
always @(posedge clk or negedge rst_n) begin
	if(!rst_n)	begin
		cnt_en <= 0;
	end
	else if(data_tready_nege)	begin
		cnt_en <= 0;
	end
	else if(data_tready_pose)	begin
		cnt_en <= 1;
	end
    else if(cnt == fft_point-1) begin		//FFT运算点数
        cnt_en <= 0;
    end
end
always @(posedge clk or negedge rst_n) begin
	if(!rst_n)	begin
		cnt <= 0;
	end
	else if(cnt_en)	begin
		cnt <= cnt + 1;
	end
	else	begin
		cnt <= 0;
	end
end
always @(posedge clk or negedge rst_n) begin
	if(!rst_n)	begin
		s_axis_data_tlast <= 0;
	end
    else if(cnt == fft_point-1)  begin		//FFT运算点数
        s_axis_data_tlast <= 1;     //输入最后一个数据时，tlast信号产生一个脉冲
    end
    else    begin
        s_axis_data_tlast <= 0;
    end
end
//--------------------------------//

//---------------IP例化-------------//
xfft_0									FFT_inst(
  	.aclk							(clk_fft),
  	.s_axis_config_tdata			(s_axis_config_tdata		),
  	.s_axis_config_tvalid			(s_axis_config_tvalid		),
  	.s_axis_config_tready			(s_axis_config_tready		),
  	.s_axis_data_tdata				(s_axis_data_tdata			),
  	.s_axis_data_tvalid				(s_axis_data_tvalid			),
  	.s_axis_data_tready				(s_axis_data_tready			),
  	.s_axis_data_tlast				(s_axis_data_tlast			),
  	.m_axis_data_tdata				(m_axis_data_tdata			),

	.m_axis_data_tuser				(m_axis_data_tuser),

  	.m_axis_data_tvalid				(m_axis_data_tvalid			),
  	.m_axis_data_tlast				(m_axis_data_tlast			),

	.m_axis_status_tdata			(m_axis_status_tdata),
	.m_axis_status_tvalid			(m_axis_status_tvalid),

  	.event_frame_started			(event_frame_started		),
  	.event_tlast_unexpected			(event_tlast_unexpected		),
  	.event_tlast_missing			(event_tlast_missing		),
	.event_fft_overflow				(event_fft_overflow),
  	.event_data_in_channel_halt		(event_data_in_channel_halt	)
);
//------------------将实部和虚部分开-----------------//
reg  [15:0]	data_out_im_r;
reg  [15:0]	data_out_re_r;
always @(posedge clk or negedge rst_n) begin
	if(!rst_n)	begin
		data_out_im_r <= 0;
	end
    else if(m_axis_data_tdata[15] == 0)  begin
        data_out_re_r <= m_axis_data_tdata[15:0];
    end
    else if(m_axis_data_tdata[15] == 1) begin		//取绝对值
        data_out_re_r <= -{m_axis_data_tdata[15:0]};
    end
    else begin
        data_out_re_r <= data_out_re_r;
    end
end
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
    	data_out_re_r <= 0;
    end
    else if(m_axis_data_tdata[31] == 0)  begin
        data_out_im_r <= m_axis_data_tdata[31:16];
    end
    else if(m_axis_data_tdata[31] == 1) begin		//取绝对值
        data_out_im_r <= -{m_axis_data_tdata[31:16]};
    end
	else	begin
		data_out_im_r <= data_out_im_r;
	end
end
//-----------------------------//
assign	data_out_im = data_out_im_r;
assign	data_out_re = data_out_re_r;

endmodule
