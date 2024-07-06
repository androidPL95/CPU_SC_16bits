library verilog;
use verilog.vl_types.all;
entity Data_Mem is
    generic(
        WIDTH           : integer := 16;
        DEPTH           : integer := 1024;
        ADD_SIZE        : vl_notype
    );
    port(
        addr            : in     vl_logic_vector;
        clk             : in     vl_logic;
        wdata           : in     vl_logic_vector;
        we              : in     vl_logic;
        rst             : in     vl_logic;
        \out\           : out    vl_logic_vector;
        leds            : out    vl_logic_vector;
        hex0            : out    vl_logic_vector;
        hex1            : out    vl_logic_vector;
        hex2            : out    vl_logic_vector;
        hex3            : out    vl_logic_vector;
        hex4            : out    vl_logic_vector;
        hex5            : out    vl_logic_vector;
        switchs         : in     vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DEPTH : constant is 1;
    attribute mti_svvh_generic_type of ADD_SIZE : constant is 3;
end Data_Mem;
