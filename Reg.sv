module Reg
#(
    parameter WIDTH = 16
)
(
    input  [WIDTH-1:0]  in ,
    input               clk ,
    output [WIDTH-1:0]  out
);

logic [WIDTH-1:0] aux;

assign out = aux;

always_ff@(posedge clk) begin
    aux <= in;
end

endmodule