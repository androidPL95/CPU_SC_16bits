library verilog;
use verilog.vl_types.all;
entity RegFile is
    generic(
        WIDTH           : integer := 16;
        DEPTH           : integer := 32;
        ADDR_SIZE       : vl_notype
    );
    port(
        a1              : in     vl_logic_vector;
        a2              : in     vl_logic_vector;
        wdata           : in     vl_logic_vector;
        we              : in     vl_logic;
        clk             : in     vl_logic;
        rd1             : out    vl_logic_vector;
        rd2             : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DEPTH : constant is 1;
    attribute mti_svvh_generic_type of ADDR_SIZE : constant is 3;
end RegFile;
