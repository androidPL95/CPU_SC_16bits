module CounterMem
#(
    parameter  WIDTH = 16,
    parameter  NUM_EXC = 16
    localparam ADDR_SIZE = $clog2(NUM_EXC)
)
(
    input  logic clk,
    input  logic rst,
    input  logic[NUM_EXC-1:0] excpt_en,
    output logic[WIDTH-1:0] excpt_addr
)

logic [ADD_SIZE-1 : 0] count;

// ADDRESS DECODER
// Checks exceptions priority and defines the memory address
generate;

    always_comb begin
        if(excpt_en[0] == '1) begin
            count <= '0 
        end
    end
    
    for (int i = 1 ; i < NUM_EXC ; ++i) begin
        always_comb begin
            if((|excpt_en[i-1:0] == '0) && (excpt_en[i] == '1)) begin
                count <= ( (ADD_SIZE)'0 + (ADD_SIZE)'i ) 
            end
        end
    end

endgenerate

// I suppose this should be a ROM, with the vectors already defined
Mem #(.WIDTH(WIDTH) , .DEPTH(NUM_EXC)) HandlerAddrMem (
    .clk,
    .rst,
    .wdata('0),
    .we('0),
    .addr(count),
    .out(excpt_addr)
);

endmodule