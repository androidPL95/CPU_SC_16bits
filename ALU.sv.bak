module ALU import typedefs::*;
#(
    parameter WIDTH    = 16
)
(
    input  [WIDTH-1:0]    a     ,
    input  [WIDTH-1:0]    b     ,
    input  alu_opcode_t       opcode,
    // Should we expand to 2*WIDTH and add another auxiliary? That's something to think about
    output [WIDTH-1:0]    out   ,
    // Comparison Operations Output
    output                comp
);

logic [WIDTH-1:0] aux_out;
logic             aux_comp;

assign out = aux_out;
assign comp = aux_comp;

always_comb begin
    case (opcode)

        ALU_ADD : begin
            aux_out = (a + b);
            aux_comp = '0;
        end

        ALU_SUB : begin
            aux_out = (a - b);
            aux_comp = '0;
        end

        ALU_NOT : begin
            aux_out = ~a;
            aux_comp = '0;
        end

        ALU_AND : begin
            aux_out = (a & b);
            aux_comp = '0;
        end

        ALU_OR  : begin
            aux_out = (a | b);
            aux_comp = '0;
        end

        ALU_XOR : begin
            aux_out = (a ^ b);
            aux_comp = '0;
        end

        ALU_SLL : begin
            aux_out = (a << b);
            aux_comp = '0;
        end

        ALU_SRL : begin
            aux_out = (a >> b);
            aux_comp = '0;
        end

        ALU_SLA : begin
            aux_out = (a <<< b);
            aux_comp = '0;
        end

        ALU_SRA : begin
            aux_out = (a >>> b);
            aux_comp = '0;
        end

        EQ  : begin
            aux_out = '0;
            aux_comp = (signed'(a) == signed'(b)) ? '1 : '0;
        end

        GRT : begin
            aux_out = '0;
            aux_comp = (signed'(a) > signed'(b)) ? '1 : '0;
        end

        GTU : begin
            aux_out = '0;
            aux_comp = (a > b) ? '1 : '0;
        end

        GTE : begin
            aux_out = '0;
            aux_comp = (signed'(a) >= signed'(b)) ? '1 : '0;
        end

        LTE : begin
            aux_out = '0;
            aux_comp = (signed'(a) <= signed'(b)) ? '1 : '0;
        end

        GEU : begin
            aux_out = '0;
            aux_comp = (a >= b) ? '1 : '0;
        end

        LEU : begin
            aux_out = '0;
            aux_comp = (a <= b) ? '1 : '0;
        end

    endcase
end

endmodule