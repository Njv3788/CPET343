vlib work
vcom -93 -work work ../../src/generic_counter.vhd
vcom -93 -work work ../src/generic_counter_tb.vhd
vsim -voptargs=+acc generic_counter_tb
do wave.do
run 10 us