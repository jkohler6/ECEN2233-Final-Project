# Create the working library if it doesn't exist
# if {[file exists work]} {
#     vdel -lib work -all
# }
# vlib work

# Compile the design files in dependency order
# We use -sv to ensure SystemVerilog parsing
vlog -sv clk_div.sv
vlog -sv debounce.sv
vlog -sv thunderbird_fsm.sv
vlog -sv sev.sv
vlog -sv top.sv

# Compile the testbench
vlog -sv tb_thunderbird.sv

# Initialize the simulation
# -voptargs="+acc" is critical to allow the testbench to access 
# internal signals like uut.fsm.out or uut.divd_clk [cite: 16, 18]
vsim -voptargs="+acc" work.tb_thunderbird

# Add waves for debugging
add wave -noupdate /tb_thunderbird/clk
add wave -noupdate /tb_thunderbird/btn
add wave -noupdate /tb_thunderbird/led
add wave -noupdate -divider Internal
add wave -noupdate /tb_thunderbird/uut/divd_clk
add wave -noupdate /tb_thunderbird/uut/fsm/current
add wave -noupdate /tb_thunderbird/uut/fsm/next

# Run the simulation until the $finish command in the testbench [cite: 35]
run -all

# Zoom to fit the waveform
wave zoom full