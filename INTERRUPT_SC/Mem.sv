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

file[0] = 16'b0010100000000000;     // LUI   0
file[1] = 16'b0011000000000001;     // ORI   1
file[2] = 16'b0110110000001000;     // LAD  $t0 
file[3] = 16'b0000000000000000;     // ADD $zero $zero 
file[4] = 16'b0110110000001001;     // LAD  $t1 
file[5] = 16'b0111000000000000;     // LOA  $zero 
file[6] = 16'b0010010000000110;     // ADDI   6
file[7] = 16'b0110110000010000;     // LAD  $s0 
file[8] = 16'b0111000000000000;     // LOA  $zero 
file[9] = 16'b0010010000001011;     // ADDI   11
file[10] = 16'b0110110000010001;     // LAD  $s1 
file[11] = 16'b0111000000010000;     // LOA  $s0 
file[12] = 16'b0110100000001001;     // SW  $t1 
file[13] = 16'b0000000100101000;     // ADD $t1 $t0 
file[14] = 16'b0110110000001001;     // LAD  $t1 
file[15] = 16'b0111000000010001;     // LOA  $s1 
file[16] = 16'b0110000010100000;     // JAL $a1  
	
   //$readmemb("initial_memory_contents.txt", file);
end

endmodule
