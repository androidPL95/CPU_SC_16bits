module Mux3x1
(
    input [15:0] a,
    input [15:0] b,
    input [15:0] c,

    input wire logic[1:0] sel,

    output [15:0] out
);

always_comb begin
    case (sel)
        2'b00:
            out = a;
        2'b01:
            out = b;
        2'b10:
            out = c;
        default:
            out = 'X;
    endcase
end

endmodule