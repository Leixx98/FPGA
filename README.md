﻿# FPGA
## 使用vivado对赛灵思FPGA进行开发的工程
——————————————————————————————
### 2020.2.6
UART工程，实现了在9600的波特率下与电脑串口通信，将收到的电脑发送的信息再发送到电脑上。
——————————————————————————————
### 2020.2.7
数码管工程，实现了4位数码管计时显示。
——————————————————————————————
### 2020.2.16
使用ADC的两个通道进行采样，并使用波特率为9600的串口将数据发送到电脑。电脑发送0x00是控制发送通道1的数据，发送0x0a是发送通道2的数据。使用DAC输出当前发送数据的ADC通道波形。

