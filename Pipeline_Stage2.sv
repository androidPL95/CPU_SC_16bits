module Pipeline_Stage2 import typedefs::*;
#(
	parameter WIDTH = 16
)
(
	input logic clk,
	input logic reset,
	input logic enable,
	
	input logic in_branch,
	input logic in_ALU_bypass,
	input logic in_Mem_WE,
	input logic in_Mem_bypass,
	input logic in_jump,
	
	input alu_opcode_t      in_ALU_control,
	input logic [WIDTH-1:0] in_instruction,
	input logic [WIDTH-1:0] in_RD1,
	input logic [WIDTH-1:0] in_RD2,
	input logic [WIDTH-1:0] in_immmux,
	input logic [WIDTH-1:0] in_wa,
	
	output logic out_branch,
	output logic out_ALU_bypass,
	output logic out_Mem_WE,
	output logic out_Mem_bypass,
	output logic out_jump,
	
	output alu_opcode_t      out_ALU_control,
	output logic [WIDTH-1:0] out_instruction,
	output logic [WIDTH-1:0] out_RD1,
	output logic [WIDTH-1:0] out_RD2,
	output logic [WIDTH-1:0] out_immmux,
	output logic [WIDTH-1:0] out_wa


);

always_ff @(posedge clk or posedge reset) begin
	if (~reset) begin
		out_branch <= 0;
		out_ALU_bypass <= 0;
		out_Mem_WE <= 0;
		out_Mem_bypass <= 0;
		out_jump <= 0;
		out_ALU_control <= ALU_ADD;
		out_instruction <= 0;
		out_RD1 <= 0;
		out_RD2 <= 0;
		out_immmux <= 0;
		out_wa <= 0;
	end else begin
		if (~enable) begin
			out_branch <= in_branch;
			out_ALU_bypass <= in_ALU_bypass;
			out_Mem_WE <= in_Mem_WE;
			out_Mem_bypass <= in_Mem_bypass;
			out_jump <= in_jump;
			out_ALU_control <= in_ALU_control;
			out_instruction <= in_instruction;
			out_RD1 <= in_RD1;
			out_RD2 <= in_RD2;
			out_immmux <= in_immmux;
			out_wa <= in_wa;
		end
	end
end

endmodule
