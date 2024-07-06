module Reg
#(
    parameter WIDTH = 16
)
(
    input  [WIDTH-1:0]  in,
    input               clk,
    input               rst,
    output [WIDTH-1:0]  out
);

logic [WIDTH-1:0] aux;

assign out = aux;

always_ff @(posedge clk or negedge rst) begin
    if (!rst) begin
        aux <= '0;
    end
    else begin
        aux <= in;
    end
end

endmodule
