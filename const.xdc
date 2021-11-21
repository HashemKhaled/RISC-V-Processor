set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { ssd_clk }]; #IO_L12P_T1_MRCC_35 Sch=clk100mhz
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk] 
set_property package_pin N17 [get_ports clk]
set_property iostandard LVCMOS33 [get_ports clk]
set_property package_pin P18 [get_ports reset]
set_property iostandard LVCMOS33 [get_ports reset]



set_property package_pin H17 [get_ports {LEDs[0]}]
set_property iostandard LVCMOS33 [get_ports {LEDs[0]}]
set_property package_pin K15 [get_ports {LEDs[1]}]
set_property iostandard LVCMOS33 [get_ports {LEDs[1]}]
set_property package_pin J13 [get_ports {LEDs[2]}]
set_property iostandard LVCMOS33 [get_ports {LEDs[2]}]
set_property package_pin N14 [get_ports {LEDs[3]}]
set_property iostandard LVCMOS33 [get_ports {LEDs[3]}]
set_property package_pin R18 [get_ports {LEDs[4]}]
set_property iostandard LVCMOS33 [get_ports {LEDs[4]}]
set_property package_pin V17 [get_ports {LEDs[5]}]
set_property iostandard LVCMOS33 [get_ports {LEDs[5]}]
set_property package_pin U17 [get_ports {LEDs[6]}]
set_property iostandard LVCMOS33 [get_ports {LEDs[6]}]
set_property package_pin U16 [get_ports {LEDs[7]}]
set_property iostandard LVCMOS33 [get_ports {LEDs[7]}]
set_property package_pin V16 [get_ports {LEDs[8]}]
set_property iostandard LVCMOS33 [get_ports {LEDs[8]}]
set_property package_pin T15 [get_ports {LEDs[9]}]
set_property iostandard LVCMOS33 [get_ports {LEDs[9]}]
set_property package_pin U14 [get_ports {LEDs[10]}]
set_property iostandard LVCMOS33 [get_ports {LEDs[10]}]
set_property package_pin T16 [get_ports {LEDs[11]}]
set_property iostandard LVCMOS33 [get_ports {LEDs[11]}]
set_property package_pin V15 [get_ports {LEDs[12]}]
set_property iostandard LVCMOS33 [get_ports {LEDs[12]}]
set_property package_pin V14 [get_ports {LEDs[13]}]
set_property iostandard LVCMOS33 [get_ports {LEDs[13]}]
set_property package_pin V12 [get_ports {LEDs[14]}]
set_property iostandard LVCMOS33 [get_ports {LEDs[14]}]
set_property package_pin V11 [get_ports {LEDs[15]}]
set_property iostandard LVCMOS33 [get_ports {LEDs[15]}]

set_property package_pin J15 [get_ports {ledSel[0]}]
set_property iostandard LVCMOS33 [get_ports {ledSel[0]}]
set_property package_pin L16 [get_ports {ledSel[1]}]
set_property iostandard LVCMOS33 [get_ports {ledSel[1]}]

set_property package_pin H6 [get_ports {ssdSel[0]}]
set_property iostandard LVCMOS33 [get_ports {ssdSel[0]}]
set_property package_pin U12 [get_ports {ssdSel[1]}]
set_property iostandard LVCMOS33 [get_ports {ssdSel[1]}]
set_property package_pin U11 [get_ports {ssdSel[2]}]
set_property iostandard LVCMOS33 [get_ports {ssdSel[2]}]
set_property package_pin V10 [get_ports {ssdSel[3]}]
set_property iostandard LVCMOS33 [get_ports {ssdSel[3]}]



set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { LED_out[6] }]; #IO_L24N_T3_A00_D16_14 Sch=ca
set_property -dict { PACKAGE_PIN R10   IOSTANDARD LVCMOS33 } [get_ports { LED_out[5] }]; #IO_25_14 Sch=cb
set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { LED_out[4] }]; #IO_25_15 Sch=cc
set_property -dict { PACKAGE_PIN K13   IOSTANDARD LVCMOS33 } [get_ports { LED_out[3] }]; #IO_L17P_T2_A26_15 Sch=cd
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { LED_out[2] }]; #IO_L13P_T2_MRCC_14 Sch=ce
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports { LED_out[1] }]; #IO_L19P_T3_A10_D26_14 Sch=cf
set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports { LED_out[0] }]; #IO_L4P_T0_D04_14 Sch=cg
set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { Anode[0] }]; #IO_L23P_T3_FOE_B_15 Sch=an[0]
set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { Anode[1] }]; #IO_L23N_T3_FWE_B_15 Sch=an[1]
set_property -dict { PACKAGE_PIN T9    IOSTANDARD LVCMOS33 } [get_ports { Anode[2] }]; #IO_L24P_T3_A01_D17_14 Sch=an[2]
set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports { Anode[3] }]; #IO_L19P_T3_A22_15 Sch=an[3]