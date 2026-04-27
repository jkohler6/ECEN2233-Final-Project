set_property PACKAGE_PIN T6 [get_ports {sw}]

set_property PACKAGE_PIN Y9 [get_ports {led[0]}]
set_property PACKAGE_PIN Y8 [get_ports {led[1]}]
set_property PACKAGE_PIN V7 [get_ports {led[2]}]
set_property PACKAGE_PIN W7 [get_ports {led[3]}]
set_property PACKAGE_PIN V10 [get_ports {led[4]}]
set_property PACKAGE_PIN W12 [get_ports {led[5]}]

set_property PACKAGE_PIN U12 [get_ports {btn[0]}]
set_property PACKAGE_PIN V12 [get_ports {btn[1]}]
set_property PACKAGE_PIN U7 [get_ports {btn[2]}]
set_property PACKAGE_PIN Y6 [get_ports {btn[3]}]

set_property PACKAGE_PIN L18 [get_ports sysclk_125mhz]

set_property PACKAGE_PIN K20 [get_ports {ssegout[0]}]  ;# dp
set_property PACKAGE_PIN L19 [get_ports {ssegout[1]}]  ;# g
set_property PACKAGE_PIN H18 [get_ports {ssegout[2]}]  ;# f
set_property PACKAGE_PIN M20 [get_ports {ssegout[3]}]  ;# e
set_property PACKAGE_PIN K21 [get_ports {ssegout[4]}]  ;# d
set_property PACKAGE_PIN K18 [get_ports {ssegout[5]}]  ;# c
set_property PACKAGE_PIN H17 [get_ports {ssegout[6]}]  ;# b
set_property PACKAGE_PIN H19 [get_ports {ssegout[7]}]  ;# a

set_property LVCMOS33 [get_ports {led[0]}]
set_property LVCMOS33 [get_ports {led[1]}]
set_property LVCMOS33 [get_ports {led[2]}]
set_property LVCMOS33 [get_ports {led[3]}]
set_property LVCMOS33 [get_ports {led[4]}]
set_property LVCMOS33 [get_ports {led[5]}]

set_property LVCMOS33 [get_ports {btn[0]}]
set_property LVCMOS33 [get_ports {btn[1]}]
set_property LVCMOS33 [get_ports {btn[2]}]
set_property LVCMOS33 [get_ports {btn[3]}]


set_property IOSTANDARD LVCMOS33 [get_ports {ssegout[*]}]

set_property IOSTANDARD LVCMOS33 [get_ports {sw}]
set_property IOSTANDARD LVCMOS33 [get_ports sysclk_125mhz]

set_property IOSTANDARD LVCMOS33 [get_ports *]