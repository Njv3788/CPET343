vlib work

vcom -93 -work work ../../src/top.vhd
vcom -93 -work work ../../src/synchronizer.vhd
vcom -93 -work work ../../src/rising_edge_synchronizer.vhd

vcom -93 -work work ../../src/display/src/seven_seg/src/seven_seg.vhd
vcom -93 -work work ../../src/display/src/double_dabble.vhd
vcom -93 -work work ../../src/display/src/display.vhd

vcom -93 -work work ../../src/calculator/src/memory/src/memory.vhd
vcom -93 -work work ../../src/calculator/src/State_machine.vhd
vcom -93 -work work ../../src/calculator/src/calculator.vhd
vcom -93 -work work ../../src/calculator/src/alu.vhd

vcom -93 -work work ../src/top_tb.vhd
vsim -voptargs=+acc top_tb
do wave.do
run 1000 ns
