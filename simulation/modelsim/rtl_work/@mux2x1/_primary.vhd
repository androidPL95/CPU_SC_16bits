library verilog;
use verilog.vl_types.all;
entity Mux2x1 is
    port(
        a               : in     vl_logic;
        b               : in     vl_logic;
        sel             : in     vl_logic;
        \out\           : out    vl_logic
    );
end Mux2x1;
