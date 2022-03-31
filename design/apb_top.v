//=====================================================================
// Description:
// the top level of the ahb2apb bridge and apb bus (AMBA 5)
// Designer : zhaozj34@sjtu.edu.cn
// Revision History:
// V0 date:xxx Initial version， zhaozj34@sjtu.edu.cn
// ====================================================================

module apb_top (
    /* AHB */ 
    input                         hclk,       // AHB system clock
    input                         hreset_n,   // AHB system reset
    input  [`HADDR_SYS_WIDTH-1:0] haddr,      // AHB address bus
    input                         hready,     // AHB ready signal
    input                         hsel,       // AHB slave select signal
    input  [`HTRANS_WIDTH-1:0]    htrans,     // AHB transfer type bus
    input                         hwrite,     // AHB write/read signal
    input  [`HSIZE_WIDTH-1:0]     hsize,      // AHB transfer size        
    input  [`HBURST_WIDTH -1:0]   hburst,     // AHB transfer burst type
    output                        hresp,      // AHB response
    output                        hreadyout,  // AHB ready output
    input  [`AHB_DATA_WIDTH-1:0]  hwdata,     // AHB write data bus
    output [`AHB_DATA_WIDTH-1:0]  hrdata,     // AHB read data bus
    
    /* APB */
    output                        penable,    // APB enable
    output [`PADDR_WIDTH-1:0]     paddr,      // APB address bus
    output                        pwrite,     // APB write
    output [`APB_DATA_WIDTH-1:0]  pwdata,     // APB write data
    // apb slvae_0
    output                        psel_0,     // APB select slave_x
    input  [`APB_DATA_WIDTH-1:0]  prdata_0,   // APB read data from slave_x
    input                         pready_0,   // APB ready from slave_x (optinal for slave)
    input                         pslverr_0,  // APB slave error from slave_x (optinal for slave)
    // apb slvae_1
    output                        psel_1,
    input  [`APB_DATA_WIDTH-1:0]  prdata_1,
    input                         pready_1,
    input                         pslverr_1,
    // apb slvae_2 
    output                        psel_2,
    input  [`APB_DATA_WIDTH-1:0]  prdata_2,
    input                         pready_2,
    input                         pslverr_2,
    // apb slvae_3
    output                        psel_3,
    input  [`APB_DATA_WIDTH-1:0]  prdata_3,
    input                         pready_3,
    input                         pslverr_3,
    // apb slvae_4
    output                        psel_4,
    input  [`APB_DATA_WIDTH-1:0]  prdata_4,
    input                         pready_4,
    input                         pslverr_4,
    // apb slvae_5
    output                        psel_5,
    input  [`APB_DATA_WIDTH-1:0]  prdata_5,
    input                         pready_5,
    input                         pslverr_5,
    // apb slvae_6
    output                        psel_6,
    input  [`APB_DATA_WIDTH-1:0]  prdata_6,
    input                         pready_6,
    input                         pslverr_6,
    // apb slvae_7
    output                        psel_7,
    input  [`APB_DATA_WIDTH-1:0]  prdata_7,
    input                         pready_7,
    input                         pslverr_7,
    // apb slvae_8
    output                        psel_8,
    input  [`APB_DATA_WIDTH-1:0]  prdata_8,
    input                         pready_8,
    input                         pslverr_8,
    // apb slvae_9
    output                        psel_9,
    input  [`APB_DATA_WIDTH-1:0]  prdata_9,
    input                         pready_9,
    input                         pslverr_9,
    // apb slvae_10
    output                        psel_10,
    input  [`APB_DATA_WIDTH-1:0]  prdata_10,
    input                         pready_10,
    input                         pslverr_10,
    // apb slvae_11
    output                        psel_11,
    input  [`APB_DATA_WIDTH-1:0]  prdata_11,
    input                         pready_11,
    input                         pslverr_11
);

/* internal signal and reg */
// internal AHB address 
wire [`HADDR_INT_WIDTH-1:0]      haddr_int;
// internal APB psel
wire [`NUM_APB_SLAVES-1:0]       psel_int;
// APB psel output
wire [`NUM_APB_SLAVES-1:0]       psel_apb;
// APB psel enable
wire                             psel_en;
// select APB slave pready
wire                             pready_x;
// select APB slave pslverr
wire                             pslverr_x;
// select APB slave prdata
wire [`APB_DATA_WIDTH-1:0]       prdata_x;



