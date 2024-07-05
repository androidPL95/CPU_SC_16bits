// QUARTUS DOES NOT ACCEPT LOCALPARAM WTFFFFFFFFFFF
// DO NOT USE ADD_SIZE PARAMETER, LET THE BLOCK ITSELF CALCULATE THE VALUE
module Mem
#(
    parameter  WIDTH    = 16  ,
    parameter  DEPTH    = 1024,
    parameter ADD_SIZE = $clog2(DEPTH)
)
(
    input  [ADD_SIZE-1:0] addr   ,
    input                 clk    ,
    input  [WIDTH-1:0]    wdata  ,
    input                 we     ,
    output [WIDTH-1:0]    out    
);

logic [WIDTH-1:0] file [ADD_SIZE-1:0];

logic aux_out;

assign out = aux_out;

// READ BLOCK
// Read must be async, otherwise we can't implement a single cycle CPU
always_latch begin
    if(we == 1'b0) begin
        aux_out = file[addr];
    end
end

// WRITE BLOCK
always_ff@(posedge clk) begin
    if(we == 1'b1) begin
        file[addr] <= wdata;
    end
end

// InicializaÃ§Ã£o da memÃ³ria
initial begin
    $readmemb("initial_memory_contents.txt", file);
end

endmodule