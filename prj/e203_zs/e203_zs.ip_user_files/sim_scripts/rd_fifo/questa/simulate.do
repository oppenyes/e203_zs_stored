onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib rd_fifo_opt

do {wave.do}

view wave
view structure
view signals

do {rd_fifo.udo}

run -all

quit -force