/* conenction of the internal signal */
// only take the lower 32 bits from system haddr
assign haddr_int = haddr[`HADDR_INT_WIDTH-1:0];

// split out pselx_int to the individual psel signals
assign psel_0 = psel_apb[0];
assign psel_1 = psel_apb[1];
assign psel_2 = psel_apb[2];
assign psel_3 = psel_apb[3];
assign psel_4 = psel_apb[4];
assign psel_5 = psel_apb[5];
assign psel_6 = psel_apb[6];
assign psel_7 = psel_apb[7];
assign psel_8 = psel_apb[8];
assign psel_9 = psel_apb[9];
assign psel_10 = psel_apb[10];
assign psel_11 = psel_apb[11];

/* module instantiation */
// AHB slave interface
apb_ahb_if i_apb_ahb_if (
    .hclk(hclk),           // AHB system clock
    .hreset_n(hreset_n),   // AHB system reset
    .haddr_int(haddr_int), // internal AHB address
    .hready(hready),     
    .hsel(hsel),           // AHB slave select
    .htrans(htrans),       // AHB transfer type 
    .hwrite(hwrite),       // AHB write/read signal
    .hwdata(hwdata),       // AHB write data
    .hreadyout(hreadyout),  
    .hresp(hresp),         // AHB response
    .hrdata(hrdata),
    .pready_x(pready_x),   // APB ready from slave_x (optinal for slave)
    .pslverr_x(pslverr_x), // APB slave error from slave_x (optinal for slave)
    .prdata_x(prdata_x),   // APB read data from slave_x (optinal for slave)
    .psel_en(psel_en),     // APB psel enable
    .paddr(paddr),         // APB address
    .penable(penable),     // APB enable
    .pwdata(pwdata),       // APB write data
    .pwrite(pwrite)        // APB write/read signal
);

// APB address decoder
apb_addr_dec i_apb_addr_dec (
    .paddr(paddr),
    .psel_int(psel_int)    // internal APB psel
);

// APB slave psel
apb_psel i_apb_psel (
    .psel_en(psel_en),
    .psel_int(psel_int),
    .psel_apb(psel_apb)
);

// select APB slave prdata
apb_mux #(.DATA_WIDTH(`APB_DATA_WIDTH)) i_apb_mux_prdata (
    .sel(psel_int),    // internal APB psel
    .ch_0(prdata_0),   // read data from APB slave #0 
    .ch_1(prdata_1),   // read data from APB slave #1
    .ch_2(prdata_2),   // read data from APB slave #2
    .ch_3(prdata_3),   // read data from APB slave #3
    .ch_4(prdata_4),   // read data from APB slave #4
    .ch_5(prdata_5),   // read data from APB slave #5
    .ch_6(prdata_6),   // read data from APB slave #6
    .ch_7(prdata_7),   // read data from APB slave #7
    .ch_8(prdata_8),   // read data from APB slave #8
    .ch_9(prdata_9),   // read data from APB slave #9
    .ch_10(prdata_10), // read data from APB slave #10
    .ch_11(prdata_11), // read data from APB slave #11
    .tc_ch(prdata_x)
);

// select APB slave pready
apb_mux #(.DATA_WIDTH(1)) i_apb_mux_pready (
    .sel(psel_int),    // internal APB psel
    .ch_0(pready_0),   // ready from APB slave #0 
    .ch_1(pready_1),   // ready data from APB slave #1
    .ch_2(pready_2),   // ready data from APB slave #2
    .ch_3(pready_3),   // ready data from APB slave #3
    .ch_4(pready_4),   // ready data from APB slave #4
    .ch_5(pready_5),   // ready data from APB slave #5
    .ch_6(pready_6),   // ready data from APB slave #6
    .ch_7(pready_7),   // ready data from APB slave #7
    .ch_8(pready_8),   // ready data from APB slave #8
    .ch_9(pready_9),   // ready data from APB slave #9
    .ch_10(pready_10), // ready data from APB slave #10
    .ch_11(pready_11), // ready data from APB slave #11
    .tc_ch(pready_x)
);

// select APB slave pslverr
apb_mux #(.DATA_WIDTH(1)) i_apb_mux_pslverr (
    .sel(psel_int),    // internal APB psel
    .ch_0(pslverr_0),   // pslverr from APB slave #0 
    .ch_1(pslverr_1),   // pslverr from APB slave #1
    .ch_2(pslverr_2),   // pslverr from APB slave #2
    .ch_3(pslverr_3),   // pslverr from APB slave #3
    .ch_4(pslverr_4),   // pslverr from APB slave #4
    .ch_5(pslverr_5),   // pslverr from APB slave #5
    .ch_6(pslverr_6),   // pslverr from APB slave #6
    .ch_7(pslverr_7),   // pslverr from APB slave #7
    .ch_8(pslverr_8),   // pslverr from APB slave #8
    .ch_9(pslverr_9),   // pslverr from APB slave #9
    .ch_10(pslverr_10), // pslverr from APB slave #10
    .ch_11(pslverr_11), // pslverr from APB slave #11
    .tc_ch(pslverr_x)
);
    
endmodule