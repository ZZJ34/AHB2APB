//=====================================================================
// Description:
// enbale APB slave select
// Designer : zhaozj34@sjtu.edu.cn
// Revision History:
// V0 date:xxx Initial version， zhaozj34@sjtu.edu.cn
// ====================================================================

module apb_psel (
    input                            psel_en,
    input      [`NUM_APB_SLAVES-1:0] psel_int,
    output reg [`NUM_APB_SLAVES-1:0] psel_apb
);

always @(psel_int or psel_en) begin
    if (psel_en == 1'b1) begin
        psel_apb = psel_int;
    end
    else begin
        psel_apb = {`NUM_APB_SLAVES{1'b0}};
    end
end
    
endmodule