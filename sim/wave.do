# set external editor
proc external_editor {filename linenumber} {exec "F:/VS code/Microsoft VS Code/Code.exe" -g $filename:$linenumber}
set PrefSource(altEditor) external_editor
# set wave
onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider {Global Signals}
add wave -noupdate -format Logic -label clk /test_bench/clk
add wave -noupdate -format Logic -label rst_n /test_bench/rst_n

add wave -noupdate -divider {AHB Master Signals}
add wave -noupdate -format Literal -radix hexadecimal -label haddr /test_bench/i_apb_if/haddr
add wave -noupdate -format Logic -label hready /test_bench/i_apb_if/hready
add wave -noupdate -format Logic -label hsel /test_bench/i_apb_if/hsel
add wave -noupdate -format Literal -radix hexadecimal -label htrans /test_bench/i_apb_if/htrans
add wave -noupdate -format Logic -label hwrite /test_bench/i_apb_if/hwrite
add wave -noupdate -format Literal -radix hexadecimal -label hsize /test_bench/i_apb_if/hsize
add wave -noupdate -format Literal -radix hexadecimal -label hburst /test_bench/i_apb_if/hburst
add wave -noupdate -format Logic -label hresp /test_bench/i_apb_if/hresp
add wave -noupdate -format Logic -label hreadyout /test_bench/i_apb_if/hreadyout
add wave -noupdate -format Literal -radix hexadecimal -label hwdata /test_bench/i_apb_if/hwdata
add wave -noupdate -format Literal -radix hexadecimal -label hrdata /test_bench/i_apb_if/hrdata

add wave -noupdate -divider {APB Slave Signals}
add wave -noupdate -group {APB Slave 0} -expand -label penable -format Logic /test_bench/i_apb_if/penable
add wave -noupdate -group {APB Slave 0} -expand -label paddr -format Literal -radix hexadecimal /test_bench/i_apb_if/paddr
add wave -noupdate -group {APB Slave 0} -expand -label pwrite -format Logic /test_bench/i_apb_if/pwrite
add wave -noupdate -group {APB Slave 0} -expand -label pwdata -format Literal -radix hexadecimal /test_bench/i_apb_if/pwdata
add wave -noupdate -group {APB Slave 0} -expand -label psel_0 -format Logic /test_bench/i_apb_if/psel_0
add wave -noupdate -group {APB Slave 0} -expand -label prdata_0 -format Literal -radix hexadecimal /test_bench/i_apb_if/prdata_0
add wave -noupdate -group {APB Slave 0} -expand -label pready_0 -format Logic /test_bench/i_apb_if/pready_0
add wave -noupdate -group {APB Slave 0} -expand -label pslverr_0 -format Logic /test_bench/i_apb_if/pslverr_0

TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 169
configure wave -valuecolwidth 122
configure wave -justifyvalue right
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ns} {1000 ns}
WaveRestoreCursors {0 ps}

