module RegPipeStage4
(
    input clk,
    input rst,

    input mux_in,
    output mux_out,

    input wire logic[4:0] wa_in,
    output wire logic[4:0] wa_out,
);

always_ff@(posedge clk or negedge rst) begin
    if (!rst) begin
        mux_out <= '0;
        wa_out <= '0;
    end
    else if (clk) begin
        mux_out <= mux_in;
        wa_out <= wa_in;
    end
end

endmodule