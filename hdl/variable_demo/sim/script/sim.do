vlib work
vcom -93 -work work ../src/variable_demo_tb.vhd
vsim -voptargs=+acc variable_demo_tb
do wave.do
run 10 ns
