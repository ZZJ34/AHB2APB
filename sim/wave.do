# set external editor
proc external_editor {filename linenumber} {exec "F:/VS code/Microsoft VS Code/Code.exe" -g $filename:$linenumber}
set PrefSource(altEditor) external_editor
# set wave
onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider {Global Signals}
add wave -noupdate -format Logic -label clk /test_bench/clk
add wave -noupdate -format Logic -label rst_n /test_bench/rst_n

add wave -noupdate -divider {AHB2APB if state}
add wave -noupdate -format Literal -radix binary -label state /test_bench/i_apb_top_wrapped/i_apb_top/i_apb_ahb_if/state

add wave -noupdate -divider {AHB Master Signals}
add wave -noupdate -format Literal -radix hexadecimal -label htrans /test_bench/i_apb_if/htrans
add wave -noupdate -format Literal -radix hexadecimal -label haddr /test_bench/i_apb_if/haddr
add wave -noupdate -format Literal -radix hexadecimal -label hwdata /test_bench/i_apb_if/hwdata
add wave -noupdate -format Literal -radix hexadecimal -label hrdata /test_bench/i_apb_if/hrdata
add wave -noupdate -format Logic -label hreadyout /test_bench/i_apb_if/hreadyout
add wave -noupdate -format Logic -label hresp /test_bench/i_apb_if/hresp
add wave -noupdate -format Logic -label hready /test_bench/i_apb_if/hready
add wave -noupdate -format Logic -label hsel /test_bench/i_apb_if/hsel
add wave -noupdate -format Logic -label hwrite /test_bench/i_apb_if/hwrite
add wave -noupdate -format Literal -radix hexadecimal -label hsize /test_bench/i_apb_if/hsize
add wave -noupdate -format Literal -radix hexadecimal -label hburst /test_bench/i_apb_if/hburst


add wave -noupdate -divider {APB Slave Signals}
add wave -noupdate -group {APB Slave 0} -label psel_0 -format Logic /test_bench/i_apb_if/psel_0
add wave -noupdate -group {APB Slave 0} -label penable -format Logic /test_bench/i_apb_if/penable
add wave -noupdate -group {APB Slave 0} -label pwrite -format Logic /test_bench/i_apb_if/pwrite
add wave -noupdate -group {APB Slave 0} -label paddr -format Literal -radix hexadecimal /test_bench/i_apb_if/paddr
add wave -noupdate -group {APB Slave 0} -label pwdata -format Literal -radix hexadecimal /test_bench/i_apb_if/pwdata
add wave -noupdate -group {APB Slave 0} -label prdata_0 -format Literal -radix hexadecimal /test_bench/i_apb_if/prdata_0
add wave -noupdate -group {APB Slave 0} -label pready_0 -format Logic /test_bench/i_apb_if/pready_0
add wave -noupdate -group {APB Slave 0} -label pslverr_0 -format Logic /test_bench/i_apb_if/pslverr_0

add wave -noupdate -group {APB Slave 1} -label psel_1 -format Logic /test_bench/i_apb_if/psel_1
add wave -noupdate -group {APB Slave 1} -label penable -format Logic /test_bench/i_apb_if/penable
add wave -noupdate -group {APB Slave 1} -label pwrite -format Logic /test_bench/i_apb_if/pwrite
add wave -noupdate -group {APB Slave 1} -label paddr -format Literal -radix hexadecimal /test_bench/i_apb_if/paddr
add wave -noupdate -group {APB Slave 1} -label pwdata -format Literal -radix hexadecimal /test_bench/i_apb_if/pwdata
add wave -noupdate -group {APB Slave 1} -label prdata_1 -format Literal -radix hexadecimal /test_bench/i_apb_if/prdata_1
add wave -noupdate -group {APB Slave 1} -label pready_1 -format Logic /test_bench/i_apb_if/pready_1
add wave -noupdate -group {APB Slave 1} -label pslverr_1 -format Logic /test_bench/i_apb_if/pslverr_1

