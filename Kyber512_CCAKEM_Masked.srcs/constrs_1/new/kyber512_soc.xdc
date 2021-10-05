set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

set_input_delay -clock [get_clocks -of_objects [get_pins kyber_soc_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]] -min 1.000 [get_ports -filter { NAME =~  "*uart*" && DIRECTION == "IN" }]
set_input_delay -clock [get_clocks -of_objects [get_pins kyber_soc_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]] -max 2.000 [get_ports -filter { NAME =~  "*uart*" && DIRECTION == "IN" }]
set_output_delay -clock [get_clocks -of_objects [get_pins kyber_soc_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]] -min 1.000 [get_ports -filter { NAME =~  "*uart*" && DIRECTION == "OUT" }]
set_output_delay -clock [get_clocks -of_objects [get_pins kyber_soc_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]] -max 2.000 [get_ports -filter { NAME =~  "*uart*" && DIRECTION == "OUT" }]
set_input_delay -clock [get_clocks -of_objects [get_pins kyber_soc_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]] -min 1.000 [get_ports -filter { NAME =~  "*reset*" && DIRECTION == "IN" }]
set_input_delay -clock [get_clocks -of_objects [get_pins kyber_soc_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]] -max 2.000 [get_ports -filter { NAME =~  "*reset*" && DIRECTION == "IN" }]

# SMA Diff Pair
set_property PACKAGE_PIN AN31 [get_ports USER_SMA_GPIO_P]
set_property IOSTANDARD LVCMOS18 [get_ports USER_SMA_GPIO_P]
#set_property PACKAGE_PIN AP31 [get_ports USER_SMA_GPIO_N]
#set_property IOSTANDARD LVCMOS18 [get_ports USER_SMA_GPIO_N]

################################################################################
# XADC
################################################################################

#set_property PACKAGE_PIN AN38 [get_ports XADC_VAUX0P_R]
#set_property IOSTANDARD LVCMOS18 [get_ports XADC_VAUX0P_R]
#set_property PACKAGE_PIN AP38 [get_ports XADC_VAUX0N_R]
#set_property IOSTANDARD LVCMOS18 [get_ports XADC_VAUX0N_R]
#set_property PACKAGE_PIN AM41 [get_ports XADC_VAUX8P_R]
#set_property IOSTANDARD LVCMOS18 [get_ports XADC_VAUX8P_R]
#set_property PACKAGE_PIN AM42 [get_ports XADC_VAUX8N_R]
#set_property IOSTANDARD LVCMOS18 [get_ports XADC_VAUX8N_R]

#set_property PACKAGE_PIN BA21 [get_ports XADC_GPIO_0]
#set_property IOSTANDARD LVCMOS18 [get_ports XADC_GPIO_0]
#set_property PACKAGE_PIN BB21 [get_ports XADC_GPIO_1]
#set_property IOSTANDARD LVCMOS18 [get_ports XADC_GPIO_1]
set_property PACKAGE_PIN BB24 [get_ports XADC_GPIO_2]
set_property IOSTANDARD LVCMOS18 [get_ports XADC_GPIO_2]
set_property PACKAGE_PIN BB23 [get_ports XADC_GPIO_3]
set_property IOSTANDARD LVCMOS18 [get_ports XADC_GPIO_3]