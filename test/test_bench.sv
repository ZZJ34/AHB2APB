//=====================================================================
// Description:
// testbench
// Designer : zhaozj34@sjtu.edu.cn
// Revision History:
// V0 date:xxx Initial version， zhaozj34@sjtu.edu.cn
// ====================================================================

`timescale 1ns / 1ps

`include "./ahb2apb_defines.v"
`include "./apb_if.sv"
`include "./apb_top_wrapped.sv"

`include "./par.sv"

module test_bench();

parameter PERIOD_CYCLE = 20 ;  // 20ns 50Mhz
parameter DELAY_CYCLE  = 205;  // 205ns

// global signal
logic clk;
logic rst_n;

// APB interface
apb_if i_apb_if(.hclk(clk), .hreset_n(rst_n));

// APB top(wrapped)
apb_top_wrapped i_apb_top_wrapped(._if(i_apb_if.AHB2APB));

// clk signal
initial begin
    clk = 0;
    forever begin
        # (PERIOD_CYCLE/2) clk = ~clk;
    end
end

// reset signal
initial begin
    rst_n = 0;
    # DELAY_CYCLE
    rst_n = 1;
end

`include "./tasks.sv"

initial begin
    wait(i_apb_if.hreset_n == 1'b1);

    if (sim_test == "one_write_defalut")
        one_write_trans_defalut();

    if (sim_test == "one_read_defalut")
        one_read_trans_defalut();

    if (sim_test == "write")
        write_trans(.nums(nums), .index(index), .max_delay(max_delay));

    if (sim_test == "read")
        read_trans(.nums(nums), .index(index), .max_delay(max_delay));
    
    if (sim_test == "random")
        random_trans(.nums(nums), .max_delay(max_delay));

    $finish;
end
    
endmodule