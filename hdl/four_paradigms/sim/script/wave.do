onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /four_paradigms_tb/uut1/clk
add wave -noupdate /four_paradigms_tb/uut1/reset
add wave -noupdate /four_paradigms_tb/uut1/a
add wave -noupdate /four_paradigms_tb/uut1/b_comb
add wave -noupdate /four_paradigms_tb/uut1/b_sync
add wave -noupdate /four_paradigms_tb/uut1/b_conc
add wave -noupdate /four_paradigms_tb/uut1/b_sequ
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9924276 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 40
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
WaveRestoreZoom {9901 ns} {9915483 ps}
