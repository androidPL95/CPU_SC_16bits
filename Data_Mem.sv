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
);

logic [WIDTH-1:0] file [DEPTH-1:0]; // Corrigido para DEPTH


// READ BLOCK
// Needs to be async
always_comb begin
    aux_out = file[addr];
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

//// Inicialização da memória
//initial begin
//    $readmemb("initial_memory_contents.txt", file);
//end

endmodule
