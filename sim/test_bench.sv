//=====================================================================
// Description:
// testbench
// Designer : zhaozj34@sjtu.edu.cn
// Revision History:
// V0 date:xxx Initial version， zhaozj34@sjtu.edu.cn
// ====================================================================

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

initial begin
    #1000
    $finish;
end
    
endmodule