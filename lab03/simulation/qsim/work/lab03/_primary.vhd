library verilog;
use verilog.vl_types.all;
entity lab03 is
    port(
        L1              : out    vl_logic;
        Reset           : in     vl_logic;
        Clock           : in     vl_logic;
        L4              : out    vl_logic;
        L3              : out    vl_logic;
        L2              : out    vl_logic;
        M4              : out    vl_logic;
        M3              : out    vl_logic;
        M2              : out    vl_logic;
        M1              : out    vl_logic
    );
end lab03;
