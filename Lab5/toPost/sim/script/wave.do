onerror {resume}
radix define Display {
    "7'b1000000" "0" -color "yellow",
    "7'b1111001" "1" -color "yellow",
    "7'b0100100" "2" -color "yellow",
    "7'b0110000" "3" -color "yellow",
    "7'b0011001" "4" -color "yellow",
    "7'b0010010" "5" -color "yellow",
    "7'b0000010" "6" -color "yellow",
    "7'b1111000" "7" -color "yellow",
    "7'b0000000" "8" -color "yellow",
    "7'b0011000" "9" -color "yellow",
    "7'b0001000" "A" -color "yellow",
    "7'b0000011" "B" -color "yellow",
    "7'b1000110" "C" -color "yellow",
    "7'b0100001" "D" -color "yellow",
    "7'b0000110" "E" -color "yellow",
    "7'b0001110" "F" -color "yellow",
    -default default         yellow
}
radix define States {
    "4'b0001" "input_a"   -color "pink",
    "4'b0010" "input_b"   -color "pink",
    "4'b0100" "disp_sum"  -color "pink",
    "4'b1000" "disp_diff" -color "pink",
    -default default
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_tb/uut/clk
add wave -noupdate /top_tb/uut/reset
add wave -noupdate /top_tb/uut/btn_sync
add wave -noupdate -radix unsigned /top_tb/uut/input
add wave -noupdate -radix unsigned /top_tb/uut/a
add wave -noupdate -radix unsigned /top_tb/uut/b
add wave -noupdate -radix unsigned /top_tb/uut/add_SUB
add wave -noupdate -radix unsigned /top_tb/uut/bcd
add wave -noupdate -radix unsigned /top_tb/uut/result
add wave -noupdate -radix Display /top_tb/uut/one_out
add wave -noupdate -radix Display /top_tb/uut/ten_out
add wave -noupdate -radix Display /top_tb/uut/hun_out
add wave -noupdate -radix States /top_tb/uut/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {887 ns} 0}
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
WaveRestoreZoom {0 ns} {2100 ns}
