foreach {port pin} {
    	led[0] Y9
    	led[1] Y8
    	led[2] V7
	led[3] W7
	led[4] V10
	led[5] W12
} {
	set_property PACKAGE_PIN $pin [get_ports $port]
	set_property IOSTANDARD LVCMOS33 [get_ports $port]
}

foreach {port pin} {
	btn[0] U12
	btn[1] V12
	btn[2] U7
	btn[3] Y6
} {
	set_property PACKAGE_PIN $pin [get_ports $port]
	set_property IOSTANDARD LVCMOS33 [get_ports $port]
}

foreach {port pin} {
	sseg_an[3] J20
	sseg_an[2] J18
	sseg_an[1] H20
	sseg_an[0] K19
} {
	set_property PACKAGE_PIN $pin [get_ports $port]
	set_property IOSTANDARD LVCMOS33 [get_ports $port]
}

foreach {port pin} {
    	ssegout[0] K20
    	ssegout[1] L19
    	ssegout[2] H18
    	ssegout[3] M20
    	ssegout[4] K21
    	ssegout[5] K18
    	ssegout[6] H17
    	ssegout[7] H19
} {
	set_property PACKAGE_PIN $pin [get_ports $port]
	set_property IOSTANDARD LVCMOS33 [get_ports $port]
}