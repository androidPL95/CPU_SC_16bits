library verilog;
use verilog.vl_types.all;
library work;
entity ALU is
    generic(
        WIDTH           : integer := 16
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        opcode          : in     work.typedefs.alu_opcode_t;
        \out\           : out    vl_logic_vector;
        comp            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end ALU;
