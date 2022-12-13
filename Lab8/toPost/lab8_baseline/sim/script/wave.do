onerror {resume}
radix define States {
    "8'b000?????" "Play" -color "green",
    "8'b001?????" "Repeat" -color "purple",
    "8'b01??????" "Pause" -color "orange",
    "8'b10??????" "Seek" -color "blue",
    "8'b11??????" "Stop" -color "red",
    -default hexadecimal
    -defaultcolor white
}
radix define Top_States {
    "5'b00001" "idle"      -color "green",
    "5'b00010" "fetch"     -color "purple",
    "5'b00100" "decode"    -color "orange",
    "5'b01000" "error"     -color "blue",
    "5'b10000" "run"       -color "red",
    -default default
}
radix define Pro_States {
    "5'b00001" "Play"      -color "green",
    "5'b00010" "Repeat"    -color "purple",
    "5'b00100" "Pause"     -color "orange",
    "5'b01000" "Seek"      -color "blue",
    "5'b10000" "Stop"      -color "red",
    -default default
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/clk
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/reset
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/execute_btn
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/sync
add wave -noupdate -radix Top_States /dj_roomba_3000_tb/dj_roomba/head/state
add wave -noupdate -radix States /dj_roomba_3000_tb/dj_roomba/led
add wave -noupdate -radix Pro_States /dj_roomba_3000_tb/dj_roomba/corpus/pro_state
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/corpus/command_sync
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/corpus/is_end
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/audio_out
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/data_address
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2012 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 202
configure wave -valuecolwidth 48
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
configure wave -timelineunits us
update
WaveRestoreZoom {5 ns} {2105 ns}
