all: clean compile simulate
 
compile:
	vlib work;
	vlog -sv \
	-l mac.log \
	-f mac_compile.f
 
simulate:
	vsim \
	work.tb \
	-voptargs=+acc=npr \
	-c -do "log -r /*; run -all;  exit"
 
clean:
	rm -rf transcript *.vcd *.wlf work/ *.log