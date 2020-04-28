#/////////////////////////////SYSTEM CLK & SYSTEM RESET///////////////////////
set_property PACKAGE_PIN P17 [get_ports clk_100m]
set_property PACKAGE_PIN R15 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports clk_100m]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]


#/////////////////////////////UART/////////////////////////////////////
set_property PACKAGE_PIN B7 [get_ports uart_tx]
set_property IOSTANDARD LVCMOS18 [get_ports uart_tx]

#/////////////////////////////ADC0 & ADC1/////////////////////////////////////
set_property IOSTANDARD LVCMOS33 [get_ports {ADC0_D[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ADC0_D[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ADC0_D[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ADC0_D[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ADC0_D[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ADC0_D[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ADC0_D[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ADC0_D[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ADC0_D[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ADC0_D[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports ADC0_CLK]

set_property PACKAGE_PIN P5 [get_ports {ADC0_D[0]}]
set_property PACKAGE_PIN P4 [get_ports {ADC0_D[1]}]
set_property PACKAGE_PIN P3 [get_ports {ADC0_D[2]}]
set_property PACKAGE_PIN P2 [get_ports {ADC0_D[3]}]
set_property PACKAGE_PIN R2 [get_ports {ADC0_D[4]}]
set_property PACKAGE_PIN M4 [get_ports {ADC0_D[5]}]
set_property PACKAGE_PIN N4 [get_ports {ADC0_D[6]}]
set_property PACKAGE_PIN R1 [get_ports {ADC0_D[7]}]
set_property PACKAGE_PIN T1 [get_ports {ADC0_D[8]}]
set_property PACKAGE_PIN M6 [get_ports {ADC0_D[9]}]
set_property PACKAGE_PIN T5 [get_ports ADC0_CLK]