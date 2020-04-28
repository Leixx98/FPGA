`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/24 12:23:57
// Design Name: 
// Module Name: ram_ctrl
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


module ram_ctrl(
    input clk_100m,
    input rst_n,
    input clk_10m,           //fft数据在时钟上升沿变化

    output uart_tx_start,
    input uart_tx_signal,
    output [7:0] uart_txdata,

    input m_axis_data_tlast,
    input [15:0]fft_re
    );

reg uart_tx_nextdata;
wire nextdata_pose;
wire nextdata_nege;

reg nextdata_r0;
reg nextdata_r1;



wire    tlast_pose;
wire    tlast_nege;
//------------------检测上下边沿------------------//
reg     tlast_r0;
reg     tlast_r1;
always @(posedge clk_100m or negedge rst_n) begin
    if(!rst_n)  begin
        tlast_r0 <= 0;
        tlast_r1 <= 0;

        nextdata_r0 <= 0;
        nextdata_r1 <= 0;
    end
    else    begin
        tlast_r0 <= m_axis_data_tlast;
        tlast_r1 <= tlast_r0;

        nextdata_r0 <= uart_tx_nextdata;
        nextdata_r1 <= nextdata_r0;
    end
end

assign  tlast_nege = ~tlast_r0 & tlast_r1;
assign  tlast_pose = tlast_r0 & ~tlast_r1;

assign  nextdata_nege = ~nextdata_r0 & nextdata_r1;
assign  nextdata_pose = nextdata_r0 & ~nextdata_r1;

//-----------------------------------------------//

reg 	wea;			//写数据使能
reg		[11:0]	addra;	//写数据地址
reg		[11:0]	addrb;	//读数据地址

//--------------写数据--------------//
reg     [3:0]   i;
always @(posedge clk_100m or negedge rst_n) begin
    if(!rst_n)  begin
        i <= 0;
        addra <= 0;
    end
    else if(wea)    begin
        case (i)
            4'd0:   begin
                if(tlast_pose)  i <= i + 1;
                else    i <= i;
            end
            4'd1:   begin
                if(clk_10m)    begin
                    addra <= addra + 1;
                end
                else if(addra == 12'd4095)    begin
                    addra <= addra;
                    i <= i + 1;
                end
                else    begin
                    addra <= addra;
                end
            end
            4'd2:   begin   
                if(tlast_nege)  begin
                    addra <= 0;
                    i <= 0;
                end
                else    begin
                    addra <= addra;
                    i <= i;
                end
            end 
            default: i <= 0;
        endcase
    end
    else    begin
        addra <= 0;
    end
end

//--------------读数据--------------//
always @(posedge clk_100m or negedge rst_n) begin
	if(!rst_n)	begin
		addrb <= 0;
	end
	else if((addrb == 12'd4095) || (wea == 1))	begin
		addrb <= 0;
	end
	else if((wea == 0) && (nextdata_pose==1))begin
		addrb <= addrb + 1;
	end
end

//-------------读写控制-------------//
reg		[3:0]	k;

always @(posedge clk_100m or negedge rst_n) begin
	if(!rst_n)	begin
		wea <= 0;
		k <= 0;
	end
	else	begin
		case (k)
			4'd0:	//写操作
				if(addra == 12'd4095)begin
					wea <= 0;
					k <= k + 1;
				end
				else begin
					wea <= 1;
					k <= k;
				end
			4'd1:	//读操作
				if(addrb == 12'd4095)	begin
					wea <= 1;
					k <= 0;
				end
				else	begin
					wea <= 0;
					k <= k;
				end
		  	default: k <= 0;
		endcase
	end
end

//-----------数据选择--------------//
reg     [15:0]  dina;

always @(posedge clk_100m or negedge rst_n) begin
    if(!rst_n)  begin
        dina <= 0;
    end
    else    begin
        dina <= fft_re;
    end
end

//-----------串口发送数据--------------//
reg [3:0] j;
reg uart_tx_start_r;
reg [7:0] uart_txdata_r;
reg [11:0] time_cnt;
wire [15:0] ram_out;
reg [15:0] ram_out_r;

always @(posedge clk_100m or negedge rst_n) begin
    if(!rst_n) begin
        uart_tx_start_r <= 0;
        uart_txdata_r <= 8'd0; 
        uart_tx_nextdata <= 0; 
        j <= 0;   
    end   
    else begin
        case (j)
        4'd0:   begin
            if(wea==1)begin     //写操作
                j <= j;
            end
            else  begin
                ram_out_r <= ram_out;
                j <= j+1'b1;    
            end
        end
        4'd1:   begin
            if(ram_out_r[15:8]==8'hff)begin
                uart_tx_nextdata <= 1;    //切换下一个数据
                j <= 4'd3;   
            end
            else if(!uart_tx_signal)begin        
                uart_txdata_r =  ram_out_r[15:8];
                ram_out_r = {ram_out_r[7:0],8'hff};
                uart_tx_start_r = 1;
                uart_tx_nextdata <= 0;
                j = j+1'b1;
            end    //0表示空闲    
        end 
        4'd2:   begin
            if(uart_tx_signal)  begin
                uart_tx_start_r <= 1'b0;
                j <= 1;
            end          //数据发送中
            else begin   //超时
                time_cnt <= time_cnt+1'b1;
                if(time_cnt==11'd2047)begin //超时
                    time_cnt <= 0;
                    j <= 0;
                    uart_tx_start_r <= 1'b0;
                end
            end
        end
        default: begin j <= 0; end
        endcase
    end
end

assign uart_tx_start = uart_tx_start_r;
assign uart_txdata = uart_txdata_r;

//--------------RAM IP-------------------//
blk_mem_gen_0			signal_ram_inst(
  	.clka	(clk_100m),
  	.wea	(wea),
  	.addra	(addra),
  	.dina	(dina),
  	.clkb	(clk_100m),
  	.addrb	(addrb),
  	.doutb	(ram_out)
);


//--------------ILA IP-------------------//
ila_0                   ila_0_inst(
    .clk                (clk_100m),
    .probe0             (fft_re),
    .probe1             (wea),
    .probe2             (uart_tx_signal),
    .probe3             (j)
);     

endmodule
