onerror {resume}
radix define States {
    "7'b1000000" "0" -color "blue",
    "7'b1111001" "1" -color "blue",
    "7'b0100100" "2" -color "blue",
    "7'b0110000" "3" -color "blue",
    "7'b0011001" "4" -color "blue",
    "7'b0010010" "5" -color "blue",
    "7'b0000010" "6" -color "blue",
    "7'b1111000" "7" -color "blue",
    "7'b0000000" "8" -color "blue",
    "7'b0011000" "9" -color "blue",
    "7'b0001000" "A" -color "blue",
    "7'b0000011" "B" -color "blue",
    "7'b1000110" "C" -color "blue",
    "7'b0100001" "D" -color "blue",
    "7'b0000110" "E" -color "blue",
    "7'b0001110" "F" -color "blue",
    -default default
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_tb/uut/clk
add wave -noupdate /top_tb/uut/reset
add wave -noupdate -radix States /top_tb/uut/seven_seg_out
add wave -noupdate -radix Decimal /top_tb/uut/bcd
add wave -noupdate /top_tb/a_tb
add wave -noupdate /top_tb/b_tb


TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {50000 ps} 0}
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
WaveRestoreZoom {400250 ps} {505250 ps}
