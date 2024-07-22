module Mux3x1
(
    input a,
    input b,
    input c,

    input wire logic[1:0] sel,

    output out
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
            out = 'x;
    endcase
end

endmodule