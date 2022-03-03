//=====================================================================
// Description:
// all definitions about the ahb2apb bridge、the apb bus and constant
// Designer : zhaozj34@sjtu.edu.cn
// Revision History:
// V0 date:xxx Initial version， zhaozj34@sjtu.edu.cn
// ====================================================================

/* AHB */

// HBURST value
`define SINGLE       3'b000    // single transfer burst
`define INCR         3'b001    // incrementing burst of undefined length
`define WRAP4        3'b010    // 4-beat wrapping burst
`define INCR4        3'b011    // 4-beat incrementing burst
`define WRAP8        3'b100    // 8-beat wrapping burst
`define INCR8        3'b101    // 8-beat incrementing burst
`define WRAP16       3'b110    // 16-beat wrapping burst
`define INCR16       3'b111    // 16-beat incrementing burst

// HSIZE values(only supprt 32-bit AHB data bus)
`define BYTE         3'b000     // 8    bits
`define HWORD        3'b001     // 16   bits
`define WORD         3'b010     // 32   bits

// HRESP values
`define OKAY         1'b0
`define ERROR        1'b1

// HTRANS values
`define IDLE         1'b00      // indicates that no data transfer is required
`define BUSY         1'b01      // indicates that the Manager is continuing with a burst but the next transfer cannot take place immediately
`define NONSEQ       1'b10      // Indicates a single transfer or the first transfer of a burst
`define SEQ          1'b11      // the remaining transfers in a burst are SEQUENTIAL and the address is related to the previous transfer

// HWRITE/PWRITE values
`define READ         1'b0
`define WRITE        1'b1

// port width
`define HSIZE_WIDTH        3
`define HTRANS_WIDTH       2
`define HBURST_WIDTH       3
`define HADDR_SYS_WIDTH    32       // AHB system address bus width
`define HADDR_INT_WIDTH    32       // hardware internal AHB address bus width        
`define AHB_DATA_WIDTH     32        

/* APB */

// port width
`define PADDR_WIDTH    32
`define APB_DATA_WIDTH 32

// number of the slaves
`define NUM_APB_SLAVES 12