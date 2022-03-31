//=====================================================================
// Description:
// AHB Slave interface state machine
// Designer : zhaozj34@sjtu.edu.cn
// Revision History:
// V0 date:xxx Initial version， zhaozj34@sjtu.edu.cn
// ====================================================================

module apb_ahb_if (
    /* AHB */
    input                            hclk,       // AHB system clock
    input                            hreset_n,   // AHB system reset
    input  [`HADDR_INT_WIDTH-1:0]    haddr_int,  // internal AHB address
    input                            hready,     
    input                            hsel,       // AHB slave select
    input  [`HTRANS_WIDTH-1:0]       htrans,     // AHB transfer type 
    input                            hwrite,     // AHB write/read signal
    input  [`AHB_DATA_WIDTH-1:0]     hwdata,     // AHB write data
    
    output reg                       hreadyout,  
    output reg                       hresp,      // AHB response
    output reg [`AHB_DATA_WIDTH-1:0] hrdata,    
    
    /* APB */
    input                            pready_x,   // APB ready from slave_x (optinal for slave)
    input                            pslverr_x,  // APB slave error from slave_x (optinal for slave)
    input  [`APB_DATA_WIDTH-1:0]     prdata_x,   // APB read data from slave_x
    output reg                       psel_en,    // APB psel enable
    output reg [`PADDR_WIDTH-1:0]    paddr,      // APB address
    output reg                       penable,    // APB enable
    output reg [`APB_DATA_WIDTH-1:0] pwdata,     // APB write data
    output reg                       pwrite      // APB write/read signal
);

/* internal signal and reg */
wire                        ahb_sel_idd;     
wire                        ahb_tran_idd;   
wire                        ahb_valid;   

// wire type of the reg with the same name
wire [`HADDR_INT_WIDTH-1:0] piped_haddr_w;   
wire [`AHB_DATA_WIDTH-1:0]  piped_hwdata_w;
wire                        piped_hwrite_w;

wire                        psel_en_w;
wire                        penable_w;

wire [`AHB_DATA_WIDTH-1:0]  prdata_reg_w;

// store AHB address
reg [`HADDR_INT_WIDTH-1:0]  piped_haddr;
// store AHB write data     
reg [`AHB_DATA_WIDTH-1:0]   piped_hwdata;
// store AHB direction   
reg                         piped_hwrite; 
// store APB read data
reg [`AHB_DATA_WIDTH-1:0]   prdata_reg;       


reg [3:0]                   next_state;      
reg [3:0]                   state;            

/* FSM definition */
parameter IDLE                = 4'b0000;
// write state
parameter WRITE_WAIT_PIPLINE  = 4'b0001;
parameter WRITE_SETUP         = 4'b0010;
parameter WRITE_ENABLE        = 4'b0011;
parameter WRITE_WAIT          = 4'b0100;
parameter WRITE_SUCCESS       = 4'b0101;
// read state
parameter READ_SETUP          = 4'b0110;
parameter READ_ENABLE         = 4'b0111;
parameter READ_WAIT           = 4'b1000;  
parameter READ_SUCCESS        = 4'b1001;
// error state
parameter ERROR_1             = 4'b1010;
parameter ERROR_2             = 4'b1011;



/* connection */

/*
 * 1. Make sure that the current AHB slave is selected and 
 *    the transfer tasks of other slaves have been completed
 * 2. When condition 1 is satisfied, determine the type of the current transaction.
 *    It should not be IDLE and BUSY.
 * 3. When condition 2 is satisfied, is means that further responses can be made.
 *
 */
assign ahb_sel_idd  = hsel && hready;
assign ahb_tran_idd = (htrans != `IDLE) && (htrans != `BUSY);
assign ahb_valid    = ahb_sel_idd && ahb_tran_idd;



/* always block */

/*
 * store the address of the AHB bus
 */
assign piped_haddr_w = piped_haddr;
always @(posedge hclk) begin
    if (hreset_n == 1'b0) begin
        piped_haddr <= {`HADDR_INT_WIDTH{1'b0}};
    end
    else begin
        case (state)
            IDLE, WRITE_SUCCESS, READ_SUCCESS, ERROR_2 : begin
                if (ahb_valid == 1'b1)
                    piped_haddr <= haddr_int;
                else
                    piped_haddr <= {`HADDR_INT_WIDTH{1'b0}};
            end 
            default: piped_haddr <= piped_haddr_w;
        endcase
    end
end

/*
 * store the direction of the AHB bus
 * 
 * Because of the pipeline operation of AHB, the indication of 
 * the transmission direction and the address are kept synchronized, 
 * so the transmission direction and the address have the same sampling time.
 * 
 */
assign piped_hwrite_w = piped_hwrite;
always @(posedge hclk) begin
    if (hreset_n == 1'b0)
        piped_hwrite <= 1'b0;
    else begin
        case (state)
            IDLE, WRITE_SUCCESS, READ_SUCCESS, ERROR_2 : begin
                if (ahb_valid == 1'b1) 
                    piped_hwrite <= hwrite;
                else
                    piped_hwrite <= 1'b0;
            end 
            default: piped_hwrite <= piped_hwrite_w;
        endcase
    end
end

/*
 * store the write data of the AHB bus
 *
 * For write transfer, only when complete AHB bus information 
 * (address and data) can be obtained, the Setup phase of APB bus can be entered.
 * 
 */
assign piped_hwdata_w = piped_hwdata;
always @(posedge hclk) begin
    if (hreset_n == 1'b0) 
        piped_hwdata <= {`AHB_DATA_WIDTH{1'b0}};
    else begin
        case (state)
            WRITE_WAIT_PIPLINE : piped_hwdata <= hwdata;
            default: piped_hwdata <= piped_hwdata_w;
        endcase
    end
end

/*
* AHB bus hreadyout
*
* assert on IDLE, and only on successful completion of read and write 
* and the second cycle of error response.
* 
*/
always @(posedge hclk) begin
    if (hreset_n == 1'b0)
        hreadyout <= 1'b1;
    else begin
        case (next_state)
            IDLE, WRITE_SUCCESS, READ_SUCCESS, ERROR_2 : hreadyout <= 1'b1;
            default: hreadyout <= 1'b0;
        endcase
    end
end

/*
* AHB bus hresp
*
* assert on cycles of error response.
* 
*/
always @(posedge hclk) begin
    if (hreset_n == 1'b0)
        hresp <= `OKAY;
    else begin
        case (next_state)
            ERROR_1, ERROR_2 : hresp <= `ERROR;
            default: hresp <= `OKAY;
        endcase
    end
end

/*
* AHB bus hrdata
*/
always @(*) begin
    hrdata = prdata_reg_w;
end

/*
* APB bus psel_en
* 
* assert when the APB bus enters the setup phase and deassert when finished.
*/
assign psel_en_w = psel_en;
always @(posedge hclk) begin
    if (hreset_n == 1'b0)
        psel_en <= 1'b0;
    else begin
        case(next_state)
            WRITE_SETUP, READ_SETUP : psel_en <= 1'b1;
            WRITE_SUCCESS, READ_SUCCESS, ERROR_1 : psel_en <= 1'b0;
            default: psel_en <= psel_en_w;
        endcase
    end
end

/*
* APB bus penable
* 
* assert when the APB bus enters the access phase and deassert when finished.
*/
assign penable_w = penable;
always @(posedge hclk) begin
    if (hreset_n == 1'b0)
        penable <= 1'b0;
    else begin
        case(next_state)
            WRITE_ENABLE, READ_ENABLE : penable <= 1'b1;
            WRITE_SUCCESS, READ_SUCCESS, ERROR_1 : penable <= 1'b0;
            default: penable <= penable_w;
        endcase
    end
end

/*
* APB bus prdata
*/
assign prdata_reg_w = prdata_reg;
always @(posedge hclk) begin
    if (hreset_n == 1'b0)
        prdata_reg <= {`AHB_DATA_WIDTH{1'b0}};
    else begin
        if (pready_x == 1'b1)
            prdata_reg <= prdata_x;
        else
            prdata_reg <= prdata_reg_w;
    end        
end

/*
* APB bus paddr，pwdata，pwrite
*/
always @(*) begin
    paddr = piped_haddr_w;
    pwdata = piped_hwdata_w;
    pwrite = piped_hwrite_w;
end


/* 
 * FSM switch
 */
always @(posedge hclk) begin
    if (hreset_n == 1'b0) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        // IDLE state, waiting for AHB bus to wake up
        IDLE : begin
            if (ahb_valid == 1'b1) begin
                // accept the current transfer
                if ( hwrite == `WRITE)
                    // write transfer
                    next_state = WRITE_WAIT_PIPLINE; 
                else
                    // read transfer
                    next_state = READ_SETUP;
            end
            else
                next_state = IDLE;
        end

        // write transfer (waiting for data), 
        // after obtaining the data of the AHB write transfer, 
        // the APB bus enters the setup phase
        WRITE_WAIT_PIPLINE : next_state = WRITE_SETUP;

        // APB write transfer setup phase
        WRITE_SETUP : next_state = WRITE_ENABLE;
    
        // APB write transfer enable phase
        WRITE_ENABLE : begin
            if (pready_x == 1'b0)
                // APB slave not ready
                next_state = WRITE_WAIT;
            else begin
                if (pslverr_x == 1'b0)
                    next_state = WRITE_SUCCESS;
                else
                    next_state = ERROR_1;
            end
        end

        // APB write transfer waiting
        WRITE_WAIT : begin
            if (pready_x == 1'b0)
                // APB slave not ready
                next_state = WRITE_WAIT;
            else begin
                if (pslverr_x == 1'b0)
                    next_state = WRITE_SUCCESS;
                else
                    next_state = ERROR_1;
            end
        end

        // APB write transfer finish
        WRITE_SUCCESS : begin
            if (ahb_valid == 1'b1) begin
                if (hwrite == `WRITE)
                    next_state = WRITE_WAIT_PIPLINE; 
                else
                    next_state = READ_SETUP;
            end
            else
                next_state = IDLE;
        end

        // APB read transfer setup phase
        READ_SETUP : next_state = READ_ENABLE;

        // APB read transfer enable phase
        READ_ENABLE : begin
            if (pready_x == 1'b0)
                // APB slave not ready 
                next_state = READ_WAIT;
            else begin
                if (pslverr_x == 1'b0)
                    next_state = READ_SUCCESS;
                else
                    next_state = ERROR_1;
            end
        end

        // APB read transfer waiting
        READ_WAIT : begin
            if (pready_x == 1'b0)
                // APB slave not ready 
                next_state = READ_WAIT;
            else begin
                if (pslverr_x == 1'b0)
                    next_state = READ_SUCCESS;
                else
                    next_state = ERROR_1;
            end
        end

        // APB read transfer finish
        READ_SUCCESS : begin
            if (ahb_valid == 1'b1) begin
                if (hwrite == `WRITE)
                    next_state = WRITE_WAIT_PIPLINE; 
                else
                    next_state = READ_SETUP;
            end
            else
                next_state = IDLE;
        end

        ERROR_1 : next_state = ERROR_2;

        ERROR_2 : begin
            if (ahb_valid == 1'b1) begin
                if (hwrite == `WRITE)
                    next_state = WRITE_WAIT_PIPLINE; 
                else
                    next_state = READ_SETUP;
            end
            else
                next_state = IDLE;
        end

        default : next_state = IDLE;

    endcase
end

endmodule