onerror {resume}
radix define Display {
    "7'b1000000" "0"     -color "yellow",
    "7'b1111001" "1"     -color "yellow",
    "7'b0100100" "2"     -color "yellow",
    "7'b0110000" "3"     -color "yellow",
    "7'b0011001" "4"     -color "yellow",
    "7'b0010010" "5"     -color "yellow",
    "7'b0000010" "6"     -color "yellow",
    "7'b1111000" "7"     -color "yellow",
    "7'b0000000" "8"     -color "yellow",
    "7'b0011000" "9"     -color "yellow",
    "7'b0001000" "A"     -color "yellow",
    "7'b0000011" "B"     -color "yellow",
    "7'b1000110" "C"     -color "yellow",
    "7'b0100001" "D"     -color "yellow",
    "7'b0000110" "E"     -color "yellow",
    "7'b0001110" "F"     -color "yellow",
    "7'b1111111" "blank" -color "yellow",
    -default default         yellow
}

radix define States {
    "5'b00001" "read_w"      -color "pink",
    "5'b00010" "burn_cycle"  -color "pink",
    "5'b00100" "write_w"     -color "pink",
    "5'b01000" "read_s"      -color "pink",
    "5'b10000" "write_s"     -color "pink",
    -default default
}
radix define top_states {
    "5'b00001" "idle"      -color "blue",
    "5'b00010" "fetch"     -color "blue",
    "5'b00100" "decode"    -color "blue",
    "5'b01000" "dec_err"   -color "blue",
    "5'b10000" "run"       -color "blue",
    -default default
}

quietly WaveActivateNextPane {} 0
add wave -noupdate /top_tb/uut/clk
add wave -noupdate /top_tb/uut/reset
add wave -noupdate /top_tb/uut/execute
add wave -noupdate -radix hexadecimal /top_tb/uut/instruction
add wave -noupdate -radix hexadecimal /top_tb/uut/res_instruction
add wave -noupdate -radix hexadecimal /top_tb/uut/decode_1_instruction
add wave -noupdate -radix hexadecimal /top_tb/uut/decode_2_instruction
add wave -noupdate -radix hexadecimal /top_tb/uut/decode_3_instruction
add wave -noupdate -radix hexadecimal /top_tb/uut/valid_instruction
add wave -noupdate -radix top_states /top_tb/uut/top_state
add wave -noupdate -radix top_states /top_tb/uut/change_top/is_valid
add wave -noupdate -radix top_states /top_tb/uut/change_top/ex_error
add wave -noupdate /top_tb/uut/ex
add wave -noupdate /top_tb/uut/ex_sync
add wave -noupdate /top_tb/uut/ms_sync
add wave -noupdate /top_tb/uut/mr_sync
add wave -noupdate /top_tb/uut/operation
add wave -noupdate /top_tb/uut/operand
add wave -noupdate -radix Display /top_tb/uut/one_out
add wave -noupdate -radix Display /top_tb/uut/ten_out
add wave -noupdate -radix Display /top_tb/uut/hun_out
add wave -noupdate -radix hex /top_tb/uut/math/ram_gen/RAM
add wave -noupdate -radix States /top_tb/uut/state_out

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
