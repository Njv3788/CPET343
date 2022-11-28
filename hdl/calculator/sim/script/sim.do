vlib work

vcom -93 -work work ../../src/memory/src/memory.vhd
vcom -93 -work work ../../src/State_machine.vhd
vcom -93 -work work ../../src/calculator.vhd
vcom -93 -work work ../../src/alu.vhd

vcom -93 -work work ../src/calculator_tb.vhd
vsim -voptargs=+acc calculator_tb
do wave.do
run 1000 ns
