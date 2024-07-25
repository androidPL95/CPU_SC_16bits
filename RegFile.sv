module RegFile
#(
    parameter WIDTH = 16,
    parameter DEPTH = 32,
    parameter ADDR_SIZE = $clog2(DEPTH)
)
(
    input  [ADDR_SIZE-1:0] a1,
    input  [ADDR_SIZE-1:0] a2,
    input  [WIDTH-1:0]     wdata,
    input  [ADDR_SIZE-1:0] waddr,
    input                  we,
    input                  clk,
    input                  rst,
    output [WIDTH-1:0]     rd1,
    output [WIDTH-1:0]     rd2
);

logic [WIDTH-1:0] file [DEPTH-1:0]; // Corrigido para DEPTH
logic [WIDTH-1:0] out1, out2;

assign rd1 = out1;
assign rd2 = out2;

// READ BLOCK
// Needs to be async
always_comb begin

	out1 = file[a1];
	out2 = file[a2];
	
end

// WRITE BLOCK
always_ff @(posedge clk or negedge rst) begin
    if (!rst) begin
        integer i;
        for (i = 0; i < DEPTH; i = i + 1) begin
            file[i] <= '0;
        end
    end else if (we) begin
        file[waddr] <= wdata;
    end
end

endmodule
