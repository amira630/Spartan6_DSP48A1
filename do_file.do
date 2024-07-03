vlib work
vlog adder_sub.v REG_MUX.v Register.v MUX4x1.v MUX2x1.v Spartan6_DSP48A1.v DSP_48A1_tb.v
vsim -voptargs=+acc work.DSP_48A1_tb
add wave *
run -all