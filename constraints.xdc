set_property PACKAGE_PIN U16 [get_ports {led[0]}]
set_property PACKAGE_PIN E19 [get_ports {led[1]}]
set_property PACKAGE_PIN U19 [get_ports {led[2]}]
set_property PACKAGE_PIN V19 [get_ports {led[3]}]
set_property PACKAGE_PIN W18 [get_ports {led[4]}]
set_property PACKAGE_PIN U15 [get_ports {led[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[*]}]

set_property PACKAGE_PIN T18 [get_ports {btn[0]}]
set_property PACKAGE_PIN W19 [get_ports {btn[1]}]
set_property PACKAGE_PIN T17 [get_ports {btn[2]}]
set_property PACKAGE_PIN U17 [get_ports {btn[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btn[*]}]

set_property PACKAGE_PIN U7  [get_ports {ssegout[7]}]  ;# a  (CA)
set_property PACKAGE_PIN V5  [get_ports {ssegout[6]}]  ;# b  (CB)
set_property PACKAGE_PIN U5  [get_ports {ssegout[5]}]  ;# c  (CC)
set_property PACKAGE_PIN V8  [get_ports {ssegout[4]}]  ;# d  (CD)
set_property PACKAGE_PIN U8  [get_ports {ssegout[3]}]  ;# e  (CE)
set_property PACKAGE_PIN W6  [get_ports {ssegout[2]}]  ;# f  (CF)
set_property PACKAGE_PIN W7  [get_ports {ssegout[1]}]  ;# g  (CG)
set_property PACKAGE_PIN V7  [get_ports {ssegout[0]}]  ;# dp (DP)
set_property IOSTANDARD LVCMOS33 [get_ports {ssegout[*]}]

set_property PACKAGE_PIN U2 [get_ports {an[0]}]
set_property PACKAGE_PIN U4 [get_ports {an[1]}]
set_property PACKAGE_PIN V4 [get_ports {an[2]}]
set_property PACKAGE_PIN W4 [get_ports {an[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[*]}]

set_property PACKAGE_PIN V17 [get_ports {sw}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw}]

set_property PACKAGE_PIN W5 [get_ports sysclk_100mhz]
set_property IOSTANDARD LVCMOS33 [get_ports sysclk_100mhz]