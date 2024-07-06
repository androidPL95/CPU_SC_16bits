module Data_Mem
#(
    parameter WIDTH = 16,
    parameter DEPTH = 1024,
    parameter ADD_SIZE = $clog2(DEPTH)
)
(
    input  [ADD_SIZE-1:0] addr,
    input                 clk,
    input  [WIDTH-1:0]    wdata,
    input                 we,
    input                 rst,
    output [WIDTH-1:0]    out,
    output [WIDTH-1:0]    leds,
    output [WIDTH-1:0]    hex0,
    output [WIDTH-1:0]    hex1,
    output [WIDTH-1:0]    hex2,
    output [WIDTH-1:0]    hex3,
    output [WIDTH-1:0]    hex4,
    output [WIDTH-1:0]    hex5,
    input  [WIDTH-1:0]    switchs
);

logic [WIDTH-1:0] file [DEPTH-1:0]; // Corrigido para DEPTH

logic [WIDTH-1:0] aux_out;
logic [WIDTH-1:0] aux_hex0;
logic [WIDTH-1:0] aux_hex1;
logic [WIDTH-1:0] aux_hex2;
logic [WIDTH-1:0] aux_hex3;
logic [WIDTH-1:0] aux_hex4;
logic [WIDTH-1:0] aux_hex5;
logic [WIDTH-1:0] aux_leds;

assign hex0 = aux_hex0;
assign hex1 = aux_hex1;
assign hex2 = aux_hex2;
assign hex3 = aux_hex3;
assign hex4 = aux_hex4;
assign hex5 = aux_hex5;
assign leds = aux_leds;
assign out  = aux_out;

// READ BLOCK
// Needs to be async
always_comb begin
    aux_out = file[addr];
    aux_hex0 = file[0];
    aux_hex1 = file[1];
    aux_hex2 = file[2];
    aux_hex3 = file[3];
    aux_hex4 = file[4];
    aux_hex5 = file[5];
    aux_leds = file[6];
end

// WRITE BLOCK AND INITIALIZATION
always_ff @(posedge clk or negedge rst) begin
    if (!rst) begin
        integer i;
        for (i = 0; i < DEPTH; i = i + 1) begin
            file[i] <= '0;
        end
    end else if (we) begin
        if (addr != 7) begin
            file[addr] <= wdata;
        end
        file[7] <= switchs;
    end
end

//// Inicialização da memória
//initial begin
//    $readmemb("initial_memory_contents.txt", file);
//end

endmodule
