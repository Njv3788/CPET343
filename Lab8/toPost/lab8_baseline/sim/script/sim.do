vlib work
vmap altera_mf ../../src/altera_mf
vcom -93 -work work ../../src/controller/control_parts.vhd
vcom -93 -work work ../../src/controller/generic_2x1_mux.vhd
vcom -93 -work work ../../src/controller/generic_laterial_shift.vhd
vcom -93 -work work ../../src/controller/generic_nzero.vhd
vcom -93 -work work ../../src/controller/machine.vhd
vcom -93 -work work ../../src/controller/controller.vhd
vcom -93 -work work ../../src/program_counter/src/program_counter.vhd
vcom -93 -work work ../../src/program_counter/src/generic_adder_beh/src/generic_adder_beh.vhd
vcom -93 -work work ../../src/processor/pro_parts.vhd
vcom -93 -work work ../../src/processor/processor.vhd
vcom -93 -work work ../../src/processor/pro_machine.vhd
vcom -93 -work work ../../src/rom_data/rom_data.vhd
vcom -93 -work work ../../src/rom_instructions/rom_instructions.vhd
vcom -93 -work work ../../src/rising_edge_synchronizer.vhd
vcom -93 -work work ../../src/dj_roomba_3000.vhd
vcom -93 -work work ../src/dj_roomba_3000_tb.vhd
vsim -voptargs=+acc dj_roomba_3000_tb
do wave.do
run 2000 us