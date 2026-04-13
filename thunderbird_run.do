onbreak {resume}

if {[file exists work]} {
    vdel -lib work -all
}
vlib work
vmap work work

vlog -sv clock_divider.sv
vlog -sv thunderbird_fsm.sv
vlog -sv seven_seg_decoder.sv
vlog -sv top_thunderbird.sv
vlog -sv tb_thunderbird.sv

vsim -voptargs=+acc work.tb_thunderbird

view wave
view list

radix -binary
add wave -binary /tb_thunderbird/clk
add wave -binary /tb_thunderbird/btn
add wave -binary /tb_thunderbird/uut/step_tick
add wave -binary /tb_thunderbird/uut/lights
add wave -binary /tb_thunderbird/uut/mode
add wave -binary /tb_thunderbird/led
add wave -binary /tb_thunderbird/seg
add wave -binary /tb_thunderbird/an
add wave -binary /tb_thunderbird/uut/u_fsm/current_state
add wave -binary /tb_thunderbird/uut/u_fsm/next_state

add list -binary /tb_thunderbird/clk
add list -binary /tb_thunderbird/btn
add list -binary /tb_thunderbird/uut/step_tick
add list -binary /tb_thunderbird/uut/lights
add list -binary /tb_thunderbird/uut/mode
add list -binary /tb_thunderbird/led
add list -binary /tb_thunderbird/seg
add list -binary /tb_thunderbird/an

configure wave -namecolwidth 180
configure wave -valuecolwidth 120
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
WaveRestoreZoom {0 ps} {260000 ps}

run 300 ns
