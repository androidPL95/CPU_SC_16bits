module Reg
#(
    parameter WIDTH = 16
)
(
    input  [WIDTH-1:0]  in ,
    input               clk ,
    input               rst ,
    output [WIDTH-1:0]  out
);

logic [WIDTH-1:0] aux;

assign out = aux;

always_ff@(clk or rst) begin
    if(rst == 1'b0) begin
        aux <= '0;
    end
    else if(posedge clk) begin
        aux <= in;
    end
end

endmodule