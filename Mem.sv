module Mem
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
    output [WIDTH-1:0]    out
);

logic [WIDTH-1:0] file [DEPTH-1:0];
logic [WIDTH-1:0] aux_out;

assign out = aux_out;

// READ BLOCK
// Read must be async, otherwise we can't implement a single cycle CPU
always_comb begin
	if (!rst) begin
		aux_out = 'h0;
	end else begin
    aux_out = file[addr];
	end
end

// WRITE BLOCK AND INITIALIZATION
always_ff @(posedge clk or negedge rst) begin
    if (!rst) begin
        integer i;
        for (i = 0; i < DEPTH; i = i + 1) begin
            file[i] <= '0;
        end
    end else if (we) begin
        file[addr] <= wdata;
    end
end

// Inicialização da memória
initial begin

	file[0] = 16'b0110000000000000;
	file[1] = 16'b0111000000000001;
	file[2] = 16'b0110000000010111;
	file[3] = 16'b0000001111111111;
	file[4] = 16'b0110000000010111;
	file[5] = 16'b0110000000011111;
	file[6] = 16'b0000000000000110;
	file[7] = 16'b0110000000010000;
	file[8] = 16'b0110000000011111;
	file[9] = 16'b0000000000001011;
	file[10] = 16'b0110000000010001;
	file[11] = 16'b0110000000010000;
	file[12] = 16'b0111000000010111;
	file[13] = 16'b0000001011110111;
	file[14] = 16'b0110000000010111;
	file[15] = 16'b0110000000010001;
	file[16] = 16'b0110000010100000;
   //$readmemb("initial_memory_contents.txt", file);
end

endmodule
