# tbird_fsm testbench — ModelSim .do file

# Quit any running sim
quit -sim

# Compile
vlog thunderbird_fsm.sv tb_tbird_fsm.sv

# Load
vsim -voptargs=+acc work.tb_tbird_fsm

# Add waves
add wave -divider "CLOCK / RST"
add wave -logic   sim:/tb_tbird_fsm/clk
add wave -logic   sim:/tb_tbird_fsm/rst

add wave -divider "INPUTS"
add wave -logic   sim:/tb_tbird_fsm/in

add wave -divider "FSM INTERNALS"
add wave sim:/tb_tbird_fsm/dut/current
add wave sim:/tb_tbird_fsm/dut/next

add wave -divider "OUTPUT"
add wave -bin     sim:/tb_tbird_fsm/out

# Run
run -all

# Zoom to fit
wave zoom full
