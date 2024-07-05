library verilog;
use verilog.vl_types.all;
library work;
entity Controller is
    port(
        clk             : in     vl_logic;
        op              : in     work.typedefs.opcode_t;
        comp            : in     vl_logic;
        sel_PC          : out    vl_logic;
        sum_imm         : out    vl_logic;
        store_pc        : out    vl_logic;
        reg_we          : out    vl_logic;
        alu_imm         : out    vl_logic;
        alu_ctrl        : out    work.typedefs.alu_opcode_t;
        alu_bypass      : out    vl_logic;
        mem_we          : out    vl_logic;
        mem_bypass      : out    vl_logic
    );
end Controller;
