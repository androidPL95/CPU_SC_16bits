module IntReg
(
    input  logic clk,
    input  logic set,
    input  logic unset,
    output logic out
);

always_ff @(posedge clk or posedge unset) begin
    if (unset) begin
        out <= '0;
    end
    else if (set) begin
        out <= '1;
    end
end

endmodule