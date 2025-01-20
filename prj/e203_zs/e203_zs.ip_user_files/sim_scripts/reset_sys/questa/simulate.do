onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib reset_sys_opt

do {wave.do}

view wave
view structure
view signals

do {reset_sys.udo}

run -all

quit -force
