vlib work
vcom -93 -work work ../../src/four_paradigms.vhd
vcom -93 -work work ../src/four_paradigms_tb.vhd
vsim -voptargs=+acc four_paradigms_tb
do wave.do
run 10 us