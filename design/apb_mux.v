//=====================================================================
// Description:
// select signals from the apb slaves
// Designer : zhaozj34@sjtu.edu.cn
// Revision History:
// V0 date:xxx Initial version， zhaozj34@sjtu.edu.cn
// ====================================================================

module apb_mux #(
    parameter DATA_WIDTH = 8
) (
    input  [`NUM_APB_SLAVES-1:0] sel,
    input  [DATA_WIDTH-1:0]      ch_0,
    input  [DATA_WIDTH-1:0]      ch_1,
    input  [DATA_WIDTH-1:0]      ch_2,
    input  [DATA_WIDTH-1:0]      ch_3,
    input  [DATA_WIDTH-1:0]      ch_4,
    input  [DATA_WIDTH-1:0]      ch_5,
    input  [DATA_WIDTH-1:0]      ch_6,
    input  [DATA_WIDTH-1:0]      ch_7,
    input  [DATA_WIDTH-1:0]      ch_8,
    input  [DATA_WIDTH-1:0]      ch_9,
    input  [DATA_WIDTH-1:0]      ch_10,
    input  [DATA_WIDTH-1:0]      ch_11,
    output [DATA_WIDTH-1:0]      tc_ch    // selected signal                   
);

/* internal signal and reg */
reg [DATA_WIDTH-1:0] tc_ch_reg;


// one hot mux 
always @(*) begin
    case (1'b1)
        sel[0]: tc_ch_reg = ch_0;
        sel[1]: tc_ch_reg = ch_1;
        sel[2]: tc_ch_reg = ch_2;
        sel[3]: tc_ch_reg = ch_3;
        sel[4]: tc_ch_reg = ch_4;
        sel[5]: tc_ch_reg = ch_5;
        sel[6]: tc_ch_reg = ch_6;
        sel[7]: tc_ch_reg = ch_7;
        sel[8]: tc_ch_reg = ch_8;
        sel[9]: tc_ch_reg = ch_9;
        sel[10]: tc_ch_reg = ch_10;
        sel[11]: tc_ch_reg = ch_11;
        default: tc_ch_reg = {DATA_WIDTH{1'b0}};
    endcase
end
    
endmodule