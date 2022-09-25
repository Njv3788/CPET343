vlib work
vcom -93 -work work ../../src/falling_edge_synchronizer.vhd
vcom -93 -work work ../src/falling_edge_synchronizer_tb.vhd
vsim -voptargs=+acc falling_edge_synchronizer_tb
do wave.do
run 300 ns
