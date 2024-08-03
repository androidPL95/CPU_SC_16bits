module InterruptController
#(
    parameter  NUM_INT   = 16
    localparam ADDR_SIZE = $clog2(NUM_INT)
)
(
    input  logic              clk   ,
    input  logic              rst   ,

    input  logic[ADDR_SIZE:0]   reg_addr,

    input  logic              ier_set_flag,
    input  logic              ier_unset_flag,

    input  logic              ifr_set_flag,
    input  logic              ifr_unset_flag,

    input  logic[15:0]        rtrn_addr_in,
    input  logic              end_routine,
    
    output logic              enable,
    output logic[15:0]        addr_out
);

logic [NUM_INT-1:0] excpt_en;
logic [NUM_INT:0]   ier_out;
logic [NUM_INT-1:0] ifr_out;

logic[NUM_INT:0]   ier_set;
logic[NUM_INT:0]   ier_unset;
logic[NUM_INT-1:0]   ifr_set;
logic[NUM_INT-1:0]   ifr_unset;

logic [15:0] rtrn_addr_out;

// Used to store state -> it's executing an interruption or not
logic executing_int;

assign excpt_en[NUM_INT-1:0] = (ier_out[NUM_INT-1:0] & ifr_out[NUM_INT-1:0]);
assign enable = ((ier_out[NUM_INT] && (|excpt_en[NUM_INT-1:0])) || end_routine);

// Register (IER / IFR) Bank
generate

    // IER[NUM_INT] is used for storing general monitoring flag
    // other registers are used to set monitoring for specific interrupts
    for ( int i = 0 ; i <= NUM_INT ; ++i ) begin : ier_bank
        IntReg IER (
            .clk                    ,
            .set    ( ier_set[i]   ),
            .unset  ( ier_unset[i] ),
            .out    ( ier_out[i]   )
        );
    end

    for ( int i = 0 ; i < NUM_INT ; ++i ) begin : ifr_bank
        IntReg IFR (
            .clk                    ,
            .set    ( ifr_set[i]   ),
            .unset  ( ifr_unset[i] ),
            .out    ( ifr_out[i]   )
        );
    end

endgenerate

// IER and IFR address decoder
generate

    for ( int i = 0 ; i <= NUM_INT ; ++i ) begin : ier_decoder
        assign ier_set[i]   = ( ier_set_flag   && (i == reg_addr) ) ? '1 : '0;
        assign ier_unset[i] = ( ier_unset_flag && (i == reg_addr) ) ? '1 : '0;
    end

    for ( int i = 0 ; i < NUM_INT ; ++i ) begin : ifr_decoder
        assign ifr_set[i]   = ( ifr_set_flag   && (i == reg_addr) ) ? '1 : '0;
        assign ifr_unset[i] = ( ifr_unset_flag && (i == reg_addr) ) ? '1 : '0;
    end

endgenerate

Reg #(.WIDTH(16)) ReturnAddr (
    .clk(executing_int),
    .rst,
    .input(rtrn_addr_in),
    .output(rtrn_addr_out)
);

CounterMem #(.NUM_EXC(NUM_INT)) HandlerAddrMem (
    .clk,
    .rst,
    .excpt_en,
    .excpt_addr(handler_addr)
);

// Racing Condition? probably, but let's try anyway
always_ff @(posedge clk or negedge rst) begin
    if (!rst) begin
        executing_int <= '0;
    end
    else if( (ier_out[NUM_INT] && (|excpt_en[NUM_INT-1:0])) && executing_int == '0) begin
        executing_int <= '1;
    end
    else if( ((end_routine == '1) && !(|excpt_en[NUM_INT-1:0])) && executing_int == '1 ) begin
        executing_int <= '0;
    end
end

always_comb begin

    if( (end_routine == '1) && !(|excpt_en[NUM_INT-1:0]) ) begin
        addr_out = rtrn_addr_out;
    end
    else begin
        addr_out = handler_addr;
    end

end



endmodule