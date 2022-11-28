vlib work
vcom -93 -work work ../src/file_io_advanced_tb.vhd
vsim -voptargs=+acc file_io_advanced_tb
do wave.do
run 1 us
