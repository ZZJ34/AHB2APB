//=====================================================================
// Description:
// interface definition
// Designer : zhaozj34@sjtu.edu.cn
// Revision History:
// V0 date:xxx Initial version， zhaozj34@sjtu.edu.cn
// ====================================================================


interface apb_if(input hclk, input hreset_n);
    // AHB 
    logic [`HADDR_SYS_WIDTH-1:0] haddr;
    logic                        hready;     
    logic                        hsel;       
    logic [`HTRANS_WIDTH-1:0]    htrans;     
    logic                        hwrite;     
    logic [`HSIZE_WIDTH-1:0]     hsize;    
    logic [`HBURST_WIDTH -1:0]   hburst;    
    logic                        hresp; 
    logic                        hreadyout;
    logic [`AHB_DATA_WIDTH-1:0]  hwdata;
    logic [`AHB_DATA_WIDTH-1:0]  hrdata;
    
    // APB
    logic                        penable;    
    logic [`PADDR_WIDTH-1:0]     paddr;     
    logic                        pwrite;     
    logic [`APB_DATA_WIDTH-1:0]  pwdata;

    // apb slvae_0
    logic                        psel_0;     
    logic [`APB_DATA_WIDTH-1:0]  prdata_0;   
    logic                        pready_0;  
    logic                        pslverr_0;  
    // apb slvae_1
    logic                        psel_1;
    logic [`APB_DATA_WIDTH-1:0]  prdata_1;
    logic                        pready_1;
    logic                        pslverr_1;
    // apb slvae_2
    logic                        psel_2;
    logic  [`APB_DATA_WIDTH-1:0] prdata_2;
    logic                        pready_2;
    logic                        pslverr_2;
    // apb slvae_3
    logic                        psel_3;
    logic  [`APB_DATA_WIDTH-1:0] prdata_3;
    logic                        pready_3;
    logic                        pslverr_3;
    // apb slvae_4
    logic                        psel_4;
    logic  [`APB_DATA_WIDTH-1:0] prdata_4;
    logic                        pready_4;
    logic                        pslverr_4;
    // apb slvae_5
    logic                        psel_5;
    logic  [`APB_DATA_WIDTH-1:0] prdata_5;
    logic                        pready_5;
    logic                        pslverr_5;
    // apb slvae_6
    logic                        psel_6;
    logic  [`APB_DATA_WIDTH-1:0] prdata_6;
    logic                        pready_6;
    logic                        pslverr_6;
    // apb slvae_7
    logic                        psel_7;
    logic  [`APB_DATA_WIDTH-1:0] prdata_7;
    logic                        pready_7;
    logic                        pslverr_7;
    // apb slvae_8
    logic                        psel_8;
    logic  [`APB_DATA_WIDTH-1:0] prdata_8;
    logic                        pready_8;
    logic                        pslverr_8;
    // apb slvae_9
    logic                        psel_9;
    logic  [`APB_DATA_WIDTH-1:0] prdata_9;
    logic                        pready_9;
    logic                        pslverr_9;
    // apb slvae_10
    logic                        psel_10;
    logic  [`APB_DATA_WIDTH-1:0] prdata_10;
    logic                        pready_10;
    logic                        pslverr_10;
    // apb slvae_11
    logic                        psel_11;
    logic  [`APB_DATA_WIDTH-1:0] prdata_11;
    logic                        pready_11;
    logic                        pslverr_11;
    
    // AHB2APB bridge port
    modport AHB2APB(
        input  hclk,    
        input  hreset_n,   // AHB system reset
        input  haddr,      // AHB address bus
        input  hready,     // AHB ready signal
        input  hsel,       // AHB slave select signal
        input  htrans,     // AHB transfer type bus
        input  hwrite,     // AHB write/read signal
        input  hsize,      // AHB transfer size        // 没用
        input  hburst,     // AHB transfer burst type  // 没用
        output hresp,      // AHB response
        output hreadyout,  // AHB ready output
        input  hwdata,     // AHB write data bus
        output hrdata,     // AHB read data bus
        /* APB */
        output penable,    // APB enable
        output paddr,      // APB address bus
        output pwrite,     // APB write
        output pwdata,     // APB write data
        // apb slvae_0
        output psel_0,     // APB select slave_x
        input  prdata_0,   // APB read data from slave_x
        input  pready_0,   // APB ready from slave_x (optinal for slave)
        input  pslverr_0,  // APB slave error from slave_x (optinal for slave)
        // apb slvae_1
        output psel_1,
        input  prdata_1,
        input  pready_1,
        input  pslverr_1,
        // apb slvae_2
        output psel_2,
        input  prdata_2,
        input  pready_2,
        input  pslverr_2,
        // apb slvae_3
        output psel_3,
        input  prdata_3,
        input  pready_3,
        input  pslverr_3,
        // apb slvae_4
        output psel_4,
        input  prdata_4,
        input  pready_4,
        input  pslverr_4,
        // apb slvae_5
        output psel_5,
        input  prdata_5,
        input  pready_5,
        input  pslverr_5,
        // apb slvae_6
        output psel_6,
        input  prdata_6,
        input  pready_6,
        input  pslverr_6,
        // apb slvae_7
        output psel_7,
        input  prdata_7,
        input  pready_7,
        input  pslverr_7,
        // apb slvae_8
        output psel_8,
        input  prdata_8,
        input  pready_8,
        input  pslverr_8,
        // apb slvae_9
        output psel_9,
        input  prdata_9,
        input  pready_9,
        input  pslverr_9,
        // apb slvae_10
        output psel_10,
        input  prdata_10,
        input  pready_10,
        input  pslverr_10,
        // apb slvae_11
        output psel_11,
        input  prdata_11,
        input  pready_11,
        input  pslverr_11
    );

    // AHB master port
    modport AHB_M(
        input  hclk,    
        input  hreset_n,   
        output haddr,      // AHB address bus
        output hready,     // AHB ready signal
        output hsel,       // AHB slave select signal
        output htrans,     // AHB transfer type bus
        output hwrite,     // AHB write/read signal
        output hsize,      // AHB transfer size        // 没用
        output hburst,     // AHB transfer burst type  // 没用
        input  hresp,      // AHB response
        input  hreadyout,  // AHB ready output
        output hwdata,     // AHB write data bus
        input  hrdata      // AHB read data bus
    );

    // APB slave_0 port
    modport APB_S0(
        input  hclk,    
        input  hreset_n,
        input  penable,    // APB enable
        input  paddr,      // APB address bus
        input  pwrite,     // APB write
        input  pwdata,     // APB write data
        // apb slvae_0
        input  psel_0,     // APB select slave_x
        output prdata_0,   // APB read data from slave_x
        output pready_0,   // APB ready from slave_x (optinal for slave)
        output pslverr_0   // APB slave error from slave_x (optinal for slave)
    );

    // APB slave_1 port
    modport APB_S1(
        input  hclk,    
        input  hreset_n,
        input  penable,    // APB enable
        input  paddr,      // APB address bus
        input  pwrite,     // APB write
        input  pwdata,     // APB write data
        // apb slvae_1
        input  psel_1,     // APB select slave_x
        output prdata_1,   // APB read data from slave_x
        output pready_1,   // APB ready from slave_x (optinal for slave)
        output pslverr_1   // APB slave error from slave_x (optinal for slave)
    );

    // APB slave_2 port
    modport APB_S2(
        input  hclk,    
        input  hreset_n,
        input  penable,    // APB enable
        input  paddr,      // APB address bus
        input  pwrite,     // APB write
        input  pwdata,     // APB write data
        // apb slvae_2
        input  psel_2,     // APB select slave_x
        output prdata_2,   // APB read data from slave_x
        output pready_2,   // APB ready from slave_x (optinal for slave)
        output pslverr_2   // APB slave error from slave_x (optinal for slave)
    );

    // APB slave_3 port
    modport APB_S3(
        input  hclk,    
        input  hreset_n,
        input  penable,    // APB enable
        input  paddr,      // APB address bus
        input  pwrite,     // APB write
        input  pwdata,     // APB write data
        // apb slvae_3
        input  psel_3,     // APB select slave_x
        output prdata_3,   // APB read data from slave_x
        output pready_3,   // APB ready from slave_x (optinal for slave)
        output pslverr_3   // APB slave error from slave_x (optinal for slave)
    );

    // APB slave_4 port
    modport APB_S4(
        input  hclk,    
        input  hreset_n,
        input  penable,    // APB enable
        input  paddr,      // APB address bus
        input  pwrite,     // APB write
        input  pwdata,     // APB write data
        // apb slvae_4
        input  psel_4,     // APB select slave_x
        output prdata_4,   // APB read data from slave_x
        output pready_4,   // APB ready from slave_x (optinal for slave)
        output pslverr_4   // APB slave error from slave_x (optinal for slave)
    );

    // APB slave_5 port
    modport APB_S5(
        input  hclk,    
        input  hreset_n,
        input  penable,    // APB enable
        input  paddr,      // APB address bus
        input  pwrite,     // APB write
        input  pwdata,     // APB write data
        // apb slvae_5
        input  psel_5,     // APB select slave_x
        output prdata_5,   // APB read data from slave_x
        output pready_5,   // APB ready from slave_x (optinal for slave)
        output pslverr_5   // APB slave error from slave_x (optinal for slave)
    );

    // APB slave_6 port
    modport APB_S6(
        input  hclk,    
        input  hreset_n,
        input  penable,    // APB enable
        input  paddr,      // APB address bus
        input  pwrite,     // APB write
        input  pwdata,     // APB write data
        // apb slvae_6
        input  psel_6,     // APB select slave_x
        output prdata_6,   // APB read data from slave_x
        output pready_6,   // APB ready from slave_x (optinal for slave)
        output pslverr_6   // APB slave error from slave_x (optinal for slave)
    );

    // APB slave_7 port
    modport APB_S7(
        input  hclk,    
        input  hreset_n,
        input  penable,    // APB enable
        input  paddr,      // APB address bus
        input  pwrite,     // APB write
        input  pwdata,     // APB write data
        // apb slvae_7
        input  psel_7,     // APB select slave_x
        output prdata_7,   // APB read data from slave_x
        output pready_7,   // APB ready from slave_x (optinal for slave)
        output pslverr_7   // APB slave error from slave_x (optinal for slave)
    );

    // APB slave_8 port
    modport APB_S8(
        input  hclk,    
        input  hreset_n,
        input  penable,    // APB enable
        input  paddr,      // APB address bus
        input  pwrite,     // APB write
        input  pwdata,     // APB write data
        // apb slvae_8
        input  psel_8,     // APB select slave_x
        output prdata_8,   // APB read data from slave_x
        output pready_8,   // APB ready from slave_x (optinal for slave)
        output pslverr_8   // APB slave error from slave_x (optinal for slave)
    );

    // APB slave_9 port
    modport APB_S9(
        input  hclk,    
        input  hreset_n,
        input  penable,    // APB enable
        input  paddr,      // APB address bus
        input  pwrite,     // APB write
        input  pwdata,     // APB write data
        // apb slvae_9
        input  psel_9,     // APB select slave_x
        output prdata_9,   // APB read data from slave_x
        output pready_9,   // APB ready from slave_x (optinal for slave)
        output pslverr_9   // APB slave error from slave_x (optinal for slave)
    );

    // APB slave_10 port
    modport APB_S10(
        input  hclk,    
        input  hreset_n,
        input  penable,    // APB enable
        input  paddr,      // APB address bus
        input  pwrite,     // APB write
        input  pwdata,     // APB write data
        // apb slvae_10
        input  psel_10,     // APB select slave_x
        output prdata_10,   // APB read data from slave_x
        output pready_10,   // APB ready from slave_x (optinal for slave)
        output pslverr_10   // APB slave error from slave_x (optinal for slave)
    );

    // APB slave_11 port
    modport APB_S11(
        input  hclk,    
        input  hreset_n,
        input  penable,    // APB enable
        input  paddr,      // APB address bus
        input  pwrite,     // APB write
        input  pwdata,     // APB write data
        // apb slvae_11
        input  psel_11,     // APB select slave_x
        output prdata_11,   // APB read data from slave_x
        output pready_11,   // APB ready from slave_x (optinal for slave)
        output pslverr_11   // APB slave error from slave_x (optinal for slave)
    );

endinterface