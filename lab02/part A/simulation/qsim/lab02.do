onerror {quit -f}
vlib work
vlog -work work lab02.vo
vlog -work work lab02.vt
vsim -novopt -c -t 1ps -L max7000s_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.lab02_vlg_vec_tst
vcd file -direction lab02.msim.vcd
vcd add -internal lab02_vlg_vec_tst/*
vcd add -internal lab02_vlg_vec_tst/i1/*
add wave /*
run -all