add wave -noupdate -group {APB Slave 2} -label psel_2 -format Logic /test_bench/i_apb_if/psel_2
add wave -noupdate -group {APB Slave 2} -label penable -format Logic /test_bench/i_apb_if/penable
add wave -noupdate -group {APB Slave 2} -label pwrite -format Logic /test_bench/i_apb_if/pwrite
add wave -noupdate -group {APB Slave 2} -label paddr -format Literal -radix hexadecimal /test_bench/i_apb_if/paddr
add wave -noupdate -group {APB Slave 2} -label pwdata -format Literal -radix hexadecimal /test_bench/i_apb_if/pwdata
add wave -noupdate -group {APB Slave 2} -label prdata_2 -format Literal -radix hexadecimal /test_bench/i_apb_if/prdata_2
add wave -noupdate -group {APB Slave 2} -label pready_2 -format Logic /test_bench/i_apb_if/pready_2
add wave -noupdate -group {APB Slave 2} -label pslverr_2 -format Logic /test_bench/i_apb_if/pslverr_2

add wave -noupdate -group {APB Slave 3} -label psel_3 -format Logic /test_bench/i_apb_if/psel_3
add wave -noupdate -group {APB Slave 3} -label penable -format Logic /test_bench/i_apb_if/penable
add wave -noupdate -group {APB Slave 3} -label pwrite -format Logic /test_bench/i_apb_if/pwrite
add wave -noupdate -group {APB Slave 3} -label paddr -format Literal -radix hexadecimal /test_bench/i_apb_if/paddr
add wave -noupdate -group {APB Slave 3} -label pwdata -format Literal -radix hexadecimal /test_bench/i_apb_if/pwdata
add wave -noupdate -group {APB Slave 3} -label prdata_3 -format Literal -radix hexadecimal /test_bench/i_apb_if/prdata_3
add wave -noupdate -group {APB Slave 3} -label pready_3 -format Logic /test_bench/i_apb_if/pready_3
add wave -noupdate -group {APB Slave 3} -label pslverr_3 -format Logic /test_bench/i_apb_if/pslverr_3

add wave -noupdate -group {APB Slave 4} -label psel_4 -format Logic /test_bench/i_apb_if/psel_4
add wave -noupdate -group {APB Slave 4} -label penable -format Logic /test_bench/i_apb_if/penable
add wave -noupdate -group {APB Slave 4} -label pwrite -format Logic /test_bench/i_apb_if/pwrite
add wave -noupdate -group {APB Slave 4} -label paddr -format Literal -radix hexadecimal /test_bench/i_apb_if/paddr
add wave -noupdate -group {APB Slave 4} -label pwdata -format Literal -radix hexadecimal /test_bench/i_apb_if/pwdata
add wave -noupdate -group {APB Slave 4} -label prdata_4 -format Literal -radix hexadecimal /test_bench/i_apb_if/prdata_4
add wave -noupdate -group {APB Slave 4} -label pready_4 -format Logic /test_bench/i_apb_if/pready_4
add wave -noupdate -group {APB Slave 4} -label pslverr_4 -format Logic /test_bench/i_apb_if/pslverr_4

add wave -noupdate -expand -group {APB Slave 5} -label psel_5 -format Logic /test_bench/i_apb_if/psel_5
add wave -noupdate -expand -group {APB Slave 5} -label penable -format Logic /test_bench/i_apb_if/penable
add wave -noupdate -expand -group {APB Slave 5} -label pwrite -format Logic /test_bench/i_apb_if/pwrite
add wave -noupdate -expand -group {APB Slave 5} -label paddr -format Literal -radix hexadecimal /test_bench/i_apb_if/paddr
add wave -noupdate -expand -group {APB Slave 5} -label pwdata -format Literal -radix hexadecimal /test_bench/i_apb_if/pwdata
add wave -noupdate -expand -group {APB Slave 5} -label prdata_5 -format Literal -radix hexadecimal /test_bench/i_apb_if/prdata_5
add wave -noupdate -expand -group {APB Slave 5} -label pready_5 -format Logic /test_bench/i_apb_if/pready_5
add wave -noupdate -expand -group {APB Slave 5} -label pslverr_5 -format Logic /test_bench/i_apb_if/pslverr_5

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

