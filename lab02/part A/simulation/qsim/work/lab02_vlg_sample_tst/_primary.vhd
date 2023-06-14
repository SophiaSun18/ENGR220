library verilog;
use verilog.vl_types.all;
entity lab02_vlg_sample_tst is
    port(
        input_1         : in     vl_logic;
        input_2         : in     vl_logic;
        input_3         : in     vl_logic;
        input_4         : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end lab02_vlg_sample_tst;
