library verilog;
use verilog.vl_types.all;
entity SingleCycle_Top is
    port(
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        SW              : in     vl_logic_vector(9 downto 0);
        LEDS            : out    vl_logic_vector(9 downto 0);
        HEX0            : out    vl_logic_vector(7 downto 0);
        HEX1            : out    vl_logic_vector(9 downto 0);
        HEX2            : out    vl_logic_vector(5 downto 0);
        HEX3            : out    vl_logic_vector(7 downto 0);
        HEX4            : out    vl_logic_vector(7 downto 0);
        HEX5            : out    vl_logic_vector(7 downto 0)
    );
end SingleCycle_Top;
