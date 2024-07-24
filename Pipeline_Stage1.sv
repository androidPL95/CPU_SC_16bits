module Pipeline_Stage1
#(
	parameter WIDTH = 16
)
(
	input logic clk,
	input logic reset,
	input logic enable,
	input logic [WIDTH-1:0] in_instruction,
	input logic [WIDTH-1:0] in_PC,
	output logic [WIDTH-1:0] out_instruction,
	output logic [WIDTH-1:0] out_PC
);

always_ff @(posedge clk or posedge reset) begin
	if (~reset) begin
		out_instruction <= 0;
		out_PC <= 0;
	end else begin
		if (~enable) begin
			out_instruction <= in_instruction;
			out_PC <= in_PC;
		end
	end
end

endmodule
