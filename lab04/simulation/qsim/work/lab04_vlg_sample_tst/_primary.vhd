library verilog;
use verilog.vl_types.all;
entity lab04_vlg_sample_tst is
    port(
        Clock           : in     vl_logic;
        REQ0            : in     vl_logic;
        REQ1            : in     vl_logic;
        Reset           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end lab04_vlg_sample_tst;
