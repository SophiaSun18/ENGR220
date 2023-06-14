library verilog;
use verilog.vl_types.all;
entity lab04 is
    port(
        OUT_GNT1        : out    vl_logic;
        Reset           : in     vl_logic;
        Clock           : in     vl_logic;
        REQ1            : in     vl_logic;
        REQ0            : in     vl_logic;
        OUT_GNT0        : out    vl_logic
    );
end lab04;
