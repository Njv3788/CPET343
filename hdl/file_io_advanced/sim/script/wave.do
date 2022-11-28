onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /file_io_advanced_tb/clk
add wave -noupdate /file_io_advanced_tb/reset
add wave -noupdate /file_io_advanced_tb/read_file/input_line
add wave -noupdate /file_io_advanced_tb/read_file/next_time
add wave -noupdate /file_io_advanced_tb/read_file/btn
add wave -noupdate /file_io_advanced_tb/read_file/switch
add wave -noupdate -color Yellow /file_io_advanced_tb/read_file/btn_std_logic
add wave -noupdate -color Yellow /file_io_advanced_tb/read_file/switch_std_logic
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {254 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 75
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1050 ns}
