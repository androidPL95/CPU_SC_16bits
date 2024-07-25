module Pipeline_Stage3
(
    input clk,
    input rst,

    input logic reg_we_in,
	input logic store_pc_in,
    output logic reg_we_out,
	output logic store_pc_out,

    input mem_bypass_in,
    output mem_bypass_out,

    input mem_we_in,
    output mem_we_out,

    input aux_in,
    output aux_out,

    input wire logic[4:0] wa_in,
    output wire logic[4:0] wa_out
);

always_ff @(posedge clk or negedge rst) begin
    if (!rst) begin
        mem_bypass_out <= '0;
        mem_we_out <= '0;
        aux_out <= '0;

        wa_out <= '0;
    end
    else if (clk) begin
        mem_bypass_out <= mem_bypass_in;
        mem_we_out <= mem_we_in;
        aux_out <= aux_in;
        wa_out <= wa_in;
    end
end

endmodule