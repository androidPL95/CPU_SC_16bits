module RegPipeStage3
(
    input clk,
    input rst,

    input mem_bypass_in,
    output mem_bypass_out,

    input mem_we_in,
    output mem_we_out,

    input mux_in,
    output mux_out,

    input rd2_in,
    output rd2_out,

    input wire logic[4:0] wa_in,
    output wire logic[4:0] wa_out
);

always_ff @(posedge clk or negedge rst) begin
    if (!rst) begin
        mem_bypass_out <= '0;
        mem_we_out <= '0;
        mux_out <= '0;
        rd2_out <= '0;
        wa_out <= '0;
    end
    else if (clk) begin
        mem_bypass_out <= mem_bypass_in;
        mem_we_out <= mem_we_in;
        mux_out <= mux_in;
        rd2_out <= rd2_in;
        wa_out <= wa_in;
    end
end

endmodule