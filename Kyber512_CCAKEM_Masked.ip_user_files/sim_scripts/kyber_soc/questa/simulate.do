onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib kyber_soc_opt

do {wave.do}

view wave
view structure
view signals

do {kyber_soc.udo}

run -all

quit -force
