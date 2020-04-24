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
    input clk,
    input rst_n,
    input clk_fft,           //fft数据在时钟上升沿变化

    input m_axis_data_tvalid,
    input [15:0]fft_re,
    output [15:0]ram_out 
    );

wire    tvalid_pose;
wire    tvalid_nege;
//------------------检测上下边沿------------------//
reg     tvalid_r0;
reg     tvalid_r1;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)  begin
        tvalid_r0 <= 0;
        tvalid_r1 <= 0;
    end
    else    begin
        tvalid_r0 <= m_axis_data_tvalid;
        tvalid_r1 <= tvalid_r0;
    end
end

assign  tvalid_nege = ~tvalid_r0 & tvalid_r1;
assign  tvalid_pose = tvalid_r0 & ~tvalid_r1;

//-----------------------------------------------//

reg 	wea;			//写数据使能
reg		[11:0]	addra;	//写数据地址
reg		[11:0]	addrb;	//读数据地址

//--------------写数据--------------//
reg     [3:0]   i;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)  begin
        i <= 0;
        addra <= 0;
    end
    else if(wea)    begin
        case (i)
            4'd0:   begin
                if(tvalid_pose)  i <= i + 1;
                else    i <= i;
            end
            4'd1:   begin
                if(clk_fft)    begin
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
                if(tvalid_nege)  begin
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
always @(posedge clk or negedge rst_n) begin
	if(!rst_n)	begin
		addrb <= 0;
	end
	else if((addrb == 12'd4095) || (wea == 1))	begin
		addrb <= 0;
	end
	else if(wea == 0)begin
		addrb <= addrb + 1;
	end
end

//-------------读写控制-------------//
reg		[3:0]	k;

always @(posedge clk or negedge rst_n) begin
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

reg     [15:0]  dina;
//-----------数据选择--------------//
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)  begin
        dina <= 0;
    end
    else    begin
        dina <= fft_re;
    end
end

blk_mem_gen_0			signal_ram_inst(
  	.clka	(clk),
  	.wea	(wea),
  	.addra	(addra),
  	.dina	(dina),
  	.clkb	(clk),
  	.addrb	(addrb),
  	.doutb	(ram_out)
);

endmodule
