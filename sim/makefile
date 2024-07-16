all: clean compile simulate

ifndef test
override test = xgemac_base_test
endif

ifndef verbosity
override verbosity = UVM_MEDIUM
endif

compile:
	vlib work;
	vlog -sv \
	-l mac.log \
	-f mac_compile.f
 
simulate:
	vsim \
	work.xgemac_top \
	-voptargs=+acc=npr \
	+UVM_TESTNAME=$(test) \
	+UVM_VERBOSITY=$(verbosity) \
	-c -do "log -r /*; run -all;  exit" > mac_sim.log
	wlf2vcd -o wave.vcd vsim.wlf
 
clean:
	rm -rf transcript *.vcd *.wlf work/ *.log *.vstf