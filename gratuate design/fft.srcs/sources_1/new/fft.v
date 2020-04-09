`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/26 14:26:49
// Design Name: 
// Module Name: fft
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


module fft(
    input clk_100m,
    input rst_n,
    output sample_begin,
    output trans_begin,
    output [9:0]trans_cnt,
    input sample_done,
    input signed [10:0]adc_data,     //输入ADC数据
    output [31:0]fft_data      //输出FFT数据
    );

//常数定义
parameter N = 11'd1024;     //fft计算点数
//数组和标志位定义
reg signed [23:0]wndatareal[0:511];     //旋转因子实部数据
reg signed [23:0]wndataimg[0:511];     //旋转因子虚部数据
wire signed [10:0]wndatareal_r;
wire signed [10:0]wndataimg_r;
reg [8:0]wndatareal_addr=0; //旋转因子实部查表地址 
reg [8:0]wndataimg_addr=0;   //旋转因子虚部查表地址
reg sample_begin_r;
reg trans_begin_r;


reg signed [23:0] input_data [0:N-1];  //原始输入数据,最高位为符号位

reg signed [23:0] dft_oridata [0:N-1];  //码位倒置后的输入数据，最高位为符号位

reg signed [23:0] dft_firoutreal [0:N-1];  //第一级DFT输出数据实部，最高位为符号位
reg signed [23:0] dft_firoutimg [0:N-1];  //第一级DFT输出数据虚部，最高位为符号位

reg signed [23:0] dft_secoutreal [0:N-1];  //第二级DFT输出数据实部，最高位为符号位
reg signed [23:0] dft_secoutimg [0:N-1];  //第二级DFT输出数据虚部，最高位为符号位

reg signed [23:0] dft_trdoutreal [0:N-1];  //第三级DFT输出数据实部，最高位为符号位
reg signed [23:0] dft_trdoutimg [0:N-1];  //第三级DFT输出数据虚部，最高位为符号位

reg signed [23:0] dft_foroutreal [0:N-1];  //第四级DFT输出数据实部，最高位为符号位
reg signed [23:0] dft_foroutimg [0:N-1];  //第四级DFT输出数据虚部，最高位为符号位

reg signed [23:0] dft_fifoutreal [0:N-1];  //第五级DFT输出数据实部，最高位为符号位
reg signed [23:0] dft_fifoutimg [0:N-1];  //第五级DFT输出数据虚部，最高位为符号位

reg signed [23:0] dft_sixoutreal [0:N-1];  //第六级DFT输出数据实部，最高位为符号位
reg signed [23:0] dft_sixoutimg [0:N-1];  //第六级DFT输出数据虚部，最高位为符号位

reg signed [23:0] dft_sevoutreal [0:N-1];  //第七级DFT输出数据实部，最高位为符号位
reg signed [23:0] dft_sevoutimg [0:N-1];  //第七级DFT输出数据虚部，最高位为符号位

reg signed [23:0] dft_eigoutreal [0:N-1];  //第八级DFT输出数据实部，最高位为符号位
reg signed [23:0] dft_eigoutimg [0:N-1];  //第八级DFT输出数据虚部，最高位为符号位

reg signed [23:0] dft_ninoutreal [0:N-1];  //第九级DFT输出数据实部，最高位为符号位
reg signed [23:0] dft_ninoutimg [0:N-1];  //第九级DFT输出数据虚部，最高位为符号位

reg signed [23:0] dft_tenoutreal [0:N-1];  //第十级DFT输出数据实部，最高位为符号位
reg signed [23:0] dft_tenoutimg [0:N-1];  //第十级DFT输出数据虚部，最高位为符号位


///fft流水线///////
reg [4:0] state=0;   //状态机
reg [10:0]data_cnt=0;//数据计数
reg [10:0]wndata_cnt=0; //旋转因子计数
reg [10:0]group_cnt=0; //每一阶计算时都会数据进行不同的分组，该寄存器计数已计算的分组，便去切换奇数和偶数部分，以及每一阶
reg [31:0]cache_real=0; //数据实部缓存（用于计算）
reg [31:0]cache_img=0;  //数据虚部缓存（用于计算）
reg [31:0]cache_realres=0;  //实部计算结果
reg [31:0]cache_imgres=0;  //虚部计算结果
reg [10:0]cal_stage=1;      //fft蝶形运算阶数对应的2次方,用于寻找蝶形运算的两个数据
reg [7:0]fft_stage=1;    //fft运算阶数
always@(posedge clk_100m or negedge rst_n) begin
   if(!rst_n) begin
       state <= 5'd0;
    end
    else begin
        case(state)
            5'd0:begin             //装载旋转因子
                #15 wndatareal[wndatareal_addr] = wndatareal_r;     //加延时是因为读取ROM表时有时延，为了保证时延对齐
                #15 wndataimg[wndataimg_addr] = wndataimg_r;  
                wndatareal_addr = wndatareal_addr+1'b1;
                wndataimg_addr = wndataimg_addr+1'b1;
                if(!wndatareal_addr)begin
                    state <= state+1'b1;    
                end
            end
            5'd1:begin            //开始ADC采样
                sample_begin_r <= 1'b1;   //开始ADC采样
                if(sample_done)begin
                    sample_begin_r <= 1'b0;
                    trans_begin_r<=1'b1;   //开始传输数据
                    state <= state+1;
                end
            end
            5'd2:begin                   //装载需要计算的数据       
                #15 input_data[data_cnt] = adc_data;
                data_cnt = data_cnt+1'b1;
                if(data_cnt==11'd1024) begin
                    trans_begin_r <= 1'b0; 
                    state <= state+1;
                    data_cnt <= 11'd0; 
                end 
            end 
            5'd3:begin                //码位倒置
                dft_oridata[data_cnt] = input_data[{data_cnt[0],data_cnt[1],data_cnt[2],data_cnt[3],data_cnt[4],data_cnt[5],
                                                    data_cnt[6],data_cnt[7],data_cnt[8],data_cnt[9]}];  
                data_cnt = data_cnt+1'b1; 
                if(data_cnt==N)begin
                    data_cnt <= 0;    
                    state <= state+1'b1; 
                end   
            end            
            5'd4:begin                 //第一级蝶形运算，N/2点DFT,计算偶数部分
                cache_real = dft_oridata[data_cnt+cal_stage]*wndatareal[wndatareal_addr];        //先计算旋转因子，分别计算实部和虚部
                cache_img = dft_oridata[data_cnt+cal_stage]*wndataimg[wndataimg_addr];
               
                cache_realres[31:0] = (dft_oridata[data_cnt]<<8) + cache_real;              //分别相加和相减
                cache_imgres[31:0] = cache_img;
                dft_firoutreal[data_cnt] = cache_realres[31:8];
                dft_firoutimg[data_cnt] = cache_imgres[31:8];

                cache_realres[31:0] = (dft_oridata[data_cnt]<<8) - cache_real;
                cache_imgres[31:0] = 0-cache_img;
                dft_firoutreal[data_cnt+cal_stage] = cache_realres[31:8];
                dft_firoutimg[data_cnt+cal_stage] = cache_imgres[31:8];                

                wndatareal_addr = wndatareal_addr+(N>>fft_stage);
                wndataimg_addr = wndataimg_addr+(N>>fft_stage); 
                wndata_cnt = wndata_cnt+1;  
                data_cnt = data_cnt+1;

                if(wndata_cnt==cal_stage)begin           //说明该分组已完成计算，切换到下一个分组
                    data_cnt = data_cnt+cal_stage;  
                    wndatareal_addr = 0;
                    wndataimg_addr = 0; 
                    wndata_cnt = 0;
                    group_cnt = group_cnt+1;        //已计算完一个分组
                    if(group_cnt==N>>(fft_stage+1))begin       //说明偶数部分已计算完成
                        group_cnt <= 0;
                        state <= state+1;
                        data_cnt <= N>>1;                        
                    end
                end  
            end
            5'd5:begin                 //第一级蝶形运算，N/2点DFT,计算奇数部分
                cache_real = dft_oridata[data_cnt+cal_stage]*wndatareal[wndatareal_addr];        //先计算旋转因子，分别计算实部和虚部
                cache_img = dft_oridata[data_cnt+cal_stage]*wndataimg[wndataimg_addr];
              
                cache_realres[31:0] = (dft_oridata[data_cnt]<<8) + cache_real;
                cache_imgres[31:0] = cache_img;
                dft_firoutreal[data_cnt] = cache_realres[31:8];
                dft_firoutimg[data_cnt] = cache_imgres[31:8];

                cache_realres[31:0] = (dft_oridata[data_cnt]<<8) - cache_real;
                cache_imgres[31:0] = 0-cache_img;
                dft_firoutreal[data_cnt+cal_stage] = cache_realres[31:8];
                dft_firoutimg[data_cnt+cal_stage] = cache_imgres[31:8];                

                wndatareal_addr = wndatareal_addr+(N>>fft_stage);
                wndataimg_addr = wndataimg_addr+(N>>fft_stage); 
                wndata_cnt = wndata_cnt+1;  
                data_cnt = data_cnt+1;

                if(wndata_cnt==cal_stage)begin           //说明该分组已完成计算，切换到下一个分组
                    data_cnt = data_cnt +cal_stage;  
                    wndatareal_addr = 0;
                    wndataimg_addr = 0; 
                    wndata_cnt = 0;
                    group_cnt = group_cnt+1;        //已计算完一个分组
                    if(group_cnt==(N>>(fft_stage+1)))begin       //说明奇数部分已计算完成
                        group_cnt <= 0;
                        state<= state+1;
                        cal_stage <= cal_stage<<1;
                        fft_stage <= fft_stage+1;
                        data_cnt <= 4'd0;                        
                    end
                end    
            end            
            5'd6:begin                //第二级蝶形运算，N/4点DFT，计算偶数部分
                cache_real = dft_firoutreal[data_cnt+cal_stage]*wndatareal[wndatareal_addr]-
                             dft_firoutimg[data_cnt+cal_stage]*wndataimg[wndataimg_addr];        //先计算旋转因子，分别计算实部和虚部
                cache_img = dft_firoutreal[data_cnt+cal_stage]*wndataimg[wndataimg_addr]+
                            dft_firoutimg[data_cnt+cal_stage]*wndatareal[wndatareal_addr];
                         
                cache_realres[31:0] = (dft_firoutreal[data_cnt]<<8) + cache_real;
                cache_imgres[31:0] = (dft_firoutimg[data_cnt]<<8) + cache_img;
                dft_secoutreal[data_cnt] = cache_realres[31:8];
                dft_secoutimg[data_cnt] = cache_imgres[31:8];

                cache_realres[31:0] = (dft_firoutreal[data_cnt]<<8) - cache_real;
                cache_imgres[31:0] = (dft_firoutimg[data_cnt]<<8)-cache_img;
                dft_secoutreal[data_cnt+cal_stage] = cache_realres[31:8];
                dft_secoutimg[data_cnt+cal_stage] = cache_imgres[31:8];                

                wndatareal_addr = wndatareal_addr+(N>>fft_stage);
                wndataimg_addr = wndataimg_addr+(N>>fft_stage); 
                wndata_cnt = wndata_cnt+1;  
                data_cnt = data_cnt+1;

                if(wndata_cnt==cal_stage)begin           //说明该分组已完成计算，切换到下一个分组
                    data_cnt = data_cnt+cal_stage;  
                    wndatareal_addr = 0;
                    wndataimg_addr = 0; 
                    wndata_cnt = 0;
                    group_cnt = group_cnt+1;        //已计算完一个分组
                    if(group_cnt==N>>(fft_stage+1))begin       //说明偶数部分已计算完成
                        group_cnt <= 0;
                        state <= state+1;
                        data_cnt <= N>>1;                        
                    end
                end               
            end
            5'd7:begin                //第二级蝶形运算，N/4点DFT，计算奇数部分
                cache_real = dft_firoutreal[data_cnt+cal_stage]*wndatareal[wndatareal_addr]-
                             dft_firoutimg[data_cnt+cal_stage]*wndataimg[wndataimg_addr];        //先计算旋转因子，分别计算实部和虚部
                cache_img = dft_firoutreal[data_cnt+cal_stage]*wndataimg[wndataimg_addr]+
                            dft_firoutimg[data_cnt+cal_stage]*wndatareal[wndatareal_addr];
                         
                cache_realres[31:0] = (dft_firoutreal[data_cnt]<<8) + cache_real;
                cache_imgres[31:0] = (dft_firoutimg[data_cnt]<<8) + cache_img;
                dft_secoutreal[data_cnt] = cache_realres[31:8];
                dft_secoutimg[data_cnt] = cache_imgres[31:8];

                cache_realres[31:0] = (dft_firoutreal[data_cnt]<<8) - cache_real;
                cache_imgres[31:0] = (dft_firoutimg[data_cnt]<<8)-cache_img;
                dft_secoutreal[data_cnt+cal_stage] = cache_realres[31:8];
                dft_secoutimg[data_cnt+cal_stage] = cache_imgres[31:8];                

                wndatareal_addr = wndatareal_addr+(N>>fft_stage);
                wndataimg_addr = wndataimg_addr+(N>>fft_stage); 
                wndata_cnt = wndata_cnt+1;  
                data_cnt = data_cnt+1;

                if(wndata_cnt==cal_stage)begin           //说明该分组已完成计算，切换到下一个分组
                    data_cnt = data_cnt +cal_stage;  
                    wndatareal_addr = 0;
                    wndataimg_addr = 0; 
                    wndata_cnt = 0;
                    group_cnt = group_cnt+1;        //已计算完一个分组
                    if(group_cnt==(N>>(fft_stage+1)))begin       //说明奇数部分已计算完成
                        group_cnt <= 0;
                        state<= state+1;
                        cal_stage <= cal_stage<<1;
                        fft_stage <= fft_stage+1;
                        data_cnt <= 4'd0;                        
                    end
                end                   
            end  
            5'd8:begin                //第三级蝶形运算，N/8点DFT，计算偶数部分
                cache_real = dft_secoutreal[data_cnt+cal_stage]*wndatareal[wndatareal_addr]-
                             dft_secoutimg[data_cnt+cal_stage]*wndataimg[wndataimg_addr];        //先计算旋转因子，分别计算实部和虚部
                cache_img = dft_secoutreal[data_cnt+cal_stage]*wndataimg[wndataimg_addr]+
                            dft_secoutimg[data_cnt+cal_stage]*wndatareal[wndatareal_addr];
                           
                cache_realres[31:0] = (dft_secoutreal[data_cnt]<<8) + cache_real;
                cache_imgres[31:0] = (dft_secoutimg[data_cnt]<<8) + cache_img;
                dft_trdoutreal[data_cnt] = cache_realres[31:8];
                dft_trdoutimg[data_cnt] = cache_imgres[31:8];

                cache_realres[31:0] = (dft_secoutreal[data_cnt]<<8) - cache_real;
                cache_imgres[31:0] = (dft_secoutimg[data_cnt]<<8)-cache_img;
                dft_trdoutreal[data_cnt+cal_stage] = cache_realres[31:8];
                dft_trdoutimg[data_cnt+cal_stage] = cache_imgres[31:8];                

                wndatareal_addr = wndatareal_addr+(N>>fft_stage);
                wndataimg_addr = wndataimg_addr+(N>>fft_stage); 
                wndata_cnt = wndata_cnt+1;  
                data_cnt = data_cnt+1;

                if(wndata_cnt==cal_stage)begin           //说明该分组已完成计算，切换到下一个分组
                    data_cnt = data_cnt +cal_stage;  
                    wndatareal_addr = 0;
                    wndataimg_addr = 0; 
                    wndata_cnt = 0;
                    group_cnt = group_cnt+1;        //已计算完一个分组
                    if(group_cnt==(N>>(fft_stage+1)))begin       //说明偶数部分已计算完成
                        group_cnt <= 0;
                        state<= state+1;
                        data_cnt <= N>>1;                        
                    end
                end               
            end
            5'd9:begin                //第三级蝶形运算，N/8点DFT，计算奇数部分
                cache_real = dft_secoutreal[data_cnt+cal_stage]*wndatareal[wndatareal_addr]-
                             dft_secoutimg[data_cnt+cal_stage]*wndataimg[wndataimg_addr];        //先计算旋转因子，分别计算实部和虚部
                cache_img = dft_secoutreal[data_cnt+cal_stage]*wndataimg[wndataimg_addr]+
                            dft_secoutimg[data_cnt+cal_stage]*wndatareal[wndatareal_addr];
                           
                cache_realres[31:0] = (dft_secoutreal[data_cnt]<<8) + cache_real;
                cache_imgres[31:0] = (dft_secoutimg[data_cnt]<<8) + cache_img;
                dft_trdoutreal[data_cnt] = cache_realres[31:8];
                dft_trdoutimg[data_cnt] = cache_imgres[31:8];

                cache_realres[31:0] = (dft_secoutreal[data_cnt]<<8) - cache_real;
                cache_imgres[31:0] = (dft_secoutimg[data_cnt]<<8)-cache_img;
                dft_trdoutreal[data_cnt+cal_stage] = cache_realres[31:8];
                dft_trdoutimg[data_cnt+cal_stage] = cache_imgres[31:8];                

                wndatareal_addr = wndatareal_addr+(N>>fft_stage);
                wndataimg_addr = wndataimg_addr+(N>>fft_stage); 
                wndata_cnt = wndata_cnt+1;  
                data_cnt = data_cnt+1;

                if(wndata_cnt==cal_stage)begin           //说明该分组已完成计算，切换到下一个分组
                    data_cnt = data_cnt +cal_stage;  
                    wndatareal_addr = 0;
                    wndataimg_addr = 0; 
                    wndata_cnt = 0;
                    group_cnt = group_cnt+1;        //已计算完一个分组
                    if(group_cnt==(N>>(fft_stage+1)))begin       //说明偶数部分已计算完成
                        group_cnt <= 0;
                        state<= state+1;
                        cal_stage <= cal_stage<<1;
                        fft_stage <= fft_stage+1;
                        data_cnt <= 4'd0;                         
                    end
                end                   
            end 
            5'd10:begin                //第四级蝶形运算，N/16点DFT，计算偶数部分
                cache_real = dft_trdoutreal[data_cnt+cal_stage]*wndatareal[wndatareal_addr]-
                             dft_trdoutimg[data_cnt+cal_stage]*wndataimg[wndataimg_addr];        //先计算旋转因子，分别计算实部和虚部
                cache_img = dft_trdoutreal[data_cnt+cal_stage]*wndataimg[wndataimg_addr]+
                            dft_trdoutimg[data_cnt+cal_stage]*wndatareal[wndatareal_addr];
                           
                cache_realres[31:0] = (dft_trdoutreal[data_cnt]<<8) + cache_real;
                cache_imgres[31:0] = (dft_trdoutimg[data_cnt]<<8) + cache_img;
                dft_foroutreal[data_cnt] = cache_realres[31:8];
                dft_foroutimg[data_cnt] = cache_imgres[31:8];

                cache_realres[31:0] = (dft_trdoutreal[data_cnt]<<8) - cache_real;
                cache_imgres[31:0] = (dft_trdoutimg[data_cnt]<<8)-cache_img;
                dft_foroutreal[data_cnt+cal_stage] = cache_realres[31:8];
                dft_foroutimg[data_cnt+cal_stage] = cache_imgres[31:8];                

                wndatareal_addr = wndatareal_addr+(N>>fft_stage);
                wndataimg_addr = wndataimg_addr+(N>>fft_stage); 
                wndata_cnt = wndata_cnt+1;  
                data_cnt = data_cnt+1;

                if(wndata_cnt==cal_stage)begin           //说明该分组已完成计算，切换到下一个分组
                    data_cnt = data_cnt +cal_stage;  
                    wndatareal_addr = 0;
                    wndataimg_addr = 0; 
                    wndata_cnt = 0;
                    group_cnt = group_cnt+1;        //已计算完一个分组
                    if(group_cnt==(N>>(fft_stage+1)))begin       //说明偶数部分已计算完成
                        group_cnt <= 0;
                        state<= state+1;
                        data_cnt <= N>>1;                         
                    end
                end                
            end
            5'd11:begin                //第四级蝶形运算，N/16点DFT，计算奇数部分
                cache_real = dft_trdoutreal[data_cnt+cal_stage]*wndatareal[wndatareal_addr]-
                             dft_trdoutimg[data_cnt+cal_stage]*wndataimg[wndataimg_addr];        //先计算旋转因子，分别计算实部和虚部
                cache_img = dft_trdoutreal[data_cnt+cal_stage]*wndataimg[wndataimg_addr]+
                            dft_trdoutimg[data_cnt+cal_stage]*wndatareal[wndatareal_addr];
                           
                cache_realres[31:0] = (dft_trdoutreal[data_cnt]<<8) + cache_real;
                cache_imgres[31:0] = (dft_trdoutimg[data_cnt]<<8) + cache_img;
                dft_foroutreal[data_cnt] = cache_realres[31:8];
                dft_foroutimg[data_cnt] = cache_imgres[31:8];

                cache_realres[31:0] = (dft_trdoutreal[data_cnt]<<8) - cache_real;
                cache_imgres[31:0] = (dft_trdoutimg[data_cnt]<<8)-cache_img;
                dft_foroutreal[data_cnt+cal_stage] = cache_realres[31:8];
                dft_foroutimg[data_cnt+cal_stage] = cache_imgres[31:8];                

                wndatareal_addr = wndatareal_addr+(N>>fft_stage);
                wndataimg_addr = wndataimg_addr+(N>>fft_stage); 
                wndata_cnt = wndata_cnt+1;  
                data_cnt = data_cnt+1;

                if(wndata_cnt==cal_stage)begin           //说明该分组已完成计算，切换到下一个分组
                    data_cnt = data_cnt +cal_stage;  
                    wndatareal_addr = 0;
                    wndataimg_addr = 0; 
                    wndata_cnt = 0;
                    group_cnt = group_cnt+1;        //已计算完一个分组
                    if(group_cnt==(N>>(fft_stage+1)))begin       //说明偶数部分已计算完成
                        group_cnt <= 0;
                        state<= state+1;
                        cal_stage <= cal_stage<<1;
                        fft_stage <= fft_stage+1;
                        data_cnt <= 4'd0;                         
                    end
                end                   
            end  
            5'd12:begin                //第五级蝶形运算，N/32点DFT，计算偶数部分
                cache_real = dft_foroutreal[data_cnt+cal_stage]*wndatareal[wndatareal_addr]-
                             dft_foroutimg[data_cnt+cal_stage]*wndataimg[wndataimg_addr];        //先计算旋转因子，分别计算实部和虚部
                cache_img = dft_foroutreal[data_cnt+cal_stage]*wndataimg[wndataimg_addr]+
                            dft_foroutimg[data_cnt+cal_stage]*wndatareal[wndatareal_addr];
                           
                cache_realres[31:0] = (dft_foroutreal[data_cnt]<<8) + cache_real;
                cache_imgres[31:0] = (dft_foroutimg[data_cnt]<<8) + cache_img;
                dft_fifoutreal[data_cnt] = cache_realres[31:8];
                dft_fifoutimg[data_cnt] = cache_imgres[31:8];

                cache_realres[31:0] = (dft_foroutreal[data_cnt]<<8) - cache_real;
                cache_imgres[31:0] = (dft_foroutimg[data_cnt]<<8)-cache_img;
                dft_fifoutreal[data_cnt+cal_stage] = cache_realres[31:8];
                dft_fifoutimg[data_cnt+cal_stage] = cache_imgres[31:8];                

                wndatareal_addr = wndatareal_addr+(N>>fft_stage);
                wndataimg_addr = wndataimg_addr+(N>>fft_stage); 
                wndata_cnt = wndata_cnt+1;  
                data_cnt = data_cnt+1;

                if(wndata_cnt==cal_stage)begin           //说明该分组已完成计算，切换到下一个分组
                    data_cnt = data_cnt +cal_stage;  
                    wndatareal_addr = 0;
                    wndataimg_addr = 0; 
                    wndata_cnt = 0;
                    group_cnt = group_cnt+1;        //已计算完一个分组
                    if(group_cnt==(N>>(fft_stage+1)))begin       //说明偶数部分已计算完成
                        group_cnt <= 0;
                        state<= state+1;
                        data_cnt <= N>>1;                         
                    end
                end                
            end
            5'd13:begin                //第五级蝶形运算，N/32点DFT，计算奇数部分
                cache_real = dft_foroutreal[data_cnt+cal_stage]*wndatareal[wndatareal_addr]-
                             dft_foroutimg[data_cnt+cal_stage]*wndataimg[wndataimg_addr];        //先计算旋转因子，分别计算实部和虚部
                cache_img = dft_foroutreal[data_cnt+cal_stage]*wndataimg[wndataimg_addr]+
                            dft_foroutimg[data_cnt+cal_stage]*wndatareal[wndatareal_addr];
                           
                cache_realres[31:0] = (dft_foroutreal[data_cnt]<<8) + cache_real;
                cache_imgres[31:0] = (dft_foroutimg[data_cnt]<<8) + cache_img;
                dft_fifoutreal[data_cnt] = cache_realres[31:8];
                dft_fifoutimg[data_cnt] = cache_imgres[31:8];

                cache_realres[31:0] = (dft_foroutreal[data_cnt]<<8) - cache_real;
                cache_imgres[31:0] = (dft_foroutimg[data_cnt]<<8)-cache_img;
                dft_fifoutreal[data_cnt+cal_stage] = cache_realres[31:8];
                dft_fifoutimg[data_cnt+cal_stage] = cache_imgres[31:8];                

                wndatareal_addr = wndatareal_addr+(N>>fft_stage);
                wndataimg_addr = wndataimg_addr+(N>>fft_stage); 
                wndata_cnt = wndata_cnt+1;  
                data_cnt = data_cnt+1;

                if(wndata_cnt==cal_stage)begin           //说明该分组已完成计算，切换到下一个分组
                    data_cnt = data_cnt +cal_stage;  
                    wndatareal_addr = 0;
                    wndataimg_addr = 0; 
                    wndata_cnt = 0;
                    group_cnt = group_cnt+1;        //已计算完一个分组
                    if(group_cnt==(N>>(fft_stage+1)))begin       //说明偶数部分已计算完成
                        group_cnt <= 0;
                        state<= state+1;
                        cal_stage <= cal_stage<<1;
                        fft_stage <= fft_stage+1;
                        data_cnt <= 4'd0;                         
                    end
                end                   
            end  
            5'd14:begin                //第六级蝶形运算，N/64点DFT，计算偶数部分
                cache_real = dft_fifoutreal[data_cnt+cal_stage]*wndatareal[wndatareal_addr]-
                             dft_fifoutimg[data_cnt+cal_stage]*wndataimg[wndataimg_addr];        //先计算旋转因子，分别计算实部和虚部
                cache_img = dft_fifoutreal[data_cnt+cal_stage]*wndataimg[wndataimg_addr]+
                            dft_fifoutimg[data_cnt+cal_stage]*wndatareal[wndatareal_addr];
                           
                cache_realres[31:0] = (dft_fifoutreal[data_cnt]<<8) + cache_real;
                cache_imgres[31:0] = (dft_fifoutimg[data_cnt]<<8) + cache_img;
                dft_sixoutreal[data_cnt] = cache_realres[31:8];
                dft_sixoutimg[data_cnt] = cache_imgres[31:8];

                cache_realres[31:0] = (dft_fifoutreal[data_cnt]<<8) - cache_real;
                cache_imgres[31:0] = (dft_fifoutimg[data_cnt]<<8)-cache_img;
                dft_sixoutreal[data_cnt+cal_stage] = cache_realres[31:8];
                dft_sixoutimg[data_cnt+cal_stage] = cache_imgres[31:8];                

                wndatareal_addr = wndatareal_addr+(N>>fft_stage);
                wndataimg_addr = wndataimg_addr+(N>>fft_stage); 
                wndata_cnt = wndata_cnt+1;  
                data_cnt = data_cnt+1;

                if(wndata_cnt==cal_stage)begin           //说明该分组已完成计算，切换到下一个分组
                    data_cnt = data_cnt +cal_stage;  
                    wndatareal_addr = 0;
                    wndataimg_addr = 0; 
                    wndata_cnt = 0;
                    group_cnt = group_cnt+1;        //已计算完一个分组
                    if(group_cnt==(N>>(fft_stage+1)))begin       //说明偶数部分已计算完成
                        group_cnt <= 0;
                        state<= state+1;
                        data_cnt <= N>>1;                         
                    end
                end                
            end
            5'd15:begin                //第六级蝶形运算，N/64点DFT，计算奇数部分
                cache_real = dft_fifoutreal[data_cnt+cal_stage]*wndatareal[wndatareal_addr]-
                             dft_fifoutimg[data_cnt+cal_stage]*wndataimg[wndataimg_addr];        //先计算旋转因子，分别计算实部和虚部
                cache_img = dft_fifoutreal[data_cnt+cal_stage]*wndataimg[wndataimg_addr]+
                            dft_fifoutimg[data_cnt+cal_stage]*wndatareal[wndatareal_addr];
                           
                cache_realres[31:0] = (dft_fifoutreal[data_cnt]<<8) + cache_real;
                cache_imgres[31:0] = (dft_fifoutimg[data_cnt]<<8) + cache_img;
                dft_sixoutreal[data_cnt] = cache_realres[31:8];
                dft_sixoutimg[data_cnt] = cache_imgres[31:8];

                cache_realres[31:0] = (dft_fifoutreal[data_cnt]<<8) - cache_real;
                cache_imgres[31:0] = (dft_fifoutimg[data_cnt]<<8)-cache_img;
                dft_sixoutreal[data_cnt+cal_stage] = cache_realres[31:8];
                dft_sixoutimg[data_cnt+cal_stage] = cache_imgres[31:8];                 

                wndatareal_addr = wndatareal_addr+(N>>fft_stage);
                wndataimg_addr = wndataimg_addr+(N>>fft_stage); 
                wndata_cnt = wndata_cnt+1;  
                data_cnt = data_cnt+1;

                if(wndata_cnt==cal_stage)begin           //说明该分组已完成计算，切换到下一个分组
                    data_cnt = data_cnt +cal_stage;  
                    wndatareal_addr = 0;
                    wndataimg_addr = 0; 
                    wndata_cnt = 0;
                    group_cnt = group_cnt+1;        //已计算完一个分组
                    if(group_cnt==(N>>(fft_stage+1)))begin       //说明偶数部分已计算完成
                        group_cnt <= 0;
                        state<= state+1;
                        cal_stage <= cal_stage<<1;
                        fft_stage <= fft_stage+1;
                        data_cnt <= 4'd0;                         
                    end
                end                   
            end  
            5'd16:begin                //第七级蝶形运算，N/128点DFT，计算偶数部分
                cache_real = dft_sixoutreal[data_cnt+cal_stage]*wndatareal[wndatareal_addr]-
                             dft_sixoutimg[data_cnt+cal_stage]*wndataimg[wndataimg_addr];        //先计算旋转因子，分别计算实部和虚部
                cache_img = dft_sixoutreal[data_cnt+cal_stage]*wndataimg[wndataimg_addr]+
                            dft_sixoutimg[data_cnt+cal_stage]*wndatareal[wndatareal_addr];
                           
                cache_realres[31:0] = (dft_sixoutreal[data_cnt]<<8) + cache_real;
                cache_imgres[31:0] = (dft_sixoutimg[data_cnt]<<8) + cache_img;
                dft_sevoutreal[data_cnt] = cache_realres[31:8];
                dft_sevoutimg[data_cnt] = cache_imgres[31:8];

                cache_realres[31:0] = (dft_sixoutreal[data_cnt]<<8) - cache_real;
                cache_imgres[31:0] = (dft_sixoutimg[data_cnt]<<8)-cache_img;
                dft_sevoutreal[data_cnt+cal_stage] = cache_realres[31:8];
                dft_sevoutimg[data_cnt+cal_stage] = cache_imgres[31:8];                

                wndatareal_addr = wndatareal_addr+(N>>fft_stage);
                wndataimg_addr = wndataimg_addr+(N>>fft_stage); 
                wndata_cnt = wndata_cnt+1;  
                data_cnt = data_cnt+1;

                if(wndata_cnt==cal_stage)begin           //说明该分组已完成计算，切换到下一个分组
                    data_cnt = data_cnt +cal_stage;  
                    wndatareal_addr = 0;
                    wndataimg_addr = 0; 
                    wndata_cnt = 0;
                    group_cnt = group_cnt+1;        //已计算完一个分组
                    if(group_cnt==(N>>(fft_stage+1)))begin       //说明偶数部分已计算完成
                        group_cnt <= 0;
                        state<= state+1;
                        data_cnt <= N>>1;                         
                    end
                end                
            end
            5'd17:begin                //第七级蝶形运算，N/128点DFT，计算奇数部分
                cache_real = dft_sixoutreal[data_cnt+cal_stage]*wndatareal[wndatareal_addr]-
                             dft_sixoutimg[data_cnt+cal_stage]*wndataimg[wndataimg_addr];        //先计算旋转因子，分别计算实部和虚部
                cache_img = dft_sixoutreal[data_cnt+cal_stage]*wndataimg[wndataimg_addr]+
                            dft_sixoutimg[data_cnt+cal_stage]*wndatareal[wndatareal_addr];
                           
                cache_realres[31:0] = (dft_sixoutreal[data_cnt]<<8) + cache_real;
                cache_imgres[31:0] = (dft_sixoutimg[data_cnt]<<8) + cache_img;
                dft_sevoutreal[data_cnt] = cache_realres[31:8];
                dft_sevoutimg[data_cnt] = cache_imgres[31:8];

                cache_realres[31:0] = (dft_sixoutreal[data_cnt]<<8) - cache_real;
                cache_imgres[31:0] = (dft_sixoutimg[data_cnt]<<8)-cache_img;
                dft_sevoutreal[data_cnt+cal_stage] = cache_realres[31:8];
                dft_sevoutimg[data_cnt+cal_stage] = cache_imgres[31:8];                 

                wndatareal_addr = wndatareal_addr+(N>>fft_stage);
                wndataimg_addr = wndataimg_addr+(N>>fft_stage); 
                wndata_cnt = wndata_cnt+1;  
                data_cnt = data_cnt+1;

                if(wndata_cnt==cal_stage)begin           //说明该分组已完成计算，切换到下一个分组
                    data_cnt = data_cnt +cal_stage;  
                    wndatareal_addr = 0;
                    wndataimg_addr = 0; 
                    wndata_cnt = 0;
                    group_cnt = group_cnt+1;        //已计算完一个分组
                    if(group_cnt==(N>>(fft_stage+1)))begin       //说明偶数部分已计算完成
                        group_cnt <= 0;
                        state<= state+1;
                        cal_stage <= cal_stage<<1;
                        fft_stage <= fft_stage+1;
                        data_cnt <= 4'd0;                         
                    end
                end                   
            end  
            5'd18:begin                //第八级蝶形运算，N/256点DFT，计算偶数部分
                cache_real = dft_sevoutreal[data_cnt+cal_stage]*wndatareal[wndatareal_addr]-
                             dft_sevoutimg[data_cnt+cal_stage]*wndataimg[wndataimg_addr];        //先计算旋转因子，分别计算实部和虚部
                cache_img = dft_sevoutreal[data_cnt+cal_stage]*wndataimg[wndataimg_addr]+
                            dft_sevoutimg[data_cnt+cal_stage]*wndatareal[wndatareal_addr];
                           
                cache_realres[31:0] = (dft_sevoutreal[data_cnt]<<8) + cache_real;
                cache_imgres[31:0] = (dft_sevoutimg[data_cnt]<<8) + cache_img;
                dft_eigoutreal[data_cnt] = cache_realres[31:8];
                dft_eigoutimg[data_cnt] = cache_imgres[31:8];

                cache_realres[31:0] = (dft_sevoutreal[data_cnt]<<8) - cache_real;
                cache_imgres[31:0] = (dft_sevoutimg[data_cnt]<<8)-cache_img;
                dft_eigoutreal[data_cnt+cal_stage] = cache_realres[31:8];
                dft_eigoutimg[data_cnt+cal_stage] = cache_imgres[31:8];                

                wndatareal_addr = wndatareal_addr+(N>>fft_stage);
                wndataimg_addr = wndataimg_addr+(N>>fft_stage); 
                wndata_cnt = wndata_cnt+1;  
                data_cnt = data_cnt+1;

                if(wndata_cnt==cal_stage)begin           //说明该分组已完成计算，切换到下一个分组
                    data_cnt = data_cnt +cal_stage;  
                    wndatareal_addr = 0;
                    wndataimg_addr = 0; 
                    wndata_cnt = 0;
                    group_cnt = group_cnt+1;        //已计算完一个分组
                    if(group_cnt==(N>>(fft_stage+1)))begin       //说明偶数部分已计算完成
                        group_cnt <= 0;
                        state<= state+1;
                        data_cnt <= N>>1;                         
                    end
                end                
            end
            5'd19:begin                //第八级蝶形运算，N/256点DFT，计算奇数部分
                cache_real = dft_sevoutreal[data_cnt+cal_stage]*wndatareal[wndatareal_addr]-
                             dft_sevoutimg[data_cnt+cal_stage]*wndataimg[wndataimg_addr];        //先计算旋转因子，分别计算实部和虚部
                cache_img = dft_sevoutreal[data_cnt+cal_stage]*wndataimg[wndataimg_addr]+
                            dft_sevoutimg[data_cnt+cal_stage]*wndatareal[wndatareal_addr];
                           
                cache_realres[31:0] = (dft_sevoutreal[data_cnt]<<8) + cache_real;
                cache_imgres[31:0] = (dft_sevoutimg[data_cnt]<<8) + cache_img;
                dft_eigoutreal[data_cnt] = cache_realres[31:8];
                dft_eigoutimg[data_cnt] = cache_imgres[31:8];

                cache_realres[31:0] = (dft_sevoutreal[data_cnt]<<8) - cache_real;
                cache_imgres[31:0] = (dft_sevoutimg[data_cnt]<<8)-cache_img;
                dft_eigoutreal[data_cnt+cal_stage] = cache_realres[31:8];
                dft_eigoutimg[data_cnt+cal_stage] = cache_imgres[31:8];                 

                wndatareal_addr = wndatareal_addr+(N>>fft_stage);
                wndataimg_addr = wndataimg_addr+(N>>fft_stage); 
                wndata_cnt = wndata_cnt+1;  
                data_cnt = data_cnt+1;

                if(wndata_cnt==cal_stage)begin           //说明该分组已完成计算，切换到下一个分组
                    data_cnt = data_cnt +cal_stage;  
                    wndatareal_addr = 0;
                    wndataimg_addr = 0; 
                    wndata_cnt = 0;
                    group_cnt = group_cnt+1;        //已计算完一个分组
                    if(group_cnt==(N>>(fft_stage+1)))begin       //说明偶数部分已计算完成
                        group_cnt <= 0;
                        state<= state+1;
                        cal_stage <= cal_stage<<1;
                        fft_stage <= fft_stage+1;
                        data_cnt <= 4'd0;                         
                    end
                end                   
            end  
            5'd20:begin                //第九级蝶形运算，N/512点DFT，计算偶数部分
                cache_real = dft_eigoutreal[data_cnt+cal_stage]*wndatareal[wndatareal_addr]-
                             dft_eigoutimg[data_cnt+cal_stage]*wndataimg[wndataimg_addr];        //先计算旋转因子，分别计算实部和虚部
                cache_img = dft_eigoutreal[data_cnt+cal_stage]*wndataimg[wndataimg_addr]+
                            dft_eigoutimg[data_cnt+cal_stage]*wndatareal[wndatareal_addr];
                           
                cache_realres[31:0] = (dft_eigoutreal[data_cnt]<<8) + cache_real;
                cache_imgres[31:0] = (dft_eigoutimg[data_cnt]<<8) + cache_img;
                dft_ninoutreal[data_cnt] = cache_realres[31:8];
                dft_ninoutimg[data_cnt] = cache_imgres[31:8];

                cache_realres[31:0] = (dft_eigoutreal[data_cnt]<<8) - cache_real;
                cache_imgres[31:0] = (dft_eigoutimg[data_cnt]<<8)-cache_img;
                dft_ninoutreal[data_cnt+cal_stage] = cache_realres[31:8];
                dft_ninoutimg[data_cnt+cal_stage] = cache_imgres[31:8];                

                wndatareal_addr = wndatareal_addr+(N>>fft_stage);
                wndataimg_addr = wndataimg_addr+(N>>fft_stage); 
                wndata_cnt = wndata_cnt+1;  
                data_cnt = data_cnt+1;

                if(wndata_cnt==cal_stage)begin           //说明该分组已完成计算，切换到下一个分组
                    data_cnt = data_cnt +cal_stage;  
                    wndatareal_addr = 0;
                    wndataimg_addr = 0; 
                    wndata_cnt = 0;
                    group_cnt = group_cnt+1;        //已计算完一个分组
                    if(group_cnt==(N>>(fft_stage+1)))begin       //说明偶数部分已计算完成
                        group_cnt <= 0;
                        state<= state+1;
                        data_cnt <= N>>1;                         
                    end
                end                
            end
            5'd21:begin                //第九级蝶形运算，N/512点DFT，计算奇数部分
                cache_real = dft_eigoutreal[data_cnt+cal_stage]*wndatareal[wndatareal_addr]-
                             dft_eigoutimg[data_cnt+cal_stage]*wndataimg[wndataimg_addr];        //先计算旋转因子，分别计算实部和虚部
                cache_img = dft_eigoutreal[data_cnt+cal_stage]*wndataimg[wndataimg_addr]+
                            dft_eigoutimg[data_cnt+cal_stage]*wndatareal[wndatareal_addr];
                           
                cache_realres[31:0] = (dft_eigoutreal[data_cnt]<<8) + cache_real;
                cache_imgres[31:0] = (dft_eigoutimg[data_cnt]<<8) + cache_img;
                dft_ninoutreal[data_cnt] = cache_realres[31:8];
                dft_ninoutimg[data_cnt] = cache_imgres[31:8];

                cache_realres[31:0] = (dft_eigoutreal[data_cnt]<<8) - cache_real;
                cache_imgres[31:0] = (dft_eigoutimg[data_cnt]<<8)-cache_img;
                dft_ninoutreal[data_cnt+cal_stage] = cache_realres[31:8];
                dft_ninoutimg[data_cnt+cal_stage] = cache_imgres[31:8];                 

                wndatareal_addr = wndatareal_addr+(N>>fft_stage);
                wndataimg_addr = wndataimg_addr+(N>>fft_stage); 
                wndata_cnt = wndata_cnt+1;  
                data_cnt = data_cnt+1;

                if(wndata_cnt==cal_stage)begin           //说明该分组已完成计算，切换到下一个分组
                    data_cnt = data_cnt +cal_stage;  
                    wndatareal_addr = 0;
                    wndataimg_addr = 0; 
                    wndata_cnt = 0;
                    group_cnt = group_cnt+1;        //已计算完一个分组
                    if(group_cnt==(N>>(fft_stage+1)))begin       //说明偶数部分已计算完成
                        group_cnt <= 0;
                        state<= state+1;
                        cal_stage <= cal_stage<<1;
                        fft_stage <= fft_stage+1;
                        data_cnt <= 4'd0;                         
                    end
                end                   
            end                                                                      
            5'd22:begin                //第十级蝶形运算，N/1024点DFT
                cache_real = dft_ninoutreal[data_cnt+cal_stage]*wndatareal[wndatareal_addr]-
                             dft_ninoutimg[data_cnt+cal_stage]*wndataimg[wndataimg_addr];        //先计算旋转因子，分别计算实部和虚部
                cache_img = dft_ninoutreal[data_cnt+cal_stage]*wndataimg[wndataimg_addr]+
                            dft_ninoutimg[data_cnt+cal_stage]*wndatareal[wndatareal_addr];

                cache_realres[31:0] = (dft_ninoutreal[data_cnt]<<8) + cache_real;
                cache_imgres[31:0] = (dft_ninoutimg[data_cnt]<<8) + cache_img;
                dft_tenoutreal[data_cnt] = cache_realres[31:8];
                dft_tenoutimg[data_cnt] = cache_imgres[31:8];

                cache_realres[31:0] = (dft_ninoutreal[data_cnt]<<8) - cache_real;
                cache_imgres[31:0] = (dft_ninoutimg[data_cnt]<<8) - cache_img;
                dft_tenoutreal[data_cnt+cal_stage] = cache_realres[31:8];
                dft_tenoutimg[data_cnt+cal_stage] = cache_imgres[31:8];                

                wndatareal_addr = wndatareal_addr+(N>>fft_stage);
                wndataimg_addr = wndataimg_addr+(N>>fft_stage); 
                wndata_cnt = wndata_cnt+1;  
                data_cnt = data_cnt+1;

                if(wndata_cnt==cal_stage)begin           //说明该分组已完成计算，切换到下一个分组
                    data_cnt = data_cnt +cal_stage;  
                    wndatareal_addr = 0;
                    wndataimg_addr = 0; 
                    wndata_cnt = 0;
                    group_cnt = group_cnt+1;        //已计算完一个分组
                    if(group_cnt==(N>>fft_stage))begin       //最后一阶只有一个小组
                        group_cnt <= 0;
                        state<= state+1;
                        cal_stage <= cal_stage<<1;
                        data_cnt <= 0;                        
                    end
                end                  
            end      
            default:begin state <= 5'd1; cal_stage <= 1;fft_stage <= 1; data_cnt <= 0; end
        endcase
    end
end

assign trans_cnt = data_cnt;      //传输数据由FFT模块控制
assign sample_begin = sample_begin_r;
assign trans_begin = trans_begin_r;

blk_mem_gen_0 blk_mem_gen_0_ini(
    .clka(clk_100m),
    .addra(wndatareal_addr),
    .douta(wndatareal_r)
); 

blk_mem_gen_1 blk_mem_gen_1_ini(
    .clka(clk_100m),
    .addra(wndataimg_addr),
    .douta(wndataimg_r)
); 

endmodule
