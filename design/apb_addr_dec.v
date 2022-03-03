//=====================================================================
// Description:
// hardware internal address decoder
// Designer : zhaozj34@sjtu.edu.cn
// Revision History:
// V0 date:xxx Initial version， zhaozj34@sjtu.edu.cn
// ====================================================================

module apb_addr_dec (
    input  [`PADDR_WIDTH-1:0]      paddr,     // APB address
    output [`NUM_APB_SLAVES-1:0]   psel_int   // internal psel output
);

assign psel_int[0] = (paddr >= `START_PADDR_0) && (paddr <= `END_PADDR_0);
assign psel_int[1] = (paddr >= `START_PADDR_1) && (paddr <= `END_PADDR_1);
assign psel_int[2] = (paddr >= `START_PADDR_2) && (paddr <= `END_PADDR_2);
assign psel_int[3] = (paddr >= `START_PADDR_3) && (paddr <= `END_PADDR_3);
assign psel_int[4] = (paddr >= `START_PADDR_4) && (paddr <= `END_PADDR_4);
assign psel_int[5] = (paddr >= `START_PADDR_5) && (paddr <= `END_PADDR_5);
assign psel_int[6] = (paddr >= `START_PADDR_6) && (paddr <= `END_PADDR_6);
assign psel_int[7] = (paddr >= `START_PADDR_7) && (paddr <= `END_PADDR_7);
assign psel_int[8] = (paddr >= `START_PADDR_8) && (paddr <= `END_PADDR_8);
assign psel_int[9] = (paddr >= `START_PADDR_9) && (paddr <= `END_PADDR_9);
assign psel_int[10] = (paddr >= `START_PADDR_10) && (paddr <= `END_PADDR_10);
assign psel_int[11] = (paddr >= `START_PADDR_11) && (paddr <= `END_PADDR_11);

    
endmodule